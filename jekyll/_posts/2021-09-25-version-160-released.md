---
title: "Version 1.6.0 released"
author: The Nim Team
---

Nim version 1.6 is now officially released!

A year in the making, 1.6 is the latest stable release and by far the largest yet.
We're proud of what we, the core team and dedicated volunteers, have accomplished with this milestone.
Here are some stats:
* 1667 PRs merged (1760 commits)
* 893 issues closed
* 15 new stdlib modules
* new features in >40 stdlib modules, including major improvements to 10 commonly used modules.
* documentation and minor improvements to 170 modules, including 312 new runnable examples
* 280 new nimble packages

Nim made its first entry in TIOBE index in 2017 at position 129,
last year it entered the top-100, and last 2 months it entered the top-50 (https://forum.nim-lang.org/t/8297).
We hope this release will reinforce this trend, building on Nim's core strenghs:
a practical, compiled systems programming language; offering C-like performance and portability;
Python-like syntax; LISP-like flexibility; strong C, C++, JS, python interop;
and best-in class metaprogramming.

This release includes improvements in the following areas:
* new language features (user defined literals, private imports, strict effects, `iterable[T]`, new style concepts, dot-like operators, block arguments with optional params)
* new compiler features (`nim --eval:cmd`, custom nimscript extensions, customizable compiler messages)
* major improvements to `--gc:arc`, `--gc:orc`
* correctness and performance of integer and float parsing and rendering in all backends
* significant improvements in error messages, showing useful context
* doc generation logic and documentation, in particular `runnableExamples` now works in more contexts and replaces `code-block`.
* made JS, VM and nimscript backend more consistent with C backend, allowing more modules to work with those backends, including the imports from `std/prelude`; the test suite now standardizes on testing stdlib modules on each major backend (C, JS, VM).
* support for Apple silicon/M1, 32-bit RISC-V, CROSSOS, improved support for NodeJS backend
* major improvements to the following modules: `system, math, random, json, jsonutils, os, typetraits, wrapnils, lists, hashes` including performance improvements
* deprecated a number of error prone or redundant mis-features


# Installing Nim 1.6
We recommend everyone to upgrade to 1.6:

## New users

Check out if the package manager of your OS already ships version 1.6 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6 is as easy as:

```bash
choosenim update self
choosenim update stable
```

If you don't have `choosenim`, you can follow the same
[install link](https://nim-lang.org/install.html) as above.

## Building from source
```bash
git clone https://github.com/nim-lang/Nim
cd Nim
sh build_all.sh
```
The last command can be re-run after pulling new commits.
Note that the `csources` repo used was changed to `csources_v1`, the new setup is designed to be forward and backward compatible.

## Building from a CI setup
We now have an API to be used in CI which abstracts the implementation details: `. ci/funs.sh && nimBuildCsourcesIfNeeded`; in fact all the existing CI pipelines have been refactored to use this, see
[#17815](https://github.com/nim-lang/Nim/pull/17815).


# Contributors to Nim 1.6

Many thanks to our recurring and new [contributors](https://github.com/nim-lang/Nim/graphs/contributors?from=2020-10-16&to=2021-09-25&type=c),
Nim is a community driven collaborative effort that welcomes all contributions, big or small.


# Backward compatibility and preview flags

Starting with this release, we've introduced preview flags of the form `-d:nimPreviewX`
(e.g. `-d:nimPreviewFloatRoundtrip`); they allow users to opt-in a new stdlib/compiler behavior
that will likely become default in the next or a future release.
These staging flags are aimed at minimizing backward compatibility issues.
We also introduced opt-out flags of the form `-d:nimLegacyX`,  e.g. `-d:nimLegacyCopyFile`,
for cases where the default was changed to the new behavior,
and an explicit opt-out is needed for some transition period.

# Major new features
With so many new features, pinpointing the most salient ones is a subjective exercise,
but here are a select few:


## Strict effects
The effect system was refined and there is a new `.effectsOf` annotation that does
  explicitly what was previously done implicitly. See the manual for details.
  To write code that is portable with older Nim versions, use this idiom:

```nim
when defined(nimHasEffectsOf):
  {.experimental: "strictEffects".}
else:
  {.pragma: effectsOf.}

proc mysort(s: seq; cmp: proc(a, b: T): int) {.effectsOf: cmp.}
```

To enable the new effect system, use --experimental:strictEffects. See [#18777](https://github.com/nim-lang/Nim/pull/18777) and RFC [#408](https://github.com/nim-lang/RFCs/issues/408).


## `iterable[T]`
Added `iterable[T]` type class to match called iterators, which enables writing:
```nim
template fn(a: iterable) # or template fn[T](a: iterable[T])
# instead of:
template fn(a: untyped)
```
This solves a number of long standing issues related to iterators. In particular,
iterable arguments can now be used with MCS, e.g. `iota(3).toSeq` now works.
See PR [#17196](https://github.com/nim-lang/Nim/pull/17196) for additional details.


## Private imports and private field access
- A new import syntax `import foo {.all.}` now allows to import all symbols (public or private)
  from `foo`. This can be useful for testing purposes or for more flexibility in project organization.
- Added a new module `std/importutils`, and an API `privateAccess`, which allows access to private fields
  for an object type in the current scope.
Example:
```nim
from system as system2 {.all.} import ThisIsSystem
import os {.all.}
assert weirdTarget
```

## `nim --eval:cmd`
Added `nim --eval:cmd` to evaluate a command directly:, e.g.: `nim --eval:"echo 1"`.
It defaults to `e` (nimscript) but can also work with other commands, e.g.:
```bash
find . | nim r --eval:'import strutils; for a in stdin.lines: echo a.toUpper'
```
You can now use nim as a calculator, e.g. `nim --eval:'echo 3.1 / (1.2+7)'`.
You can also use it to explore a module's APIs, including private symbols:
```bash
nim --eval:'import os {.all.}; echo weirdTarget'
```
See PR [#15687](https://github.com/nim-lang/Nim/pull/15687) for more details.


## Round-trip float to string
`system.addFloat` and `system.$` now can produce string representations of floating point numbers that are minimal in size and possess round-trip and correct rounding guarantees (via the [Dragonbox](https://raw.githubusercontent.com/jk-jeon/dragonbox/master/other_files/Dragonbox.pdf) algorithm).
This currently has to be enabled via `-d:nimPreviewFloatRoundtrip`.
It is expected that this behavior becomes the new default in upcoming versions, as with other `nimPreviewX` define flags.

Example:
```nim
from math import round
let a = round(9.779999999999999, 2)
assert a == 9.78
echo a # with `-d:nimPreviewFloatRoundtrip`: 9.78, like in python3 (instead of  9.779999999999999)
```

## New `std/jsbigints` module
Provides arbitrary precision integers for JS target. See PR [#16409](https://github.com/nim-lang/Nim/pull/16409).
Example:
```nim
import std/jsbigints
assert big"2" ** big"64" == big"18446744073709551616"
```

## New `std/sysrand` module
Cryptographically secure pseudorandom number generator, see PR [#16459](https://github.com/nim-lang/Nim/pull/16459).
Example:
```nim
import std/sysrand
assert urandom(1234) != urandom(1234) # unlikely to fail in practice
```


## New module: `std/tempfiles`
Allows creating temporary files and directories, see PR [#17361](https://github.com/nim-lang/Nim/pull/17361) and followups.
```nim
import std/tempfiles
let tmpPath = genTempPath("prefix", "suffix.log", "/tmp/")
# tmpPath looks like: /tmp/prefixpmW1P2KLsuffix.log

let dir = createTempDir("tmpprefix_", "_end")
# created dir looks like: getTempDir() / "tmpprefix_YEl9VuVj_end"

let (cfile, path) = createTempFile("tmpprefix_", "_end.tmp")
# path looks like: getTempDir() / "tmpprefix_FDCIRZA0_end.tmp"
cfile.write "foo"
cfile.setFilePos 0
assert readAll(cfile) == "foo"
close cfile
assert readFile(path) == "foo"
```


## User defined literals
- Custom numeric literals (e.g. `-128'bignum`) are now supported.
- The unary minus in `-1` is now part of the integer literal, it is now parsed as a single token.
  This implies that edge cases like `-128'i8` finally work correctly.
Example:
```nim
func `'big`*(num: cstring): JsBigInt {.importjs: "BigInt(#)".}
assert 0xffffffffffffffff'big == (1'big shl 64'big) - 1'big
```

## New-style concepts
Example:
```nim
type
  Comparable = concept # no T, an atom
    proc cmp(a, b: Self): int
```
See PR [#15251](https://github.com/nim-lang/Nim/pull/15251) for details.


## Dot-like operators
With `-d:nimPreviewDotLikeOps`, dot-like operators (operators starting with `.`, but not with `..`)
now have the same precedence as `.`, so that `a.?b.c` is now parsed as `(a.?b).c` instead of `a.?(b.c)`.
A warning is generated when a dot-like operator is used without `-d:nimPreviewDotLikeOps`.

An important use case is to enable dynamic fields without affecting the builtin `.` operator, e.g. for
`std/jsffi`, `std/json`, `pkg/nimpy`. Example:
```nim
import std/json
template `.?`(a: JsonNode, b: untyped{ident}): JsonNode =
  a[astToStr(b)]
let j = %*{"a1": {"a2": 10}}
assert j.?a1.?a2.getInt == 10
```


## Block arguments now support optional params
This solves a major pain point for routines accepting block params, see PR #18631 for details:
```nim
template fn(a = 1, b = 2, body) = discard
fn(1, 2): # already works
  bar
fn(a = 1): # now works
  bar
```
ditto with multiple block args via do:
```nim
template fn(a = 1, b = 2, body1, body2) = discard
fn(a = 1): # now works
  bar1
do:
  bar2
```


# Other new features

## New and deprecated modules
The following modules were added (they are discussed in the rest of the text):
- `std/enumutils`
- `std/genasts`
- `std/importutils`
- `std/jsbigints`
- `std/jsfetch`
- `std/jsformdata`
- `std/jsheaders`
- `std/packedsets`
- `std/setutils`
- `std/socketstreams`
- `std/strbasics`
- `std/sysrand`
- `std/tasks`
- `std/tempfiles`
- `std/vmutils`

- Deprecated `std/mersenne`.
- Removed deprecated `std/iup` module from stdlib, it has already moved to
  [nimble](https://github.com/nim-lang/iup).


## New module: `std/setutils`
- Added `setutils.toSet` that can take any iterable and convert it to a built-in `set`,
  if the iterable yields a built-in settable type.
- Added `setutils.fullSet` which returns a full built-in `set` for a valid type.
- Added `setutils.complement` which returns the complement of a built-in `set`.
- Added `setutils.[]=`.


## New module: `std/enumutils`
- Added `genEnumCaseStmt` macro that generates
  case statement to parse string to enum.
- Added `items` for enums with holes.
- Added `symbolName` to return the `enum` symbol name ignoring the human readable name.
- Added `symbolRank` to return the index in which an `enum` member is listed in an enum.


## `system`
- Added `system.prepareMutation` for better support of low
  level `moveMem`, `copyMem` operations for `gc:orc`'s copy-on-write string
  implementation.
- `system.addEscapedChar` now renders `\r` as `\r` instead of `\c`, to be compatible
  with most other languages.
- Added `cmpMem` to `system`.
- `doAssertRaises` now correctly handles foreign exceptions.
- `addInt` now supports unsigned integers

Compatibility notes:
- `system.delete` had a most surprising behavior when the index passed to it was out of
  bounds (it would delete the last entry then). Compile with `-d:nimStrictDelete` so
  that an index error is produced instead. But be aware that your code might depend on
  this quirky behavior so a review process is required on your part before you can
  use `-d:nimStrictDelete`. To make this review easier, use the `-d:nimAuditDelete`
  switch, it pretends that `system.delete` is deprecated so that it is easier to see
  where it was used in your code.

  `-d:nimStrictDelete` will become the default in upcoming versions.
- `cuchar` is now deprecated as it aliased `char` where arguably it should have aliased `uint8`.
  Please use `char` or `uint8` instead.
- `repr` now doesn't insert trailing newline; previous behavior was very inconsistent,
  see [#16034](https://github.com/nim-lang/Nim/pull/16034). Use `-d:nimLegacyReprWithNewline` for previous behavior. `repr` now also
  renders ASTs correctly for user defined literals, setters, `do`, etc.
- Deprecated `any`. See RFC [#281](https://github.com/nim-lang/RFCs/issues/281).
- The unary slice `..b` was deprecated, use `0..b` instead.


## `std/math`
- Added `almostEqual` for comparing two float values using a machine epsilon.
- Added `clamp` which allows using a `Slice` to clamp to a value.
- Added `ceilDiv` for round up integer division.
- Added `isNaN`.
- Added `copySign`.
- Added `euclDiv` and `euclMod`.
- Added `signbit`.
- Added `frexp` overload procs. Deprecated `c_frexp`, use `frexp` instead.

Compatibility notes:
- `math.round` now is rounded "away from zero" in JS backend which is consistent
  with other backends. See [#9125](https://github.com/nim-lang/Nim/pull/9125). Use `-d:nimLegacyJsRound` for previous behavior.


## Random number generators: `std/random`, `std/sysrand`, `std/oids`
- Added `randState` template that exposes the default random number generator.
  Useful for library authors.
- Added `initRand()` overload with no argument which uses the current time as a seed.
- `initRand(seed)` now allows `seed == 0`.
- Added `std/sysrand` module to get random numbers from a secure source
- Fixed overflow bugs.
- Fix `initRand` to avoid random number sequences overlapping, refs [#18744](https://github.com/nim-lang/Nim/pull/18744).
- `std/oids` now uses `std/random`.

Compatibility notes:
- Deprecated `std/mersenne`.
- `random.initRand(seed)` now produces non-skewed values for the 1st call to `rand()` after
  initialization with a small (< 30000) seed. Use `-d:nimLegacyRandomInitRand` to restore
  previous behavior for a transition time, see PR [#17467](https://github.com/nim-lang/Nim/pull/17467).
  provided by the operating system.


## `std/json`, `std/jsonutils`
- `std/jsonutils` now serializes/deserializes holey enums as regular enums (via `ord`) instead of as strings.
  Use `-d:nimLegacyJsonutilsHoleyEnum` for a transition period. `toJson` now serializes `JsonNode`
  as is via reference (without a deep copy) instead of treating `JsonNode` as a regular ref object,
  this can be customized via `jsonNodeMode`.
- `std/json` and `std/jsonutils` now serialize NaN, Inf, -Inf as strings, so that
  `%[NaN, -Inf]` is the string `["nan","-inf"]` instead of `[nan,-inf]` which was invalid JSON.
- `std/json` can now handle integer literals and floating point literals of
  arbitrary length and precision.
  Numbers that do not fit the underlying `BiggestInt` or `BiggestFloat` fields are
  kept as string literals and one can use external BigNum libraries to handle these.
  The `parseFloat` family of functions also has now optional `rawIntegers` and
  `rawFloats` parameters that can be used to enforce that all integer or float
  literals remain in the "raw" string form so that client code can easily treat
  small and large numbers uniformly.
- Added `BackwardsIndex` overload for `JsonNode`.
- `json.%`,`json.to`, `jsonutils.formJson`,`jsonutils.toJson` now work with `uint|uint64`
  instead of raising (as in 1.4) or giving wrong results (as in 1.2).
- `std/jsonutils` now handles `cstring` (including as Table key), and `set`.
- added `jsonutils.jsonTo` overload with `opt = Joptions()` param.
- `jsonutils.toJson` now supports customization via `ToJsonOptions`.
- `std/json`, `std/jsonutils` now support round-trip serialization when `-d:nimPreviewFloatRoundtrip` is used.


## `std/typetraits`, `std/compilesettings`
- `distinctBase` now is identity instead of error for non distinct types.
- `distinctBase` now allows controlling whether to be recursive or not.
- Added `enumLen` to return the number of elements in an enum.
- Added `HoleyEnum` for enums with holes, `OrdinalEnum` for enums without holes.
- Added `hasClosure`.
- Added `pointerBase` to return `T` for `ref T | ptr T`.
- Added `compilesettings.SingleValueSetting.libPath`.


## networking: `std/net`, `std/asyncnet`, `std/htmlgen`, `std/httpclient`, `std/asyncdispatch`, `std/asynchttpserver`, `std/httpcore`
- Fixed buffer overflow bugs in `std/net`.
- Exported `sslHandle` from `std/net` and `std/asyncnet`.
- Added `hasDataBuffered` to `std/asyncnet`.
- various functions in `std/httpclient` now accept `url` of type `Uri`. Moreover `request` function's
  `httpMethod` argument of type `string` was deprecated in favor of `HttpMethod` `enum` type; see [#15919](https://github.com/nim-lang/Nim/pull/15919).
- Added `asyncdispatch.activeDescriptors` that returns the number of currently
  active async event handles/file descriptors.
- Added `getPort` to `std/asynchttpserver` to resolve OS-assigned `Port(0)`;
  this is usually recommended instead of hardcoding ports which can lead to "Address already in use" errors.
- Fixed premature garbage collection in `std/asyncdispatch`, when a stacktrace override is in place.
- Added `httpcore.is1xx` and missing HTTP codes.
- Added `htmlgen.portal` for [making "SPA style" pages using HTML only](https://web.dev/hands-on-portals).

Compatibility notes:
- On Windows the SSL library now checks for valid certificates.
  It uses the `cacert.pem` file for this purpose which was extracted
  from `https://curl.se/ca/cacert.pem`. Besides
  the OpenSSL DLLs (e.g. libssl-1_1-x64.dll, libcrypto-1_1-x64.dll) you
  now also need to ship `cacert.pem` with your `.exe` file.


## `std/hashes`
- `hashes.hash` can now support `object` and `ref` (can be overloaded in user code),
  if `-d:nimEnableHashRef` is used.

- `hashes.hash(proc|ptr|ref|pointer)` now calls `hash(int)` and honors `-d:nimIntHash1`,
  `hashes.hash(closure)` has also been improved.


## OS: `std/os`, `std/io`, `std/socketstream`, `std/linenoise`, `std/tempfiles`
- `os.FileInfo` (returned by `getFileInfo`) now contains `blockSize`,
  determining preferred I/O block size for this file object.
- Added `os.getCacheDir()` to return platform specific cache directory.
- Improved `os.getTempDir()`, see PR [#16914](https://github.com/nim-lang/Nim/pull/16914).
- Added `os.isAdmin` to tell whether the caller's process is a member of the
  Administrators local group (on Windows) or a root (on POSIX).
- Added optional `options` argument to `copyFile`, `copyFileToDir`, and
  `copyFileWithPermissions`. By default, on non-Windows OSes, symlinks are
  followed (copy files symlinks point to); on Windows, `options` argument is
  ignored and symlinks are skipped.
- On non-Windows OSes, `copyDir` and `copyDirWithPermissions` copy symlinks as
  symlinks (instead of skipping them as it was before); on Windows symlinks are
  skipped.
- On non-Windows OSes, `moveFile` and `moveDir` move symlinks as symlinks
  (instead of skipping them sometimes as it was before).
- Added optional `followSymlinks` argument to `setFilePermissions`.
- Added a simpler to use `io.readChars` overload.
- Added `socketstream` module that wraps sockets in the stream interface
- Added experimental `linenoise.readLineStatus` to get line and status (e.g. ctrl-D or ctrl-C).


## Environment variable handling
- empty environment variable values are now supported across OS's and backends
- environment variable APIs now work in multithreaded scenarios, by delegating to direct OS calls
  instead of trying to keep track of the environment.
- `putEnv`, `delEnv` now work at CT.
- NodeJS backend now supports osenv: `getEnv`, `putEnv`, `envPairs`, `delEnv`, `existsEnv`.

Compatibility notes:
- `std/os`: `putEnv` now raises if the 1st argument contains a `=`


## POSIX
- On POSIX systems, the default signal handlers used for Nim programs (it's
  used for printing the stacktrace on fatal signals) will now re-raise the
  signal for the OS default handlers to handle.
  This lets the OS perform its default actions, which might include core
  dumping (on select signals) and notifying the parent process about the cause
  of termination.
- On POSIX systems, we now ignore `SIGPIPE` signals, use `-d:nimLegacySigpipeHandler`
  for previous behavior.
- Added `posix_utils.osReleaseFile` to get system identification from `os-release` file on Linux and the BSDs.
  https://www.freedesktop.org/software/systemd/man/os-release.html
- Remove undefined behavior for `posix.open`


## `std/prelude`
- `std/strformat` is now part of `include std/prelude`.
- Added `std/sequtils` import to `std/prelude`.
- `std/prelude` now works with the JS target.
- `std/prelude` can now be used via `include std/prelude`, but `include prelude` still works.


## String manipulation: `std/strformat`, `std/strbasics`
- added support for parenthesized expressions.
- added support for const string's instead of just string literals

- Added `std/strbasics` for high performance string operations.
  Added `strip`, `setSlice`, `add(a: var string, b: openArray[char])`.


## `std/wrapnils`
- `std/wrapnils` doesn't use `experimental:dotOperators` anymore, avoiding
  issues like bug [#13063](https://github.com/nim-lang/Nim/issues/13063) (which affected error messages)
  for modules importing `std/wrapnils`.
  Added `??.` macro which returns an `Option`.
  `std/wrapnils` can now be used to protect against `FieldDefect` errors in
  case objects, generates optimal code (no overhead compared to manual
  if-else branches), and preserves lvalue semantics which allows modifying
  an expression.


## Containers: `std/algorithm`, `std/lists`, `std/sequtils`, `std/options`, `std/packedsets`
- Removed the optional `longestMatch` parameter of the `critbits._WithPrefix` iterators (it never worked reliably)
- Added `algorithm.merge`.
- In `std/lists`: renamed `append` to `add` and retained `append` as an alias;
  added `prepend` and `prependMoved` analogously to `add` and `addMoved`;
  added `remove` for `SinglyLinkedList`s.
- Added new operations for singly- and doubly linked lists: `lists.toSinglyLinkedList`
  and `lists.toDoublyLinkedList` convert from `openArray`s; `lists.copy` implements
  shallow copying; `lists.add` concatenates two lists - an O(1) variation that consumes
  its argument, `addMoved`, is also supplied. 
  See PR [#16362](https://github.com/nim-lang/Nim/pull/16362), [#16536](https://github.com/nim-lang/Nim/pull/16536).

- new module: `std/packedsets`
  Generalizes `std/intsets`, see PR [#15564](https://github.com/nim-lang/Nim/pull/15564).

Compatibility notes:
- Deprecated `sequtils.delete` and added an overload taking a `Slice` that raises a defect
  if the slice is out of bounds, likewise with `strutils.delete`.
- Deprecated `proc reversed*[T](a: openArray[T], first: Natural, last: int): seq[T]` in `std/algorithm`.
- `std/options` changed `$some(3)` to `"some(3)"` instead of `"Some(3)"`
  and `$none(int)` to `"none(int)"` instead of `"None[int]"`.


## `std/times`
- Added `ZZZ` and `ZZZZ` patterns to `times.nim` `DateTime` parsing, to match time
  zone offsets without colons, e.g. `UTC+7 -> +0700`.
- Added `dateTime` and deprecated `initDateTime`.


## `std/macros` and AST
- New module `std/genasts` containing `genAst` that avoids the problems inherent with `quote do` and can
  be used as a replacement.
  use `-d:nimLegacyMacrosCollapseSymChoice` to get previous behavior.

- The required name of case statement macros for the experimental
  `caseStmtMacros` feature has changed from `match` to `` `case` ``.
- Tuple expressions are now parsed consistently as
  `nnkTupleConstr` node. Will affect macros expecting nodes to be of `nnkPar`.
- In `std/macros`, `treeRepr,lispRepr,astGenRepr` now represent SymChoice nodes in a collapsed way,

- Make custom op in `macros.quote` work for all statements.


## `std/sugar`
- Added `sugar.dumpToString` which improves on `sugar.dump`.
- Added an overload for the `collect` macro that inferes the container type based
  on the syntax of the last expression. Works with std seqs, tables and sets.

Compatibility notes:
- Removed support for named procs in `sugar.=>`.


## Parsing: `std/parsecfg`, `std/strscans`, `std/uri`
- Added `sections` iterator in `parsecfg`.
- `strscans.scanf` now supports parsing single characters.
- `strscans.scanTuple` added which uses `strscans.scanf` internally,
  returning a tuple which can be unpacked for easier usage of `scanf`.
- Added `decodeQuery` to `std/uri`.
- `parseopt.initOptParser` has been made available and `parseopt` has been
  added back to `std/prelude` for all backends. Previously `initOptParser` was
  unavailable if the `std/os` module did not have `paramCount` or `paramStr`,
  but the use of these in `initOptParser` were conditionally to the runtime
  arguments passed to it, so `initOptParser` has been changed to raise
  `ValueError` when the real command line is not available. `parseopt` was
  previously excluded from `std/prelude` for JS, as it could not be imported.

Compatibility notes:
- Changed the behavior of `uri.decodeQuery` when there are unencoded `=`
  characters in the decoded values. Prior versions would raise an error. This is
  no longer the case to comply with the HTML spec and other languages
  implementations. Old behavior can be obtained with
  `-d:nimLegacyParseQueryStrict`. `cgi.decodeData` which uses the same
  underlying code is also updated the same way.


## JS stdlib changes
- Added `std/jsbigints` module, arbitrary precision integers for JS target.
- Added `setCurrentException` for JS backend.
- `writeStackTrace` is available in JS backend now.
- Added `then`, `catch` to `std/asyncjs` for promise pipelining, for now hidden behind `-d:nimExperimentalAsyncjsThen`.
- Added `std/jsfetch` module [Fetch](https://developer.mozilla.org/docs/Web/API/Fetch_API) wrapper for JS target.
- Added `std/jsheaders` module [Headers](https://developer.mozilla.org/en-US/docs/Web/API/Headers) wrapper for JS target.
- Added `std/jsformdata` module [FormData](https://developer.mozilla.org/en-US/docs/Web/API/FormData) wrapper for JS target.
- Added `jscore.debugger` to [call any available debugging functionality, such as breakpoints.](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger).
- Added `jsconsole.dir`, `jsconsole.dirxml`, `jsconsole.timeStamp`.
- Added dollar `$` and `len` for `jsre.RegExp`.
- Added `jsconsole.jsAssert` for JS target.
- Added `**` to `std/jsffi`.
- Added `copyWithin` [for `seq` and `array` for JS targets](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin).
- In `std/dom`, `Interval` is now a `ref object`, same as `Timeout`. Definitions of `setTimeout`,
  `clearTimeout`, `setInterval`, `clearInterval` were updated.
- Added `dom.scrollIntoView` proc with options
- Added `dom.setInterval`, `dom.clearInterval` overloads.
- Merged `std/dom_extensions` module into `std/dom` module,
  it was a module with a single line, see RFC [#413](https://github.com/nim-lang/RFCs/issues/413).
- `$` now gives more correct results on JS backend.


## JS compiler changes
- The `cstring` doesn't support `[]=` operator in JS backend.
- Now array literals(JS backend) uses JS typed arrays when the corresponding JS typed array exists,
  for example `[byte(1), 2, 3]` generates `new Uint8Array([1, 2, 3])`.


## VM and nimscript backend
- VM now supports `addr(mystring[ind])` (index + index assignment)
- `nimscript` now handles `except Exception as e`.
- nil dereference is not allowed at compile time. `cast[ptr int](nil)[]` is rejected at compile time.
- `static[T]` now works better, refs [#17590](https://github.com/nim-lang/Nim/pull/17590), [#15853](https://github.com/nim-lang/Nim/pull/15853).
- `distinct T` conversions now works in VM.
- `items(cstring)` now works in VM
- fix `addr`, `len`, `high` in VM ([#16002](https://github.com/nim-lang/Nim/pull/16002), [#16610](https://github.com/nim-lang/Nim/pull/16610)).
- `std/cstrutils` now works in VM.


## OS-specific notes
- Support for Apple silicon/M1.
- Support for 32-bit RISC-V, refs [#16231](https://github.com/nim-lang/Nim/pull/16231).
- Support for CROSSOS, refs [#18889](https://github.com/nim-lang/Nim/pull/18889).
- The allocator for Nintendo Switch, which was nonfunctional because
  of breaking changes in libnx, was removed, in favour of the new `-d:nimAllocPagesViaMalloc` option.
- Allow reading parameters when compiling for Nintendo Switch.

- Cross compilation targeting Windows was improved
  This now works from OSX/Linux:
  `nim r -d:mingw main`
  `--nimcache` now correctly works in a cross-compilation setting.


## Performance / memory optimizations
- The comment field in PNode AST was moved to a side channel, reducing overall memory usage during compilation by a factor 1.25x
- `std/jsonutils` deserialization is now up to 20x faster
- `os.copyFile` is now 2.5x faster on OSX, by using `copyfile` from `copyfile.h`;
  use `-d:nimLegacyCopyFile` for OSX < 10.5.
- float to string is now 10x faster thanks to Dragonbox algorithm, with `-d:nimPreviewFloatRoundtrip`.
- `newSeqWith` is 3x faster
- CI now supports batching (making Windows CI 2.3X faster).
- sets now uses optimized `countSetBits`, see PR [#17334](https://github.com/nim-lang/Nim/pull/17334).

## Debugging
- You can now enable/disable VM tracing in user code via `vmutils.vmTrace`.
- `koch tools` now builds `bin/nim_dbg` which allows easy access to a debug version of Nim without recompiling.
- Added new module `compiler/debugutils` to help with debugging Nim compiler.
- Renamed `-d:nimCompilerStackraceHints` to `-d:nimCompilerStacktraceHints` and used it in more contexts;
  this flag which works in tandem with `--stackTraceMsgs` to show user code context in compiler stacktraces.


## Type system
- `typeof(voidStmt)` now works and returns `void`.
- `enum` values can now be overloaded. This needs to be enabled
  via `{.experimental: "overloadableEnums".}`. We hope that this feature allows for the
  development of more fluent (less ugly) APIs. See RFC [#373](https://github.com/nim-lang/RFCs/issues/373).
  for more details.

- A type conversion from one `enum` type to another now produces an `[EnumConv]` warning.
  You should use `ord` (or `cast`, but the compiler won't help, if you misuse it) instead.
  ```
  type A = enum a1, a2
  type B = enum b1, b2
  echo a1.B # produces a warning
  echo a1.ord.B # produces no warning
  ```

- A dangerous implicit conversion to `cstring` now triggers a `[CStringConv]` warning.
  This warning will become an error in future versions! Use an explicit conversion
  like `cstring(x)` in order to silence the warning.

- There is a new warning for *any* type conversion to `enum` that can be enabled via
  `.warning[AnyEnumConv]:on` or `--warning:AnyEnumConv:on`.

- Reusing a type name in a different scope now works, refs [#17710](https://github.com/nim-lang/Nim/pull/17710).
- Fixed implicit and explicit generics in procedures, refs [#18808](https://github.com/nim-lang/Nim/pull/18808).


## Lexical / syntactic
- Nim now supports a small subset of Unicode operators as operator symbols.
  The supported symbols are: "∙ ∘ × ★ ⊗ ⊘ ⊙ ⊛ ⊠ ⊡ ∩ ∧ ⊓ ± ⊕ ⊖ ⊞ ⊟ ∪ ∨ ⊔".
  To enable this feature, use `--experimental:unicodeOperators`. Note that due
  to parser limitations you **cannot** enable this feature via a
  pragma `{.experimental: "unicodeOperators".}` reliably, you need to enable
  it via the command line or in a configuration file.

- `var a{.foo.} = expr` now works inside templates (except when `foo` is overloaded).


## Compiler messages, error messages, hints, warnings
- Significant improvement to error messages involving effect mismatches, see PRs [#18384](https://github.com/nim-lang/Nim/pull/18384), [#18418](https://github.com/nim-lang/Nim/pull/18418).
- Added `--declaredLocs` to show symbol declaration location in error messages.
- Added `--spellSuggest` to show spelling suggestions on typos.
- Added `--processing:dots|filenames|off` which customizes `hintProcessing`;
  `--processing:filenames` shows which include/import modules are being compiled as an import stack.
- `FieldDefect` messages now shows discriminant value + lineinfo, in all backends (C, JS, VM)
- Added `--hintAsError` with similar semantics as `--warningAsError`.
- Added `--unitsep:on|off` to control whether to add ASCII unit separator `\31` before a newline
 for every generated message (potentially multiline), so tooling can tell when messages start and end.
- Added `--filenames:abs|canonical|legacyRelProj` which replaces `--listFullPaths:on|off`
- `--hint:all:on|off` is now supported to select or deselect all hints; it
  differs from `--hints:on|off` which acts as a (reversible) gate.
  Likewise with `--warning:all:on|off`.
- The style checking of the compiler now supports a `--styleCheck:usages` switch. This switch
  enforces that every symbol is written as it was declared, not enforcing
  the official Nim style guide. To be enabled, this has to be combined either
  with `--styleCheck:error` or `--styleCheck:hint`.
- Type mismatch errors now show more context, use `-d:nimLegacyTypeMismatch` for previous
  behavior.
- `typedesc[Foo]` now renders as such instead of `type Foo` in compiler messages.
- `runnableExamples` now show originating location in stacktraces on failure.
- `SuccessX` message now shows more useful information.
- new `DuplicateModuleImport` warning, and improved `UnusedImport` and `XDeclaredButNotUsed` accuracy.

Compatibility notes:
- `--hint:CC` now goes to stderr (like all other hints) instead of stdout.


## Building and running Nim programs, configuration system
- JSON build instructions are now generated in `$nimcache/outFileBasename.json`
  instead of `$nimcache/projectName.json`. This allows avoiding recompiling a given project
  compiled with different options if the output file differs.

- `--usenimcache` (implied by `nim r main`) now generates an output file that includes a hash of
  some of the compilation options, which allows caching generated binaries:
```bash
  nim r main # recompiles
  nim r -d:foo main # recompiles
  nim r main # uses cached binary
  nim r main arg1 arg2 # ditto (runtime arguments are irrelevant)
```

- `nim r` now supports cross compilation from unix to windows when specifying `-d:mingw` by using Wine,
  e.g.: `nim r --eval:'import os; echo "a" / "b"'` prints `a\b`

- `nim` can compile version 1.4.0 as follows: `nim c --lib:lib --stylecheck:off -d:nimVersion140 compiler/nim`.
  `-d:nimVersion140` is not needed for bootstrapping, only for building 1.4.0 from devel.

- `nim e` now accepts arbitrary file extensions for the nimscript file,
  although `.nims` is still the preferred extension in general.
- The configuration subsystem now allows for `-d:release` and `-d:danger` to work as expected.
  The downside is that these defines now have custom logic that doesn't apply for
  other defines.


## Multithreading
- TLS: OSX now uses native TLS (`--tlsEmulation:off`), TLS now works with importcpp non-POD types,
  such types must use `.cppNonPod` and `--tlsEmulation:off`should be used.
- Added `unsafeIsolate` and `extract` to `std/isolation`.
- Added `std/tasks`, a new module containing primitives for creating parallel programs.


## Memory management
- `--gc:arc` now bootstraps (PR [#17342](https://github.com/nim-lang/Nim/pull/17342)).
- Lots of improvements to `gc:arc`, `gc:orc`, refs PR [#15697](https://github.com/nim-lang/Nim/pull/15697), [#16849](https://github.com/nim-lang/Nim/pull/16849), [#17993](https://github.com/nim-lang/Nim/pull/17993).
- `--gc:orc` is now 10% faster than previously for common workloads. If
  you have trouble with its changed behavior, compile with `-d:nimOldOrc`.
- The `--gc:orc` algorithm was refined so that custom container types can participate in the
  cycle collection process. See the documentation of `=trace` for more details.
- On embedded devices `malloc` can now be used instead of `mmap` via `-d:nimAllocPagesViaMalloc`.
  This is only supported for `--gc:orc` or `--gc:arc`.

Compatibility notes:
- `--newruntime` and `--refchecks` are deprecated,
  use `--gc:arc`, --gc:orc`, or `--gc:none` as appropriate instead.


## Docgen
- docgen: RST files can now use single backticks instead of double backticks and correctly render
  in both `rst2html` (as before) as well as common tools rendering RST directly (e.g. GitHub), by
  adding: `default-role:: code` directive inside the RST file, which is now handled by `rst2html`.

- Source+Edit links now appear on top of every docgen'd page when
  `nim doc --git.url:url ...` is given.

- Latex doc generation is revised: output `.tex` files should be compiled
  by `xelatex` (not by `pdflatex` as before). Now default Latex settings
  provide support for Unicode and do better job for avoiding margin overflows.

- The RST parser now supports footnotes, citations, admonitions, short style references with symbols.
- The RST parser now supports Markdown table syntax.
  Known limitations:
  - cell alignment is not supported, i.e. alignment annotations in a delimiter
    row (`:---`, `:--:`, `---:`) are ignored,
  - every table row must start with `|`, e.g. `| cell 1 | cell 2 |`.

- Implemented `doc2tex` compiler command which converts documentation in
  `.nim` files to Latex.

- docgen now supports syntax highlighting for inline code.
- docgen now supports same line doc comments:
```nim
func fn*(a: int): int = 42  ## Doc comment
```
- docgen now renders deprecated and other pragmas.

- `runnableExamples` now works with templates and nested templates.
- `runnableExamples: "-r:off"` now works for examples that should compile but not run. 
- `runnableExamples` now renders code verbatim, and produces correct code in all cases.
- docgen now shows correct, canonical import paths in docs.
- docgen now shows all routines in sidebar, and the proc signature is now shown in sidebar.

## Effects and checks
- Significant improvement to error messages involving effect mismatches

- There is a new `cast` section `{.cast(uncheckedAssign).}: body` that disables some
  compiler checks regarding `case objects`. This allows serialization libraries
  to avoid ugly, non-portable solutions. See RFC [#407](https://github.com/nim-lang/RFCs/issues/407).
  for more details.

## Tools
- major improvements to `nimgrep`, see PR [#15612
](https://github.com/nim-lang/Nim/pull/15612).
- `fusion` is now un-bundled from Nim, `./koch fusion` will
  install it via Nimble at a fixed hash.

- `testament`: added `nimoutFull: bool` spec to compare full output of compiler
  instead of a subset; many bugfixes to testament.

- Added `atlas` a tool for automating workflows involing "cloning" a nimble package and dependencies recursively

## Misc/cleanups
- Deprecated `TaintedString` and `--taintmode`.
- Deprecated `--nilseqs` which is now a noop.
- Added `-d:nimStrictMode` in CI in several places to ensure code doesn't have certain hints/warnings
- Removed `.travis.yml`, `appveyor.yml.disabled`, `.github/workflows/ci.yml.disabled`.
- `[skip ci]` now works in azure and CI pipelines, see detail in PR [#17561](https://github.com/nim-lang/Nim/pull/17561)
