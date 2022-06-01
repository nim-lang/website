---
title: "This Month with Nim: April and May 2022"
author: The Nim Community
excerpt: "Rest API templates, Fancy Strings, and terminal image rendering"
---


## [API binding template](https://github.com/tandy-1000/api-binding-template/)

#### Author: [tandy1000](https://github.com/tandy-1000)

After maintaining 3 sets of REST API bindings in Nim I've amassed some useful boilerplate which the community will benefit from.

Features:

- Out of the box support for native C / C++ and JS backend.
- Built in [jsony](https://github.com/treeform/jsony/) hooks for:
   - snake_case APIs,
   - Option types,
- Uses `fastsync` pragma from [asyncutils](https://github.com/tandy-1000/asyncutils) to enable sync / async with reduced code duplication.

This was built with help from [ElegantBeef](https://github.com/beef331/) and [dylan](https://github.com/dylhack/).




## [Small String Optimized Strings](https://github.com/planetis-m/ssostrings)

#### Author: [planetis](https://github.com/planetis-m)

The Small String Optimized (SSO) string data-type attempts to reduce the number of heap allocations that happen at runtime.

When a string is less than 23 bytes on 64bit it can be stored directly in the object.
Avoiding a dynamic allocation.
There exist two modes for each String.
A short string and a long string mode in which the dynamic memory is managed using Nim's destructors.

The implementation is based on clang's std::string class.
This technique might improve runtime performance and reduce fragmented memory where this is most needed, i.e. on embedded systems.




## [cowstrings](https://github.com/planetis-m/cowstrings)

#### Author: [planetis](https://github.com/planetis-m)

Copy-On-Write string data-type provides an implementation of mutable strings so that creating and copying them is free performance wise.

The object's internal memory is reference counted and shared among it's instances.
Thus it only make a copy for a specific instance, when it's data is modified.
It is based on [nim-lang/RFCs#221](https://github.com/nim-lang/RFCs/issues/221).
It should improve performance when strings are frequently copied.
Passing a string to a thread triggers a deep copy, so it is compatible with multi-threading.




## [tpix](https://github.com/jesvedberg/tpix)

#### Authors: [Jesper Svedberg](https://github.com/jesvedberg)

Tpix is a simple terminal image viewer written in [Nim](https://nim-lang.org/).

It is compatible with terminal emulators that supports the [kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/) and uses the [Pixie](https://github.com/treeform/pixie) graphics library to read and render images.
Tpix is available as a statically linked single binary that is easy to deploy on remote systems where the user does not have root privileges.

Tpix can view the following image formats: PNG, JPG, GIF (animated GIFs not supported), BMP, QOI, PPM and SVG (currently only limited support).
Tpix has so far been compiled on x86_64 and arm64 Linux, x86_64 MacOSX, and it has been tested with [Kitty](https://sw.kovidgoyal.net/kitty/) and [Wezterm](https://wezfurlong.org/wezterm/).


----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
