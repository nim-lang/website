---
title: "Version 1.6.16 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.6.16, our eight patch release for
Nim 1.6.

Version 1.6.16 is a result of three months of hard work, and it contains
[84 commits](https://github.com/nim-lang/Nim/compare/v1.6.14...v1.6.16),
bringing lots of general improvements over 1.6.14.

This release is aimed at our users who haven't switched to [Nim v2.0](https://nim-lang.org/blog/2023/08/01/nim-v20-released.html) yet.




# Installing Nim 1.6

## New users

Check out if the package manager of your OS already ships version 1.6.16 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6.16 is as easy as:

```bash
$ choosenim 1.6.16
```

Alternatively, you can download Nim 1.6.16 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2023-10-10-version-1-6-3c9b68dc157804885b14a1984efc25e8b7cc861d).




# Donating to Nim

We would like to encourage you to donate to Nim.
The donated money will be used to further improve Nim by creating bounties
for the most important bugfixes and features.

You can donate via:

* [Open Collective](https://opencollective.com/nim)
* [Patreon](https://www.patreon.com/araq)
* [BountySource](https://salt.bountysource.com/teams/nim)
* [PayPal](https://www.paypal.com/donate/?hosted_button_id=KYXH3BLJBHZTA)
* Bitcoin: `1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ`

If you are a company, we also offer commercial support.




# Bugfixes

These reported issues were fixed:

- Fixed "Undefined behavior when with `hash(...)` on non-aligned bytes due to `murmurHash` `cast[ptr int32]`"
  ([#22387](https://github.com/nim-lang/Nim/issues/22387))
- Fixed "async/closure environment does not align local variables"
  ([#22419](https://github.com/nim-lang/Nim/issues/22419))
- Fixed "Ambiguous error when import modules with same names but different aliases"
  ([#22208](https://github.com/nim-lang/Nim/issues/22208))
- Fixed "system.create doesn't work with bitfield objects"
  ([#20516](https://github.com/nim-lang/Nim/issues/20516))
- Fixed "Memory leak with implicit `result`"
  ([#21703](https://github.com/nim-lang/Nim/issues/21703))
- Fixed "Missing range or overflow check in "sum" or "prod" functions."
  ([#21792](https://github.com/nim-lang/Nim/issues/21792))
- Fixed "Compiler SIGSEGV when using SharedTable"
  ([#21251](https://github.com/nim-lang/Nim/issues/21251))
- Fixed "Wrong codegen with openArray"
  ([#15428](https://github.com/nim-lang/Nim/issues/15428))
- Fixed "Invalid codegen when unpacking tuple via template"
  ([#22049](https://github.com/nim-lang/Nim/issues/22049))
- Fixed "Wrong assignment for tuples in some contexts with refc"
  ([#16331](https://github.com/nim-lang/Nim/issues/16331))
- Fixed "Table has inconsistent hash"
  ([#20023](https://github.com/nim-lang/Nim/issues/20023))
- Fixed "`template` with module as parameter elides usage/checking of module name specifier"
  ([#21231](https://github.com/nim-lang/Nim/issues/21231))
- Fixed "gcc error compiling generated code using `for` with iterator"
  ([#21110](https://github.com/nim-lang/Nim/issues/21110))
- Fixed "Consistent nimsuggest crash on generics in first class functions"
  ([#22137](https://github.com/nim-lang/Nim/issues/22137))
- Fixed "SIGSEGV with ARC and closure iterator"
  ([#22237](https://github.com/nim-lang/Nim/issues/22237))
- Fixed "`--gcc.exe` doesn't work with `--genScript:on`"
  ([#22281](https://github.com/nim-lang/Nim/issues/22281))
- Fixed "async proc Error: unhandled exception: closureiters.nim(858, 11) `ctx.nearestFinally != 0`  [AssertionDefect] when the return statement is in the finally block"
  ([#22297](https://github.com/nim-lang/Nim/issues/22297))
- Fixed "Crash of compiler on array type check"
  ([#5780](https://github.com/nim-lang/Nim/issues/5780))
- Fixed "`when` picks wrong branch with `static int`"
  ([#22474](https://github.com/nim-lang/Nim/issues/22474))
- Fixed "Undefined behaviorwith `set` `card()` on non-aligned pointer from `cardSetImpl`/`countBits64cast` on `ptr uint64`"
  ([#22481](https://github.com/nim-lang/Nim/issues/22481))
- Fixed "`elementType` from `std/typetraits` doesn't work in generic procs"
  ([#21532](https://github.com/nim-lang/Nim/issues/21532))
- Fixed ""environment misses" for type reference in iterator access nested in closure"
  ([#22548](https://github.com/nim-lang/Nim/issues/22548))
- Fixed "Invalid type mismatch in generic"
  ([#17509](https://github.com/nim-lang/Nim/issues/17509))
- Fixed "Error compiling with ARC/ORC"
  ([#21974](https://github.com/nim-lang/Nim/issues/21974))
- Fixed "Internal error when using `lent` + `template` in method/proc"
  ([#22138](https://github.com/nim-lang/Nim/issues/22138))
- Fixed "`-d:useMalloc` broken with `--mm:none` and threads on"
  ([#22262](https://github.com/nim-lang/Nim/issues/22262))
- Fixed "peg matchLen can raise an unlisted exception: Exception"
  ([#22541](https://github.com/nim-lang/Nim/issues/22541))
- Fixed "Piece of code output c compiler error "
  ([#17197](https://github.com/nim-lang/Nim/issues/17197))
- Fixed "Missing type inference in loop + case + if + continue"
  ([#22604](https://github.com/nim-lang/Nim/issues/22604))


The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v1.6.14...v1.6.16).

