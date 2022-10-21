---
title: "Versions 1.4.4 and 1.2.10 released"
author: The Nim Team
---

The Nim team is happy to announce the double patch release of versions 1.2.10 and 1.4.4.

The crucial bugfix that demanded these releases is the rework of the SSL certificate handling;
it is now performed correctly and also enabled on Windows.
The 1.0.x line is not affected simply because 1.0 does not check SSL certificates at all.
**Please upgrade to either 1.2.10 or 1.4.4 immediately.**

Version 1.4.4 is our main release, which brings several improvements over
1.4.2, released two months ago.
As our [Community Survey](https://nim-lang.org/blog/2021/01/20/community-survey-results-2020.html)
has shown, most of our users use 1.4.x version, and this release is for them
and for all newcomers: we recommend you to install version 1.4.4.

We didn't forget the users who are still on the older versions and cannot
update to the latest stable version.
Version 1.2.10 is for them, and contains mostly just security fixes.
You can find more information about this version at the bottom of the article.

If you are still on Nim 1.2.x, and would like to know about new features
available in Nim 1.4, check out our
[version 1.4.0 release article](https://nim-lang.org/blog/2020/10/16/version-140-released.html).



# Version 1.4.4

Version 1.4.4 is our second patch release for Nim 1.4 and it brings several fixes,
including the new Nimble version containing security fixes (see
[Nimble changelog](https://github.com/nim-lang/nimble/blob/master/changelog.markdown#nimble-changelog)).


## Installing Nim 1.4

### New users

Check out if the package manager of your OS already ships version 1.4.4 or
install it as described [here](https://nim-lang.org/install.html).


### Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.4.4 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.4.4 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2021-02-23-version-1-4-2ff517462bf8609b30e6134c96658aa7912b628a).



## Bugfixes since 1.4.2

- Fixed "-d:fulldebug switch does not compile with gc:arc"
  ([#16214](https://github.com/nim-lang/Nim/issues/16214))
- Fixed "Strange behavior when calling into Nim"
  ([#16249](https://github.com/nim-lang/Nim/issues/16249))
- Fixed "VC++ winnt.h fatal error "No Target Architecture" in stdlib_io."
  ([#14259](https://github.com/nim-lang/Nim/issues/14259))
- Fixed "`osLastError` may randomly raise defect and crash"
  ([#16359](https://github.com/nim-lang/Nim/issues/16359))
- Fixed "`&` shows as `&amp;` in docs"
  ([#16364](https://github.com/nim-lang/Nim/issues/16364))
- Fixed "gc:arc - SIGSEGV for rawAlloc on windows"
  ([#16365](https://github.com/nim-lang/Nim/issues/16365))
- Fixed "generic importc proc's don't work (breaking lots of vmops procs for js)"
  ([#16428](https://github.com/nim-lang/Nim/issues/16428))
- Fixed "[ARC] Compiler error with a closure proc in a macro "
  ([#15043](https://github.com/nim-lang/Nim/issues/15043))
- Fixed "`genericAssignAux` runtime error"
  ([#16706](https://github.com/nim-lang/Nim/issues/16706))
- Fixed "Concept: codegen ignores parameter passing"
  ([#16897](https://github.com/nim-lang/Nim/issues/16897))
- Fixed "{.push exportc.} interacts with anonymous functions"
  ([#16967](https://github.com/nim-lang/Nim/issues/16967))
- Fixed "ARC exports a dangerous 'dispose' proc"
  ([#17003](https://github.com/nim-lang/Nim/issues/17003))
- Fixed "Cursor inference leading to corrupt memory with a tuple"
  ([#17033](https://github.com/nim-lang/Nim/issues/17033))
- Fixed "toOpenArray doesn't work in VM; toOpenArray with var openArray doesn't work in nim js"
  ([#15952](https://github.com/nim-lang/Nim/issues/15952))
- Fixed "memory allocation during {.global.} init breaks GC"
  ([#17085](https://github.com/nim-lang/Nim/issues/17085))

Full changelog since v1.4.2 contains [45 commits](https://github.com/nim-lang/Nim/compare/v1.4.2...v1.4.4).




# Donating to Nim

We would like to encourage you to donate to Nim.

The donated money will be used to further improve Nim:
- Bugs need to be fixed, the documentation can be improved, compiler error
  messages can always be better.
- The most exciting upcoming feature, that has the greatest impact to all
  of our users, is [incremental compilation](https://github.com/nim-lang/RFCs/issues/46).
- Incremental compilation will also be the foundation for further tooling
  improvements like `nimsuggest` (autocompletion, find usages).


You can donate via:

* [Open Collective](https://opencollective.com/nim)
* [Patreon](https://www.patreon.com/araq)
* [PayPal](https://www.paypal.com/donate/?hosted_button_id=KYXH3BLJBHZTA)
* Bitcoin: bc1qzgw3vsppsa9gu53qyecyu063jfajmjpye3r2h4

If you are a company, we also offer commercial support.
Please get in touch with us via `support@nim-lang.org`.
As a commercial backer, you can decide what features and bugfixes should
be prioritized.






# Version 1.2.10

Version 1.2.10 is our fifth patch release for Nim 1.2 and it brings several new
fixes since version 1.2.8, released 4 months ago, and a new Nimble version containing
security fixes (see
[Nimble changelog](https://github.com/nim-lang/nimble/blob/master/changelog.markdown#nimble-changelog)).


## Installing Nim 1.2.10

### New users

We recommend you to install the newest Nim version (at the time of writing: 1.4.4, see above).
Check out if the package manager of your OS already ships Nim 1.4 or
install it as described [here](https://nim-lang.org/install.html).


### Existing users

If you have installed a previous version of Nim using `choosenim` and you
cannot switch to 1.4.x yet, getting Nim 1.2.10 is as easy as:

```bash
$ choosenim 1.2.10
```

Alternatively, you can download Nim 1.2.10 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2021-02-23-version-1-2-ebc114c5266582dcaf5e323e0ec3d2b2a9f17063).



## Bugfixes since 1.2.8

- Fixed "JS backend doesn't handle `float->int` type conversion "
  ([#8404](https://github.com/nim-lang/Nim/issues/8404))
- Fixed "The "try except" not work when the "OSError: Too many open files" error occurs!"
  ([#15925](https://github.com/nim-lang/Nim/issues/15925))
- Fixed "Nim emits #line 0 C preprocessor directives with --debugger:native, with ICE in gcc-10"
  ([#15942](https://github.com/nim-lang/Nim/issues/15942))
- Fixed "tfuturevar fails when activated"
  ([#9695](https://github.com/nim-lang/Nim/issues/9695))
- Fixed "nre.escapeRe is not gcsafe"
  ([#16103](https://github.com/nim-lang/Nim/issues/16103))
- Fixed ""Error: internal error: genRecordFieldAux" - in the "version-1-4" branch"
  ([#16069](https://github.com/nim-lang/Nim/issues/16069))
- Fixed "-d:fulldebug switch does not compile with gc:arc"
  ([#16214](https://github.com/nim-lang/Nim/issues/16214))
- Fixed "`osLastError` may randomly raise defect and crash"
  ([#16359](https://github.com/nim-lang/Nim/issues/16359))
- Fixed "generic importc proc's don't work (breaking lots of vmops procs for js)"
  ([#16428](https://github.com/nim-lang/Nim/issues/16428))
- Fixed "Concept: codegen ignores parameter passing"
  ([#16897](https://github.com/nim-lang/Nim/issues/16897))
- Fixed "{.push exportc.} interacts with anonymous functions"
  ([#16967](https://github.com/nim-lang/Nim/issues/16967))
- Fixed "memory allocation during {.global.} init breaks GC"
  ([#17085](https://github.com/nim-lang/Nim/issues/17085))

Full changelog since v1.2.8 contains [45 commits](https://github.com/nim-lang/Nim/compare/v1.2.8...v1.2.10).
