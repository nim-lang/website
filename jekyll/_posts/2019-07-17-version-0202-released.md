---
title: "Version 0.20.2 released"
author: The Nim Team
---

The Nim team is happy to announce version 0.20.2, which is our second
release candidate for version 1.0.

To read more about version 0.20 and our plans for version 1.0 and beyond,
check the [previous release notes](https://nim-lang.org/blog/2019/06/06/version-0200-released.html).
This is mostly a bugfix release of version 0.20.0 (1.0 RC1).

The only new feature is that `toOpenArray`, our slicing operator,
is now available for the JavaScript backend.

Although this release comes only one month after a previous release,
it has over 200 new commits, fixing over 70 reported issues and bringing
lots of improvements which should make Nim even more stable.


### Style checks

Since version 0.20.0 we improved our style checker to the point that
Nim now bootstraps with `--styleCheck:error` flag, meaning that the compiler
and the standard library are now style checked and they won't compile if
different styles (e.g. `fooBar` and `foo_bar`) are used.

If you would like to only style check your own nimble package, but not its
dependencies, you can use `--styleCheck:hint`, making your package consistent
while still retaining perfect interoperability with all other Nim code in the wild.


### Nimpretty

One of the areas which we focused on for this release is our `nimpretty` tool --
it is a Nim source code beautifier, to format code according to the official
style guide ([NEP-1](https://nim-lang.org/docs/nep1.html)).
More than 30 commits were made aiming to improve `nimpretty` experience and
to make it more robust for real-world scenarios.
Nimpretty version 0.2 ships with Nim, and we invite you to give it a try.


### New runtime

The new runtime is progressing nicely but it is off the critical path for
version 1.0 as it's an opt-in feature.
The next significant milestone is to make the new runtime work with `async`.
Only after this is accomplished we can push for more adoption of it.



## Installing 0.20.2

If you have installed a previous version of Nim using ``choosenim``,
getting Nim 0.20.2 is as easy as:

```bash
$ choosenim update stable
```

If you don't have it already, you can get ``choosenim`` by following
[these instructions](https://github.com/dom96/choosenim) or you can install
Nim by following the instructions on our
[install](https://nim-lang.org/install.html) page.




## Changes affecting backwards compatibility

- All `strutils.rfind` procs now take `start` and `last` like `strutils.find`
  with the same data slice/index meaning. This is backwards compatible for
  calls *not* changing the `rfind` `start` parameter from its default. (#11487)

  In the unlikely case that you were using `rfind X, start=N`, or `rfind X, N`,
  then you need to change that to `rfind X, last=N` or `rfind X, 0, N`. (This
  should minimize gotchas porting code from other languages like Python or C++.)

- On Windows stderr/stdout/stdin are not opened as binary files anymore. Use the switch
  `-d:nimBinaryStdFiles` for a transition period.

### Breaking changes in the standard library

- Mac OS X / BSD: TSa_Family is now the ``uint8`` type, so type
  conversions like ``x.sin_family = uint16 toInt(nativesockets.AF_INET)``
  need to be changed into ``x.sin_family = TSa_Family toInt(nativesockets.AF_INET)``.



## Library additions

- `toOpenArray` is now available for the JS target.


## Library changes

- Fix async IO operations stalling even after socket is closed. (#11232)

- More informative error message for `streams.openFileStream`. (#11438)


## Compiler changes

- Better error message for IndexError for empty containers. (#11476)

- Fix regression in semfold for old right shift. (#11477)

- Fix for passing tuples as static params to macros. (#11423)


## Bugfixes

- Fixed "nimpretty goes crazy with this snippet"
  ([#10295](https://github.com/nim-lang/Nim/issues/10295))
- Fixed "nimpretty doesn't trim all whitespace on the right side of an export marker"
  ([#10177](https://github.com/nim-lang/Nim/issues/10177))
- Fixed "nimpretty gives invalid indentation to array elements"
  ([#9505](https://github.com/nim-lang/Nim/issues/9505))
- Fixed "nimpretty doesn't indent correctly if preceding line ends with `;`, `{` etc"
  ([#10159](https://github.com/nim-lang/Nim/issues/10159))
- Fixed "Nimpretty wrong indentation for doc comments"
  ([#10156](https://github.com/nim-lang/Nim/issues/10156))
- Fixed "HttpClient Documentation needs Proxy example"
  ([#11281](https://github.com/nim-lang/Nim/issues/11281))
- Fixed "nimpretty aligns comment annoyingly"
  ([#9399](https://github.com/nim-lang/Nim/issues/9399))
- Fixed "ENDB missing from Docs and TheIndex, remove ENDB from --fullhelp"
  ([#11431](https://github.com/nim-lang/Nim/issues/11431))
- Fixed "Nimrod on Documentation generator"
  ([#11460](https://github.com/nim-lang/Nim/issues/11460))
- Fixed "nimpretty (de)indents code where it shouldn't"
  ([#11468](https://github.com/nim-lang/Nim/issues/11468))
- Fixed "nimpretty adds spaces where it shouldn't"
  ([#11470](https://github.com/nim-lang/Nim/issues/11470))
- Fixed "nimpretty formats enums differently based on commas"
  ([#11467](https://github.com/nim-lang/Nim/issues/11467))
- Fixed "strutils.rfind start parameter is unecessarily unusual"
  ([#11430](https://github.com/nim-lang/Nim/issues/11430))
- Fixed "TinyC is not documented"
  ([#11495](https://github.com/nim-lang/Nim/issues/11495))
- Fixed "c2nim missing from 0.20.0"
  ([#11434](https://github.com/nim-lang/Nim/issues/11434))
- Fixed "nimsuggest doesn't work unless compiled with -d:danger"
  ([#11482](https://github.com/nim-lang/Nim/issues/11482))
- Fixed "random.initRand crashes in Nim 0.20.0 JS backend"
  ([#11450](https://github.com/nim-lang/Nim/issues/11450))
- Fixed "0.20.0 fails to bootstrap when passing "--verbosity:2" (or 3) to koch"
  ([#11436](https://github.com/nim-lang/Nim/issues/11436))
- Fixed "Destructors lifting doesn't work with inheritance"
  ([#11517](https://github.com/nim-lang/Nim/issues/11517))
- Fixed "std/sums missing from TheIndex"
  ([#11543](https://github.com/nim-lang/Nim/issues/11543))
- Fixed "sequtils module: link is broken"
  ([#11546](https://github.com/nim-lang/Nim/issues/11546))
- Fixed "Case Statement Macros do not work in functions above exported functions."
  ([#11556](https://github.com/nim-lang/Nim/issues/11556))
- Fixed "newruntime: internal error when initializing a proc variable"
  ([#11533](https://github.com/nim-lang/Nim/issues/11533))
- Fixed "newruntime: error when modifying a sequence"
  ([#11524](https://github.com/nim-lang/Nim/issues/11524))
- Fixed "fmod and other math module functions are missing in js mode"
  ([#4630](https://github.com/nim-lang/Nim/issues/4630))
- Fixed "Object variants and new runtime"
  ([#11563](https://github.com/nim-lang/Nim/issues/11563))
- Fixed "newruntime exceptions"
  ([#11577](https://github.com/nim-lang/Nim/issues/11577))
- Fixed "nimpretty is not aware that the next line is a part of the same context"
  ([#11469](https://github.com/nim-lang/Nim/issues/11469))
- Fixed "Distinct procs fail to compile"
  ([#11600](https://github.com/nim-lang/Nim/issues/11600))
- Fixed "[SharedTables] Error: undeclared identifier: 'defaultInitialSize'"
  ([#11588](https://github.com/nim-lang/Nim/issues/11588))
- Fixed "newSeqOfCap is not working in newruntime"
  ([#11098](https://github.com/nim-lang/Nim/issues/11098))
- Fixed "nimpretty destroys source with a source code filter"
  ([#11532](https://github.com/nim-lang/Nim/issues/11532))
- Fixed "Unexpected behaviour when constructing with `result`"
  ([#11525](https://github.com/nim-lang/Nim/issues/11525))
- Fixed "Regression in 0.20.0: Nested proc using outer scope variable fails to compile"
  ([#11523](https://github.com/nim-lang/Nim/issues/11523))
- Fixed "os:standalone Error: redefinition of 'nimToCStringConv' "
  ([#11445](https://github.com/nim-lang/Nim/issues/11445))
- Fixed "No ambiguity error on field overloaded by `field=`"
  ([#11514](https://github.com/nim-lang/Nim/issues/11514))
- Fixed "object variants and new runtime part 2"
  ([#11611](https://github.com/nim-lang/Nim/issues/11611))
- Fixed "seq Error: unhandled exception: value out of range: 32772 "
  ([#11606](https://github.com/nim-lang/Nim/issues/11606))
- Fixed "Compiled binary includes full path to internal nim files"
  ([#11572](https://github.com/nim-lang/Nim/issues/11572))
- Fixed "Newruntime: top-level string variable is empty after an array assignment"
  ([#11614](https://github.com/nim-lang/Nim/issues/11614))
- Fixed "Newruntime: raise ObjContructor() doesn't compile"
  ([#11628](https://github.com/nim-lang/Nim/issues/11628))
- Fixed "Owned ref can be copied and causes double-free"
  ([#11617](https://github.com/nim-lang/Nim/issues/11617))
- Fixed "When compiling to JS (in `-d:release`) output contains toolchain path on dev's machine"
  ([#11545](https://github.com/nim-lang/Nim/issues/11545))
- Fixed "wrong unicode string output"
  ([#11618](https://github.com/nim-lang/Nim/issues/11618))
- Fixed "unittest "generic instantiation too nested" error"
  ([#11515](https://github.com/nim-lang/Nim/issues/11515))
- Fixed "Last read of a var parameter generates sink instead of assignment"
  ([#11633](https://github.com/nim-lang/Nim/issues/11633))
- Fixed "const table with proc type does not compile anymore"
  ([#11479](https://github.com/nim-lang/Nim/issues/11479))
- Fixed "Can't use offsetOf on object that ends with an UncheckedArray"
  ([#11320](https://github.com/nim-lang/Nim/issues/11320))
- Fixed "Newruntime/regression: Bad codegen for inline methods"
  ([#11636](https://github.com/nim-lang/Nim/issues/11636))
- Fixed "String or sequences inside a loop are not cleared in each iteration"
  ([#11510](https://github.com/nim-lang/Nim/issues/11510))
- Fixed "Nim -v doesn't acknowledge new danger flag"
  ([#11484](https://github.com/nim-lang/Nim/issues/11484))
- Fixed "SIGSEGV while compiling when trying to instantiate a case type, that uses an enum with non-zero start"
  ([#11585](https://github.com/nim-lang/Nim/issues/11585))
- Fixed "Compile-time usage of parts of strutils fails when using -d:useNimRtl"
  ([#8405](https://github.com/nim-lang/Nim/issues/8405))
- Fixed "regression(0.20): `finally` block executed twice in VM"
  ([#11610](https://github.com/nim-lang/Nim/issues/11610))
- Fixed "exportc symbol not exported, leading to link error"
  ([#11651](https://github.com/nim-lang/Nim/issues/11651))
- Fixed "Render bug: opearator priority can be wrong for second argument"
  ([#11662](https://github.com/nim-lang/Nim/issues/11662))
- Fixed "Nim & C disagree on type size"
  ([#6860](https://github.com/nim-lang/Nim/issues/6860))
- Fixed "Spawn passes refs across threads"
  ([#7057](https://github.com/nim-lang/Nim/issues/7057))
- Fixed "BUG: "varargs[string, `$`]"  calls `$` n^2 times instead of n times (n=len(varargs))"
  ([#8316](https://github.com/nim-lang/Nim/issues/8316))
- Fixed "Problem with the same name for module and exported type"
  ([#3333](https://github.com/nim-lang/Nim/issues/3333))
- Fixed "--gc:go does not work anymore"
  ([#11447](https://github.com/nim-lang/Nim/issues/11447))
- Fixed "Error: inconsistent typing for reintroduced symbol"
  ([#11494](https://github.com/nim-lang/Nim/issues/11494))
- Fixed "Auto generated destructors  for tuples/objects fail with "non-trivial" error..."
  ([#11671](https://github.com/nim-lang/Nim/issues/11671))
- Fixed "Regression: parameter default value + typedesc parameter causes compiler crash"
  ([#11660](https://github.com/nim-lang/Nim/issues/11660))
- Fixed "newruntime: undetected dangling ref"
  ([#11350](https://github.com/nim-lang/Nim/issues/11350))
- Fixed "Newruntime: setLen() not working on sequences of owned refs"
  ([#11530](https://github.com/nim-lang/Nim/issues/11530))
- Fixed "Incorrect overflow/underflow error in case statements"
  ([#11551](https://github.com/nim-lang/Nim/issues/11551))
- Fixed "cgen preprocessor directive placed after struct declaration"
  ([#11691](https://github.com/nim-lang/Nim/issues/11691))
- Fixed "`continue` in an `except Exception as e` block crashes the compiler."
  ([#11683](https://github.com/nim-lang/Nim/issues/11683))
- Fixed "nimsuggest, nim check segfault when using bindSym and doAssert"
  ([#10901](https://github.com/nim-lang/Nim/issues/10901))
- Fixed "Nimpretty issue, multiline string of x length only causes output grow every time."
  ([#11700](https://github.com/nim-lang/Nim/issues/11700))
- Fixed "Array indexed by distinct int doesnt work with iterators"
  ([#11715](https://github.com/nim-lang/Nim/issues/11715))
