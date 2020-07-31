---
title: "Versions 1.2.6 and 1.0.8 released"
author: The Nim Team
---

The Nim team is happy to announce this double release of versions 1.2.6 and 1.0.8.


# Version 1.2.6

Version 1.2.6 is our third patch release for Nim 1.2 and it brings several new
fixes since versions 1.2.2 and 1.2.4 (the latter was just a hotfix release,
because 1.2.2 was mistakenly shipped without `nim-gdb`).


## Installing Nim 1.2.6

### New users

Check out if the package manager of your OS already ships version 1.2.6 or
install it as described [here](https://nim-lang.org/install.html).


### Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.2.6 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.0.8 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2020-07-29-version-1-2-bf320ed).


## Bugfixes since 1.2.2

- Fixed "The pegs module doesn't work with generics!"
  ([#14718](https://github.com/nim-lang/Nim/issues/14718))
- Fixed "[goto exceptions] {.noReturn.} pragma is not detected in a case expression"
  ([#14458](https://github.com/nim-lang/Nim/issues/14458))
- Fixed "[exceptions:goto] C compiler error with dynlib pragma calling a proc"
  ([#14240](https://github.com/nim-lang/Nim/issues/14240))
- Fixed "Nim source archive install: 'install.sh' fails with error: cp: cannot stat 'bin/nim-gdb': No such file or directory"
  ([#14748](https://github.com/nim-lang/Nim/issues/14748))
- Fixed "Stropped identifiers don't work as field names in tuple literals"
  ([#14911](https://github.com/nim-lang/Nim/issues/14911))
- Fixed "uri.decodeUrl crashes on incorrectly formatted input"
  ([#14082](https://github.com/nim-lang/Nim/issues/14082))
- Fixed "odbcsql module has some wrong integer types"
  ([#9771](https://github.com/nim-lang/Nim/issues/9771))
- Fixed "[ARC] Compiler crash declaring a finalizer proc directly in 'new'"
  ([#15044](https://github.com/nim-lang/Nim/issues/15044))
- Fixed "code with named arguments in proc of winim/com can not been compiled"
  ([#15056](https://github.com/nim-lang/Nim/issues/15056))
- Fixed "javascript backend produces javascript code with syntax error in object syntax"
  ([#14534](https://github.com/nim-lang/Nim/issues/14534))
- Fixed "[ARC] SIGSEGV when calling a closure as a tuple field in a seq"
  ([#15038](https://github.com/nim-lang/Nim/issues/15038))
- Fixed "Compiler crashes when using string as object variant selector with else branch"
  ([#14189](https://github.com/nim-lang/Nim/issues/14189))
- Fixed "Constructing a uint64 range on a 32-bit machine leads to incorrect codegen"
  ([#14616](https://github.com/nim-lang/Nim/issues/14616))

Full changelog since v1.2.2 contains [30 commits](https://github.com/nim-lang/Nim/compare/v1.2.2...v1.2.6).



# Verson 1.0.8

Version 1.0.8 is our fourth patch release for Nim 1.0 for those users who haven't
yet switched to Nim 1.2, coming 5 months after the release of Nim 1.0.6.

If you are still on Nim 1.0.x, and would like to know about new features
available in Nim 1.2.x, check out our
[version 1.2.0 release article](https://nim-lang.org/blog/2020/04/03/version-120-released.html).


## Installing Nim 1.0.8

### New users

We recommend you to install Nim 1.2, see the instructions above.


### Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.0.8 is as easy as:

```bash
$ choosenim 1.0.8
```

Alternatively, you can download Nim 1.0.8 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2020-07-29-version-1-0-b5ec602).


## Bugfixes since 1.0.6

- Fixed "write requires conversion to string"
  ([#13182](https://github.com/nim-lang/Nim/issues/13182))
- Fixed "Some remarks to stdlib documentation"
  ([#13352](https://github.com/nim-lang/Nim/issues/13352))
- Fixed "[Macro] Crash on malformed case statement with multiple else"
  ([#13255](https://github.com/nim-lang/Nim/issues/13255))
- Fixed "regression: `echo 'discard' | nim c -r -` generates a file '-' ; `-` should be treated specially"
  ([#13374](https://github.com/nim-lang/Nim/issues/13374))
- Fixed "Internal error in getTypeDescAux"
  ([#13378](https://github.com/nim-lang/Nim/issues/13378))
- Fixed "Internal error in getTypeDescAux"
  ([#13378](https://github.com/nim-lang/Nim/issues/13378))
- Fixed "joinPath("", "") is "/" ; should be """
  ([#13455](https://github.com/nim-lang/Nim/issues/13455))
- Fixed "tables.values is broken"
  ([#13496](https://github.com/nim-lang/Nim/issues/13496))
- Fixed "Arrays are passed by copy to iterators, causing crashes, unnecessary allocations and slowdowns"
  ([#12747](https://github.com/nim-lang/Nim/issues/12747))
- Fixed "[regression] VM: Error: cannot convert -1 to uint64"
  ([#13661](https://github.com/nim-lang/Nim/issues/13661))
- Fixed "Error: cannot convert -1 to uint (inside tuples)"
  ([#13671](https://github.com/nim-lang/Nim/issues/13671))
- Fixed "Critical: 1 completed Future, multiple await: Only 1 await will be awakened (the last one)"
  ([#13889](https://github.com/nim-lang/Nim/issues/13889))
- Fixed "openssl wrapper corrupts stack on OpenSSL 1.1.1f + Android"
  ([#13903](https://github.com/nim-lang/Nim/issues/13903))
- Fixed "Cant use expressions with `when` in `type` sections."
  ([#14007](https://github.com/nim-lang/Nim/issues/14007))
- Fixed "Incorrect escape sequence for example in jsffi library documentation"
  ([#14110](https://github.com/nim-lang/Nim/issues/14110))
- Fixed "cas is wrong for tcc"
  ([#14151](https://github.com/nim-lang/Nim/issues/14151))
- Fixed "Invalid return value of openProcess is NULL rather than `INVALID_HANDLE_VALUE(-1)` in windows"
  ([#14289](https://github.com/nim-lang/Nim/issues/14289))
- Fixed "nim-gdb is missing from all released packages"
  ([#13104](https://github.com/nim-lang/Nim/issues/13104))
- Fixed "The pegs module doesn't work with generics!"
  ([#14718](https://github.com/nim-lang/Nim/issues/14718))
- Fixed "Nim source archive install: 'install.sh' fails with error: cp: cannot stat 'bin/nim-gdb': No such file or directory"
  ([#14748](https://github.com/nim-lang/Nim/issues/14748))
- Fixed "Stropped identifiers don't work as field names in tuple literals"
  ([#14911](https://github.com/nim-lang/Nim/issues/14911))
- Fixed "uri.decodeUrl crashes on incorrectly formatted input"
  ([#14082](https://github.com/nim-lang/Nim/issues/14082))
- Fixed "odbcsql module has some wrong integer types"
  ([#9771](https://github.com/nim-lang/Nim/issues/9771))
- Fixed "code with named arguments in proc of winim/com can not been compiled"
  ([#15056](https://github.com/nim-lang/Nim/issues/15056))
- Fixed "javascript backend produces javascript code with syntax error in object syntax"
  ([#14534](https://github.com/nim-lang/Nim/issues/14534))
- Fixed "Compiler crashes when using string as object variant selector with else branch"
  ([#14189](https://github.com/nim-lang/Nim/issues/14189))

Full changelog since v1.0.6 contains [82 commits](https://github.com/nim-lang/Nim/compare/v1.0.6...v1.0.8).
