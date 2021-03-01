---
title: "This Month with Nim: Feburary 2021"
author: The Nim Community
excerpt: "Five interesting packages our users worked on in Feburary"
---


## Suber

#### Author: Allin

[Suber](https://github.com/olliNiinivaara/Suber) is an in-process topic-based [publish/subscribe](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern) engine with an in-memory cache.
It is primarily aimed for situations where a server is pushing messages to clients but connections may occasionally fail, and therefore a fast method for redelivering missed messages comes in handy.
Probably also other valid use cases exist.


## [Prologue](https://github.com/planety/prologue) web framework

#### Author: xflywind

Prologue is a powerful web framework written in Nim.
It is ideal for building elegant and high performance web services.
```nim
import prologue

proc hello*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologue!</h1>"

let app = newApp()
app.get("/", hello)
app.run()
```

## Nim SDL2 Game Development Tutorial

#### Author: Kiloneie

An entry level [SDL2 tutorial](https://www.youtube.com/watch?v=x76fT8GG0Pk) aimed at teaching the basics of SDL and the Nim bindings.



## Pixie

#### Author: treeform and guzba 

<p style="text-align: center;">
  <img width="auto" height="400" src="{{ site.baseurl }}/assets/thismonthwithnim/2021-03/pixie.png">
</p>

[Pixie](https://github.com/treeform/pixie) is a 2D graphics library similar to [Cairo](https://www.cairographics.org/) and [Skia](https://skia.org/) written almost entirely in Nim.


## Spacy

#### Author: treeform and guzba 

Spatial algorithms are used to find the "closest" things faster than simple brute force iteration would.
They make your code run faster using smarter data structures.
[Spacy](https://github.com/treeform/spacy) has different "Spaces" that you can use to speed up games and graphical applications.


## Nim VS Code/Codium Extension

#### Author: saem

If you'd like to write programs in Nim and be certain that you're on Nim while doing it, well then the [Nim Extension](https://github.com/saem/vscode-nim) for VS Code/Codium is for you!

Originally started as a port of an extension written in TypeScript, this one is written in straight Nim and compiled to JS -- yes, Nim can do that!
The port started as a project to learn Nim itself and make it easier for Nimions or even new Nimlets to be productive using the language and be empowered to make changes to the extension directly.
Imagine, being able to improve your tools as you go, it's like macros, but your IDE or something.



----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website) to add your project to the next month's blog post.
