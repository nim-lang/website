---
title: "Version 0.17.2 released"
author: The Nim Team
---

The Nim team is happy to announce that the latest release of Nim,
version 0.17.2, is now available. Nim is a systems programming language that
focuses on performance, portability and expressiveness.

The major new feature in this release is the support for ``.nimble-link`` files.
This has been added in order to support the latest Nimble version with its "develop" feature. For more information, see [``nimble``](https://github.com/nim-lang/nimble#nimble-develop).

This is however primarily a bug fix release, with the most important bugfixes
including the long standing codegen bugs that triggered GC crashes.
Updating is recommended!

Be sure to check out the changelog [below](#changelog) for
a comprehensive list of changes.

This release also includes version 0.8.8 of the Nimble package manager,
be sure to check out its
[changelog](https://github.com/nim-lang/nimble/blob/master/changelog.markdown)
for a list of changes since its last release.

You can download the latest release of Nim from the [download](download.html)
page. If you're using [``choosenim``](https://github.com/dom96/choosenim)
then you can easily update to the latest version by running the following:

```
$ choosenim update stable
```

# Changelog

## Changes affecting backwards compatibility

- The changes made to the `do` notation parsing rules in v0.17.0 have been
reverted.

## Bugfixes

The list below has been generated based on the commits in Nim's git
repository. As such it lists only the issues which have been closed
via a commit, for a full list see
[this link on Github](https://github.com/nim-lang/Nim/issues?utf8=%E2%9C%93&q=is%3Aissue+closed%3A%222017-05-16+..+2017-09-10%22+).

- Fixed "Fixed syslocks for ios"
  ([#5804](https://github.com/nim-lang/Nim/issues/5804))
- Fixed "OpenBSD pthread issue"
  ([#5920](https://github.com/nim-lang/Nim/issues/5920))
- Fixed "JS backend doesn't copy 'object' when adding to 'seq'"
  ([#4139](https://github.com/nim-lang/Nim/issues/4139))
- Fixed "sequtils insert produces wrong result in a case of sequence of objects in JS"
  ([#5933](https://github.com/nim-lang/Nim/issues/5933))
- Fixed "Index out of bounds error while using sets with cstring in JS"
  ([#5969](https://github.com/nim-lang/Nim/issues/5969))
- Fixed "Compiler crash when a proc marked as gcsafe moves around non-gcsafe closures"
  ([#5959](https://github.com/nim-lang/Nim/issues/5959))
- Fixed "type with packed pragma is not properly packed"
  ([#5824](https://github.com/nim-lang/Nim/issues/5824))
- Fixed "httpclient Docs Wrong"
  ([#5863](https://github.com/nim-lang/Nim/issues/5863))
- Fixed "{.async.} doesn't work with do notation"
  ([#5995](https://github.com/nim-lang/Nim/issues/5995))
- Fixed "Sigmatch error in fitting anonymous tuples to generic types"
  ([#5890](https://github.com/nim-lang/Nim/issues/5890))
- Fixed "Nested array alias type leads to compile-time and run-time bugs"
  ([#5962](https://github.com/nim-lang/Nim/issues/5962))
- Fixed "Static - Default value for static arg - Cannot instantiate"
  ([#5864](https://github.com/nim-lang/Nim/issues/5864))
- Fixed "constant of generic type becomes all zero when assigning to a local value"
  ([#5756](https://github.com/nim-lang/Nim/issues/5756))
- Fixed "User defined arithemetic in generic types"
  ([#5106](https://github.com/nim-lang/Nim/issues/5106))
- Fixed "Overloading with static[] leads to strange error"
  ([#5017](https://github.com/nim-lang/Nim/issues/5017))
- Fixed "Compiler crash"
  ([#2730](https://github.com/nim-lang/Nim/issues/2730))
- Fixed "Compiler segfaults on non-recursive code"
  ([#4524](https://github.com/nim-lang/Nim/issues/4524))
- Fixed "static[T] generic type cause `invalid type`"
  ([#3784](https://github.com/nim-lang/Nim/issues/3784))
- Fixed "Using static generic params on procs often fails to compile"
  ([#1017](https://github.com/nim-lang/Nim/issues/1017))
- Fixed "Inferring nested `static[T]` "
  ([#3153](https://github.com/nim-lang/Nim/issues/3153))
- Fixed "another static_t problem"
  ([#3152](https://github.com/nim-lang/Nim/issues/3152))
- Fixed "Generic code can cause attempts to use constructors for unrelated types to fail"
  ([#1051](https://github.com/nim-lang/Nim/issues/1051))
- Fixed "Internal Error with with static generic parameters"
  ([#1082](https://github.com/nim-lang/Nim/issues/1082))
- Fixed "Internal error with enumerable concept and map proc"
  ([#5968](https://github.com/nim-lang/Nim/issues/5968))
- Fixed "Concept - strange behaviour"
  ([#4020](https://github.com/nim-lang/Nim/issues/4020))
- Fixed "Compiler crash while wrapping concepts"
  ([#5127](https://github.com/nim-lang/Nim/issues/5127))
- Fixed "Using generic concept parameter causes stack overflow"
  ([#4737](https://github.com/nim-lang/Nim/issues/4737))
- Fixed "About ambiguous ``concept``"
  ([#5888](https://github.com/nim-lang/Nim/issues/5888))
- Fixed "Concepts don't play well with distinct primitive types, e.g. distinct float or string"
  ([#5983](https://github.com/nim-lang/Nim/issues/5983))
- Fixed "Error with generic concepts"
  ([#5084](https://github.com/nim-lang/Nim/issues/5084))
- Fixed "the `^` operator fails on floats"
  ([#5966](https://github.com/nim-lang/Nim/issues/5966))
- Fixed "Documentation: times.nim"
  ([#6010](https://github.com/nim-lang/Nim/issues/6010))
- Fixed "[Regression] Nim js crashes"
  ([#5946](https://github.com/nim-lang/Nim/issues/5946))
- Fixed "Times module compiled in JS failed to compare values"
  ([#6021](https://github.com/nim-lang/Nim/issues/6021))
- Fixed "JS: tables assignment breaks with importcpp's in scope (internal error: genAddr: nkDerefExpr)"
  ([#5846](https://github.com/nim-lang/Nim/issues/5846))
- Fixed "Object constructor violates copy semantics, allows modifying immutable [js only]"
  ([#4703](https://github.com/nim-lang/Nim/issues/4703))
- Fixed "No bounds checking in JS target?"
  ([#5563](https://github.com/nim-lang/Nim/issues/5563))
- Fixed "js: genDeref compiler crash"
  ([#5974](https://github.com/nim-lang/Nim/issues/5974))
- Fixed "JS: internal error in genDeref"
  ([#5379](https://github.com/nim-lang/Nim/issues/5379))
- Fixed "JS: compiler internal error"
  ([#5517](https://github.com/nim-lang/Nim/issues/5517))
- Fixed "JS codegen produces circular structure"
  ([#6035](https://github.com/nim-lang/Nim/issues/6035))
- Fixed ""nim doc" SIGSEGV when foo*(a: proc)"
  ([#6030](https://github.com/nim-lang/Nim/issues/6030))
- Fixed "Value redefinition not detected in {.pure.} enum"
  ([#6008](https://github.com/nim-lang/Nim/issues/6008))
- Fixed "unexpected option : '-o'"
  ([#6069](https://github.com/nim-lang/Nim/issues/6069))
- Fixed "Nimsuggest crashes in sempass2.useVar"
  ([#6067](https://github.com/nim-lang/Nim/issues/6067))
- Fixed "Nim compiler generates variables for discarded proc return values"
  ([#6037](https://github.com/nim-lang/Nim/issues/6037))
- Fixed "js target bug with operator +="
  ([#5608](https://github.com/nim-lang/Nim/issues/5608))
- Fixed "Nim Tutorial (Part I) need update"
  ([#6062](https://github.com/nim-lang/Nim/issues/6062))
- Fixed "Error after codegen when shadowing template arg"
  ([#4898](https://github.com/nim-lang/Nim/issues/4898))
- Fixed "Threadpool doesn't work after sync"
  ([#6090](https://github.com/nim-lang/Nim/issues/6090))
- Fixed "parsecfg silently fails to store and retrieve negative integers"
  ([#6046](https://github.com/nim-lang/Nim/issues/6046))
- Fixed "async + threads:on + globals = error"
  ([#5738](https://github.com/nim-lang/Nim/issues/5738))
- Fixed "Strange behaviour when importing `locks` for use in a generic type"
  ([#6049](https://github.com/nim-lang/Nim/issues/6049))
- Fixed "js backend failed to compile try...except new syntax"
  ([#5986](https://github.com/nim-lang/Nim/issues/5986))
- Fixed "Different handling of .emit with and without native debugger"
  ([#5989](https://github.com/nim-lang/Nim/issues/5989))
- Fixed "Structure packing and alignment issue on Windows."
  ([#4763](https://github.com/nim-lang/Nim/issues/4763))
- Fixed "ICE on discard seq.len"
  ([#6118](https://github.com/nim-lang/Nim/issues/6118))
- Fixed "ICE: genRecordField 3"
  ([#5892](https://github.com/nim-lang/Nim/issues/5892))
- Fixed "JS exportc regression?"
  ([#6096](https://github.com/nim-lang/Nim/issues/6096))
- Fixed "ReraiseError when using try/except within finally block"
  ([#5871](https://github.com/nim-lang/Nim/issues/5871))

- Fixed "Inconsistent os:standalone behavior"
  ([#6131](https://github.com/nim-lang/Nim/issues/6131))
- Fixed ".cfg files (, parsecfg) and quoting"
  ([#499](https://github.com/nim-lang/Nim/issues/499))
- Fixed "SIGSEGV: Illegal storage access. (Attempt to read from nil?)"
  ([#6127](https://github.com/nim-lang/Nim/issues/6127))
- Fixed "Nim Tutorial doc bugs"
  ([#6125](https://github.com/nim-lang/Nim/issues/6125))

- Fixed "union type compile error.."
  ([#6016](https://github.com/nim-lang/Nim/issues/6016))
- Fixed "Failure to compile stdlib/system with VCC, C++ and threads:on on i386"
  ([#6196](https://github.com/nim-lang/Nim/issues/6196))
- Fixed "GC bug resulting in random crashes"
  ([#6234](https://github.com/nim-lang/Nim/issues/6234))
- Fixed "deque.nim: Doc says removeLast proc, but not defined "
  ([#6110](https://github.com/nim-lang/Nim/issues/6110))
- Fixed "Nim crashes when instancing with incorrect arg sintax"
  ([#5965](https://github.com/nim-lang/Nim/issues/5965))
- Fixed "Equality of OrderedTable is incorrect"
  ([#6250](https://github.com/nim-lang/Nim/issues/6250))
- Fixed "0.17.0 Regression: Statement macro from tutorial does not compile anymore"
  ([#5918](https://github.com/nim-lang/Nim/issues/5918))

- Fixed "httpclient crash when performing get request"
  ([#6284](https://github.com/nim-lang/Nim/issues/6284))
- Fixed "GC bug"
  ([#6279](https://github.com/nim-lang/Nim/issues/6279))
- Fixed "Minor typo in system.nim"
  ([#6288](https://github.com/nim-lang/Nim/issues/6288))
- Fixed "Incorrect render of GenericParams"
  ([#6295](https://github.com/nim-lang/Nim/issues/6295))
- Fixed "Wrong [XDeclaredButNotUsed] hint"
  ([#3583](https://github.com/nim-lang/Nim/issues/3583))
- Fixed "Segfault when using reorder pragma"
  ([#6306](https://github.com/nim-lang/Nim/issues/6306))
- Fixed "execvpe not available on older linux versions"
  ([#1734](https://github.com/nim-lang/Nim/issues/1734))
- Fixed "tables.`[]=`[A](t: var CountTable[A]; key: A; val: int) should support val = 0"
  ([#4366](https://github.com/nim-lang/Nim/issues/4366))
- Fixed "nimble and koch executables in win32 distribution are x64, not x86"
  ([#6147](https://github.com/nim-lang/Nim/issues/6147))
- Fixed "nim-0.17.0_x32.zip contains some 64-bit binaries"
  ([#6028](https://github.com/nim-lang/Nim/issues/6028))
- Fixed "Inherited fields are not set in some cases, using object literals"
  ([#6294](https://github.com/nim-lang/Nim/issues/6294))
- Fixed "existsEnv declared twice in develop branch ospaths and nimscript"
  ([#6327](https://github.com/nim-lang/Nim/issues/6327))
