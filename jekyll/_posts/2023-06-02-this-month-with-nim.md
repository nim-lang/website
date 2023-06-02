---
title: "This Month with Nim: April and May 2023"
author: The Nim Community
excerpt: "Nuance, Ferus and Gooey"
---


## [Nuance](https://github.com/metagn/nuance)

#### Author: [metagn](https://github.com/metagn)

[nuance](https://github.com/metagn/nuance) is a library that provides:
* Runtime-compatible types to represent Nim (untyped) AST including filename, line and column information.
* Serialization of these types into an S-expression format that can be directly inserted inside a Nim triple-quoted string.
* Deserialization to these types that works in the compile-time VM.
* Conversion from these types into the compile-time NimNode type that can be used in macros.

This allows complex systems that generate Nim code to do it in a much faster and easier way than the current alternatives (making all code run only in the compile-time VM, generating it as raw text, interfacing with the compiler codebase etc.).
Examples of use cases may be templating engines, alternative parsers etc.

As a demonstration of what we can do, [lispnim](https://github.com/metagn/lispnim) is a rudimentary version of Lisp that directly maps to Nim code using this library.
[lispnimgen](https://github.com/metagn/lispnimgen) is a simple binary Nimble package that generates Nim files from lispnim files, in the sense that the Nim file loads the serialized version at compile-time.
[lispnimgentest](https://github.com/metagn/lispnimgentest) is a demonstration of how one can write a Nimble package in lispnim, then generate the Nim files in the installation process of the package.

```
# testpkg/src/testpkg.lispnim

(proc (foo *) ((x y int) int) (do
  (= result (* x y))
  (if (< result 0)
    (raise (newException ValueError "result cannot be negative")))))
```

&nbsp;

```nim
# testpkg/testpkg.nimble

...
requires "https://github.com/metagn/lispnimgen"

import os, strutils
after install:
  let lispnimgenPath = strip staticExec"nimble path lispnimgen"
  let exePath = lispnimgenPath / "lispnimgen"
  # run lispnimgen on install path
  exec quoteShellCommand([exePath, getPkgDir()])
```

Installing `testpkg` will generate a Nim file in its path like:

```nim
# testpkg.nim
import nuance/[fromsexp, comptime]

load(parseSexp("""<serialized ast of testpkg.lispnim>"""))
```

We can then import and use this module:

```nim
import testpkg
# or
import pkg/testpkg

echo foo(3, 7)
echo foo(3, -7)
```

Using `--excessiveStackTrace:off`, we get the output:

```
21
main.nim(4)              cmdfile
testpkg.lispnim(5)       foo
Error: unhandled exception: result cannot be negative [ValueError]
```

We can see that the file and line information has been kept for errors.
Note that this is only possible because of the [macros.setLineInfo proc](https://github.com/nim-lang/Nim/pull/21153) which exists in Nim version 1.6.12 or higher,
meaning custom information will not persist on older versions.

A binary serialization option may be added in the future for faster deserializing at compile time,

All linked libraries are tested on the C, JavaScript and NimScript backends.
The NimScript backend means that they all work on the compile-time VM as well.


## Ferus and FerusHTML

#### Author: [xTrayambak](https://github.com/xTrayambak)

[Ferus](https://github.com/xTrayambak/ferus) is a web engine/browser written in Nim.
It aims to be fast, compliant and secure. It doesn't do much yet, it simply does HTML/CSS parsing, it also has an IPC layer written using reliable UDP (netty), a sandboxed rendering model (rendering is not done on the main process), an incomplete DOM implementation and an experimental layout engine is being worked on.
All of this is done within 2.1k lines of code. My future plans include:

- a rewrite of Bellard's QuickJS in Nim, possibly with JIT compilation
- a fully functional layout engine with support for all HTML tags
- more speed improvements (particularly in the IPC layer)
- full WHATWG compliance
- developer tools
- builtin adblocker/anti-fingerprinter
- embeddable API that abstracts the underlying engine from the main browser itself (like Chromium Embedded Framework or GeckoView)
- Manifest V2/V3 support
- hardware accelerated video decode
- fast 3D graphics (WebGL)

Now, let us talk about Ferus' other component: ferushtml.
[FerusHTML](https://github.com/xTrayambak/ferushtml) is a safe, fast and (somewhat) compliant HTML parser that is still being worked on.
It uses a finite-state-motion based parser but we intend to add a consume based parser soon.
It is *somewhat* fast, it can parse a simple HTML document within 0.1415580014387766 ms,
and it also has a utility for dumping a HTMLElement to show it's children in a neatly organized manner.
It doesn't support attributes yet, but that is the top priority as of right now.

Here is the basic API:
```nim
import ferushtml

let mySource = """
<html>
    <head>
        <title>Hello ferushtml!</title>
    </head>
    <body>
        <p1>This is rather plain.</p1>
    </body>
</html>
"""

# Create a parser
var myParser = newHTMLParser()

# Parse the HTML source
var res = myParser.parse(mySource)

# Dump the source to stdout in a neat tree like manner
echo res.dump()
```

Compile the code with `--threads:on`, and we get this:
![image](https://github.com/beef331/website/assets/59499552/fab11063-99cd-411e-94ee-9a38269f9694)

You can now time how fast the executable is,
or you can check out the benchmark test inside ferushtml tests!

If you are interested in this project,
I would appreciate some help.



## [gooey](https://github.com/beef331/gooey/)

#### Author: [Jason Beetham](https://github.com/beef331/)

Gooey is very hard to describe GUI tool.
It is mostly for my game framework, but it is a renderer and vector agnostic framework.
In theory one could use it for any place such as TUI, embedded, or its main purpose games.


To declare an element one needs to define a few procedures:
- `upload` this sends the UI to its target. In my SDL implementation it blits to the screen. In my game framework implementation it adds the UI to a render queue.
- `interact` this controls interaction, there are a few base procedures that Gooey knows how to call(`onEnter`, `onClick`, `onHover`, `onDrag`, `onExit`, `onTextInput`). More are soon to follow. Enabling more usable widgets.
- `layout` this controls how and where to draw this element using information it has stored.

For instance Gooey has a `buttons` module that implements the base required for a Button:
```nim
import gooey, mathtypes

type ButtonBase*[Base] = ref object of Base
  clickCb*: proc()

proc layout*[Base](button: ButtonBase[Base], parent: Base, offset: Vec3, state: UiState) =
  mixin layout
  Base(button).layout(parent, offset, state)

proc onClick*[Base](button: ButtonBase[Base], uiState: var UiState) =
  if button.clickCb != nil:
    button.clickCb()
```

To use this in my SDL implementation I do:
```nim
type
  Button = ref object of ButtonBase[Element]
    baseColor: Color
    hoveredColor: Color = (127, 127, 127, 255)
    button: Label

proc upload(button: Button, state: UiState, target: var RenderTarget) =
  Element(button).upload(state, target)
  if button.label != nil:
    button.label.upload(state, target)

proc layout(button: Button, parent: Element, offset: Vec3, state: UiState) =
  buttons.layout(button, parent, offset, state)
  if button.label != nil:
    button.label.size = button.size
    button.label.layout(button, (0f, 0f, 0f), state)

proc onEnter(button: Button, uiState: var UiState) =
  button.flags.incl {hovered}
  button.baseColor = button.color
  button.color = button.hoveredColor

proc onExit(button: Button, uiState: var UiState) =
  button.color = button.baseColor

proc onClick(button: Button, uiState: var UiState) = buttons.onClick(button, uiState)
```

With all of that one is now capable of using a Button assuming they did everything properly.

A full implementation is visible [here](https://github.com/beef331/gooey/blob/master/example/sdlimpl.nim).

This is a rapidly developing UI system that will change depending on my needs and wants.

----


## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
