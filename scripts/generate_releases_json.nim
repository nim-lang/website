import std/[osproc, strutils, tables, sequtils, json, httpclient, os, algorithm]

const
  nimRepoUrl = "https://github.com/nim-lang/nim.git"
  nightliesRepoUrl = "https://github.com/nim-lang/nightlies.git"
  githubApiBase = "https://api.github.com/repos/nim-lang/nightlies/releases/tags/"

proc runGitLsRemote(url: string): seq[string] =
  ## Runs `git ls-remote --tags <url>` and returns the non-empty lines.
  let cmd = "git ls-remote --tags " & url
  let output = execProcess(cmd)
  for line in output.splitLines():
    let trimmed = line.strip()
    if trimmed.len > 0:
      result.add trimmed

proc extractNimVersions(lines: seq[string]): Table[string, string] =
  ## Parses ls-remote output for the Nim repo and returns
  ## a table mapping version -> commit hash.
  var res = initTable[string, string]()
  for line in lines:
    let parts = line.splitWhitespace()
    if parts.len < 2:
      continue
    let sha = parts[0]
    var refs = parts[1]
    # Ignore dereferenced annotated tag lines.
    # if refs.endsWith("^{}"):
    #   continue
    let tagName = refs.split('/')[^1].replace("^{}","")
    # Nim tags are typically of the form v2.2.6
    if tagName.len < 2 or tagName[0] != 'v':
      continue
    let version = tagName[1..^1]
    res[version] = sha
  res

proc findNightlyTagForCommit(lines: seq[string], commit: string): string =
  ## Finds the nightly tag name whose line contains the given Nim commit hash.
  ## This mirrors `grep $TAG` from the shell script.
  result = ""
  for line in lines:
    if not line.contains(commit):
      continue
    let parts = line.splitWhitespace()
    if parts.len < 2:
      continue
    var refs = parts[1]
    # if not refs.endsWith("^{}"):
    #   continue
    let tagName = refs.split('/')[^1]
    # Keep the last match, mirroring `tail -n1` in the shell script.
    result = tagName.replace("^{}","")

proc deriveOsKey(assetName, version: string): string =
  ## Derives an OS/arch key from an asset filename, e.g.
  ##   nim-2.2.6-linux_x64.tar.xz -> linux_x64
  ##   nim-2.2.6_x64.zip          -> windows_x64
  var base = assetName
  if base.startsWith("nim-"):
    base = base[4..^1]

  # Strip version prefix plus separator.
  if base.len >= version.len and base.startsWith(version):
    var rest = base[version.len .. ^1]
    if rest.len > 0 and (rest[0] == '-' or rest[0] == '_' or rest[0] == '.'):
      rest = rest[1..^1]
    base = rest

  # Strip extension (first dot and everything after) from the remainder.
  let dotIdx = base.find('.')
  if dotIdx != -1:
    base = base[0 ..< dotIdx]

  var osKey = base
  # Heuristic for Windows builds that are just x64/x32.
  if osKey == "x64" or osKey == "x32":
    osKey = "windows_" & osKey

  result = osKey

proc main() =
  # Get all tags from Nim and the nightlies repo.
  let nimTagLines = runGitLsRemote(nimRepoUrl)
  let nightlyTagLines = runGitLsRemote(nightliesRepoUrl)

  # version -> commit hash
  let versions = extractNimVersions(nimTagLines)

  var client = newHttpClient()
  let token = getEnv("GITHUB_TOKEN")
  if token.len > 0:
    client.headers["Authorization"] = "token " & token
  client.headers["User-Agent"] = "nim-website-release-generator"

  var root = newJObject()

  # Iterate versions in a stable order.
  var versionList: seq[string] = @[]
  for v in versions.keys:
    versionList.add v
  versionList.sort()

  for version in versionList[^2..^1]:
    let commit = versions[version]
    let nightlyTag = findNightlyTagForCommit(nightlyTagLines, commit)
    if nightlyTag.len == 0:
      stderr.writeLine "No nightly tag for Nim ", version, " (commit ", commit, "), skipping"
      continue

    let url = githubApiBase & nightlyTag
    try:
      let body = client.getContent(url)
      let parsed = parseJson(body)
      if not parsed.hasKey("assets"):
        stderr.writeLine "No assets for nightly tag ", nightlyTag, " (version ", version, "), skipping"
        continue

      var assetsObj = newJObject()
      for asset in parsed["assets"].getElems():
        let name = asset["name"].getStr()
        if not asset.hasKey("browser_download_url"):
          continue
        let downloadUrl = asset["browser_download_url"].getStr()
        let osKey = deriveOsKey(name, version)

        var osObj = newJObject()
        osObj["url"] = %downloadUrl

        if asset.hasKey("digest"):
          osObj["digest"] = %asset["digest"].getStr()
        if asset.hasKey("updated_at"):
          osObj["updated"] = %asset["updated_at"].getStr()

        assetsObj[osKey] = osObj

      root[version] = assetsObj
    except CatchableError as e:
      stderr.writeLine "Failed to fetch or parse release for ", version, ": ", e.msg

  # Final JSON: { "<version>": { "<os>": { "url": ..., "digest": ..., "updated_at": ... }, ... }, ... }
  echo root.pretty()

when isMainModule:

  when defined(test):
    echo deriveOsKey("nim-2.2.6-linux_x32.tar.xz", "2.2.6")
    assert deriveOsKey("nim-2.2.6-linux_x32.tar.xz", "2.2.6") == "linux_x32"
    assert deriveOsKey("nim-2.2.6-linux_armv7l.tar.xz", "2.2.6") == "linux_armv7l"
    assert deriveOsKey("nim-2.2.6-windows_x32.zip", "2.2.6") == "windows_x32"
  else:
    main()
