---
title: "One web framework to rule over all fashions"
author: Zeshen Xing (xflywind)
excerpt: "Nim language is an elegant and expressive programming language. The article talks about how to extend the routing fashion without invading inside the web framework."
---

<div class="sidebarblock">
  <div class="content">
    <div class="title">Guest post</div>
    <div class="paragraph">
      This is a guest post by Zeshen Xing (xflywind). If you would like to publish articles as a guest author on nim-lang.org then get in touch with us via
      <a href="https://twitter.com/nim_lang">Twitter</a> or <a href="https://nim-lang.org/community.html">otherwise</a>.
    </div>
  </div>
</div>


## Introduction

Nim language is an elegant and expressive programming language. The powerful macros system allows you to create impressive programs. Let's play with the magics in the Nim world.

## Requirement

Nim Version >= 1.4.0 [Installation](https://nim-lang.org/install.html)

`Prologue` Version >= 0.4.0 

```
nimble install prologue@0.4.0
```

## Background

[Prologue](https://github.com/planety/prologue) is a great web framework in the Nim world. However, `Prologue` framework tries to avoid using `macros`. It is intended to `reduce magic and reduce surprise`. Macros could save you from redundant codebases. At the mean time, it could bring surprise. This article talks about how to extend the routing fashion outside `Prologue` without invading inside the web framework.

There are three ways to register routing out of box using `Prologue`. 

Using a callback is the most basic way. First write an asynchronous function which responds "Hello World!" to the client. Next create a new `Prologue` instance. Then use `get` function to register the routing and handler. Finally `run` the application. 

Visit `localhost:8080/hello` and "Hello World!" will be displayed on the screen.

```nim
import prologue

proc hello(ctx: Context) {.async.} =
  resp "Hello World!"

var app = newApp()
app.get("/hello", hello)
app.run()
```

If you love `Express.js` or `Koa` web framework, you may prefer the fashion below which uses anonymous function.

Visit `localhost:8080/hello` and "Hello World!" will be displayed on the screen.

```nim
import prologue

var app = newApp()
app.get("/hello", proc(ctx: Context) {.async.} =
  resp "Hello World!")
app.run()
```

If you love `Django` web framework, you may prefer the fashion below which uses URL patterns.

Visit `localhost:8080/hello` and "Hello World!" will be displayed on the screen.

```nim
import prologue

proc hello(ctx: Context) {.async.} =
  resp "Hello World!"

let urlPatterns* = @[
  pattern("/hello", hello)
]

var app = newApp()

app.addRoute(urls.urlPatterns, "")
app.run()
```

## Magics

The topic of today is to extend `Prologue` with the powerful macros outside the web framework.

If you love `Flask` web framework, you may prefer the fashion below which uses `pragma` to simulate decorator.

The core codebase is **just 4 lines**:

```nim
import prologue
import std/macros


macro get*(app: Prologue, path: string, body: untyped) = 
  let handler = body[0] # Gets the name of handler, for example "hello"
  result = quote do:
    prologue.get(`app`, `path`, `handler`)

macro get*(app: Prologue, path: string, middlewares: openArray[HandlerAsync], body: untyped) = discard

var app = newApp()

proc hello(ctx: Context) {.async, get(app, "/hello").} =
  resp "<h1>Hello, Prologue!</h1>"

app.run()
```

If you love `Jester` or `Sinatra` web framework,  you may prefer the fashion below.

The core codebase is **just 4 lines** too:

```nim
import prologue except get
import std/[macros, with]


macro get*(app: Prologue, route: string, body: untyped) =
  let ctx = ident"ctx"
  result = quote do:
    prologue.get(`app`, `route`, proc (`ctx`: Context) {.async.} = `body`)


var app = newApp()

with app:
  get "/":
    resp "<h1>Hello, Prologue!</h1>"

app.run()
```

## Automation

The powerful macros system could transform `Prologue` framework into the DSL fashion completely(Thanks to @`exelotl` and @`Vindaar`). It could be used to generate codebases using templates. Redundant codes will be simplified. The less is more.

The full codebase is **less than 40 lines**. `defineRouteSugar` and `defineGroup` are the templates to generate all the DSL routing functions. It makes codebases simple and hard to go wrong.

```nim
# dsl_fashion.nim
import prologue except head, get, post, put, delete, options
import std/macros

export prologue

macro defineRouteSugar(name: untyped) =
  let ctx = ident"ctx"
  result = quote do:
    template `name`*(app: Prologue, route: string, body: untyped) =
      prologue.`name`(app, route, proc(`ctx`: Context) {.async.} =
                                    let ctx {.inject.} = `ctx`
                                    body)

macro defineGroupSugar(name: untyped) =
  let ctx = ident"ctx"
  result = quote do:
    template `name`*(group: Group, route: string, body: untyped) =
      prologue.`name`(group, route, proc(`ctx`: Context) {.async.} = 
                                      let ctx {.inject.} = `ctx`
                                      body)

defineRouteSugar(head)
defineRouteSugar(get)
defineRouteSugar(post)
defineRouteSugar(put)
defineRouteSugar(delete)
defineRouteSugar(options)


defineGroupSugar(head)
defineGroupSugar(get)
defineGroupSugar(post)
defineGroupSugar(put)
defineGroupSugar(delete)
defineGroupSugar(options)
```

Test code:

```nim
# app.nim
include dsl_fashion
import std/with


var
  app = newApp()
  base = newGroup(app, "/apiv2", @[])
  level1 = newGroup(app,"/level1", @[], base)
  level2 = newGroup(app, "/level2", @[], level1)
  level3 = newGroup(app, "/level3", @[], level2)

with app:
  get "/":
    resp "<h1>Hello, Prologue!</h1>"

  get "/hello":
    resp "<h1>Hello, Prologue!</h1>"

with base:
  get "/":
    resp "<h1>Hello, Prologue!</h1>"

  post "/":
    resp "<h1>Hello, Prologue!</h1>"

with level3:
  get "/":
    resp "<h1>Hello, Prologue!</h1>"

  get "/hello":
    resp "<h1>Hello, Prologue!</h1>"

app.run()
```

If you are interested in `Prologue` or want to maintain these plugins based on macros, welcome to join our [discord server](https://discord.gg/e2dB4WT).
