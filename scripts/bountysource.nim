# Based on bountysource.cr located at https://github.com/crystal-lang/crystal-website/blob/master/scripts/bountysource.cr
import httpclient, asyncdispatch, json, strutils, os, strtabs, sequtils, sugar,
  algorithm, times

type
  BountySource = ref object
    client: AsyncHttpClient
    team: string

  Sponsor = object
    name, url, logo: string
    amount, allTime: float
    since: DateTime
    level: int # TODO: Change to enum?

const
  team = "nim"
  apiUrl = "https://api.bountysource.com"
  githubApiUrl = "https://api.github.com"

proc newBountySource(team, token: string): BountySource =
  result = BountySource(
    client: newAsyncHttpClient(userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36"),
    team: team
  )

  # Set up headers
  result.client.headers["Accept"] = "application/vnd.bountysource+json; version=2"
  result.client.headers["Authorization"] = "token " & token
  result.client.headers["Referer"] = "https://salt.bountysource.com/teams/nim/admin/supporters"
  result.client.headers["Origin"] = "https://salt.bountysource.com/"

proc getSupporters(self: BountySource): Future[JsonNode] {.async.} =
  let response = await self.client.get(apiUrl &
    "/supporters?order=monthly&per_page=200&team_slug=" & self.team)
  doAssert response.status.startsWith($Http200)
  return parseJson(await response.body)

proc getGithubUser(username, githubToken: string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  if githubToken != "":
    client.headers["Authorization"] = "token " & githubToken

  if ' ' in username:
    echo("Skipping trying to query GitHub for username: ", username)
    return nil

  let response = await client.get(githubApiUrl & "/users/" & username)
  if response.status.startsWith($Http200):
    return parseJson(await response.body)
  else:
    echo("Could not get Github user: ", username, ". ", response.status)
    return nil

proc performMod(supporters, findBy, modification: JsonNode) =
  ## Modifies the supporters JsonNode's children in-place based on
  ## the modification and findBy criteria.

  # First we find the supporter.
  for supporter in supporters:
    # Check if this is the one.
    var found = true
    for criteriaKey, criteriaVal in findBy:
      found = found and supporter{criteriaKey} == criteriaVal

    if found:
      # Make the modifications.
      for modKey, modVal in modification:
        supporter[modKey] = modVal
      break

proc modSupporters(supporters: JsonNode) =
  const bountysourceModFilename = "bountysource_mod.json"
  if not fileExists(bountysourceModFilename):
    quit("Could not find bountysource_mod.json file. Are you running me from" &
         " the correct directory?")

  let modJson = parseFile(bountysourceModFilename)

  echo("Modifying sponsors based on ", bountysourceModFilename, " file")
  for elem in modJson:
    case elem["source"].getStr()
    of "bountysource":
      # Currently we expect all BountySource entries to modify an
      # existing entry. So `find_by` and `mod` keys should exist.
      assert elem.hasKey("find_by")
      assert elem.hasKey("mod")
      let findBy = elem["find_by"]
      let modification = elem["mod"]
      performMod(supporters, findBy, modification)
    of "paypal", "bitcoin", "gittip", "freebie", "opencollective", "other":
      # Verify that it contains all the necessary fields.
      doAssert elem.hasKey("created_at"), "Mod needs created_at field"
      doAssert elem.hasKey("display_name"), "Mod needs display_name field"
      doAssert elem.hasKey("alltime_amount"), "Mod needs alltime_amount field"
      doAssert elem.hasKey("monthly_amount"), "Mod needs monthly_amount field"
      supporters.add(elem)
    else:
      doAssert false, "Unknown source type: " & elem["source"].getStr()


proc processSupporters(supporters: JsonNode) =
  var before = supporters.elems.len
  # Use bountysource_mod.json file to modify the data based on custom
  # mod parameters.
  modSupporters(supporters)

  # Discard anon sponsors.
  supporters.elems.keepIf(
    item => item["display_name"].getStr != "Anonymous"
  )
  echo("Discarded ", before - supporters.elems.len, " anonymous sponsors.")
  echo("Found ", supporters.elems.len, " named sponsors.")

  supporters.elems.sort(
    (x, y) => cmp(y["alltime_amount"].getFloat, x["alltime_amount"].getFloat)
  )


proc quote(text: string): string =
  if {' ', ','} in text:
    return "\"" & text & "\""
  else:
    return text

proc getLevel(supporter: JsonNode): int =
  if supporter.hasKey("level"):
    return supporter["level"].getInt().int

  let amount = supporter["monthly_amount"].getFloat()
  const levels = [250, 150, 75, 25, 10, 5, 1, 0]
  result = levels[0]
  for i in levels:
    if amount.int <= i:
      result = i

proc writeCsv(sponsors: seq[Sponsor], filename="sponsors.new.csv") =
  var csv = ""
  csv.add "logo,name,url,this_month,all_time,since,level\n"
  for sponsor in sponsors:
    csv.add "$#,$#,$#,$#,$#,$#,$#\n" % [
      sponsor.logo.quote, sponsor.name.quote,
      sponsor.url.quote, $sponsor.amount.int,
      $sponsor.allTime.int, sponsor.since.format("MMM d, yyyy").quote,
      $sponsor.level
    ]
  writeFile(filename, csv)
  echo("Written csv file to ", filename)

when isMainModule:
  if paramCount() == 0:
    quit("You need to specify the BountySource access token on the command\n" &
      "line, you can find it by going onto https://www.bountysource.com/people/25278-dom96\n" &
      "and looking at your browser's network inspector tab to see the token being\n" &
      "sent to api.bountysource.com")

  let token = paramStr(1)
  let githubToken = if paramCount() == 2: paramStr(2) else: ""
  let bountysource = newBountySource(team, token)

  if githubToken.len == 0:
    echo("WARNING: GitHub API token not specified. GitHub queries may become " &
         "rate limited :(. Grab a token from " &
         "https://github.com/settings/tokens and paste as second cmd line arg.")

  echo("Getting sponsors...")
  let supporters = waitFor bountysource.getSupporters()
  processSupporters(supporters)

  echo("Generating sponsors list... (please be patient)")
  var activeSponsors: seq[Sponsor] = @[]
  var inactiveSponsors: seq[Sponsor] = @[]
  for supporter in supporters:
    let name = supporter["display_name"].getStr
    var url = supporter{"url"}.getStr()
    let ghUser = waitFor getGithubUser(name, githubToken)
    if not ghUser.isNil:
      if ghUser["blog"].kind != JNull:
        url = ghUser["blog"].getStr
      else:
        url = ghUser["html_url"].getStr

    if url.len > 0 and not url.startsWith("http"):
      url = "http://" & url

    let amount = supporter["monthly_amount"].getFloat()
    # Only show URL when user donated at least $5.
    if amount < 5:
      url = ""

    var logo = ""
    if amount >= 75:
      logo = supporter["image_url_large"].getStr()

    let sponsor = Sponsor(name: name, url: url, logo: logo, amount: amount,
        allTime: supporter["alltime_amount"].getFloat(),
        since: parse(supporter["created_at"].getStr[0 .. 18], "yyyy-MM-dd'T'hh:mm:ss"),
        level: getLevel(supporter)
      )
    if supporter["monthly_amount"].getFloat > 0.0:
      activeSponsors.add(sponsor)
    else:
      inactiveSponsors.add(sponsor)

  echo("Generated ", activeSponsors.len, " active sponsors")
  echo("Generated ", inactiveSponsors.len, " inactive sponsors")
  writeCsv(activeSponsors)
  writeCsv(inactiveSponsors, "inactive_sponsors.new.csv")

  echo("Make sure that the new csv files don't lose any data, then copy them " &
       "into the _data directory. (Remember to rename them to remove the .new "&
       "suffix.")
