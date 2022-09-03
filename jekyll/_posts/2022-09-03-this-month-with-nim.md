---
title: "This Month with Nim: June and July 2022"
author: The Nim Community
excerpt: "Home Automation, NimYAML 1.0, and a LaTeX like"
---


## [libcoap](https://github.com/PMunch/libcoap)

#### Author: [PMunch](https://github.com/PMunch)

CoAP, the Constrained Applications Protocol, is a protocol which is most commonly used for communicating with IoT devices.

[This library](https://github.com/PMunch/libcoap) uses Futhark to wrap the C library `libcoap`.
Then it has a nice Nim-like interface on top with automatic memory management (using destructors) and async integration so that it fits right in with your other Nim libraries.
Currently fairly limited in what it supports, only the things needed for my own IKEA Home Smart integration has been implemented (but since it's wrapped with Futhark you still have access to all the low-level C procedures and types from libcoap).




## [NimYAML](https://github.com/flyx/NimYAML)

#### Author: [flyx](https://github.com/flyx)

NimYAML has long been in pure maintenance mode.
To reflect this, I have set the version number to `1.0.0` for the most recent release (previous releases used `0.x.y` versions).

The single significant feature in this release is that the DOM API has been merged into the serialization API. Previously, you had the option to load your YAML either directly into native types (objects, seqs, strings, etc) or into a `YamlDocument` which is a descriptive, DOM-like representation of the YAML structure which contains `YamlNode`s. Now, you can have a `YamlNode` anywhere in your target type and NimYAML will parse the subgraph at that position into a descriptive `YamlNode` value.
For example:

```nim
import yaml

type
  Root = object
    id: string
    data: YamlNode

var loaded = loadAs[Root]("""
id: 12345
data:
  a: b
  c: [d, e]
""")

loaded.id = "123456"
echo dump(loaded, tsNone, asNone, defineOptions(outputVersion = ovNone), @[])
```

This gives

```yaml
---
id: 123456
data:
  c: [d, e]
  a: b
```

The use-case for this is when you do not care about certain subgraphs from the YAML input, but do want to keep the contained data.
As you can see, NimYAML might not keep the order of mapping keys (due to usage of hash maps), which is conformant to the YAML specification.

The old DOM API is still supported, but carries deprecation warnings from now on.
If you want to parse the  whole YAML input into a DOM, you can use `loadAs[YamlNode](…)` now.




## [maTeXt](https://xigoi.srht.site/matext/)

#### Author: [xiogoi](https://github.com/xigoi)

Communicating online about math is often difficult.
The notation uses many characters that are hard to type and makes liberal use of fonts and two-dimensional layout.
To deal with this, there's the awesome (La)TeX typesetting system and tools like [KaTeX](https://katex.org/) that allow using it on the web, but sometimes that's not possible — for example, when using a text messaging app or publishing articles using the [Gemini](https://gemini.circumlunar.space/) protocol.

That's why I created [maTeXt](https://xigoi.srht.site/matext/), a library and CLI application that renders LaTeX math to plain text using Unicode math characters. For vertical notation, it uses multiple lines and assumes a monospace font, but in case that's not available, it also supports one-line mode.

Here is an example of the quadratic formula in LaTeX, multiline maTeXt and one-line maTeXt. (The multiline version may look broken because of a bad monospace font.)

```latex
x_{1,2} = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
```

```
                 ________
                ╱ 2
        − 𝑏 ± ╲╱ 𝑏  − 4𝑎𝑐
𝑥     = ─────────────────
 1, 2          2𝑎
```

```
𝑥_(1, 2) = (− 𝑏 ± √(𝑏² − 4𝑎𝑐)) / (2𝑎)
```

Currently, not all notation is supported; I'm intending to improve that.
Obviously you can also contribute if you want.

Thanks to the authors of [honeycomb](https://katrinakitten.github.io/honeycomb/honeycomb.html) and [cligen](https://github.com/c-blake/cligen/) and to the [Unicode Table](https://unicode-table.com/en/) for making this possible.



## [IKEA Home Smart](https://github.com/PMunch/ikeahomesmart)

#### Authors: [Pmunch](https://github.com/PMunch)

Have you got IKEA Home Smart bulbs in your house?
Want to automate them with some nice type-safe scripts?
Then you've come to the right place.

Unlike Home Assistant and Openhabian which uses a CoAP client program which is executed for every bulb change, [IKEA Home Smart](https://github.com/PMunch/ikeahomesmart) uses libcoap directly to speak to your gateway and control your bulbs.
It is also completely async, so you can send multiple commands at the same time and wait for them all to complete (CoAP only allows a single transaction at a time, but you can queue up requests which will be fired one after the other while your program does something else). It supports groups and bulbs, and setting the brightness, colour, and temperature of the bulbs (as long as the hardware supports it).


----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
