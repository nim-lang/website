---
title: "This Month with Nim: November and December 2022"
author: The Nim Community
excerpt: "Cliche, WebRTC, Nimrun Action and p5nim"
---

## New [Cliche](https://github.com/juancarlospaco/cliche) version

#### Author: [Juan Carlos](https://github.com/juancarlospaco)

New Cliche version:
- [Added support for `bool`](https://github.com/juancarlospaco/cliche/pull/9#issue-1445943903).
- Reads `enum`, `Positive`, `Natural`, `BiggestInt`, `BiggestFloat`, `int`, `float` directly from command line.
- Fallbacks for values: static default ➡️ env var ➡️ command line.
- Uses `parseInt` for int, `parseFloat` for float, `parseEnum` for enum, etc.

```nim
import std/strutils
import cliche
# Use https://nim-lang.github.io/Nim/os.html#commandLineParams
type Food = enum PIZZA, TACO  # Enum from CLI.
# let real = commandLineParams()
let fake = @["--a=1", "--v_1=9.9", "--v2=1", "--v3=2", "--v4=X", "--v5=t", "--v6=5", "--v7=true", "--food=PIZZA"]
fake.getOpt (a: int.high, v_1: 3.14, v2: 9'u64, v3: -9'i64, v4: "a", v5: '4', v6: 9.Positive, v7: false, missing: 42, food: TACO)
doAssert a == 1  # int
doAssert v_1 == 9.9  # float
doAssert v2 == 1'u64  # uint64
doAssert v3 == 2'i64  # int64
doAssert v4 == "X"  # string
doAssert v5 == 't'  # char
doAssert v6 == 5.Positive  # Positive
doAssert v7 == true  # bool
doAssert missing == 42 # missing is not in fake, fallback to default value 42.
doAssert food is Food and food == PIZZA  # food is Food.PIZZA
```

- https://github.com/juancarlospaco/cliche
- https://juancarlospaco.github.io/cliche

## [WebRTC for Nim](https://juancarlospaco.github.io/nodejs/nodejs/jswebrtc)

#### Author: [Juan Carlos](https://github.com/juancarlospaco)

New WebRTC for Nim (Web Real-Time Communications) just landed:

- https://juancarlospaco.github.io/nodejs/nodejs/jswebrtc
- https://github.com/juancarlospaco/nodejs

From stdlib only uses JsObject, Blob, Node, Future types.

## [Nimrun Action](https://github.com/juancarlospaco/nimrun-action#nimrun-action)

#### Author: [Juan Carlos](https://github.com/juancarlospaco)

[GitHub Action](https://github.com/features/actions) to compile and run Nim source code [from GitHub issue comments code blocks](https://github.com/juancarlospaco/nimrun-action/issues/3#issuecomment-1351871284).

<p style="text-align: center;">
  <video src="{{ site.url }}{{ site.baseurl }}/assets/thismonthwithnim/2023-01/nimrun-action-video.mp4" controls="controls" muted="muted" style="max-height:640px;">
  </video>
</p>

<p style="text-align: center;">
  <img width="auto" height="300" src="{{ site.url }}{{ site.baseurl }}/assets/thismonthwithnim/2023-01/nimrun-action-screenshot.png">
</p>

## [p5nim](https://github.com/pietroppeter/p5nim)

#### Author: [pietroppeter](https://github.com/pietroppeter)

[p5nim](https://github.com/pietroppeter/p5nim) is a wrapper for [p5js](https://p5js.org) nim library.
I have picked up the old bindings https://github.com/Foldover/nim-p5/ which were not working with a more recent nim, fixed them and starting to improve them. In particular I make it easy to call p5js with [nimib](https://github.com/pietroppeter/nimib/). I have also started to add a wrapper for p5sound (additional library to use sound).

p5js is a great library to create visualization, generative art, games and generally speaking [creative coding](https://en.wikipedia.org/wiki/Creative_coding). It has a specific focus on making coding accessible and inclusive for artists, designers, educators, beginners, and anyone else! Great learning material has been published: [the coding train], [the nature of code].
The community around p5js is very active (you can look for #p5js tag on mastodon, twitter, ...) and welcoming with examples often sharing the source on [openprocessing].

The goal of p5nim is to continue improving the wrapper and provide examples of p5js code ported to p5nim. You are much welcome to contribute new examples! The website is still a bit clunky but it will be improved. It is now available to install on nimble with `nimble install p5nim`. Here is a very nice example of animated art ([live+source](https://pietroppeter.github.io/p5nim/okazz_220919a.html)): 

<p style="text-align: center;">
  <img width="auto" height="300" src="{{ site.url }}{{ site.baseurl }}/assets/thismonthwithnim/2023-01/p5nim-okazz.png">
</p>

----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
