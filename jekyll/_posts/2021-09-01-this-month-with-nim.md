---
title: "This Month with Nim: September 2021"
author: The Nim Community
excerpt: "Three interesting projects our users worked on in September"
---

## [HTTP Harpoon](https://juancarlospaco.github.io/harpoon)

#### Author: [Juan](https://github.com/juancarlospaco)

- Same API as stdlib `HttpClient`.
- 1 file, 0 dependencies, 300 lines, pure Nim.
- No Curl nor LibCurl dependencies.
- Async and sync client.
- Works with ARC and ORC. Works with `strictFuncs`.
- Uses `Uri` type for URL.
- `GET` and `POST` from JSON to JSON directly.
- `downloadFile` that takes `openArray` of URLs.
- HTTP Headers can be compile-time immutable `const`.
- Proxy support, with Auth.
- Response has `isIpv6: bool` attribute.
- Timeout support for Async and Sync.
- Option to skip parsing headers or status code or body, if you dont need them.
- HTTP Methods use `HttpMethod` enum, not strings. Status code use `HttpCode` not integers.
- Share a `Socket` with multiple clients, reuse `Socket`.
- Theres no open/close functions for the client, just call `get()` or `post()`.
- Works with Threads, Tasks, and other Async implementations.
- Uses very few symbols from stdlib, very future proof.
- `runnableExamples` with `doAssert` for everything.
- Documentation online.


##### GET and POST

Examples require to import `harpoon` and `uri`.

```nim
echo getContent(parseUri"http://httpbin.org/get")
echo postContent(parseUri"http://httpbin.org/post", "data here")
```


##### GET and POST from JsonNode to JsonNode

```nim
import std/json
let jsonData: JsonNode = %*{"key": "value", "other": 42}
doAssert getJson(parseUri"http://httpbin.org/get") is JsonNode
doAssert postJson(parseUri"http://httpbin.org/post", jsonData) is JsonNode
```


##### Download files

```nim
downloadFile(parseUri"http://httpbin.org/image/png", "temp.png")
downloadFile([(url: parseUri"http://httpbin.org/image/png", path: "temp.png"), 
              (url: parseUri"http://httpbin.org/image/jpg", path: "temp.jpg")])
```


##### HTTP Headers can be const

```nim
const header = newDefaultHeaders("body", "application/json", "application/json")
# Use std/sequtils to manipulate the header or something...
```


##### Async

```nim
import std/asyncdispatch

proc example() {.async.} =
  doAssert getContent("http://httpbin.org/get") is Future[string]
  doAssert deleteContent("http://httpbin.org/delete") is Future[string]
  doAssert putContent("http://httpbin.org/put", "data here") is Future[string]
  doAssert postContent("http://httpbin.org/post", "data here") is Future[string]
  doAssert patchContent("http://httpbin.org/patch", "data here") is Future[string]
  doAssert downloadFile("http://httpbin.org/image/png", "temp.png") is Future[void]

waitFor example()
```


##### PUT, DELETE, etc

```nim
echo deleteContent(parseUri"http://httpbin.org/delete")
echo putContent(parseUri"http://httpbin.org/put", "data here")
echo patchContent(parseUri"http://httpbin.org/patch", "data here")
```


## [Goodboy Galaxy](https://www.goodboygalaxy.com/)

#### Authors: [@exelotl](https://twitter.com/exelotl) and [@hot_pengu](https://twitter.com/hot_pengu)

Goodboy Galaxy is an exploration-focused platform game in development for Game Boy Advance, PC and Nintendo Switch.

This month, the developers launched a [Kickstarter](https://www.kickstarter.com/projects/penguinrik/goodboy-galaxy-exploration-platform-game-gba-pc-and-switch) campaign to fund the game's development and bring it to real GBA carts.
The campaign exceeded all expectations, meeting its funding goal in less than 8 hours!
A free demo ([Chapter Zero](https://hotpengu.itch.io/goodboy-galaxy-demo)) is available to play right now in your browser, in an emulator, or on a real GBA.

The game is written in Nim using the [Natu](https://github.com/exelotl/natu) library, and has been worked on for about two years (during the developers' free time).
If you'd like to learn more about the development process, see their [forum post](https://forum.nim-lang.org/t/8375), and the NimConf [video](https://www.youtube.com/watch?v=sZUM7MhWr88&list=PLxLdEZg8DRwTIEzUpfaIcBqhsj09mLWHx&index=9) from last year.

## [CPython](https://github.com/juancarlospaco/cpython#alternative-stdlib-for-nim-for-python-targets)

#### Author: [Juan](https://github.com/juancarlospaco)
Hijacks the Python 3.10+ standard library for Nim.

A whole new standard library becomes usable for Nim, without Nim having to spend any resources.

Showcases the easy and transparent interoperability of Nim (Python's CTypes is a lot harder, etc).
Nim is also likely less verbose than Python (files are <200 lines each).

Code is very simple and easy to hack for new users, no complex Macros, just [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) templates.

Each file is completely self-contained standalone,
you can copy just 1 file on your project and use it, steal the code.

Same API as Python standard library, same function names, 
same argument names, same module filenames, same imports,
any Python documentation becomes a documentation you can use with Nim.

It is also a place to pile up "Nim-ified" Python stuff,
anything that people are interested in can be added in the future (games?, science?, etc),
if you are interested, Pull Requests are welcome !.

##### [Arbitrary precision big Decimals](https://juancarlospaco.github.io/cpython/decimal.html)

```nim
import cpython/decimal

let x: PyDecimal = newDecimal"999999999999999999999999999999999999999.999999999999999999999999999999999999999"
let y: PyDecimal = -999999999999999999999999999999999999999.999999999999999999999999999999999999999'PyD
let z: PyDecimal = newDecimal BiggestUint.high
echo toString(x * y + z - z)
```

No limits on the size, only limited by memory capacity.

Decimals have all the math operators, like
`-`, `+`, `<`, `<=`, `==`, `>`, `>=`, `!=`, `*`, `div`, `**`, `shl`, `shr`, `inc`, `dec`, etc

Input can be a Nim `string`, `float`, `int`, etc. `math` modules are available.

You can get back a Nim type in the end using `toFloat` or `toInt` or `toUint` etc.

[os](https://juancarlospaco.github.io/cpython/os.html) and [sys](https://juancarlospaco.github.io/cpython/sys.html) modules work too.


##### [Pet the Turtle](https://juancarlospaco.github.io/cpython/turtle.html)

- This draws a star in a GUI window, meant for kids or people learning programming:

```nim
import cpython/turtle

title "Nim Turtle"
shape "turtle"
shapesize 2, 2, 8
color "green", "yellow"
speed "fast"
beginFill()

while true:
  forward 200
  left 170
  if position() < (1.0, 1.0):
    break

endFill()
mainLoop()
```


###### Thank you for reading

Whats the rule that dictates that a programming language can only have 1 standard library?,
lets break it..., lets have 2, why 2?, lets have 4!,
maybe in the future there can be a standard library optimized for JavaScript,
a standard library optimized for working with Python, etc lets keep cool stuff incoming...

----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim) to add your project to the next month's blog post.
