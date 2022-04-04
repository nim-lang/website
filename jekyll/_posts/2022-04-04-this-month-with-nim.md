---
title: "This Month with Nim: Feburary and March 2022"
author: The Nim Community
excerpt: "Automatic C bindings, a Declarative GTK, Typesafe-ish macros, and a GameCube Emulator"
---


## [Futhark](https://github.com/PMunch/futhark)

#### Author: [PMunch](https://github.com/PMunch)

Have your eyes set on the perfect C library for your project?
Can't find a wrapper for it in Nim?
Look no further!

Futhark aims to allow you to simply import C header files directly into Nim,
and allow you to use them like you would from C without any manual intervention.
It is still in an alpha state,
but it can already wrap many complex header files without any rewrites or pre-processing.

```nim
import futhark

# Tell futhark where to find the C libraries you will compile with, and what
# header files you wish to import.
importc:
  sysPath "/usr/lib/clang/12.0.1/include"
  path "../stb"
  define STB_IMAGE_IMPLEMENTATION
  "stb_image.h"

# Tell Nim how to compile against the library. If you have a dynamic library
# this would simply be a `--passL:"-l<library name>`
static:
  writeFile("test.c", """
  #define STB_IMAGE_IMPLEMENTATION
  #include "../stb/stb_image.h"
  """)
{.compile: "test.c".}

# Use the library just like you would in C!
var width, height, channels: cint

var image = stbi_load("futhark.png", width.addr, height.addr, channels.addr, STBI_default.cint)
if image == nil:
  echo "Error in loading the image"
  quit 1

echo "Loaded image with a width of ", width, ", a height of ", height, " and ", channels, " channels"
stbi_image_free(image)
```

Install the newest 0.5.0 version now with:

```
nimble install futhark
```




## [OwlKettle](https://github.com/can-lehmann/owlkettle)

#### Author: [Can Lehmann](https://github.com/can-lehmann)

OwlKettle is a declarative user interface framework based on GTK. It brings the declarative GUI paradigm you know from many web frameworks to the Linux desktop.

Let's look at an example application:

```nim
import owlkettle

viewable App:
  counter: int

method view(app: AppState): Widget =
  result = gui:
    Window:
      title = "Counter"
      default_size = (200, 60)
      border_width = 12

      Box(orient = OrientX, spacing = 6):
        Label(text = $app.counter)
        Button:
          text = "+"
          style = {ButtonSuggested}
          proc clicked() =
            app.counter += 1

brew(gui(App()))
```

This code results in the following interactive application:

![An example application](https://github.com/can-lehmann/owlkettle/blob/main/docs/assets/introduction.png?raw=true)

If interested, check out [more examples](https://github.com/can-lehmann/owlkettle/tree/main/examples).




## [Micros](https://github.com/beef331/micros)

#### Author: [Jason Beetham](https://github.com/beef331)

Micros is an early state typesafe API on top of Nim's `NimNode`s.
It provides utility procedures for these types to enable simpler and more readable APIs.

Want to iterate a procedure's parameters?

Just do:
```nim
for idefs in myProcDef.routine.params:
  for name in idefs.names:
    echo name.NimNode
```


Want to add a generic parameter to an object definition?

Just do:
```nim
myTypeDef.objectDef.addGeneric identDef("Y", int or string or float)
```

It is pretty early so there are not many docs,
but I have started migrating my other macro libraries to it,
as it's more maintainable and easier to understand.

If wanting to see more examples I have a bunch of [tests](https://github.com/beef331/micros/tree/master/tests).




## [hocuspocube](https://github.com/RSDuck/hocuspocube)

#### Authors: [RSDuck](https://github.com/RSDuck) / doofenstein

Hocuspocube is a Nintendo GameCube emulator.

At this stage it's able to boot the IPL (initial program loader,
which loads games from DVDs and also displays the famous rolling cube animation)
as well as several commercial games.
For faster execution it features an IR based JIT recompiler,
so that both the PowerPC core (Gekko) and the DSP can share a backend for code generation.
For assembling my own assembler, [catnip](https://github.com/RSDuck/catnip) is used.

The go-to language for emulators is usually C++, mainly for performance reasons.
But I see Nim fitting this requirement just as well,
while avoiding many of the hassles C++ has
(and also just being my favourite programming language overall).

I want to highlight some macros in the codebase:


### The instruction decoding macro

Fast instruction decoding in software is normally all about creating the smallest possible LUT/case statement,
where some bits of the instruction are entered which then dispatches it to the appropriate handler.
As you can probably imagine, this is a recipe for giant seas of constants like
[this](https://github.com/Arisotura/melonDS/blob/master/src/ARM_InstrTable.h).

It is not the worst thing in the world,
but it's also something you can avoid with Nim!
With the macro, all we have to define are those pretty instruction patterns:

```nim
const PpcPatterns* =
    (block:
        var patterns: seq[(string, string)]

        # Integer Arithmetic
        template intArith(name: string, num: int, oe = true): untyped =
            patterns.add (name, "011111dddddaaaaabbbbb" & (if oe: "o" else: "0") & toBin(num, 9) & "r")
        template intArithImm(name: string, num: int): untyped =
            patterns.add (name, toBin(num, 6) & "dddddaaaaaiiiiiiiiiiiiiiii")
        intArith    "addx",         266
        intArith    "addcx",        10
        intArith    "addex",        138
        intArithImm "addi",         14
        intArithImm "addic",        12
        intArithImm "addicdot",     13
        #....
        patterns)

macro dispatchPpc*[T](instr: uint32, state: var T, undefinedInstr: proc(state: var T, instr: uint32)) =
    generateDecoder[26..31, 1..10](PpcPatterns, initTable[string, seq[(string, uint32)]](), 32, instr, state, undefinedInstr)
```

As a bonus, the macro also does the decoding of the instruction fields for us based on the patterns in the field!


### Hardware register macro

What glues together processors and other hardware is for the most part hardware registers,
which can be written to and read from.
While at first this seems like something pretty simple:
just use a case statement with all the addresses.
But it gets more complicated because a processor can read and write with multiple sizes
which can end up accessing multiple registers at the same time or only a partial register
(or in some combinations the system also just locks up).

Additionally, the PowerPC processor in the GameCube is big endian,
which makes things even more complicated
(theoretically it's possible to switch it to little endian, though nobody ever did that).

The `ioBlock` macro handles all of this:

```nim
ioBlock vi, 0x100:
of vtr, 0x00, 2:
    read: uint16 vtr
    write:
        # ...
of dcr, 0x02, 2:
    read: uint16 dcr
    write:
        dcr.mutable = val
        # ...
of htr0, 0x04, 4:
    read: uint32 htr0
    write:
            # ....
            htr0.mutable = val
```

In this case I'm not saying that this is the only good solution,
but I think this one is pretty neat (I've seen this also solved relatively cleanly with a table of function pointers).

It also runs as a homebrew application Nintendo Switch,
albeit magnitudes slower than on PC (where it doesn't reach full speed yet either).
Though the JIT recompiler at the moment only targets x64.

Many parts are still very much temporary,
so if you decide to look at the source code,
don't be scared when you see the `glReadPixels` 😄.
At the moment my main focus is currently to optimise it far enough to reach at least full speed,
otherwise implementing more hardware features and then testing them would just be just a slog.



----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
