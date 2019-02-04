---
title: "Version 0.19.4 released"
author: The Nim Team
---

The Nim team is happy to announce that the latest release of Nim,
version 0.19.4, is now available. Nim is a systems programming language that
focuses on performance, portability and expressiveness.

This is mostly a bugfix release of version 0.19.2.
There are no breaking changes.
The most important bugfixes are:

- The mark&sweep GC had a serious performance regression that has been fixed.
- The produced tarballs now support `koch tests`.
- Json escaping has been fixed.
- The documentation for `async` procs was missing, fixed.


## Installing 0.19.4

If you have installed a previous version of Nim using ``choosenim``,
getting Nim 0.19.4 is as easy as:

```bash
$ choosenim update stable
```

If you don't have it already, you can get ``choosenim`` by following
[these instructions](https://github.com/dom96/choosenim) or you can install
Nim by following the instructions on our
[install](https://nim-lang.org/install.html) page.


### Bugfixes

- Fixed "Latest HEAD segfaults when compiling Aporia"
  ([#9889](https://github.com/nim-lang/Nim/issues/9889))
- Fixed "smtp module doesn't support threads."
  ([#9728](https://github.com/nim-lang/Nim/issues/9728))
- Fixed "toInt doesn't raise an exception"
  ([#2764](https://github.com/nim-lang/Nim/issues/2764))
- Fixed "allow `import` inside `block`: makes N runnableExamples run N x faster, minimizes scope pollution"
  ([#9300](https://github.com/nim-lang/Nim/issues/9300))
- Fixed "regression: CI failing `Error: unhandled exception: cannot open: /Users/travis/.cache/nim/docgen_sample_d/runnableExamples/docgen_sample_examples.nim [IOError]`"
  ([#10188](https://github.com/nim-lang/Nim/issues/10188))
- Fixed "Discrepancy in Documentation About 'f128 Type-Suffix"
  ([#10213](https://github.com/nim-lang/Nim/issues/10213))
- Fixed "Performance regression with --gc:markandsweep"
  ([#10271](https://github.com/nim-lang/Nim/issues/10271))
- Fixed "cannot call template/macros with varargs[typed] to varargs[untyped]"
  ([#10075](https://github.com/nim-lang/Nim/issues/10075))
- Fixed "--embedsrc does not work on macos"
  ([#10263](https://github.com/nim-lang/Nim/issues/10263))
- Fixed "terminal.nim colored output is not GCSAFE."
  ([#8294](https://github.com/nim-lang/Nim/issues/8294))
- Fixed "Path in error message has `..\..\..\..\..\`  prefix since 0.19.0"
  ([#9556](https://github.com/nim-lang/Nim/issues/9556))
- Fixed ""contributing" is listed as a module on theindex"
  ([#10287](https://github.com/nim-lang/Nim/issues/10287))
- Fixed "[Regression] converter to string leads fail to compile  on 0.19"
  ([#9149](https://github.com/nim-lang/Nim/issues/9149))
- Fixed "oids counter starts at zero; spec says it should be random"
  ([#2796](https://github.com/nim-lang/Nim/issues/2796))