---
title: "This Month with Nim: October 2021"
author: The Nim Community
excerpt: "Six interesting projects our users worked on in October"
---


## [changer](https://github.com/iffy/changer)

#### Author: [Iffy](https://github.com/iffy)

I love projects that keep an accurate changelog. But most people (me included) don't like maintaining a changelog or fixing conflicts in the changelog. With [`changer`](github.com/iffy/changer) you can add a conflict-free, easy-to-maintain changelog to your project!

Initial setup:

```
nimble install changer
mkdir myproject && cd myproject
changer init
```

Any time you want to add a new changelog entry run `changer add` and follow the two prompts:

```
$ changer add
Change type:
  [F]ix
  [N]ew feature
  [B]reaking change
  [O]ther (default)

Describe change (this will show up in the changelog): 
This project has a changelog now!
changes/new-This-project-has-20211005-132645.md
```

When you're ready to release a new version run `changer bump` to combine all pending changes into the `CHANGELOG.md` file.

```
$ cat CHANGELOG.md 
# v0.1.0 - 2021-10-05

- **NEW:** This project has a changelog now!
- **FIX:** Fixed a broken thing
```

Changer can also convert issue numbers into links (or do other simple substitutions), automatically change the version in your `.nimble` file or even a `package.json` file. Happy coding!



## [OOlib](https://github.com/Glasses-Neo/OOlib)

#### Authors: [Neo](https://github.com/Glasses-Neo)

OOlib is a nimble package for object oriented programming in Nim.
example:
```nim
import strformat
import oolib


# add `pub` prefix to export class
class pub Person:
  var
    name*: string
    age* = 0

  # auto insert `self` as first argument
  proc `$`*: string = fmt"<Person> name: {self.name}"

  proc happyBirthday* =
    inc self.age


# auto define constructor
let p1 = newPerson("Tony")
let p2 = newPerson("Steve", 100)
```
It has the following features:
- Member variables with default values
- Class data constants
- Definition of `proc`, `method`, `func`, etc... (the only exception being `macro`)
- Auto inserting `self` as first argument
- Auto definition of constructor (high performance!)
- Assistance with constructor definition
- `pub` modifier instead of `*`
- Inheritance with `of` modifier
- Creating distinct type with `distinct` modifier
- `{.final.}` by default
- `{.open.}` to allow inheritance
- `super` keyword for `method`
- Alias class

More features are planned:
- `Pick` like TypeScript's `Pick`
- `let` member variables
- struct
- protocol like `interface`


## [LibVF.IO](https://libvf.io)

#### Author: [Arthur Rasmusson](https://github.com/arthurrasmusson)

LibVF.IO is commodity GPU multiplexing driven by YAML & VFIO. 
We wrote an article about it [here](https://telegra.ph/LibVFIO-A-Vendor-Neutral-GPU-Multiplexing-Tool-09-27)

LibVF.IO is made in Nim. :)


## [Metaprogramming in Nim #1 Introduction
](https://youtu.be/2EWLE-IFgGM)

#### Author: [Kiloneie](hhttps://github.com/Kiloneie)

In this video i show and teach Nim's Metaprogramming features/capabilities. Each of it's features are explained and demonstrated in a beginner friendly manner.

## [Nimscripter 1.0.0 - The Rewrittening](https://github.com/beef331/nimscripter)

#### Author: [Jason Beetham](https://github.com/beef331)

Over the past few months I have slowly been chipping at a Nimscripter rewrite and got it to a usable state in October!
No longer does it rely on silly string serialization or other annoying things, you can now easily expose code to a VM and call it or expose VM code to the compiled code and call it. 
The following is a simple example:
```nim
import nimscripter
addCallable(someNSModule):
  proc doThing(a: int): int

var someNum = 10
proc doOtherThing: bool = true
exportTo(someNsModule,
  someNum,
  doOtherThing)
const
  script = """
proc doThing*(a: int): int = 
  if doOtherThing():
    someNum * a
  else: 0
"""
  addins = implNimScriptModule(someNsModule)
let intr = loadScript(NimScriptFile(script), addins)
assert intr.invoke(doThing, 2, returnType = int) == 2 * someNum
someNum = 30
assert intr.invoke(doThing, 4, returnType = int) == 4 * someNum
```
What's that I hear, "Oh it'd be cool if it worked with emscripten"?!
[Well it does!](https://www.jasonbeetham.com/snake/nicoscripter.html)

----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
