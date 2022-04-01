---
title: "This Month with Nim: Feburary and March 2022"
author: The Nim Community
excerpt: "Automatic C bindings, a Declarative GTK, and Typesafe-ish macros"
---

## [Futhark](https://github.com/PMunch/futhark)

#### Author: [PMunch](https://github.com/PMunch)
Have your eyes set on the perfect C library for your project?
Can't find a wrapper for it in Nim?
Look no further!
Futhark aims to allow you to simply import C header files directly into Nim,
and allow you to use them like you would from C without any manual intervention.
It's still in an alpha state,
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
Owlkettle is a declarative user interface framework based on GTK. It brings the declarative GUI paradigm you know from many web frameworks to the Linux desktop.

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

If interested check out [more examples](https://github.com/can-lehmann/owlkettle/tree/main/examples).

## [Micros](https://github.com/beef331/micros)

#### Author: [Jason Beetham](https://github.com/beef331)

Micros is an early state typesafe API ontop of Nim's `NimNode`s.
It provides utillity procedures for these types to enable simpler and more readable apis.

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
but I have started migrating my other macro libraries to it as it's more maintainable and easier to understand.

If wanting to see more examples I have a bunch of [tests](https://github.com/beef331/micros/tree/master/tests).

----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
