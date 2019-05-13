---
title: "Version 0.19.6 released"
author: The Nim Team
---

The Nim team is happy to announce that the latest release of Nim,
version 0.19.6, is now available. Nim is a systems programming language that
focuses on performance, portability and expressiveness.

This is the third bugfix release of version 0.19.
There are no breaking changes.
The most important bugfixes are:

- Boolean logic at compile time is now correct.
- Bitwise operations on signed integers in VM are fixed.
- Fixed object self-assignment order of evaluation.
- Compiler no longer crashes with generic types and static generic parameters.
- Fixed raising generic exceptions.


## Installing 0.19.6

If you have installed a previous version of Nim using ``choosenim``,
getting Nim 0.19.6 is as easy as:

```bash
$ choosenim update stable
```

If you don't have it already, you can get ``choosenim`` by following
[these instructions](https://github.com/dom96/choosenim) or you can install
Nim by following the instructions on our
[install](https://nim-lang.org/install.html) page.


### Bugfixes

- Fixed "32 bit signed xor broken on VM"
  ([#10482](https://github.com/nim-lang/Nim/issues/10482))
- Fixed "SetMaxPoolSize not heeded"
  ([#10584](https://github.com/nim-lang/Nim/issues/10584))
- Fixed "uint inplace add in if branch is omitted when compiled to JS"
  ([#10697](https://github.com/nim-lang/Nim/issues/10697))
- Fixed "Booleans Work Wrong in Compile-time"
  ([#10886](https://github.com/nim-lang/Nim/issues/10886))
- Fixed "Bug in setTerminate()"
  ([#10765](https://github.com/nim-lang/Nim/issues/10765))
- Fixed "Cannot raise generic exception"
  ([#7845](https://github.com/nim-lang/Nim/issues/7845))
- Fixed "Nim string definition conflicts with other C/C++ instances"
  ([#10907](https://github.com/nim-lang/Nim/issues/10907))
- Fixed "std/json fails to escape most non-printables, breaking generation and parsing"
  ([#10541](https://github.com/nim-lang/Nim/issues/10541))
- Fixed "object self-assignment order-of-evaluation broken"
  ([#9844](https://github.com/nim-lang/Nim/issues/9844))
- Fixed "Compiler crash with generic types and static generic parameters"
  ([#7569](https://github.com/nim-lang/Nim/issues/7569))
