---
title: "Version 1.6.0 released"
author: The Nim Team
---

Nim version 1.6 is now officially released!

A year in the making, 1.6 is the latest stable release and by far the largest yet.
We're proud of what we --- the core team and dedicated volunteers --- have accomplished
with this milestone:
* 1667 PRs merged (1760 commits)
* 893 issues closed
* 15 new stdlib modules
* new features in more than 40 stdlib modules, including major improvements to 10 commonly used modules
* documentation and minor improvements to 170 modules, including 312 new runnable examples
* 280 new nimble packages

Nim made its first entry in TIOBE index in 2017 at position 129,
last year it entered the top-100, and for 2 months the top-50 ([link](https://forum.nim-lang.org/t/8297)).
We hope this release will reinforce this trend, building on Nim's core strengths:
a practical, compiled systems programming language offering C++-like perfomance
and portability, Python-like syntax, Lisp-like flexibility, strong C, C++, JS,
Python interop, and best-in-class metaprogramming.

This release includes improvements in the following areas:
* new language features (`iterable[T]`, user-defined literals, private imports, strict effects,
  dot-like operators, block arguments with optional parameters)
* new compiler features (`nim --eval:cmd`, custom nimscript extensions, customizable compiler messages)
* major improvements to `--gc:arc` and `--gc:orc`
* correctness and performance of integer and float parsing and rendering in all backends
* significant improvements in error messages, showing useful context
* documentation generation logic and documentation, in particular `runnableExamples` now works in more contexts
* JS, VM and nimscript backend are more consistent with the C backend, allowing more
  modules to work with those backends, including the imports from `std/prelude`;
  the test suite now standardizes on testing stdlib modules on each major backend (C, JS, VM)
* support for Apple silicon/M1, 32-bit RISC-V, armv8l, CROSSOS, improved support for NodeJS backend
* major improvements to the following modules: `system`, `math`, `random`, `json`, `jsonutils`, `os`,
  `typetraits`, `wrapnils`, `lists`, `hashes` including performance improvements
* deprecated a number of error prone or redundant features


## Why use Nim?

* One language to rule them all: from [shell scripting](https://nim-lang.org/docs/nims.html) to
  [web frontend and backend](https://github.com/nim-lang/nimforum),
  [scientific computing](https://github.com/SciNim),
  [deep learning](https://github.com/mratsim/Arraymancer),
  [blockchain client](https://github.com/status-im),
  [gamedev](https://github.com/ftsf/nico),
  [embedded](https://github.com/EmbeddedNim), see also some
  [companies using Nim](https://github.com/nim-lang/Nim/wiki/Organizations-using-Nim).
* Concise, readable and convenient: `echo "hello world"` is a 1-liner.
* Small binaries: `echo "hello world"` generates a 73K binary (or 5K with further options),
  optimized for embedded devices (Go: 2MB, Rust: 377K, C++: 56K) [1].
* Fast compile times: a full compiler rebuild takes ~12s (Rust: 15min, gcc: 30min+, clang: 1hr+, Go: 90s) [2].
* Native performance: see [Web Frameworks Benchmark](https://web-frameworks-benchmark.netlify.app/result),
  [ray tracing](https://nim-lang.org/blog/2020/06/30/ray-tracing-in-nim.html),
  [primes](https://github.com/PlummersSoftwareLLC/Primes).
* No need for makefiles, cmake, configure or other build scripts, thanks to compile-time
  function evaluation (CTFE) and dependency tracking [3].
* Target any platform with a C compiler:
  [Android and iOS](https://github.com/pragmagic/godot-nim#made-with-godot-nim),
  [embedded systems](https://github.com/elcritch/nesper),
  [micro-controllers](https://forum.nim-lang.org/t/7731),
  [WASM](https://forum.nim-lang.org/t/4779), Nintendo Switch,
  [Game Boy Advance](https://forum.nim-lang.org/t/8375).
* Zero-overhead interop lets you reuse code in C, C++ (including templates,
  [C++ STL](https://clonkk.github.io/nim-cppstl/cppstl.html)), JS, Objective-C,
  Python (via [nimpy](https://github.com/yglukhov/nimpy)).
* Built-in [documentation generator](https://nim-lang.github.io/Nim/system.html)
  that understands Nim code and runnable examples that stay in sync.

Last but not least, macros let you manipulate/generate code at compile time instead
of relying on code generators, enabling writing DSLs and language extensions in user code.
Typical examples include implementing Python-like
[f-strings](https://nim-lang.github.io/Nim/strformat.html),
[optional chaining](https://nim-lang.github.io/Nim/wrapnils.html),
[command line generators](https://github.com/c-blake/cligen),
React-like [Single Page Apps](https://github.com/karaxnim/karax),
[protobuf serialization and binding generators](https://github.com/PMunch/protobuf-nim).


# Installing Nim 1.6

We recommend everyone to upgrade to 1.6:

Note: earlier this year researchers spotted malware 
[written](https://thehackernews.com/2021/03/researchers-spotted-malware-written-in.html) 
nim programming language which 
supposedly led to antivirus vendors falsely tagging **all** software written in nim
as a potential threat, including nim compiler, package manager and so on (core nim 
tooling is written entirely in nim). This has been an ongoing issue ever since - 
if you have any issues related to this, please report nim compiler and associated 
tooling as false detection to the respective antivirus vendors.

## New users

Check out if your package manager already ships version 1.6 or
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
Note that the `csources` repo used was changed to `csources_v1`, the new setup
is designed to be forward and backward compatible.


## Building from a CI setup

We now have bash APIs to (re-)build Nim from source which hide implementation details,
for example: `. ci/funs.sh && nimBuildCsourcesIfNeeded`.
This can be useful for CI when alternatives (using nightly builds or a Docker image) are not suitable;
in fact all the existing CI pipelines have been refactored to use this, see
[#17815](https://github.com/nim-lang/Nim/pull/17815).


# Contributors to Nim 1.6

Many thanks to our recurring and new
[contributors](https://github.com/nim-lang/Nim/graphs/contributors?from=2020-10-16&to=2021-09-25&type=c).
Nim is a community driven collaborative effort that welcomes all contributions, big or small.


# Backward compatibility and preview flags

Starting with this release, we've introduced preview flags of the form `-d:nimPreviewX`
(e.g. `-d:nimPreviewFloatRoundtrip`), which allow users to opt-in to new stdlib/compiler behavior
that will likely become the default in the next or a future release.
These staging flags aim to minimize backward compatibility issues.

We also introduced opt-out flags of the form `-d:nimLegacyX`,  e.g. `-d:nimLegacyCopyFile`,
for cases where the default was changed to the new behavior.
For a transition period, these flags can be used to get the old behavior.

Here's the list of these flags introduced in this release, refer to the text below for explanations:
- `-d:nimLegacyCopyFile`
- `-d:nimLegacyJsRound`
- `-d:nimLegacyMacrosCollapseSymChoice`
- `-d:nimLegacyParseQueryStrict`
- `-d:nimLegacyRandomInitRand`
- `-d:nimLegacyReprWithNewline`
- `-d:nimLegacySigpipeHandler`
- `-d:nimLegacyTypeMismatch`
- `-d:nimPreviewDotLikeOps`
- `-d:nimPreviewFloatRoundtrip`
- `-d:nimPreviewHashRef`
- `-d:nimPreviewJsonutilsHoleyEnum`


# Major new features

With so many new features, pinpointing the most salient ones is a subjective exercise,
but here are a select few:


## `iterable[T]`

The `iterable[T]` type class was added to match called iterators,
which solves a number of long-standing issues related to iterators.
Example:

```nim
iterator iota(n: int): int =
  for i in 0..<n: yield i

# previously, you'd need `untyped`, which caused other problems such as lack
# of type inference, overloading issues, and MCS.
template sumOld(a: untyped): untyped = # no type inference possible
  var result: typeof(block:(for ai in a: ai))
  for ai in a: result += ai
  result

assert sumOld(iota(3)) == 0 + 1 + 2

# now, you can write:
template sum[T](a: iterable[T]): T =
  # `template sum(a: iterable): auto =` would also be possible
  var result: T
  for ai in a: result += ai
  result

assert sum(iota(3)) == 0 + 1 + 2 # or `iota(3).sum`
```

In particular iterable arguments can now be used with the method call syntax. For example:
```nim
import std/[sequtils, os]
echo walkFiles("*").toSeq # now works
```
See PR [#17196](https://github.com/nim-lang/Nim/pull/17196) for additional details.


## Strict effects

The effect system was refined and there is a new `.effectsOf` annotation that does
explicitly what was previously done implicitly. See the
[manual](https://nim-lang.github.io/Nim/manual.html#effect-system-effectsof-annotation)
for more details.
To write code that is portable with older Nim versions, use this idiom:

```nim
when defined(nimHasEffectsOf):
  {.experimental: "strictEffects".}
else:
  {.pragma: effectsOf.}

proc mysort(s: seq; cmp: proc(a, b: T): int) {.effectsOf: cmp.}
```

To enable the new effect system, compile with `--experimental:strictEffects`.
See also [#18777](https://github.com/nim-lang/Nim/pull/18777) and RFC
[#408](https://github.com/nim-lang/RFCs/issues/408).


## Private imports and private field access

A new import syntax `import foo {.all.}` now allows importing all symbols
(public or private) from `foo`.
This can be useful for testing purposes or for more flexibility in project organization.

Example:
```nim
from system {.all.} as system2 import nil
echo system2.ThisIsSystem # ThisIsSystem is private in `system`
import os {.all.} # weirdTarget is private in `os`
echo weirdTarget # or `os.weirdTarget`
```

Added a new module `std/importutils`, and an API `privateAccess`, which allows access
to private fields for an object type in the current scope.

Example:
```nim
import times
from std/importutils import privateAccess
block:
  let t = now()
  # echo t.monthdayZero # Error: undeclared field: 'monthdayZero' for type times.DateTime
  privateAccess(typeof(t)) # enables private access in this scope
  echo t.monthdayZero # ok
```

See PR [#17706](https://github.com/nim-lang/Nim/pull/17706) for additional details.


## `nim --eval:cmd`

Added `nim --eval:cmd` to evaluate a command directly, e.g.: `nim --eval:"echo 1"`.
It defaults to `e` (nimscript) but can also work with other commands, e.g.:
```bash
find . | nim r --eval:'import strutils; for a in stdin.lines: echo a.toUpper'
```

```bash
# use as a calculator:
nim --eval:'echo 3.1 / (1.2+7)'
# explore a module's APIs, including private symbols:
nim --eval:'import os {.all.}; echo weirdTarget'
# use a custom backend:
nim r -b:js --eval:"import std/jsbigints; echo 2'big ** 64'big"
```

See PR [#15687](https://github.com/nim-lang/Nim/pull/15687) for more details.


## Round-trip float to string

`system.addFloat` and `system.$` now can produce string representations of
floating point numbers that are minimal in size and possess round-trip and correct
rounding guarantees (via the
[Dragonbox](https://raw.githubusercontent.com/jk-jeon/dragonbox/master/other_files/Dragonbox.pdf) algorithm).
This currently has to be enabled via `-d:nimPreviewFloatRoundtrip`.
It is expected that this behavior becomes the new default in upcoming versions,
as with other `nimPreviewX` define flags.

Example:
```nim
from math import round
let a = round(9.779999999999999, 2)
assert a == 9.78
echo a # with `-d:nimPreviewFloatRoundtrip`: 9.78, like in python3 (instead of  9.779999999999999)
```


## New `std/jsbigints` module

Provides arbitrary precision integers for the JS target. See PR
[#16409](https://github.com/nim-lang/Nim/pull/16409).
Example:
```nim
import std/jsbigints
assert 2'big ** 65'big == 36893488147419103232'big
echo 0xdeadbeef'big shl 4'big # 59774856944n
```


## New `std/sysrand` module
Cryptographically secure pseudorandom number generator,
allows generating random numbers from a secure source provided by the operating system.
Example:
```nim
import std/sysrand
assert urandom(1234) != urandom(1234) # unlikely to fail in practice
```
See PR [#16459](https://github.com/nim-lang/Nim/pull/16459).


## New module: `std/tempfiles`

Allows creating temporary files and directories, see PR
[#17361](https://github.com/nim-lang/Nim/pull/17361) and followups.
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


## User-defined literals

Custom numeric literals (e.g. `-128'bignum`) are now supported.
Additionally, the unary minus in `-1` is now part of the integer literal, i.e.
it is now parsed as a single token.
This implies that edge cases like `-128'i8` finally work correctly.
Example:
```nim
func `'big`*(num: cstring): JsBigInt {.importjs: "BigInt(#)".}
assert 0xffffffffffffffff'big == (1'big shl 64'big) - 1'big
```


## Dot-like operators

With `-d:nimPreviewDotLikeOps`, dot-like operators (operators starting with `.`,
but not with `..`) now have the same precedence as `.`, so that `a.?b.c` is now
parsed as `(a.?b).c` instead of `a.?(b.c)`.
A warning is generated when a dot-like operator is used without `-d:nimPreviewDotLikeOps`.

An important use case is to enable dynamic fields without affecting the
built-in `.` operator, e.g. for `std/jsffi`, `std/json`, `pkg/nimpy`. Example:
```nim
import std/json
template `.?`(a: JsonNode, b: untyped{ident}): JsonNode =
  a[astToStr(b)]
let j = %*{"a1": {"a2": 10}}
assert j.?a1.?a2.getInt == 10
```


## Block arguments now support optional parameters

This solves a major pain point for routines accepting block parameters,
see PR [#18631](https://github.com/nim-lang/Nim/pull/18631) for details:

```nim
template fn(a = 1, b = 2, body) = discard
fn(1, 2): # already works
  bar
fn(a = 1): # now works
  bar
```

Likewise with multiple block arguments via `do`:
```nim
template fn(a = 1, b = 2, body1, body2) = discard
fn(a = 1): # now works
  bar1
do:
  bar2
```


## Other features

For full changelog, see [here](https://github.com/nim-lang/Nim/blob/version-1-6/changelogs/changelog_1_6_0.md).



# Footnotes

Tested on a 2.3 GHz 8-Core Intel Core i9, 2019 macOS 11.5 with 64GB RAM.
* [1] command used: `nim c -d:danger`.
  The binary size can be further reduced to 49K with stripping `--passL:-s`
  and link-time optimization (`--passC:-flto`).
  Statically linking against `musl` brings it down to 5K, see
  [link](https://irclogs.nim-lang.org/07-07-2020.html#12:31:34).
* [2] commands used:
  - for Nim: `nim c --forceBuild compiler/nim`
  - for Rust: `./x.py build`, [details](https://www.reddit.com/r/rust/comments/76jq7h/long_time_to_compile_rustc/)
  - for GCC: see [1](https://unix.stackexchange.com/questions/421822/how-long-does-it-take-to-compile-gcc-7-3-0)
    [2](https://solarianprogrammer.com/2016/10/07/building-gcc-ubuntu-linux/)
  - for Clang: [details](https://quuxplusone.github.io/blog/2018/04/16/building-llvm-from-source/)
  - for Go: `./make.bash`
* [3] a separate nimscript file can be used if needed to execute code at compile time
  before compiling the main program but it's in the same language
