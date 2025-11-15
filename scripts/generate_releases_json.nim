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

  if osKey == "tar":
    result = "source"
  result = osKey

proc nimlangUrl(version, osKey: string): string =
  ## Returns the canonical download URL on nim-lang.org for a subset of OS keys.
  ## Note: only windows_{x32,x64} and linux_{x32,x64} are hosted on nim-lang.org.
  const base = "https://nim-lang.org/download/"
  case osKey
  of "windows_x32":
    result = base & "nim-" & version & "_x32.zip"
  of "windows_x64":
    result = base & "nim-" & version & "_x64.zip"
  of "linux_x64":
    result = base & "nim-" & version & "-linux_x64.tar.xz"
  of "linux_x32":
    result = base & "nim-" & version & "-linux_x32.tar.xz"
  else:
    result = ""

proc main() =
  # Get all tags from Nim and the nightlies repo.
  let nimTagLines = runGitLsRemote(nimRepoUrl)
  let nightlyTagLines = runGitLsRemote(nightliesRepoUrl)

  # version -> commit hash
  let versions = extractNimVersions(nimTagLines)

  # Configure GitHub API headers, including optional auth token.
  var headers = newHttpHeaders({"x-github-api-version": "2022-11-28"})
  var githubToken = getEnv("GITHUB_TOKEN")
  if githubToken.len > 0:
    headers["authorization"] = "Bearer " & githubToken
  headers["user-agent"] = "nim-website-release-generator"

  var client = newHttpClient()
  client.headers = headers

  var root = newJObject()

  # Collect versions and iterate from latest to oldest.
  var versionList: seq[string] = @[]
  for v in versions.keys:
    versionList.add v
  sort(versionList, Descending)

  for version in versionList:
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
        osObj["github_url"] = %downloadUrl

        if asset.hasKey("digest") and asset["digest"].getStr() != "":
          osObj["digest"] = %asset["digest"].getStr()
        if asset.hasKey("updated_at") and asset["updated_at"].getStr() != "":
          osObj["updated"] = %asset["updated_at"].getStr()

        let nlUrl = nimlangUrl(version, osKey)
        if nlUrl.len > 0:
          osObj["nimlang_url"] = %nlUrl

        assetsObj[osKey] = osObj

      root[version] = assetsObj
    except CatchableError as e:
      stderr.writeLine "Failed to fetch or parse release for ", version, ": ", e.msg

  # Final JSON: { "<version>": { "<os>": { "url": ..., "digest": ..., "updated_at": ..., "nimlang_url": ... }, ... }, ... }
  let srcPath = currentSourcePath()
  let scriptDir = splitFile(srcPath).dir
  let repoRoot = parentDir(scriptDir)
  let dataDir = repoRoot / "jekyll" / "_data"
  createDir(dataDir)
  let outPath = dataDir / "nim_releases.json"
  writeFile(outPath, root.pretty())
  stderr.writeLine "Wrote Nim releases JSON to: ", outPath

when isMainModule:

  when defined(test):
    echo deriveOsKey("nim-2.2.6-linux_x32.tar.xz", "2.2.6")
    assert deriveOsKey("nim-2.2.6-linux_x32.tar.xz", "2.2.6") == "linux_x32"
    assert deriveOsKey("nim-2.2.6-linux_armv7l.tar.xz", "2.2.6") == "linux_armv7l"
    assert deriveOsKey("nim-2.2.6-windows_x32.zip", "2.2.6") == "windows_x32"
  else:
    main()
