---
title: "Version 0.20.0 released"
author: The Nim Team
excerpt: "We are very proud to announce Nim version 0.20. This is a massive release, both literally and figuratively. It contains more than 1,000 commits and it marks our release candidate for version 1.0!"
---

We are very proud to announce Nim version 0.20.

This is a massive release, both literally and figuratively.
It contains more than 1,000 commits *and* it marks our release candidate for version 1.0!

Version 0.20 introduces a number of breaking changes required for version 1.0.
These are changes that we feel have been necessary to include in Nim 1.0 and we currently have no plans for any further breaking changes.
Version 0.20 is effectively Nim 1.0 RC1.

Why not just release v1.0? We want to give the community a chance to test 0.20.0 and find bugs that *may* require breaking changes.
This is unlikely, but may require further release candidates.
Make no mistake, this release represents what we consider Nim 1.0, we have been working towards this milestone for many years and are incredibly excited to reach it.



# The stability guarantee

A 1.0 release means that once either Nim 0.20.0 is promoted to 1.0 status, or another release candidate is, there will no longer be any breaking changes made.
Version 1.0 will become a long-term supported stable release that will only receive bug fixes and new features in the future, as long as they don’t break backwards compatibility.

The 1.0.x branch will receive bug fixes for as long as there is demand for them.
New features (which do not break backwards compatibility) will continue in steadily advancing 1.x branches.

Our goal is to make sure that code which compiled under Nim 1.0 continues to compile under any stable Nim 1.x version.


## What’s included under the stability guarantee?

Backwards compatibility covers only the stable fragment of the language, as defined by the manual.

The compiler still implements experimental features which are documented in the newly written
[“experimental manual”](https://nim-lang.org/docs/manual_experimental.html), these features are subject to changes which may be backwards incompatible, some of the features included under this umbrella are concepts, the do notation and a few others.
Be wary of using these features in production, but do get in touch with us if you want to learn more about our plans regarding them.

The standard library is also covered, we will continue to deprecate procedures if we must, but they will remain supported throughout the 1.x version series.


## Exceptions to the rule

We of course have to concede that there are exceptions.
In certain serious cases, like for example when a security vulnerability is discovered in the stdlib, we reserve the right to break code which uses it.



# Installing 0.20.0

If you have installed a previous version of Nim using ``choosenim``,
getting Nim 0.20.0 is as easy as:

```bash
$ choosenim update stable
```

If you don't have it already, you can get ``choosenim`` by following
[these instructions](https://github.com/dom96/choosenim) or you can install
Nim by following the instructions on our
[install](https://nim-lang.org/install.html) page.


## Nimble 0.10.2

This release includes a brand new version of Nimble.
See [Nimble changelog](https://github.com/nim-lang/nimble/blob/master/changelog.markdown#0102---03062019).


## Contributors to v0.20

Our contributors are amazing, and there is [far too many](https://github.com/nim-lang/Nim/graphs/contributors?from=2018-09-26&to=2019-06-06&type=c) to list here.
Big thanks to all of you, we couldn’t have pulled off this release without you!



# New features

Version 0.20 is positively jam packed with features.
Here is a selection of our favourites:


## `not` is always a unary operator

```nim
let a = false

# v0.19:
assert not a # Error: type mismatch: got <proc (cond: untyped, msg: string): typed, bool>
assert(not a) # workaround

# v0.20:
assert not a
```


## Stricter compile time checks for integer and float conversions

```nim
# v0.19:
const b = uint16(-1)
echo b # 65535

# v0.20:
const b = uint16(-1)
# Error: -1 can't be converted to uint16
const c = not uint16(0)
echo c # 65535
```


## Tuple unpacking for constant and for loop variables

```nim
const (d, e) = (7, "eight")
# v0.19: Error: identifier expected, but got '('

# v0.20:
echo d # 7
echo e # eight


let f = @[(51, 10), (23, 25)]

for (x, y) in f: # v0.19: Error: identifier expected, but got '('
  echo x + y
# v0.20:
# 61
# 48
```

## Hash sets and tables are initialized by default

```nim
import sets, tables

var s: HashSet[int]

s.incl(5)
# v0.19: `isValid(s)` Error: unhandled exception: The set needs to be initialized. [AssertionError]
# v0.20:
echo s # {5}


var t: Table[char, int]
t['a'] = 10
# v0.19: Error: unhandled exception: index out of bounds [IndexError]
# v0.20:
echo t # {'a': 10}
```


## Better error message for case-statements

```nim
type
  MyEnum = enum
    first
    second
    third
    fourth

proc foo(x: MyEnum): int =
  case x
  of first: 1
  of second: 2
  of third: 3
  of fourth: 4
  else: 99

# v0.19: compiles
# v0.20: Error: invalid else, all cases are already covered


proc bar(x: MyEnum): int =
  case x
  of first: 1
  of third: 3

# v0.19: Error: not all cases are covered
# v0.20: Error: not all cases are covered; missing: {second, fourth}
```


## The length of a table must not change during iteration

```nim
import tables

var xs = {1: "one", 2: "two", 3: "three"}.toTable

for x in xs.keys:
  if x mod 2 == 0:
    xs[10*x] = "a lot"
echo xs

# v0.19: {200: "a lot", 1: "one", 2: "two", 3: "three", 20: "a lot"}
# v0.20: Error: unhandled exception: the length of the table changed while iterating over it [AssertionError]
```


## Better error message for index out of bounds

```nim
let a = [10, 20, 30]

echo a[5]
# v0.19: Error: index out of bounds
# v0.20: Error: index 5 not in 0 .. 2
```


# Changelog

## Changes affecting backwards compatibility

- `shr` is now sign preserving. Use `-d:nimOldShiftRight` to enable
  the old behavior globally.

- The ``isLower``, ``isUpper`` family of procs in strutils/unicode
  operating on **strings** have been
  deprecated since it was unclear what these do. Note that the much more
  useful procs that operate on ``char`` or ``Rune`` are not affected.

- `strutils.editDistance` has been deprecated,
  use `editdistance.editDistance` or `editdistance.editDistanceAscii`
  instead.

- The OpenMP parallel iterator \``||`\` now supports any `#pragma omp directive`
  and not just `#pragma omp parallel for`. See
  [OpenMP documentation](https://www.openmp.org/wp-content/uploads/OpenMP-4.5-1115-CPP-web.pdf).

  The default annotation is `parallel for`, if you used OpenMP without annotation
  the change is transparent, if you used annotations you will have to prefix
  your previous annotations with `parallel for`.

  Furthermore, an overload with positive stepping is available.

- The `unchecked` pragma was removed, instead use `system.UncheckedArray`.

- The undocumented ``#? strongSpaces`` parsing mode has been removed.

- The `not` operator is now always a unary operator, this means that code like
  ``assert not isFalse(3)`` compiles.

- `getImpl` on a `var` or `let` symbol will now return the full `IdentDefs`
  tree from the symbol declaration instead of just the initializer portion.

- Methods are now ordinary "single" methods, only the first parameter is
  used to select the variant at runtime. For backwards compatibility
  use the new `--multimethods:on` switch.

- Generic methods are now deprecated; they never worked well.

- Compile time checks for integer and float conversions are now stricter.
  For example, `const x = uint32(-1)` now gives a compile time error instead
  of being equivalent to `const x = 0xFFFFFFFF'u32`.

- Using `typed` as the result type in templates/macros now means
  "expression with a type". The old meaning of `typed` is preserved
  as `void` or no result type at all.

- A bug allowed `macro foo(): int = 123` to compile even though a
  macro has to return a `NimNode`. This has been fixed.

- With the exception of `uint` and `uint64`, conversion to unsigned types
  are now range checked during runtime.

- Macro arguments of type `typedesc` are now passed to the macro as
  `NimNode` like every other type except `static`. Use `typed` for a
  behavior that is identical in new and old
  Nim. See the RFC [Pass typedesc as NimNode to macros](https://github.com/nim-lang/RFCs/issues/148)
  for more details.


### Breaking changes in the standard library

- `osproc.execProcess` now also takes a `workingDir` parameter.

- `std/sha1.secureHash` now accepts `openArray[char]`, not `string`. (Former
   successful matches should keep working, though former failures will not.)

- `options.UnpackError` is no longer a ref type and inherits from `system.Defect`
  instead of `system.ValueError`.

- `system.ValueError` now inherits from `system.CatchableError` instead of `system.Defect`.

- The procs `parseutils.parseBiggestInt`, `parseutils.parseInt`,
  `parseutils.parseBiggestUInt` and `parseutils.parseUInt` now raise a
  `ValueError` when the parsed integer is outside of the valid range.
  Previously they sometimes raised an `OverflowError` and sometimes they
  returned `0`.

- The procs `parseutils.parseBin`, `parseutils.parseOct` and `parseutils.parseHex`
  were not clearing their `var` parameter `number` and used to push its value to
  the left when storing the parsed string into it. Now they always set the value
  of the parameter to `0` before storing the result of the parsing, unless the
  string to parse is not valid (then the value of `number` is not changed).

- `streams.StreamObject` now restricts its fields to only raise `system.Defect`,
  `system.IOError` and `system.OSError`.
  This change only affects custom stream implementations.

- nre's `RegexMatch.{captureBounds,captures}[]`  no longer return `Option` or
  `nil`/`""`, respectively. Use the newly added `n in p.captures` method to
  check if a group is captured, otherwise you'll receive an exception.

- nre's `RegexMatch.{captureBounds,captures}.toTable` no longer accept a
  default parameter. Instead uncaptured entries are left empty. Use
  `Table.getOrDefault()` if you need defaults.

- nre's `RegexMatch.captures.{items,toSeq}` now returns an `Option[string]`
  instead of a `string`. With the removal of `nil` strings, this is the only
  way to indicate a missing match. Inside your loops, instead
  of `capture == ""` or `capture == nil`, use `capture.isSome` to check if a capture is
  present, and `capture.get` to get its value.

- nre's `replace()` no longer throws `ValueError` when the replacement string
  has missing captures. It instead throws `KeyError` for named captures, and
  `IndexError` for unnamed captures. This is consistent with
  `RegexMatch.{captureBounds,captures}[]`.

- `splitFile` now correctly handles edge cases, see #10047.

- `isNil` is no longer false for undefined in the JavaScript backend:
  now it's true for both nil and undefined.
  Use `isNull` or `isUndefined` if you need exact equality:
  `isNil` is consistent with `===`, `isNull` and `isUndefined` with `==`.

- several deprecated modules were removed: `ssl`, `matchers`, `httpserver`,
  `unsigned`, `actors`, `parseurl`

- two poorly documented and not used modules (`subexes`, `scgi`) were moved to
  graveyard (they are available as Nimble packages)

- procs `string.add(int)` and `string.add(float)` which implicitly convert
  ints and floats to string have been deprecated.
  Use `string.addInt(int)` and `string.addFloat(float)` instead.

- ``case object`` branch transitions via ``system.reset`` are deprecated.
  Compile your code with ``-d:nimOldCaseObjects`` for a transition period.

- base64 module: The default parameter `newLine` for the `encode` procs
  was changed from `"\13\10"` to the empty string `""`.


### Breaking changes in the compiler

- The compiler now implements the "generic symbol prepass" for `when` statements
  in generics, see bug #8603. This means that code like this does not compile
  anymore:

```nim
proc enumToString*(enums: openArray[enum]): string =
  # typo: 'e' instead 'enums'
  when e.low.ord >= 0 and e.high.ord < 256:
    result = newString(enums.len)
  else:
    result = newString(enums.len * 2)
```

- ``discard x`` is now illegal when `x` is a function symbol.

- Implicit imports via ``--import: module`` in a config file are now restricted
  to the main package.


## Library additions

- There is a new stdlib module `std/editdistance` as a replacement for the
  deprecated `strutils.editDistance`.

- There is a new stdlib module `std/wordwrap` as a replacement for the
  deprecated `strutils.wordwrap`.

- Added `split`, `splitWhitespace`, `size`, `alignLeft`, `align`,
  `strip`, `repeat` procs and iterators to `unicode.nim`.

- Added `or` for `NimNode` in `macros`.

- Added `system.typeof` for more control over how `type` expressions
  can be deduced.

- Added `macros.isInstantiationOf` for checking if the proc symbol
  is instantiation of generic proc symbol.

- Added the parameter ``isSorted`` for the ``sequtils.deduplicate`` proc.

- Added `os.relativePath`.

- Added `parseopt.remainingArgs`.

- Added `os.getCurrentCompilerExe` (implemented as `getAppFilename` at CT),
  can be used to retrieve the currently executing compiler.

- Added `xmltree.toXmlAttributes`.

- Added ``std/sums`` module for fast summation functions.

- Added `Rusage`, `getrusage`, `wait4` to the posix interface.

- Added the `posix_utils` module.

- Added `system.default`.

- Added `sequtils.items` for closure iterators, allows closure iterators
  to be used by the `mapIt`, `filterIt`, `allIt`, `anyIt`, etc.


## Library changes

- The string output of `macros.lispRepr` proc has been tweaked
  slightly. The `dumpLisp` macro in this module now outputs an
  indented proper Lisp, devoid of commas.

- Added `macros.signatureHash` that returns a stable identifier
  derived from the signature of a symbol.

- In `strutils` empty strings now no longer match as substrings.

- The `Complex` type is now a generic object and not a tuple anymore.

- The `ospaths` module is now deprecated, use `os` instead. Note that
  `os` is available in a NimScript environment but unsupported
  operations produce a compile-time error.

- The `parseopt` module now supports a new flag `allowWhitespaceAfterColon`
  (default value: true) that can be set to `false` for better Posix
  interoperability. (Bug #9619.)

- `os.joinPath` and `os.normalizePath` handle edge cases like ``"a/b/../../.."``
  differently.

- `securehash` was moved to `lib/deprecated`.

- The switch ``-d:useWinAnsi`` is not supported anymore.

- In `times` module, procs `format` and `parse` accept a new optional
  `DateTimeLocale` argument for formatting/parsing dates in other languages.


## Language additions

- Vm support for float32<->int32 and float64<->int64 casts was added.
- There is a new pragma block `noSideEffect` that works like
  the `gcsafe` pragma block.
- added `os.getCurrentProcessId`.
- User defined pragmas are now allowed in the pragma blocks.
- Pragma blocks are no longer eliminated from the typed AST tree to preserve
  pragmas for further analysis by macros.
- Custom pragmas are now supported for `var` and `let` symbols.
- Tuple unpacking is now supported for constants and for loop variables.
- Case object branches can be initialized with a runtime discriminator if
  possible discriminator values are constrained within a case statement.

## Language changes

- The standard extension for SCF (source code filters) files was changed from
  ``.tmpl`` to ``.nimf``,
  it's more recognizable and allows tools like Github to recognize it as Nim,
  see [#9647](https://github.com/nim-lang/Nim/issues/9647).
  The previous extension will continue to work.

- Pragma syntax is now consistent. Previous syntax where type pragmas did not
  follow the type name is now deprecated. Also pragma before generic parameter
  list is deprecated to be consistent with how pragmas are used with a proc. See
  [#8514](https://github.com/nim-lang/Nim/issues/8514) and
  [#1872](https://github.com/nim-lang/Nim/issues/1872) for further details.

- Hash sets and tables are initialized by default. The explicit `initHashSet`,
  `initTable`, etc. are not needed anymore.


### Tool changes

- `jsondoc` now includes a `moduleDescription` field with the module
  description. `jsondoc0` shows comments as its own objects as shown in the
  documentation.
- `nimpretty`: --backup now defaults to `off` instead of `on` and the flag was
  undocumented; use `git` instead of relying on backup files.
- `koch` now defaults to build the latest *stable* Nimble version unless you
  explicitly ask for the latest master version via `--latest`.


### Compiler changes

- The deprecated `fmod` proc is now unavailable on the VM.
- A new `--outdir` option was added.
- The compiled JavaScript file for the project produced by executing `nim js`
  will no longer be placed in the nimcache directory.
- The `--hotCodeReloading` has been implemented for the native targets.
  The compiler also provides a new more flexible API for handling the
  hot code reloading events in the code.
- The compiler now supports a ``--expandMacro:macroNameHere`` switch
  for easy introspection into what a macro expands into.
- The `-d:release` switch now does not disable runtime checks anymore.
  For a release build that also disables runtime checks
  use `-d:release -d:danger` or simply `-d:danger`.



## Bugfixes

- Fixed "distinct generic typeclass not treated as distinct"
  ([#4435](https://github.com/nim-lang/Nim/issues/4435))
- Fixed "multiple dynlib pragmas with function calls conflict with each other causing link time error"
  ([#9222](https://github.com/nim-lang/Nim/issues/9222))
- Fixed "[RFC] `extractFilename("usr/lib/")` should return "lib" (not "") and be called `baseName` (since works with dirs)"
  ([#8341](https://github.com/nim-lang/Nim/issues/8341))
- Fixed "\0 in comment replaced with 0 in docs"
  ([#8841](https://github.com/nim-lang/Nim/issues/8841))
- Fixed "round function in Math library sometimes doesn't work"
  ([#9082](https://github.com/nim-lang/Nim/issues/9082))
- Fixed "Async readAll in httpclient produces garbled output."
  ([#8994](https://github.com/nim-lang/Nim/issues/8994))
- Fixed "[regression] project `config.nims` not being read anymore"
  ([#9264](https://github.com/nim-lang/Nim/issues/9264))
- Fixed "Using iterator within another iterator fails"
  ([#3819](https://github.com/nim-lang/Nim/issues/3819))
- Fixed "`nim js -o:dirname main.nim` writes nothing, and no error shown"
  ([#9154](https://github.com/nim-lang/Nim/issues/9154))
- Fixed "Wrong number of deallocations when using destructors"
  ([#9263](https://github.com/nim-lang/Nim/issues/9263))
- Fixed "devel docs in nim-lang.github.io `Source` links point to master instead of devel"
  ([#9295](https://github.com/nim-lang/Nim/issues/9295))
- Fixed "compiler/nimeval can't be used twice: fails 2nd time with: `Error: internal error: n is not nil`"
  ([#9180](https://github.com/nim-lang/Nim/issues/9180))
- Fixed "Codegen bug with exportc"
  ([#9297](https://github.com/nim-lang/Nim/issues/9297))
- Fixed "Regular Expressions: replacing empty patterns only works correctly in nre"
  ([#9306](https://github.com/nim-lang/Nim/issues/9306))
- Fixed "Openarray: internal compiler error when accessing length if not a param"
  ([#9281](https://github.com/nim-lang/Nim/issues/9281))
- Fixed "finish completely removing web folder"
  ([#9304](https://github.com/nim-lang/Nim/issues/9304))
- Fixed "counting the empty substring in a string results in infinite loop"
  ([#8919](https://github.com/nim-lang/Nim/issues/8919))
- Fixed "[Destructors] Wrong moves and copies"
  ([#9294](https://github.com/nim-lang/Nim/issues/9294))
- Fixed "`proc isNil*(x: Any): bool =` should be updated with non nil string, seq"
  ([#8916](https://github.com/nim-lang/Nim/issues/8916))
- Fixed "doAssert AST expansion excessive"
  ([#8518](https://github.com/nim-lang/Nim/issues/8518))
- Fixed "when Foo (of type iterator) is used where an expression is expected, show useful err msg instead of confusing `Error: attempting to call undeclared routine Foo`"
  ([#8671](https://github.com/nim-lang/Nim/issues/8671))
- Fixed "List comprehensions do not work with generic parameter"
  ([#5707](https://github.com/nim-lang/Nim/issues/5707))
- Fixed "strutils/isUpperAscii and unicode/isUpper consider space, punctuations, numbers as "lowercase""
  ([#7963](https://github.com/nim-lang/Nim/issues/7963))
- Fixed "Regular Expressions: replacing empty patterns only works correctly in nre"
  ([#9306](https://github.com/nim-lang/Nim/issues/9306))
- Fixed "BUG: os.isHidden doesn't work with directories; should use just paths, not filesystem access"
  ([#8225](https://github.com/nim-lang/Nim/issues/8225))
- Fixed "Unable to create distinct tuple in a const with a type declaration"
  ([#2760](https://github.com/nim-lang/Nim/issues/2760))
- Fixed "[nimpretty] raw strings are transformed into normal strings"
  ([#9236](https://github.com/nim-lang/Nim/issues/9236))
- Fixed "[nimpretty] proc is transfered to incorrect code"
  ([#8626](https://github.com/nim-lang/Nim/issues/8626))
- Fixed "[nimpretty] Additional new line is added with each format"
  ([#9144](https://github.com/nim-lang/Nim/issues/9144))
- Fixed ""%NIM%/config/nim.cfg" is not being read"
  ([#9244](https://github.com/nim-lang/Nim/issues/9244))
- Fixed "Illegal capture on async proc (except when the argument is `seq`)"
  ([#2361](https://github.com/nim-lang/Nim/issues/2361))
- Fixed "Jsondoc0 doesn't output module comments."
  ([#9364](https://github.com/nim-lang/Nim/issues/9364))
- Fixed "NimPretty has troubles with source code filter"
  ([#9384](https://github.com/nim-lang/Nim/issues/9384))
- Fixed "tfragment_gc test is flaky on OSX"
  ([#9421](https://github.com/nim-lang/Nim/issues/9421))
- Fixed "ansi color code templates fail to bind symbols"
  ([#9394](https://github.com/nim-lang/Nim/issues/9394))
- Fixed "Term write rule crash compiler."
  ([#7972](https://github.com/nim-lang/Nim/issues/7972))
- Fixed "SIGSEGV when converting `lines` to closure iterator, most likely caused by defer"
  ([#5321](https://github.com/nim-lang/Nim/issues/5321))
- Fixed "SIGSEGV during the compile"
  ([#5519](https://github.com/nim-lang/Nim/issues/5519))
- Fixed "Compiler crash when creating a variant type"
  ([#6220](https://github.com/nim-lang/Nim/issues/6220))
- Fixed ""continue" inside a block without loops gives "SIGSEGV: Illegal storage access. (Attempt to read from nil?)""
  ([#6367](https://github.com/nim-lang/Nim/issues/6367))
- Fixed "old changelogs should be kept instead of erased"
  ([#9376](https://github.com/nim-lang/Nim/issues/9376))
- Fixed "illegal recursion with generic typeclass"
  ([#4674](https://github.com/nim-lang/Nim/issues/4674))
- Fixed "Crash when closing an unopened file on debian 8."
  ([#9456](https://github.com/nim-lang/Nim/issues/9456))
- Fixed "nimpretty joins regular and doc comment"
  ([#9400](https://github.com/nim-lang/Nim/issues/9400))
- Fixed "nimpretty changes indentation level of trailing comment"
  ([#9398](https://github.com/nim-lang/Nim/issues/9398))
- Fixed "Some bugs with nimpretty"
  ([#8078](https://github.com/nim-lang/Nim/issues/8078))
- Fixed "Computed gotos: bad codegen, label collision with if/statement in the while body"
  ([#9276](https://github.com/nim-lang/Nim/issues/9276))
- Fixed "nimpretty not idempotent: keeps adding newlines below block comment"
  ([#9483](https://github.com/nim-lang/Nim/issues/9483))
- Fixed "nimpretty shouldn't format differently whether there's a top-level newline"
  ([#9484](https://github.com/nim-lang/Nim/issues/9484))
- Fixed "Regression: 0.18 code with mapIt() fails to compile on 0.19"
  ([#9093](https://github.com/nim-lang/Nim/issues/9093))
- Fixed "nimpretty shouldn't change file modif time if no changes => use os.updateFile"
  ([#9499](https://github.com/nim-lang/Nim/issues/9499))
- Fixed "Nim/compiler/pathutils.nim(226, 12) `canon"/foo/../bar" == "/bar"`  [AssertionError]"
  ([#9507](https://github.com/nim-lang/Nim/issues/9507))
- Fixed "nimpretty adds a space before type, ptr, ref, object in wrong places"
  ([#9504](https://github.com/nim-lang/Nim/issues/9504))
- Fixed "nimpretty badly indents block comment"
  ([#9500](https://github.com/nim-lang/Nim/issues/9500))
- Fixed "typeof: Error: illformed AST: typeof(myIter(), typeOfIter)"
  ([#9498](https://github.com/nim-lang/Nim/issues/9498))
- Fixed "newAsyncSmtp() raises exception with Nim 0.19.0"
  ([#9358](https://github.com/nim-lang/Nim/issues/9358))
- Fixed "nimpretty wrongly adds empty newlines inside proc signature"
  ([#9506](https://github.com/nim-lang/Nim/issues/9506))
- Fixed "HttpClient: requesting URL with no scheme fails"
  ([#7842](https://github.com/nim-lang/Nim/issues/7842))
- Fixed "Duplicate definition in cpp codegen"
  ([#6986](https://github.com/nim-lang/Nim/issues/6986))
- Fixed "Sugar - distinctBase: undeclared identifier uncheckedArray"
  ([#9532](https://github.com/nim-lang/Nim/issues/9532))
- Fixed "Portable fsmonitor"
  ([#6718](https://github.com/nim-lang/Nim/issues/6718))
- Fixed "Small RFC. Minimal stacktrace for Exceptions when frames are disabled"
  ([#9434](https://github.com/nim-lang/Nim/issues/9434))
- Fixed "`nim doc strutils.nim` fails on 32 bit compiler with AssertionError on a RunnableExample"
  ([#9525](https://github.com/nim-lang/Nim/issues/9525))
- Fixed "Error: undeclared identifier: '|'"
  ([#9540](https://github.com/nim-lang/Nim/issues/9540))
- Fixed "using Selectors, Error: undeclared field: 'OSErrorCode'"
  ([#7667](https://github.com/nim-lang/Nim/issues/7667))
- Fixed "The "--" template from module nimscript mis-translates "out" key"
  ([#6011](https://github.com/nim-lang/Nim/issues/6011))
- Fixed "logging error should go to stderr instead of stdout"
  ([#9547](https://github.com/nim-lang/Nim/issues/9547))
- Fixed "when in generic should fail earlier"
  ([#8603](https://github.com/nim-lang/Nim/issues/8603))
- Fixed "C++ codegen error when iterating in finally block in topmost scope"
  ([#5549](https://github.com/nim-lang/Nim/issues/5549))
- Fixed "document `nim --nep1:on`"
  ([#9564](https://github.com/nim-lang/Nim/issues/9564))
- Fixed "C++ codegen error when iterating in finally block in topmost scope"
  ([#5549](https://github.com/nim-lang/Nim/issues/5549))
- Fixed "strutils.multiReplace() crashes if search string is """
  ([#9557](https://github.com/nim-lang/Nim/issues/9557))
- Fixed "Missing docstrings are replaced with other text"
  ([#9169](https://github.com/nim-lang/Nim/issues/9169))
- Fixed "Type which followed by a function and generated by a template will not shown in docs generated by `nim doc`"
  ([#9235](https://github.com/nim-lang/Nim/issues/9235))
- Fixed "templates expand doc comments as documentation of other procedures"
  ([#9432](https://github.com/nim-lang/Nim/issues/9432))
- Fixed "please implement http put and delete in httpClient"
  ([#8777](https://github.com/nim-lang/Nim/issues/8777))
- Fixed "Module docs: 2 suggestions..."
  ([#5525](https://github.com/nim-lang/Nim/issues/5525))
- Fixed "math.hypot under/overflows"
  ([#9585](https://github.com/nim-lang/Nim/issues/9585))
- Fixed "`=sink` gets called on `result` when not used explicitly"
  ([#9594](https://github.com/nim-lang/Nim/issues/9594))
- Fixed "Treat compl as a c++ keyword"
  ([#6836](https://github.com/nim-lang/Nim/issues/6836))
- Fixed "Path in error message has `..\..\..\..\..\`  prefix since 0.19.0"
  ([#9556](https://github.com/nim-lang/Nim/issues/9556))
- Fixed "`nim check` gives `SIGSEGV: Illegal storage access`  ; maybe because of sizeof"
  ([#9610](https://github.com/nim-lang/Nim/issues/9610))
- Fixed "Cannot use a typedesc variable in a template"
  ([#9611](https://github.com/nim-lang/Nim/issues/9611))
- Fixed "`=sink` gets called on `result` when not used explicitly"
  ([#9594](https://github.com/nim-lang/Nim/issues/9594))
- Fixed "[NimScript] Error: arguments can only be given if the '--run' option is selected"
  ([#9246](https://github.com/nim-lang/Nim/issues/9246))
- Fixed "macros.getTypeImpl regression, crash when trying to query type information from ref object"
  ([#9600](https://github.com/nim-lang/Nim/issues/9600))
- Fixed "[Regression] Complex.re and Complex.im are private"
  ([#9639](https://github.com/nim-lang/Nim/issues/9639))
- Fixed "nim check: `internal error: (filename: "vmgen.nim", line: 1119, column: 19)`"
  ([#9609](https://github.com/nim-lang/Nim/issues/9609))
- Fixed "`optInd` missing indent specification in grammar.txt"
  ([#9608](https://github.com/nim-lang/Nim/issues/9608))
- Fixed "`not` as prefix operator causes problems"
  ([#9574](https://github.com/nim-lang/Nim/issues/9574))
- Fixed "It is not possible to specify a pragma for the proc that returns `lent T`"
  ([#9633](https://github.com/nim-lang/Nim/issues/9633))
- Fixed "Compiler crash when initializing table with module name"
  ([#9319](https://github.com/nim-lang/Nim/issues/9319))
- Fixed "compiler crash"
  ([#8335](https://github.com/nim-lang/Nim/issues/8335))
- Fixed ""SIGSEGV" without any "undeclared identifier" error"
  ([#8011](https://github.com/nim-lang/Nim/issues/8011))
- Fixed "Incorrect parseopt parsing ?"
  ([#9619](https://github.com/nim-lang/Nim/issues/9619))
- Fixed "Operator `or` causes a future to be completed more than once"
  ([#8982](https://github.com/nim-lang/Nim/issues/8982))
- Fixed "Nimpretty adds instead of removes incorrect spacing inside backticks"
  ([#9673](https://github.com/nim-lang/Nim/issues/9673))
- Fixed "nimpretty should hardcode indentation amount to 2 spaces"
  ([#9502](https://github.com/nim-lang/Nim/issues/9502))
- Fixed "callSoon() is not working prior getGlobalDispatcher()."
  ([#7192](https://github.com/nim-lang/Nim/issues/7192))
- Fixed "use nimf as standardized extention for nim files with source code filter?"
  ([#9647](https://github.com/nim-lang/Nim/issues/9647))
- Fixed "Banning copy for a type prevents composing"
  ([#9692](https://github.com/nim-lang/Nim/issues/9692))
- Fixed "smtp module doesn't support threads."
  ([#9728](https://github.com/nim-lang/Nim/issues/9728))
- Fixed "Compiler segfault (stack overflow) compiling code on 0.19.0 that works on 0.18.0"
  ([#9694](https://github.com/nim-lang/Nim/issues/9694))
- Fixed "nre doesn't document quantifiers `re"foo{2,4}"`"
  ([#9470](https://github.com/nim-lang/Nim/issues/9470))
- Fixed "ospaths still referenced despite its deprecation"
  ([#9671](https://github.com/nim-lang/Nim/issues/9671))
- Fixed "`move` on dereferenced pointer results in bogus value"
  ([#9743](https://github.com/nim-lang/Nim/issues/9743))
- Fixed "regression in discard statement"
  ([#9726](https://github.com/nim-lang/Nim/issues/9726))
- Fixed "try statements and exceptions do not cooperate well"
  ([#96](https://github.com/nim-lang/Nim/issues/96))
- Fixed "XDeclaredButNotUsed doesn't work with template, let/var/const, type; works with all other routine nodes"
  ([#9764](https://github.com/nim-lang/Nim/issues/9764))
- Fixed "` Warning: fun is deprecated` doesn't check whether deprecated overload is actually used"
  ([#9759](https://github.com/nim-lang/Nim/issues/9759))
- Fixed "Regression: tuple sizeof is incorrect if contains imported object"
  ([#9794](https://github.com/nim-lang/Nim/issues/9794))
- Fixed "Internal error when calling `=destroy` without declaration"
  ([#9675](https://github.com/nim-lang/Nim/issues/9675))
- Fixed "Internal error if `=sink` is used explictly"
  ([#7365](https://github.com/nim-lang/Nim/issues/7365))
- Fixed "unicode.strip behaving oddly"
  ([#9800](https://github.com/nim-lang/Nim/issues/9800))
- Fixed "X_examples.nim generated by runnableExamples should show line number where they came from"
  ([#8289](https://github.com/nim-lang/Nim/issues/8289))
- Fixed "quit() fails with "unreachable statement after 'return'""
  ([#9832](https://github.com/nim-lang/Nim/issues/9832))
- Fixed "quit() fails with "unreachable statement after 'return'""
  ([#9832](https://github.com/nim-lang/Nim/issues/9832))
- Fixed "`Error: internal error: genLiteral: ty is nil` when a `var` is accessed in `quote do`"
  ([#9864](https://github.com/nim-lang/Nim/issues/9864))
- Fixed "Regression: sizeof Error: cannot instantiate: 'T'"
  ([#9868](https://github.com/nim-lang/Nim/issues/9868))
- Fixed "Using a template as a routine pragma no longer works"
  ([#9614](https://github.com/nim-lang/Nim/issues/9614))
- Fixed "Clang error on Rosencrantz"
  ([#9441](https://github.com/nim-lang/Nim/issues/9441))
- Fixed "Enum fields get hintXDeclaredButNotUsed hint even when marked with used pragma"
  ([#9896](https://github.com/nim-lang/Nim/issues/9896))
- Fixed "internal error: environment misses"
  ([#9476](https://github.com/nim-lang/Nim/issues/9476))
- Fixed "SIGSEGV: `setLen` on a seq doesn't construct objects at CT"
  ([#9872](https://github.com/nim-lang/Nim/issues/9872))
- Fixed "Latest HEAD segfaults when compiling Aporia"
  ([#9889](https://github.com/nim-lang/Nim/issues/9889))
- Fixed "Unnecessary semicolon in error message"
  ([#9907](https://github.com/nim-lang/Nim/issues/9907))
- Fixed "`koch temp c t.nim` tries to look up `t.nim` in nim install directory (alongside koch)"
  ([#9913](https://github.com/nim-lang/Nim/issues/9913))
- Fixed "Regression: sizeof Error: cannot instantiate: 'T'"
  ([#9868](https://github.com/nim-lang/Nim/issues/9868))
- Fixed "Showstopper regression: Nimscript no longer works "
  ([#9965](https://github.com/nim-lang/Nim/issues/9965))
- Fixed "Global imports in cfg file broken"
  ([#9978](https://github.com/nim-lang/Nim/issues/9978))
- Fixed "Global imports in cfg file broken"
  ([#9978](https://github.com/nim-lang/Nim/issues/9978))
- Fixed "Regression - Nim compiler shows all gcc commands used when config.nims present"
  ([#9982](https://github.com/nim-lang/Nim/issues/9982))
- Fixed "[regression] Nimscript makes a program slower and more bloated"
  ([#9995](https://github.com/nim-lang/Nim/issues/9995))
- Fixed "Regression in Nimscript projectDir() behavior, returns empty string"
  ([#9985](https://github.com/nim-lang/Nim/issues/9985))
- Fixed "Global imports don't work for non-std modules"
  ([#9994](https://github.com/nim-lang/Nim/issues/9994))
- Fixed "Object constructor regression in JS backend"
  ([#10005](https://github.com/nim-lang/Nim/issues/10005))
- Fixed "Regression: `nimble install` fails on nim devel"
  ([#9991](https://github.com/nim-lang/Nim/issues/9991))
- Fixed "Another config.nims regression"
  ([#9989](https://github.com/nim-lang/Nim/issues/9989))
- Fixed "`nim js -d:nodejs main.nim` gives: `system.nim(1443, 7) Error: cannot 'importc' variable at compile time` with a config.nims"
  ([#9153](https://github.com/nim-lang/Nim/issues/9153))
- Fixed "how to profile? using `--profiler:on` causes: Error: undeclared identifier: 'framePtr'"
  ([#8991](https://github.com/nim-lang/Nim/issues/8991))
- Fixed "nim doc fail on lib/system/profiler.nim"
  ([#9420](https://github.com/nim-lang/Nim/issues/9420))
- Fixed "[regression] ./koch tests: Error: overloaded 'readFile' leads to ambiguous calls (with ~/.config/nim/config.nims)"
  ([#9120](https://github.com/nim-lang/Nim/issues/9120))
- Fixed "regression: normalizePath("foo/..") now incorrectly returns `""`, should be `"."` like before + in almost all other languages"
  ([#10017](https://github.com/nim-lang/Nim/issues/10017))
- Fixed "Incorrect 'not all cases are covered' when using enums with nonconsecutive items"
  ([#3060](https://github.com/nim-lang/Nim/issues/3060))
- Fixed "[ospaths] BUG: splitFile("/a.txt").dir = "" ; + other bugs with splitFile"
  ([#8255](https://github.com/nim-lang/Nim/issues/8255))
- Fixed "GC bug: seems very slow where it shouldn't; maybe it leaks?"
  ([#10040](https://github.com/nim-lang/Nim/issues/10040))
- Fixed "Closure bug with the JS backend"
  ([#7048](https://github.com/nim-lang/Nim/issues/7048))
- Fixed "Error: unhandled exception: sym is not accessible [FieldError]"
  ([#10058](https://github.com/nim-lang/Nim/issues/10058))
- Fixed "with `--errorMax:100` ; link step should not be attempted if previous step failed"
  ([#9933](https://github.com/nim-lang/Nim/issues/9933))
- Fixed "import os or ospaths compilation error in js"
  ([#10066](https://github.com/nim-lang/Nim/issues/10066))
- Fixed "Example for system.`$`[T: tuple | object] is misleading"
  ([#7898](https://github.com/nim-lang/Nim/issues/7898))
- Fixed "Combining object variants and inheritance leads to SIGSEGV during compilation"
  ([#10033](https://github.com/nim-lang/Nim/issues/10033))
- Fixed "Regression in distros.nim (foreignDep fails to compile)"
  ([#10024](https://github.com/nim-lang/Nim/issues/10024))
- Fixed "Testament megatest fails with Nim not found"
  ([#10049](https://github.com/nim-lang/Nim/issues/10049))
- Fixed "XDeclaredButNotUsed shows redundant info: declaration location shown twice"
  ([#10101](https://github.com/nim-lang/Nim/issues/10101))
- Fixed "Nim beginner's feedback: "echo type(1)" does not work"
  ([#5827](https://github.com/nim-lang/Nim/issues/5827))
- Fixed "`sizeof` still broken with regard to bitsize/packed bitfields"
  ([#10082](https://github.com/nim-lang/Nim/issues/10082))
- Fixed "Codegen init regression"
  ([#10148](https://github.com/nim-lang/Nim/issues/10148))
- Fixed "toInt doesn't raise an exception"
  ([#2764](https://github.com/nim-lang/Nim/issues/2764))
- Fixed "allow `import` inside `block`: makes N runnableExamples run N x faster, minimizes scope pollution"
  ([#9300](https://github.com/nim-lang/Nim/issues/9300))
- Fixed "Extra procs & docs for the unicode module"
  ([#2353](https://github.com/nim-lang/Nim/issues/2353))
- Fixed "regression: CI failing `Error: unhandled exception: cannot open: /Users/travis/.cache/nim/docgen_sample_d/runnableExamples/docgen_sample_examples.nim [IOError]`"
  ([#10188](https://github.com/nim-lang/Nim/issues/10188))
- Fixed "getAddrInfo index out of bounds error"
  ([#10198](https://github.com/nim-lang/Nim/issues/10198))
- Fixed "can't build a tuple with `static int` element"
  ([#10073](https://github.com/nim-lang/Nim/issues/10073))
- Fixed "nimpretty creates foo.nim.backup for foo.nims"
  ([#10211](https://github.com/nim-lang/Nim/issues/10211))
- Fixed "regression caused by WEXITSTATUS: `nim cpp compiler/nim.nim` fails on OSX"
  ([#10231](https://github.com/nim-lang/Nim/issues/10231))
- Fixed "travis and appveyor should move the bulk of its logic to running a nim file"
  ([#10041](https://github.com/nim-lang/Nim/issues/10041))
- Fixed "`Error: undeclared field: 'foo'` should show type (+ where type is defined) (hard to guess in generic code)"
  ([#8794](https://github.com/nim-lang/Nim/issues/8794))
- Fixed "Discrepancy in Documentation About 'f128 Type-Suffix"
  ([#10213](https://github.com/nim-lang/Nim/issues/10213))
- Fixed "Incorrect error message"
  ([#10251](https://github.com/nim-lang/Nim/issues/10251))
- Fixed "CI should call `./koch tools` ; right now `nimfind` isn't even being compiled"
  ([#10039](https://github.com/nim-lang/Nim/issues/10039))
- Fixed "Building koch from nim devel fails when config.nims importing `os` present"
  ([#10030](https://github.com/nim-lang/Nim/issues/10030))
- Fixed "unittest module uses `programResult` to report number of failures which can wrap"
  ([#10261](https://github.com/nim-lang/Nim/issues/10261))
- Fixed "Nimscript doesn't raise any exceptions"
  ([#10240](https://github.com/nim-lang/Nim/issues/10240))
- Fixed "{.push raises: [].} breaks when combined with certain symbols"
  ([#10216](https://github.com/nim-lang/Nim/issues/10216))
- Fixed "Support "#." for auto-enumerated lists in RST docs"
  ([#8158](https://github.com/nim-lang/Nim/issues/8158))
- Fixed "`OpenSSL error` breaking nimble and every package"
  ([#10281](https://github.com/nim-lang/Nim/issues/10281))
- Fixed "execShellCmd returns 0 instead of nonzero when child process exits with signal (eg SIGSEGV)"
  ([#10273](https://github.com/nim-lang/Nim/issues/10273))
- Fixed "`nim check` (and nim c --errorMax:0) SIGSEGV on first `index out of bounds` error"
  ([#10104](https://github.com/nim-lang/Nim/issues/10104))
- Fixed "Module `db_sqlite` doesn't finalize statements with db_sqlite.rows after breaking the iterator's loop"
  ([#7241](https://github.com/nim-lang/Nim/issues/7241))
- Fixed "Performance regression with --gc:markandsweep"
  ([#10271](https://github.com/nim-lang/Nim/issues/10271))
- Fixed "internal error when using typedesc `is` comparison in a macro"
  ([#10136](https://github.com/nim-lang/Nim/issues/10136))
- Fixed "cannot call template/macros with varargs[typed] to varargs[untyped]"
  ([#10075](https://github.com/nim-lang/Nim/issues/10075))
- Fixed "nim v0.13.0 breaks symbol lookup in quote block"
  ([#3744](https://github.com/nim-lang/Nim/issues/3744))
- Fixed "Some nimgrep issues"
  ([#989](https://github.com/nim-lang/Nim/issues/989))
- Fixed "Safecall problem?"
  ([#9218](https://github.com/nim-lang/Nim/issues/9218))
- Fixed "Nim script is not supporting reading from stdin."
  ([#3983](https://github.com/nim-lang/Nim/issues/3983))
- Fixed "Parameter constraints: undeclared identifier '{}' within a template scope"
  ([#7524](https://github.com/nim-lang/Nim/issues/7524))
- Fixed "repr does not work with 'var openarray' parameter in function"
  ([#7878](https://github.com/nim-lang/Nim/issues/7878))
- Fixed "CountTable raisen error instead of returning a count of 0"
  ([#10065](https://github.com/nim-lang/Nim/issues/10065))
- Fixed "`nim c -r main.nim foo1 "" foo3` doesn't handle empty params or params w quotes"
  ([#9842](https://github.com/nim-lang/Nim/issues/9842))
- Fixed "refs #10249 ; more debug info to diagnose failures"
  ([#10266](https://github.com/nim-lang/Nim/issues/10266))
- Fixed "ObjectAssignmentError for aliased types"
  ([#10203](https://github.com/nim-lang/Nim/issues/10203))
- Fixed "nim cpp treats Nan as 0.0 (during compile time)"
  ([#10305](https://github.com/nim-lang/Nim/issues/10305))
- Fixed "terminal.nim colored output is not GCSAFE."
  ([#8294](https://github.com/nim-lang/Nim/issues/8294))
- Fixed "Building koch from nim devel fails when config.nims importing `os` present"
  ([#10030](https://github.com/nim-lang/Nim/issues/10030))
- Fixed "every binary cmd line option should allow on/off switch"
  ([#9629](https://github.com/nim-lang/Nim/issues/9629))

- Fixed "Wrong bounds check using template [] to access array in a const object"
  ([#3899](https://github.com/nim-lang/Nim/issues/3899))
- Fixed "tdont_be_stupid.nim flaky test"
  ([#10386](https://github.com/nim-lang/Nim/issues/10386))
- Fixed "Separate nim install guide for users and packagers"
  ([#5182](https://github.com/nim-lang/Nim/issues/5182))
- Fixed "--embedsrc does not work on macos"
  ([#10263](https://github.com/nim-lang/Nim/issues/10263))
- Fixed "Devel regression on static semcheck"
  ([#10339](https://github.com/nim-lang/Nim/issues/10339))
- Fixed "vccexe.exe does not work without VS2015 x64 Native Tools command prompt."
  ([#10358](https://github.com/nim-lang/Nim/issues/10358))
- Fixed "ospaths still referenced despite its deprecation"
  ([#9671](https://github.com/nim-lang/Nim/issues/9671))
- Fixed "Regression in sequtils"
  ([#10433](https://github.com/nim-lang/Nim/issues/10433))
- Fixed "Path in error message has `..\..\..\..\..\`  prefix since 0.19.0"
  ([#9556](https://github.com/nim-lang/Nim/issues/9556))
- Fixed ""contributing" is listed as a module on theindex"
  ([#10287](https://github.com/nim-lang/Nim/issues/10287))
- Fixed "`const Foo=int` compiles; is that legal? what does it mean?"
  ([#8610](https://github.com/nim-lang/Nim/issues/8610))
- Fixed "parsecsv can't handle empty lines at the beginning of the file"
  ([#8365](https://github.com/nim-lang/Nim/issues/8365))
- Fixed "Generated c code is not compile with the vcc cl.exe before 2012 after v0.19"
  ([#10352](https://github.com/nim-lang/Nim/issues/10352))
- Fixed "[Regression] converter to string leads fail to compile  on 0.19"
  ([#9149](https://github.com/nim-lang/Nim/issues/9149))
- Fixed "regression: memory leak with default GC"
  ([#10488](https://github.com/nim-lang/Nim/issues/10488))
- Fixed "oids counter starts at zero; spec says it should be random"
  ([#2796](https://github.com/nim-lang/Nim/issues/2796))
- Fixed "re quantifier`{` under-documented"
  ([#9471](https://github.com/nim-lang/Nim/issues/9471))
- Fixed "Minor issues in docs regarding keywords"
  ([#9725](https://github.com/nim-lang/Nim/issues/9725))
- Fixed "Explained the proc \"pretty\" in detail, file: json.nim with comments and sample program"
  ([#10466](https://github.com/nim-lang/Nim/issues/10466))
- Fixed "net.recvFrom address is always "0.0.0.0" for ipv6"
  ([#7634](https://github.com/nim-lang/Nim/issues/7634))
- Fixed "import "path with space/bar.nim" gives error msg with wrong file name"
  ([#10042](https://github.com/nim-lang/Nim/issues/10042))
- Fixed "Deprecation warnings for enum values print twice"
  ([#8063](https://github.com/nim-lang/Nim/issues/8063))
- Fixed "Undefined behaviour in the usage of incrSeqV3"
  ([#10568](https://github.com/nim-lang/Nim/issues/10568))
- Fixed "SetMaxPoolSize not heeded"
  ([#10584](https://github.com/nim-lang/Nim/issues/10584))
- Fixed "CI broken: tests/macros/t8997.nim fails"
  ([#10591](https://github.com/nim-lang/Nim/issues/10591))
- Fixed "prevent common user config to interfere with testament"
  ([#10573](https://github.com/nim-lang/Nim/issues/10573))
- Fixed "`static: writeFile` doesn't work anymore since `system refactorings`"
  ([#10585](https://github.com/nim-lang/Nim/issues/10585))
- Fixed "export statement doesn't support directories"
  ([#6227](https://github.com/nim-lang/Nim/issues/6227))
- Fixed "https://nim-lang.github.io/Nim/io.html gives 404"
  ([#10586](https://github.com/nim-lang/Nim/issues/10586))
- Fixed "Choosenim fails with "ambiguous call" in rst.nim"
  ([#10602](https://github.com/nim-lang/Nim/issues/10602))
- Fixed "Enable experimental feature with command line argument has no effect."
  ([#10606](https://github.com/nim-lang/Nim/issues/10606))
- Fixed "Comparing function pointer with nil marks the proc as not gcsafe"
  ([#6955](https://github.com/nim-lang/Nim/issues/6955))
- Fixed "httpclient.timeout not exported"
  ([#10357](https://github.com/nim-lang/Nim/issues/10357))
- Fixed "`nim check SIGSEGV` (causing nimsuggest to fail too)"
  ([#10547](https://github.com/nim-lang/Nim/issues/10547))
- Fixed "`index out of bounds` errors should show `index` and `bound`"
  ([#9880](https://github.com/nim-lang/Nim/issues/9880))
- Fixed "Enable experimental feature with command line argument has no effect."
  ([#10606](https://github.com/nim-lang/Nim/issues/10606))
- Fixed "Comparing function pointer with nil marks the proc as not gcsafe"
  ([#6955](https://github.com/nim-lang/Nim/issues/6955))
- Fixed "httpclient.timeout not exported"
  ([#10357](https://github.com/nim-lang/Nim/issues/10357))
- Fixed "`nim check SIGSEGV` (causing nimsuggest to fail too)"
  ([#10547](https://github.com/nim-lang/Nim/issues/10547))
- Fixed "certain seq manipulations fail when compiled to JS"
  ([#10651](https://github.com/nim-lang/Nim/issues/10651))
- Fixed "system.insert does not work with strings in VM"
  ([#10561](https://github.com/nim-lang/Nim/issues/10561))
- Fixed "Doc suggestion: include a link to theindex.html on ..."
  ([#5515](https://github.com/nim-lang/Nim/issues/5515))
- Fixed "`koch boot` fails on windows with choosenim-installed nim: proxyexe.nim error"
  ([#10659](https://github.com/nim-lang/Nim/issues/10659))
- Fixed "getImpl on type symbol hides implementation"
  ([#10702](https://github.com/nim-lang/Nim/issues/10702))
- Fixed "Missing stdlib modules"
  ([#8164](https://github.com/nim-lang/Nim/issues/8164))
- Fixed "No "correct" way to declare inheritable ref object"
  ([#10195](https://github.com/nim-lang/Nim/issues/10195))
- Fixed "Line number missing in stdlib trace"
  ([#6832](https://github.com/nim-lang/Nim/issues/6832))
- Fixed "Better support for modifying XmlNodes"
  ([#3797](https://github.com/nim-lang/Nim/issues/3797))
- Fixed "No documentation of AsyncStreams"
  ([#6383](https://github.com/nim-lang/Nim/issues/6383))
- Fixed "`set[` in proc definition crashes compiler"
  ([#10678](https://github.com/nim-lang/Nim/issues/10678))
- Fixed "net.bindAddr fails binding to all interfaces if `address == ""` for ipv6"
  ([#7633](https://github.com/nim-lang/Nim/issues/7633))
- Fixed "Tuple unpacking of `for` vars fails inside generic proc"
  ([#10727](https://github.com/nim-lang/Nim/issues/10727))
- Fixed "initSet should be called initHashSet"
  ([#10730](https://github.com/nim-lang/Nim/issues/10730))
- Fixed "inheritable placement not symmetric between object and ref object"
  ([#3012](https://github.com/nim-lang/Nim/issues/3012))
- Fixed "Alloc functions have side effects, makes it hard to use side effect tracking with destructors"
  ([#9746](https://github.com/nim-lang/Nim/issues/9746))
- Fixed "hashes:hash returns different values on Windows/Linux"
  ([#10771](https://github.com/nim-lang/Nim/issues/10771))
- Fixed "switch("cpu", "i386") with --cc:vcc doesn't work when it is written on *.nims"
  ([#10387](https://github.com/nim-lang/Nim/issues/10387))
- Fixed "async call now treated as non-gc safed call?"
  ([#10795](https://github.com/nim-lang/Nim/issues/10795))
- Fixed "{.borrow.} hangs compiler on non-distinct type (should produce an error or warning)"
  ([#10791](https://github.com/nim-lang/Nim/issues/10791))
- Fixed "DCE regression: modules can't be eliminated"
  ([#10703](https://github.com/nim-lang/Nim/issues/10703))
- Fixed "Unsafeaddr rendered as addr in typed AST "
  ([#10807](https://github.com/nim-lang/Nim/issues/10807))
- Fixed "Rendering of return statements in typed AST"
  ([#10805](https://github.com/nim-lang/Nim/issues/10805))
- Fixed "Assigning shallow string to a field makes a copy"
  ([#10845](https://github.com/nim-lang/Nim/issues/10845))
- Fixed "func keyword for proc types doesn't imply noSideEffect"
  ([#10838](https://github.com/nim-lang/Nim/issues/10838))
- Fixed "SPAN.attachedType in toc should have no width"
  ([#10857](https://github.com/nim-lang/Nim/issues/10857))
- Fixed "[docgen] Generic type pragmas in wrong place"
  ([#10792](https://github.com/nim-lang/Nim/issues/10792))
- Fixed "os.joinPaths documentation is inaccurate; should reference uri.combine"
  ([#10836](https://github.com/nim-lang/Nim/issues/10836))
- Fixed ""invalid indentation" when assigning macro with code block to const"
  ([#10861](https://github.com/nim-lang/Nim/issues/10861))
- Fixed "Nim crashes with SIGABRT after getting into a replaceTypeVars infinite loop."
  ([#10884](https://github.com/nim-lang/Nim/issues/10884))
- Fixed "Booleans Work Wrong in Compile-time"
  ([#10886](https://github.com/nim-lang/Nim/issues/10886))
- Fixed "C / CPP backends differ in argument evaluation order"
  ([#8202](https://github.com/nim-lang/Nim/issues/8202))
- Fixed "Change in syntax breaks valid code"
  ([#10896](https://github.com/nim-lang/Nim/issues/10896))
- Fixed "`auto` return type in macros causes internal error"
  ([#10904](https://github.com/nim-lang/Nim/issues/10904))
- Fixed "Nim string definition conflicts with other C/C++ instances"
  ([#10907](https://github.com/nim-lang/Nim/issues/10907))
- Fixed "nim check crash with invalid code, lowest priority"
  ([#10930](https://github.com/nim-lang/Nim/issues/10930))
- Fixed "nim check crash due to typing error, lowest priority"
  ([#10934](https://github.com/nim-lang/Nim/issues/10934))
- Fixed "Stacktrace displayed two times"
  ([#10922](https://github.com/nim-lang/Nim/issues/10922))
- Fixed "Cpp codegen regression. Showstopper"
  ([#10948](https://github.com/nim-lang/Nim/issues/10948))
- Fixed "`lent T` can return garbage"
  ([#10942](https://github.com/nim-lang/Nim/issues/10942))
- Fixed "Regression. atomicInc doesn't compile with vcc and i386"
  ([#10953](https://github.com/nim-lang/Nim/issues/10953))
- Fixed "{.pure.} has no effect on objects"
  ([#10721](https://github.com/nim-lang/Nim/issues/10721))
- Fixed "nimpretty doesn't put space around operators like `a<b` => `a < b`"
  ([#10200](https://github.com/nim-lang/Nim/issues/10200))
- Fixed "nimpretty messes alignment, after import statement"
  ([#9811](https://github.com/nim-lang/Nim/issues/9811))
- Fixed "Destructor regression for tuples unpacking"
  ([#10940](https://github.com/nim-lang/Nim/issues/10940))
- Fixed "Link error when a module defines a global variable and has no stacktrace"
  ([#10943](https://github.com/nim-lang/Nim/issues/10943))
- Fixed "std/json fails to escape most non-printables, breaking generation and parsing"
  ([#10541](https://github.com/nim-lang/Nim/issues/10541))
- Fixed "rst/markdown parser can't handle extra parentheses after link"
  ([#10475](https://github.com/nim-lang/Nim/issues/10475))
- Fixed "Random: proc rand(x: HSlice) requires substraction"
  ([#7698](https://github.com/nim-lang/Nim/issues/7698))
- Fixed "Bug in setTerminate()"
  ([#10765](https://github.com/nim-lang/Nim/issues/10765))
- Fixed "ICE when using --newruntime with proc returning tuple"
  ([#11004](https://github.com/nim-lang/Nim/issues/11004))
- Fixed "terminal.nim does not compile using --newruntime"
  ([#11005](https://github.com/nim-lang/Nim/issues/11005))
- Fixed "Casting a seq to another seq generates invalid code with --newruntime"
  ([#11018](https://github.com/nim-lang/Nim/issues/11018))
- Fixed "strformat/fmt doesn't work for custom types [regression]"
  ([#11012](https://github.com/nim-lang/Nim/issues/11012))
- Fixed "Casting a seq to another seq generates invalid code with --newruntime"
  ([#11018](https://github.com/nim-lang/Nim/issues/11018))
- Fixed "newruntime - `t.destructor != nil`  [AssertionError] with `toTable()`"
  ([#11014](https://github.com/nim-lang/Nim/issues/11014))
- Fixed "templates (e.g. sequtils.toSeq) often shadow `result`"
  ([#10732](https://github.com/nim-lang/Nim/issues/10732))
- Fixed "newruntime: `Error: system module needs: NimStringDesc` when calling `$` inside method on an object variant"
  ([#11048](https://github.com/nim-lang/Nim/issues/11048))
- Fixed "newruntime: internal error when iterating over seq (which is a field of an object) inside methods"
  ([#11050](https://github.com/nim-lang/Nim/issues/11050))
- Fixed "Error: internal error: '=destroy' operator not found for type owned Node"
  ([#11053](https://github.com/nim-lang/Nim/issues/11053))
- Fixed "`new` output can be assigned to an unowned ref"
  ([#11073](https://github.com/nim-lang/Nim/issues/11073))
- Fixed "Illegal storage access when adding to a ref seq"
  ([#11065](https://github.com/nim-lang/Nim/issues/11065))
- Fixed "strformat float printing doesn't print ".0" portion [regression]"
  ([#11089](https://github.com/nim-lang/Nim/issues/11089))
- Fixed "nim doc2 ignores --docSeeSrcUrl parameter"
  ([#6071](https://github.com/nim-lang/Nim/issues/6071))
- Fixed "runnableExamples + forLoop = segfault"
  ([#11078](https://github.com/nim-lang/Nim/issues/11078))
- Fixed "destructible context without 'result' or 'return' should also be supported"
  ([#1192](https://github.com/nim-lang/Nim/issues/1192))
- Fixed "`new Obj` crashes at the end of the program on newruntime"
  ([#11082](https://github.com/nim-lang/Nim/issues/11082))
- Fixed "Documentation of the modules broken out of system.nim are missing "
  ([#10972](https://github.com/nim-lang/Nim/issues/10972))
- Fixed "DFA regression. Branches of AST trees are missed in control flow graph."
  ([#11095](https://github.com/nim-lang/Nim/issues/11095))
- Fixed "[Regression] nkIdentDefs can be left in vmgen"
  ([#11111](https://github.com/nim-lang/Nim/issues/11111))
- Fixed "JS target does not prevent calling compileTime procs"
  ([#11133](https://github.com/nim-lang/Nim/issues/11133))
- Fixed "`rand` can return invalid values of a `range` type"
  ([#11015](https://github.com/nim-lang/Nim/issues/11015))
- Fixed "compiler crash on discard void"
  ([#7470](https://github.com/nim-lang/Nim/issues/7470))
- Fixed "Unowned ref can trivially escape without causing any crashes"
  ([#11114](https://github.com/nim-lang/Nim/issues/11114))
- Fixed "Destructor lifting regression"
  ([#11149](https://github.com/nim-lang/Nim/issues/11149))
- Fixed "`const` alias to compile time function fails."
  ([#11045](https://github.com/nim-lang/Nim/issues/11045))
- Fixed "Using type instead of typedesc in template signature fails compilation"
  ([#11058](https://github.com/nim-lang/Nim/issues/11058))
- Fixed "Compiler error caused by quote do: else"
  ([#11175](https://github.com/nim-lang/Nim/issues/11175))
- Fixed "cast to non ptr UncheckedArray does not produce an error or warning"
  ([#9403](https://github.com/nim-lang/Nim/issues/9403))
- Fixed "`openArray` generates incorrect C code with "incomplete type""
  ([#9578](https://github.com/nim-lang/Nim/issues/9578))
- Fixed "os:standalone Error: system module needs: appendString"
  ([#10978](https://github.com/nim-lang/Nim/issues/10978))
- Fixed "gensym regression"
  ([#10192](https://github.com/nim-lang/Nim/issues/10192))
- Fixed "new: module names need to be unique per Nimble broken on Windows"
  ([#11196](https://github.com/nim-lang/Nim/issues/11196))
- Fixed "Compiler crash on cfsml bindings"
  ([#11200](https://github.com/nim-lang/Nim/issues/11200))
- Fixed "Newruntime: compileTime variables can cause compilation to fail due to destructor injections"
  ([#11204](https://github.com/nim-lang/Nim/issues/11204))
- Fixed "object self-assignment order-of-evaluation broken"
  ([#9844](https://github.com/nim-lang/Nim/issues/9844))
- Fixed "seq self-assignment order-of-evaluation broken"
  ([#9684](https://github.com/nim-lang/Nim/issues/9684))
- Fixed "Compiler crash with generic types and static generic parameters"
  ([#7569](https://github.com/nim-lang/Nim/issues/7569))
- Fixed "C macro identifiers (e.g. errno) are not properly avoided in code generation"
  ([#11153](https://github.com/nim-lang/Nim/issues/11153))
- Fixed "SIGSEGV in asgnRefNoCycle with const sequence"
  ([#9825](https://github.com/nim-lang/Nim/issues/9825))
- Fixed "asyncdispatch could not be linked to nimrtl"
  ([#6855](https://github.com/nim-lang/Nim/issues/6855))
- Fixed "Newruntime: Bad C++ codegen for ref types with destructors"
  ([#11215](https://github.com/nim-lang/Nim/issues/11215))
- Fixed "Better error message for object variant with enum that is below it"
  ([#4140](https://github.com/nim-lang/Nim/issues/4140))
- Fixed "Can't declare a mixin."
  ([#11237](https://github.com/nim-lang/Nim/issues/11237))
- Fixed "Nim doc mangles signed octal literals"
  ([#11131](https://github.com/nim-lang/Nim/issues/11131))
- Fixed "Selectors, Error: undeclared field: 'OSErrorCode' on macOS"
  ([#11124](https://github.com/nim-lang/Nim/issues/11124))
- Fixed "`--cppCompileToNamespace:foo` fails compilation with `import os`"
  ([#11194](https://github.com/nim-lang/Nim/issues/11194))
- Fixed "[OpenMP] Nim symbol interpolation support"
  ([#9365](https://github.com/nim-lang/Nim/issues/9365))
- Fixed "Inconsistent typing error with gensymed var"
  ([#7937](https://github.com/nim-lang/Nim/issues/7937))
- Fixed "New module names break file-specific flags"
  ([#11202](https://github.com/nim-lang/Nim/issues/11202))
- Fixed "inheritance for generics does not work"
  ([#88](https://github.com/nim-lang/Nim/issues/88))
- Fixed "Possible bug related to generics type resolution/matched"
  ([#6732](https://github.com/nim-lang/Nim/issues/6732))
- Fixed "static range type bounds not checked when conversion from intLit"
  ([#3766](https://github.com/nim-lang/Nim/issues/3766))
- Fixed "threadpool: sync() deadlocks in high-CPU-usage scenarios"
  ([#11250](https://github.com/nim-lang/Nim/issues/11250))
- Fixed "var result array - bad codegen (null pointer dereference)"
  ([#8053](https://github.com/nim-lang/Nim/issues/8053))
- Fixed "future/sugar `=>` syntax breaks with generics"
  ([#7816](https://github.com/nim-lang/Nim/issues/7816))
- Fixed "os.joinPath removes the leading backslash from UNC paths (regression)"
  ([#10952](https://github.com/nim-lang/Nim/issues/10952))
- Fixed "re: memory leak when calling re proc repeatedly"
  ([#11139](https://github.com/nim-lang/Nim/issues/11139))
- Fixed "threadpool: tests/parallel/tconvexhull.nim segfaults intermittently on systems with more than 4 cores"
  ([#11275](https://github.com/nim-lang/Nim/issues/11275))
- Fixed "Not equal when streams.readBool and peekBool compare `true`"
  ([#11049](https://github.com/nim-lang/Nim/issues/11049))
- Fixed "`os.tailDir` fails on some paths"
  ([#8395](https://github.com/nim-lang/Nim/issues/8395))
- Fixed "Power op ^ is not optimized for a: int; echo a ^ 2 case (minor bug)"
  ([#10910](https://github.com/nim-lang/Nim/issues/10910))
- Fixed "`str &= data` doesn't behave as `str = str & data`."
  ([#10963](https://github.com/nim-lang/Nim/issues/10963))
- Fixed "Unable to make a const instance of an inherited, generic object."
  ([#11268](https://github.com/nim-lang/Nim/issues/11268))
- Fixed "Overload precedence for non-builtin types"
  ([#11239](https://github.com/nim-lang/Nim/issues/11239))
- Fixed "Error when trying to iterate a distinct type based array"
  ([#7167](https://github.com/nim-lang/Nim/issues/7167))
- Fixed "Objects marked with {.exportc.} should be fully defined in generated header"
  ([#4723](https://github.com/nim-lang/Nim/issues/4723))
- Fixed "Generic function specialization regression"
  ([#6076](https://github.com/nim-lang/Nim/issues/6076))
- Fixed "compiler should give ambiguity errors in case of multiple compatible matches"
  ([#8568](https://github.com/nim-lang/Nim/issues/8568))
- Fixed "`xmltree.findAll` doesn't work as expected with `htmlparser` for non-lowercase names"
  ([#8329](https://github.com/nim-lang/Nim/issues/8329))
- Fixed "wrong stack trace information about the raised exception"
  ([#11309](https://github.com/nim-lang/Nim/issues/11309))
- Fixed "Newruntime: owned procs don't implicitly convert to unowned in `==`"
  ([#11257](https://github.com/nim-lang/Nim/issues/11257))
- Fixed "order of imports can cause errors"
  ([#11187](https://github.com/nim-lang/Nim/issues/11187))
- Fixed "Passing code via stdin to Nim stopped working [regression Nim 0.19+]"
  ([#11294](https://github.com/nim-lang/Nim/issues/11294))
- Fixed ""--out:" switch is ineffective with "nim doc" [regression]"
  ([#11312](https://github.com/nim-lang/Nim/issues/11312))
- Fixed "VC++ broken in devel: module machine type 'X86' conflicts with target machine type 'x64'"
  ([#11306](https://github.com/nim-lang/Nim/issues/11306))
- Fixed "Code that used `multi` aspect of multimethod now crashes at runtime"
  ([#10912](https://github.com/nim-lang/Nim/issues/10912))
- Fixed "symbol resolution issues when ambiguous call happens in generic proc"
  ([#11188](https://github.com/nim-lang/Nim/issues/11188))
- Fixed "compile pragma name collision"
  ([#10299](https://github.com/nim-lang/Nim/issues/10299))
- Fixed "Unexpected behaviour on method dispatch"
  ([#10038](https://github.com/nim-lang/Nim/issues/10038))
- Fixed "Nim object variant issue"
  ([#1286](https://github.com/nim-lang/Nim/issues/1286))
- Fixed "json.to macro cannot handle ambiguous types even in a full form (module.Type)"
  ([#11057](https://github.com/nim-lang/Nim/issues/11057))
- Fixed "Out of bounds access in CritBitTree"
  ([#11344](https://github.com/nim-lang/Nim/issues/11344))
- Fixed "Newruntime: assignment to discriminant field in case objects not supported"
  ([#11205](https://github.com/nim-lang/Nim/issues/11205))
- Fixed "Dynamic dispatch broken if base method returns generic var type"
  ([#6777](https://github.com/nim-lang/Nim/issues/6777))
- Fixed "newruntime and unused generics: compiler crash"
  ([#6755](https://github.com/nim-lang/Nim/issues/6755))
- Fixed "Type aliases do not work with Exceptions."
  ([#10889](https://github.com/nim-lang/Nim/issues/10889))
- Fixed "Compiler crash when accessing constant in nested template"
  ([#5235](https://github.com/nim-lang/Nim/issues/5235))
- Fixed "unicode.nim Error: type mismatch: got <seq[char]> but expected 'string'"
  ([#9762](https://github.com/nim-lang/Nim/issues/9762))
- Fixed "Internal error with auto return in closure iterator"
  ([#5859](https://github.com/nim-lang/Nim/issues/5859))
- Fixed "[Compiler Crash] - getAST + hasCustomPragma"
  ([#7615](https://github.com/nim-lang/Nim/issues/7615))
- Fixed "debug mode compiler crash when executing some compile time code"
  ([#8199](https://github.com/nim-lang/Nim/issues/8199))
- Fixed "Compiler does not set `.typ` inside macros when creating literal NimNodes"
  ([#7792](https://github.com/nim-lang/Nim/issues/7792))
- Fixed "Error: internal error: expr: var not init sevColor_994035"
  ([#8573](https://github.com/nim-lang/Nim/issues/8573))
- Fixed "`internal error: could not find env param for` when one iterator references another"
  ([#9827](https://github.com/nim-lang/Nim/issues/9827))
- Fixed "internal error when assigning a type to a constant of typedesc"
  ([#9961](https://github.com/nim-lang/Nim/issues/9961))
- Fixed "Overload resolution regression"
  ([#11375](https://github.com/nim-lang/Nim/issues/11375))
- Fixed "strutils: toBin(64) uses '/' for the 63rd bit if it's set"
  ([#11369](https://github.com/nim-lang/Nim/issues/11369))
- Fixed "base64.encode should not "prettify" the result by default"
  ([#11364](https://github.com/nim-lang/Nim/issues/11364))
- Fixed "Nim ships latest nimble rather than stable"
  ([#11402](https://github.com/nim-lang/Nim/issues/11402))
- Fixed "`debugger:native` no longer generates pdb file with `cc:vcc`"
  ([#11405](https://github.com/nim-lang/Nim/issues/11405))
