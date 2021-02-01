---
title: "January 2021's Month with Nim"
author: The Nim Community
excerpt: ""
---
## TrailRunner

### Author: Tuatarian

[TrailRunner](https://github.com/Tuatarian/TrailRunner) is a very simple time-wastey kind of mobile game which you'd play for a few minutes or so when you're waiting for something. The main goal of this turn & grid based game is to survive as many randomly generated levels as possible, without getting hit, without stepping on the same spot twice, and while walking on as few squares as possible.
<p style="text-align: center;">
  <img width="auto" height="300" src="{{ site.baseurl }}/assets/thismonthwithnim/2021-02/trailrunner.png">
</p>
Most of the engine/framework is pretty much done. The game itself is actually quite playable already, the next features up are the score system and random level generation

___

## Ircord

### Author: Yardanico

 [Ircord](https://github.com/Yardanico/ircord) is a bridge between Discord and IRC which allows you to connect multiple channels from your Discord server with multiple channels on IRC. It is used on the official Nim Discord server and a few others. Supports features like edits, code pastes, pings, bans, IRC and Markdown formatting.

___
## cflang

### Author: lqdev

[cflang](https://github.com/liquidev/cflang) is a minimalist, esoteric, functional programming language designed specifically to be simple, but at the same time human-readable and Turing-complete. The reference implementation is made in Nim, using [NPeg](https://github.com/zevv/npeg) for quick and easy parsing.

___

## Linerino

### Author: Jason Beetham

<p style="text-align: center;">
  <img width="auto" height="400" src="{{ site.baseurl }}/assets/thismonthwithnim/2021-02/linerino.png">
</p>
[Linerino](https://jbeetham.itch.io/linerino) is a small little puzzle game which the goal is simple, visit all the tiles. It's built using the [Nico](https://github.com/ftsf/nico) framework which can be built to the web, native and even to Android(only have Android + web published at the moment). The cool thing is how I load the tutorials, they're loaded at compile time and are embedded in all platforms! Below is how it's done:

```nim
const Tutorials* = static:
  var levels: seq[(Tutorial,int)]
  for x in walkDir("tutorials/", true):
    if x.path.endsWith(".tut"):
      var id: int
      if x.path.scanf("tutorial$i.tut", id):
        levels.add (system.readFile("./tutorials" / x.path).parseJson.to(Tutorial), id)
  levels = levels.sortedByIt(it[1])
  collect(newseq):
    for (tut, _) in levels:
      tut
```

___

## ADBScan

### Author: Yardanico

[ADBScan](https://github.com/Yardanico/adbscan) is a simple utility for finding unprotected ADB devices over the internet. The scanning process is asynchronous and quite fast. Supports multiple input (plain text IP list and Masscan output) and output (CSV, JSON, plain text) formats.

___

## pan

### Author: lqdev

[pan](https://github.com/liquidev/pan), or puny animator, is my little program for designing and rendering motion graphics with Lua scripts. This month I worked on bringing it to the latest version of my game engine, as well as adding support for images, and rendering to offscreen buffers.

___

## Refactored html2karax


### Author: planetis

[html2karax](https://github.com/nim-lang-cn/html2karax/pull/1) can convert a static html to [Karax](https://github.com/pragmagic/karax/) DSL code. In my PR, I refactored it and fixed most of the issues I came across, making it more practical for converting html snippets, as well as full pages. As a reminder, Karax is a framework for developing single page applications in Nim. It can also be used for server-side rendering! Try it and report any issues you may find.

___

### Want to see your project here next month?

[Follow this](https://github.com/beef331/website) to add your project to the next month's blog post.