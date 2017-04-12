#
#
#           Nim Website Generator
#        (c) Copyright 2017 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

import
  os, strutils, times, parseopt, parsecfg, streams, strtabs, tables,
  re, htmlgen, macros, md5, osproc, parsecsv, algorithm

from xmltree import escape

const
  gitRepo = "https://github.com/nim-lang/Nim"
  cmdRst2Html = " rst2html --compileonly $1 -o:temp/$2.temp src/$2.rst"

type
  TabKind = enum tabRst, tabHtml, tabExternHtml, tabTmpl

const
  projectName = "Nim"
  projectTitle = "Nim Programming Language"
  logo = "efficient, expressive, elegant"
  authors = "Andreas Rumpf and contributors"

  tabs = [
    ("Home", "index", tabRst),
    ("News", "news", tabRst),
    ("Examples", "examples", tabRst),
    ("Download", "download", tabRst),
    ("Community", "community", tabRst),
    ("Sponsors", "sponsors", tabTmpl),
    ("Documentation", "documentation", tabRst)
  ]

type
  ConfigData = object
    outdir: string
    nimArgs: string
    gaId: string  # google analytics ID, nil means analytics are disabled
  TRssItem = object
    year, month, day, title, url, content: string

  Sponsor = object
    logo: string
    name: string
    url: string
    thisMonth: int
    allTime: int
    since: string
    level: int

proc initConfigData(c: var ConfigData) =
  c.outdir = ""
  c.nimArgs = "--hint[Conf]:off --hint[Path]:off --hint[Processing]:off "

proc exe(f: string): string = return addFileExt(f, ExeExt)

proc findNim(): string =
  var nim = "nim".exe
  result = "bin" / nim
  if existsFile(result): return
  for dir in split(getEnv("PATH"), PathSep):
    if existsFile(dir / nim): return dir / nim
  # assume there is a symlink to the exe or something:
  return nim

proc exec(cmd: string) =
  echo(cmd)
  let (outp, exitCode) = osproc.execCmdEx(cmd)
  if exitCode != 0: quit outp

proc getSnippet(c: var ConfigData; file: string): string =
  exec(findNim() & cmdRst2Html % [c.nimArgs, file])
  var temp = "temp" / changeFileExt(file, "temp")
  try:
    result = readFile(temp).replace(""" class="""", """ class="dark """)
  except IOError:
    quit("[Error] cannot open: " & temp)
  removeFile(temp)

include "website.tmpl"
include "sponsors.tmpl"

# ------------------------- configuration file -------------------------------

const
  version = "0.9"
  usage = "nimweb - Nim Website Generator Version " & version & """

  (c) 2017 Andreas Rumpf
Usage:
  nimweb [options] [nim compile_options]
Options:
  -o, --output:dir    set the output directory (default: same as ini-file)
  -h, --help          shows this help
  -v, --version       shows the version
Compile_options:
  will be passed to the Nim compiler
"""

  rYearMonthDay = r"on\s+(\d{2})\/(\d{2})\/(\d{4})"
  rssUrl = "https://nim-lang.org/news.xml"
  rssNewsUrl = "https://nim-lang.org/news.html"
  activeSponsors = "data/sponsors.csv"
  inactiveSponsors = "data/inactive_sponsors.csv"
  validAnchorCharacters = Letters + Digits


macro id(e: untyped): untyped =
  ## generates the rss xml ``id`` element.
  let e = callsite()
  result = xmlCheckedTag(e, "id")

macro updated(e: varargs[untyped]): untyped =
  ## generates the rss xml ``updated`` element.
  let e = callsite()
  result = xmlCheckedTag(e, "updated")

proc updatedDate(year, month, day: string): string =
  ## wrapper around the update macro with easy input.
  result = updated("$1-$2-$3T00:00:00Z" % [year,
    repeat("0", 2 - len(month)) & month,
    repeat("0", 2 - len(day)) & day])

macro entry(e: varargs[untyped]): untyped =
  ## generates the rss xml ``entry`` element.
  let e = callsite()
  result = xmlCheckedTag(e, "entry")

macro content(e: varargs[untyped]): untyped =
  ## generates the rss xml ``content`` element.
  let e = callsite()
  result = xmlCheckedTag(e, "content", reqAttr = "type")

proc parseCmdLine(c: var ConfigData) =
  var p = initOptParser()
  while true:
    next(p)
    var kind = p.kind
    var key = p.key
    var val = p.val
    case kind
    of cmdArgument:
      if key == "nim":
        c.nimArgs.add(cmdLineRest(p))
        break
      else:
        echo("Invalid argument $1" % [key])
        quit(usage)

    of cmdLongOption, cmdShortOption:
      case normalize(key)
      of "help", "h":
        stdout.write(usage)
        quit(0)
      of "version", "v":
        stdout.write(version & "\n")
        quit(0)
      of "o", "output": c.outdir = val
      of "googleanalytics":
        c.gaId = val
        c.nimArgs.add("--doc.googleAnalytics:" & val & " ")
      else:
        echo("Invalid argument $1" % [key])
        quit(usage)
    of cmdEnd: break

# ------------------- main ----------------------------------------------------

proc parseNewsTitles(inputFilename: string): seq[TRssItem] =
  # Goes through each news file, returns its date/title.
  result = @[]
  var matches: array[3, string]
  let reYearMonthDay = re(rYearMonthDay)
  for kind, path in walkDir(inputFilename):
    let (_, name, ext) = path.splitFile
    if ext == ".rst":
      let content = readFile(path)
      let title = content.splitLines()[0]
      let urlPath = "news/" & name & ".html"
      if content.find(reYearMonthDay, matches) >= 0:
        result.add(TRssItem(year: matches[2], month: matches[1], day: matches[0],
          title: title, url: "https://nim-lang.org/" & urlPath,
          content: content))
  result.reverse()

proc genUUID(text: string): string =
  # Returns a valid RSS uuid, which is basically md5 with dashes and a prefix.
  result = getMD5(text)
  result.insert("-", 20)
  result.insert("-", 16)
  result.insert("-", 12)
  result.insert("-", 8)
  result.insert("urn:uuid:")

proc genNewsLink(title: string): string =
  # Mangles a title string into an expected news.html anchor.
  result = title
  result.insert("Z")
  for i in 1..len(result)-1:
    let letter = result[i].toLowerAscii()
    if letter in validAnchorCharacters:
      result[i] = letter
    else:
      result[i] = '-'
  result.insert(rssNewsUrl & "#")

proc generateRss(outputFilename: string, news: seq[TRssItem]) =
  # Given a list of rss items generates an rss overwriting destination.
  var
    output: File

  if not open(output, outputFilename, mode = fmWrite):
    quit("Could not write to $1 for rss generation" % [outputFilename])
  defer: output.close()

  output.write("""<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
""")
  output.write(title("Nim website news"))
  output.write(link(href = rssUrl, rel = "self"))
  output.write(link(href = rssNewsUrl))
  output.write(id(rssNewsUrl))

  let now = getGMTime(getTime())
  output.write(updatedDate($now.year, $(int(now.month) + 1), $now.monthday))

  for rss in news:
    output.write(entry(
        title(xmltree.escape(rss.title)),
        id(genUUID(rss.title)),
        link(`type` = "text/html", rel = "alternate",
          href = rss.url),
        updatedDate(rss.year, rss.month, rss.day),
        "<author><name>Nim</name></author>",
        content(xmltree.escape(rss.content), `type` = "text"),
      ))

  output.write("""</feed>""")

proc buildNewsRss(c: var ConfigData, destPath: string) =
  # generates an xml feed from the news.rst file
  let
    srcFilename = "news"
    destFilename = destPath / changeFileExt(splitFile(srcFilename).name, "xml")

  generateRss(destFilename, parseNewsTitles(srcFilename))

proc readSponsors(sponsorsFile: string): seq[Sponsor] =
  result = @[]
  var fileStream = newFileStream(sponsorsFile, fmRead)
  if fileStream == nil: quit("Cannot open sponsors.csv file: " & sponsorsFile)
  var parser: CsvParser
  open(parser, fileStream, sponsorsFile)
  discard readRow(parser) # Skip the header row.
  while readRow(parser):
    result.add(Sponsor(logo: parser.row[0], name: parser.row[1],
        url: parser.row[2], thisMonth: parser.row[3].parseInt,
        allTime: parser.row[4].parseInt,
        since: parser.row[5], level: parser.row[6].parseInt))
  parser.close()

proc buildSponsors(c: var ConfigData, outputDir: string) =
  let sponsors = generateSponsorsPage(readSponsors(activeSponsors),
                                      readSponsors(inactiveSponsors))
  let outFile = outputDir / "sponsors.html"
  var f: File
  if open(f, outFile, fmWrite):
    writeLine(f, generateHtmlPage(c, "", "Our Sponsors", sponsors, ""))
    close(f)
  else:
    quit("[Error] Cannot write file: " & outFile)

proc buildPage(c: var ConfigData, file, title, rss: string, assetDir = "") =
  exec(findNim() & cmdRst2Html % [c.nimArgs, file])
  var temp = "temp" / changeFileExt(file, "temp")
  var content: string
  try:
    content = readFile(temp)
  except IOError:
    quit("[Error] cannot open: " & temp)
  var f: File
  var outfile = "upload/$#.html" % file
  if not existsDir(outfile.splitFile.dir):
    createDir(outfile.splitFile.dir)
  if open(f, outfile, fmWrite):
    writeLine(f, generateHTMLPage(c, file, title, content, rss, assetDir))
    close(f)
  else:
    quit("[Error] cannot write file: " & outfile)
  removeFile(temp)

proc buildNews(c: var ConfigData, newsDir: string, outputDir: string) =
  for kind, path in walkDir(newsDir):
    let (dir, name, ext) = path.splitFile
    if ext == ".rst":
      let title = readFile(path).splitLines()[0]
      buildPage(c, tailDir(dir) / name, title, "", "../")
    else:
      echo("Skipping file in news directory: ", path)

proc buildWebsite(c: var ConfigData) =
  createDir("temp")
  createDir("upload")
  for i in 0..tabs.len-1:
    if tabs[i][2] == tabRst:
      var file = tabs[i][1]
      let rss = if file in ["news", "index"]: extractFilename(rssUrl) else: ""
      buildPage(c, file, if file == "question": "FAQ" else: file, rss)
  copyDir("assets", "upload/assets")
  buildNewsRss(c, "upload")
  buildSponsors(c, "upload")
  buildNews(c, "news", "upload/news")
  copyFile("src/style.css", "upload/assets/css/style.css")

var c: ConfigData
initConfigData(c)
parseCmdLine(c)
buildWebsite(c)
