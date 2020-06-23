---
title: "Version 1.2.2 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.2.2, our first patch release for
Nim 1.2.

Version 1.2.2 is a result of two months of work, and it contains
[70 commits](https://github.com/nim-lang/Nim/compare/v1.2.0...v1.2.2),
fixing more than 30 reported issues.

This release doesn't bring any new features compared to Nim 1.2.0.
If you are still on Nim 1.0.x, and would like to know about new features
available in Nim 1.2.x, check out our
[version 1.2.0 release article](https://nim-lang.org/blog/2020/04/03/version-120-released.html).


# Installing Nim 1.2

## New users

Check out if the package manager of your OS already ships version 1.2.2 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.2.2 is as easy as:

```bash
$ choosenim update stable
```


# Bugfixes

- Fixed "Critical: 1 completed Future, multiple await: Only 1 await will be awakened (the last one)"
  ([#13889](https://github.com/nim-lang/Nim/issues/13889))
- Fixed ""distinct uint64" type corruption on 32-bit, when using {.borrow.} operators"
  ([#13902](https://github.com/nim-lang/Nim/issues/13902))
- Fixed "Regression: impossible to use typed pragmas with proc types"
  ([#13909](https://github.com/nim-lang/Nim/issues/13909))
- Fixed "openssl wrapper corrupts stack on OpenSSL 1.1.1f + Android"
  ([#13903](https://github.com/nim-lang/Nim/issues/13903))
- Fixed "add nimExe to nim dump"
  ([#13876](https://github.com/nim-lang/Nim/issues/13876))
- Fixed "simple 'var openarray[char]' assignment crash when the openarray source is a local string and using gc:arc"
  ([#14003](https://github.com/nim-lang/Nim/issues/14003))
- Fixed "Cant use expressions with `when` in `type` sections."
  ([#14007](https://github.com/nim-lang/Nim/issues/14007))
- Fixed "Annoying warning: inherit from a more precise exception type like ValueError, IOError or OSError [InheritFromException]"
  ([#14052](https://github.com/nim-lang/Nim/issues/14052))
- Fixed "Incorrect escape sequence for example in jsffi library documentation"
  ([#14110](https://github.com/nim-lang/Nim/issues/14110))
- Fixed "macOS: dsymutil should not be called on static libraries"
  ([#14132](https://github.com/nim-lang/Nim/issues/14132))
- Fixed "Fix single match output"
  ([#12920](https://github.com/nim-lang/Nim/issues/12920))
- Fixed "algorithm.sortedByIt template corrupts tuple input under --gc:arc"
  ([#14079](https://github.com/nim-lang/Nim/issues/14079))
- Fixed "strformat: doc example fails"
  ([#14054](https://github.com/nim-lang/Nim/issues/14054))
- Fixed "Nim doc fail to run for nim 1.2.0 (nim 1.0.4 is ok)"
  ([#13986](https://github.com/nim-lang/Nim/issues/13986))
- Fixed "Exception when converting csize to clong"
  ([#13698](https://github.com/nim-lang/Nim/issues/13698))
- Fixed "[ARC] Segfault with cyclic references (?)"
  ([#14159](https://github.com/nim-lang/Nim/issues/14159))
- Fixed "cas is wrong for tcc"
  ([#14151](https://github.com/nim-lang/Nim/issues/14151))
- Fixed "Use -d:nimEmulateOverflowChecks by default?"
  ([#14209](https://github.com/nim-lang/Nim/issues/14209))
- Fixed "Invalid return value of openProcess is `NULL` rather than `INVALID_HANDLE_VALUE(-1)` in windows"
  ([#14289](https://github.com/nim-lang/Nim/issues/14289))
- Fixed "nim-gdb is missing from all released packages"
  ([#13104](https://github.com/nim-lang/Nim/issues/13104))
- Fixed "compiler error with inline async proc and pragma"
  ([#13998](https://github.com/nim-lang/Nim/issues/13998))
- Fixed "Linker error with closures"
  ([#209](https://github.com/nim-lang/Nim/issues/209))
- Fixed "ARC codegen bug with inline iterators"
  ([#14219](https://github.com/nim-lang/Nim/issues/14219))
- Fixed "[ARC] implicit move on last use happening on non-last use"
  ([#14269](https://github.com/nim-lang/Nim/issues/14269))
- Fixed "Boehm GC does not scan thread-local storage"
  ([#14364](https://github.com/nim-lang/Nim/issues/14364))
- Fixed "RVO not exception safe"
  ([#14126](https://github.com/nim-lang/Nim/issues/14126))
- Fixed "ARC: unreliable setLen "
  ([#14495](https://github.com/nim-lang/Nim/issues/14495))
- Fixed "lent is unsafe: after #14447 you can modify variables with "items" loop for sequences"
  ([#14498](https://github.com/nim-lang/Nim/issues/14498))
- Fixed "moveFile does not overwrite destination file"
  ([#14057](https://github.com/nim-lang/Nim/issues/14057))
- Fixed "`var op = fn()` wrongly gives warning `ObservableStores` with `object of RootObj` type"
  ([#14514](https://github.com/nim-lang/Nim/issues/14514))
- Fixed "`wrapWords` seems to ignore linebreaks when wrapping, leaving breaks in the wrong place"
  ([#14579](https://github.com/nim-lang/Nim/issues/14579))
