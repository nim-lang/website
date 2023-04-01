---
title: "This Month with Nim: March 2023"
author: The Nim Community
excerpt: "Ui bindings, Chess bots, Raylib binding updates. The list goes on, we swear!"
---


## [Binance](https://github.com/juancarlospaco/binance#binance)

#### Author: [Juan Carlos](https://github.com/juancarlospaco)

Trade Bitcoin, USD and Gold using Nim!.

Includes examples, API documentation, giftcards maker, futures maker,
leveraged perpetual futures automated trading bots with TSL/SL/TP/PNL,
make your own strategy, code Nim and make some money.


## [Lichess BOT Annie](https://github.com/tsoj/Annie)

#### Author: [Tsoj](https://github.com/tsoj)

I want to introduce you to Annie, a chess bot for Lichess.
She's excited about exploring the more intricate sides of chess.
Her favorite openings are the cloud variations and she is a very enthusiastic fan of en passant in every imaginable form.

Annie's handcrafted, large-table powered evaluation was trained on no fewer than six million, four hundred and thirty-four positions from games played on Lichess.
Not just the games of grandmasters, but the games of noobs and sub-800 Elo players too. On top of that she also has an anarchic sub-module in her tree search.
So be prepared for some unconventional moves (and comments).

You can play Annie [here](https://lichess.org/@/Annie_Archy) (bullet, blitz, or rapid, always with increment and unrated).

Depending on how well you've played recently, a level from **A1** to **C3** will be suggested.
If you only understand the most established strategies that grandmasters tend to go for you better play against Annie at level **C1**, **C2**, or even **C3**.
If you have experience battling the chaos of playing against 800 Elo prodigies and you can keep your composure when facing an opponent with a question mark next to their rating you should play against level **A3**, **A2**.
If you're really mad play against level **A1**.
All of you players who are ordinary give the **B** levels a try.

Annie is based on the chess engine [Nalwald](https://gitlab.com/tsoj/Nalwald).



## [c2nim](https://github.com/nim-lang/c2nim) upgrades

#### Author: [@elcritch](https://github.com/elcritch)

`c2nim` is the standard goto for many when wrapping C projects for Nim.
However, after using it for several projects I noticed I was doing the same things every time I wrapped a C project.
So I dug into `c2nim` and have made a number of improvements and features to automated things. I've also fixed a number of issues and `c2nim` can now parse the entirety of various system headers and handles things like function pointers with function pointers.

One of my favorite is the `--reorderComments` option.
It takes the common C pattern of putting docs before a function and converts it to Nim's comment style.
This alone means that 90% of imported docs will become proper Nim docs associated to the right function! Well mostly. ;)
Another favorite is `--stdints` that converts modern C's `int32_t` to the proper Nim equivalent.

Note that all options should now be available from the CLI and the c2nim pragma's.
Also, I've added support for using directives in the form of `#pragma c2nim <option>`.
This let's you add c2nim annotations directly in normal C code and they'll be ignored by your compiler.

If others have ideas for improvements, create an issue.
I'm doing this mainly for my own projects, but I like the idea of making c2nim basically be capable of automatically wrapping all C code.
C++ has also gotten much better as well, but remains tricky.
I've also got another project in the works to automate running `c2nim` on larger projects!

Here's an (incomplete list) of new options (some newer, some older):

- importDefines        import C defines as procs or vars with ``{.importc.}``
- importFuncDefines    import C define funcs as procs with ``{.importc.}``
- reorderComments      reorder C comments to match Nim's postfix style
- mangle:PEG=FORMAT    extra PEG expression to mangle identifiers, for example `--mangle:'{u?}int{\d+}_t=$1int$2'` to convert C <stdint.h> to Nim equivalents
- stdints              Mangle C stdint's into Nim style int's
- delete:IDENT         option to delete nodes with matching idents for procs, types, or vars
- mergeBlocks          merge similar adjacent blocks like two let sections
- mergeDuplicates      merge duplicate proc definitions, etc
- anonymousAsFields    turn C anonymous unions into regular Nim fields - still a C union so caveat emptor

## [nimitheme](https://github.com/neroist/nimitheme)

#### Author: [Jasmine aka Neroist](https://github.com/neroist)


[nimitheme](https://github.com/neroist/nimitheme) is a nimble library that enables easy styling of [nimib](https://github.com/pietroppeter/nimib) documents.
Currently there are ~30 different themes available, and I plan on adding more.
You can enable themes either by passing them into `nbInit` like this:

```nim
import nimitheme
import nimib

nbInit(useSakuraEarthly)
```

Or calling the function directly:

```nim
nb.useSakuraEarthly()
```

In addition, you can also easily choose the highlight.js theme nimib uses via `highlight=`. For example, you could do something like this:

```nim
import nimitheme
import nimib

nbInit

nb.highlight = codeschool
...
```

***All*** highlight.js themes are supported, so style your code to your heart's content!

In addition, you can also enable Dark Reader in your nimib document by calling `useDarkReader`, like so:

```nim
nb.useDarkReader()
```

An example of a website using nimitheme is up here: <https://neroist.github.io/nimitheme/>, which uses the Awsm Big Stone theme.


## naylib 4.5 released

#### Author: [planetis](https://github.com/planetis-m)

[Naylib](https://github.com/planetis-m/naylib) is a Nim-based wrapper for the raylib library, which allows for the creation of both 2D and 3D games.
[The API for Nim is designed to be both user-friendly and easy to use.

Naylib's achievement is being the only raylib binding that supports Android development. This is largely due to the project's extensible build system, which is based on NimScript.
Recently, this build system underwent an overhaul, playing a crucial role in the project's success.
For those interested in exploring this feature, the [raylib-game-template](https://github.com/planetis-m/raylib-game-template) is an good starting point.

Recent changes include:

- Upgraded to version 4.5.0 of the raylib library, which introduces several changes and removals to the API. For more details, please consult the upstream changelog.
- The Readme has undergone a complete rewrite with the intention of providing more thorough and informative documentation.
- Multiple areas of the codebase have been reviewed, with a focus on error checking.
- The 'windows' branch now includes experimental support for Windows.
- Our contribution upstream added Wayland support, which now benefits other bindings as well.
- More examples have been ported to naylib and are available on the [examples](https://github.com/planetis-m/raylib-examples) repo.

Join the development of naylib and contribute to its growth.
A frequently requested task is the wrapping of rres and raygui. Contributions are welcome.


## [uing](https://github.com/neroist/uing)

#### Author: [Jasmine still aka @Neroist](https://github.com/neroist)
[uing](https://github.com/neroist/uing) is a fork of [ui](https://github.com/nim-lang/ui) that wraps [libui-ng](https://github.com/libui-ng/libui-ng) instead of the old and unmaintained [libui](https://github.com/andlabs/libui) library.
I made this fork because libui seems to be abandoned (the most recent update to libui was 2 years ago), and ui hasn't been updated in a long time aswell (coincidentally, the most recent change also happens to be 2 years ago).

uing implements many things that ui doesn't have such as:

- More widgets (Grids, DateTimePickers, ColorButtons, Areas, etc.)
- Timers
- Improved callbacks
 - and more...

Uing's documentation is hosted [here](https://neroist.github.io/uing/uing.html), and examples can be found [here](https://github.com/neroist/uing/tree/main/examples). For `rawui`, I suggest you look at libui-ng's official docs here: <https://libui-ng.github.io/libui-ng/>.

Here's a simple [example](https://github.com/neroist/uing/blob/main/examples/datetime.nim):

```nim
import std/times

import uing

proc main =
  let window = newWindow("Date / Time", 320, 240)
  window.margined = true

  let grid = newGrid(true)
  window.child = grid

  let
    dateTimeLabel = newLabel()
    dateLabel = newLabel()
    timeLabel = newLabel()

    dateTimePicker = newDateTimePicker() do (dt: DateTimePicker):
      dateTimeLabel.text = dt.time.format("ddd MMM d HH:mm:ss UUUU")

    datePicker = newDatePicker() do (dt: DateTimePicker):
      dateLabel.text = dt.time.format("yyyy-MM-dd")

    timePicker = newTimePicker() do (dt: DateTimePicker):
      timeLabel.text = dt.time.format("hh:mm:ss")

    nowButton = newButton("Now") do (_: Button):
      timePicker.time = now()
      datePicker.time = now()

    epochButton = newButton("Unix epoch") do (_: Button):
      dateTimePicker.time = dateTime(1969, mDec, 31, 19)

  grid.add(dateTimePicker, 0, 0, 2, 1, true, AlignFill, false, AlignFill)
  grid.add(datePicker, 0, 1, 1, 1, true, AlignFill, false, AlignFill)
  grid.add(timePicker, 1, 1, 1, 1, true, AlignFill, false, AlignFill)

  grid.add(dateTimeLabel, 0, 2, 2, 1, true, AlignCenter, false, AlignFill)
  grid.add(dateLabel, 0, 3, 1, 1, true, AlignCenter, false, AlignFill)
  grid.add(timeLabel, 1, 3, 1, 1, true, AlignCenter, false, AlignFill)

  grid.add(nowButton, 0, 4, 1, 1, true, AlignFill, true, AlignEnd)
  grid.add(epochButton, 1, 4, 1, 1, true, AlignFill, true, AlignEnd)

  show window
  mainLoop()

init()
main()
```

## [Fungus] (https://www.github.com/beef331/fungus)

#### Author [Jason Beetham](https://www.github.com/beef331/)

One ponders sleeplessly whether Nim's object variants are the best way to write tagged unions.
Fungus puts forward an answer of how one might write simple variants in a more expressive way.
Allowing shared field names of different types and pattern matching.
Fungus does what other languages have for their tagged unions.
Here is a small taste of what it enables:

```nim
import fungus
adtEnum(Shape):
  None
  Circle: tuple[x, y, r: int]
  Rectangle: tuple[x, y, w, h: int]
  Line: tuple[x1, y1, x2, y2: int]
  SomeVal: int

proc `==`(a, b: Circle): bool = adtEqual(a, b)

var a = Shape Circle.init(10, 20, 30)

if (circ: Circle) from a:
  assert circ == Circle.init(10, 20, 30)

match a:
of Circle as (x, y, r):
  echo x, " ", y, " ", r
else:
  discard
```

## [Climate] (https://github.com/moigagoo/climate)

#### Author [moigagoo](https://github.com/moigagoo)

There are several CLI libs for Nim.
However, when I was choosing the one to use for my Sauer package,
I found out that the existing ones were either quite complex or too low-level.
I wanted a package that would allow me to think with commands and subcommands instead of parsers,
while still not use a ton of macros.

Working on Kraut I was surprised with how productive its approach to routing turned out to be and I decided to apply it to CLI.
This is how **Climate** was born.

Climate is like a router but for command line.
You define your commands and subcommands like paths and define handlers for them:

```
let commands = {"command subcommand": handlerProc}
```

Options and arguments extracted from the command line are passed inside a `Context` instance.

I can see how Climate could evolve from here, adding argument validation, type casting, and help generation but it's worth noting that it's already quite handy as it is.

See the docs and a full demo in the repo.


## [Kraut] (https://github.com/moigagoo/kraut)

#### Author [moigagoo](https://github.com/moigagoo)

I really want to make the web development story in Nim happen, in particular, the frontend part of it.

Although I am not a frontend developer myself,
I've spent some time playing around with Karax and quickly realized there are obvious missing parts.

One of those low hanging fruit is routing.
I want routing that is obvious, extensible, and unbloated.

And thus, behold **Kraut**.
Kraut is a tiny lib that allows you to think in routes instead of hash parts and URL params instead of split strings.
The routes are defined with Nim's built-in key-value sugar, so you have nothing new to learn:

```
let routes = {"#/path/{param}/subpath/": rendererProc,}
```

The requirements for the renderer price are also very simple: they must accept a `Context` instance and return a `VNode`.

See the docs and a full working example in the repo.

----


## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
