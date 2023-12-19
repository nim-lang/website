---
title: "Versions 2.0.2 and 1.6.18 released"
author: The Nim Team
---

The Nim team is happy to announce two releases:
- the latest Nim, version 2.0.2
- LTS release, version 1.6.18


For the majority of our users, v2.0.2 contains [63 commits](https://github.com/nim-lang/Nim/compare/v2.0.0...v2.0.2) and brings bugfixes and improvements to Nim 2.0.0, released four months ago.

**NOTE**: If your program uses threads (`--threads:on` became the default in the 2.0.x line) please also use the `-d:useMalloc` switch.
This problem will be fixed in 2.0.4, sorry for the inconvenience.


For those users who haven't switched to [Nim v2.0](https://nim-lang.org/blog/2023/08/01/nim-v20-released.html) yet, we have released the ninth patch release for Nim 1.6.x.
It is a small release with [13 commits](https://github.com/nim-lang/Nim/compare/v1.6.16...v1.6.18).



## Nim Community Survey 2023

Before going into details of the release, we would like to remind you that [2023 Nim Community Survey](https://nim-lang.org/blog/2023/11/17/community-survey-2023.html) is still open, and we would appreciate your input if you haven't done it already.




# Installing Nim 2.0.2

## New users

Check out if the package manager of your OS already ships version 2.0.2 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 2.0.2 is as easy as:

```bash
$ choosenim 2.0.2
```

If you are on OSX ARM, `choosenim` will not work for you.
Please choose an alternative method of installing or updating.

Alternatively, you can download Nim 2.0.2 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2023-12-15-version-2-0-c4c44d10df8a14204a75c34e499def200589cb7c).




# Donating to Nim

We would like to encourage you to donate to Nim.
The donated money will be used to further improve Nim by creating bounties
for the most important bugfixes and features.

You can donate via:

* [Open Collective](https://opencollective.com/nim)
* Bitcoin: `1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ`

If you are a company, we also offer commercial support.




# Bugfixes

These reported issues were fixed:

- Fixed "Undefined behavior when with `hash(...)` on non-aligned bytes due to `murmurHash` `cast[ptr int32]`"
  ([#22387](https://github.com/nim-lang/Nim/issues/22387))
- Fixed "async/closure environment does not align local variables"
  ([#22419](https://github.com/nim-lang/Nim/issues/22419))
- Fixed "Debugging/stepping is broken in 2.0.0 and 2.1.1"
  ([#22366](https://github.com/nim-lang/Nim/issues/22366))
- Fixed "`when` picks wrong branch with `static int`"
  ([#22474](https://github.com/nim-lang/Nim/issues/22474))
- Fixed "Regression from 1.6.14 to 2.0.0 - nimble test crashes with a core dump"
  ([#22357](https://github.com/nim-lang/Nim/issues/22357))
- Fixed "Long-term arc-closure iterator problem"
  ([#22619](https://github.com/nim-lang/Nim/issues/22619))
- Fixed "`-d:useMalloc` broken with `--mm:none` and threads on"
  ([#22262](https://github.com/nim-lang/Nim/issues/22262))
- Fixed "Crash of compiler on array type check"
  ([#5780](https://github.com/nim-lang/Nim/issues/5780))
- Fixed "Undefined behaviorwith `set` `card()` on non-aligned pointer from `cardSetImpl`/`countBits64cast` on `ptr uint64`"
  ([#22481](https://github.com/nim-lang/Nim/issues/22481))
- Fixed "`elementType` from `std/typetraits` doesn't work in generic procs"
  ([#21532](https://github.com/nim-lang/Nim/issues/21532))
- Fixed "peg matchLen can raise an unlisted exception: Exception"
  ([#22541](https://github.com/nim-lang/Nim/issues/22541))
- Fixed "Piece of code output c compiler error "
  ([#17197](https://github.com/nim-lang/Nim/issues/17197))
- Fixed "Missing type inference in loop + case + if + continue"
  ([#22604](https://github.com/nim-lang/Nim/issues/22604))
- Fixed "Invalid type mismatch in generic"
  ([#17509](https://github.com/nim-lang/Nim/issues/17509))
- Fixed "std/nativesockets getHostByAddr should support IPv6"
  ([#22834](https://github.com/nim-lang/Nim/issues/22834))
- Fixed "std/nre leaks memory on every created `Regex` due to auto-translated finalizers behaving differently under ARC/ORC"
  ([#22868](https://github.com/nim-lang/Nim/issues/22868))
- Fixed "Destructor not called for temp objects passed as arguments"
  ([#22866](https://github.com/nim-lang/Nim/issues/22866))
- Fixed "nimsuggest inlay hints for types shown in the wrong place for exported vars and consts"
  ([#23067](https://github.com/nim-lang/Nim/issues/23067))
- Fixed "[Regression] static integers in quote do"
  ([#22947](https://github.com/nim-lang/Nim/issues/22947))

The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v2.0.0...v2.0.2).

