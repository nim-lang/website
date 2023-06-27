---
title: "Version 1.6.14 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.6.14, our seventh (and largest) patch release for
Nim 1.6.

Version 1.6.14 is a result of almost four months of hard work, and it contains
[179 commits](https://github.com/nim-lang/Nim/compare/v1.6.12...v1.6.14),
bringing lots of general improvements over 1.6.12.

This release contains more than the usual amount of commits for a patch release
because we want to give you the best Nim v1 experience, in case you won't be able to
immediately switch to Nim v2, which will be our next release.

We would recommend to all of our users to upgrade and use version 1.6.14.




# Installing Nim 1.6

## New users

Check out if the package manager of your OS already ships version 1.6.14 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6.14 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.6.14 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2023-06-27-version-1-6-71ba2e7f3c5815d956b1ae0341b0743242b8fec6).




# Donating to Nim

We would like to encourage you to donate to Nim.
The donated money will be used to further improve Nim by creating bounties
for the most important bugfixes and features.

You can donate via:

* [Open Collective](https://opencollective.com/nim)
* [Patreon](https://www.patreon.com/araq)
* [BountySource](https://salt.bountysource.com/teams/nim)
* [PayPal](https://www.paypal.com/donate/?hosted_button_id=KYXH3BLJBHZTA)
* Bitcoin: `1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ`

If you are a company, we also offer commercial support.




# Bugfixes

These reported issues were fixed:

- Fixed "Segfault compiling async-related code"
  ([#21306](https://github.com/nim-lang/Nim/issues/21306))
- Fixed "Ambiguous calls compiles when module name are equal"
  ([#21496](https://github.com/nim-lang/Nim/issues/21496))
- Fixed "Invalid and UB codegen for old-style case object transitions"
  ([#20972](https://github.com/nim-lang/Nim/issues/20972))
- Fixed "calling `system.card[T](x: set[T])` with `T` of `int8` or `uint8` uses mismatched C array sizes"
  ([#20997](https://github.com/nim-lang/Nim/issues/20997))
- Fixed "nimIdentNormalize("") returns "\0""
  ([#19067](https://github.com/nim-lang/Nim/issues/19067))
- Fixed "`create` does not work for UncheckedArray, as sizeof(UncheckedArray[T])==0"
  ([#19000](https://github.com/nim-lang/Nim/issues/19000))
- Fixed "`getCustomPragmaVal` Error: typedesc not allowed as tuple field."
  ([#19020](https://github.com/nim-lang/Nim/issues/19020))
- Fixed "Block expression doesn't work in some cases"
  ([#12274](https://github.com/nim-lang/Nim/issues/12274))
- Fixed "hasCustomPragma fails on nnkVarTy/nnkBracketExpr nodes"
  ([#11923](https://github.com/nim-lang/Nim/issues/11923))
- Fixed "pragma in unreferenced function affects subsequent code"
  ([#19603](https://github.com/nim-lang/Nim/issues/19603))
- Fixed "Raises pragma and generic error/exception types compiler crash"
  ([#14318](https://github.com/nim-lang/Nim/issues/14318))
- Fixed "`multiple definition of` in Nim generated static libraries"
  ([#19830](https://github.com/nim-lang/Nim/issues/19830))
- Fixed "Closure iterator finishing prematurely"
  ([#11042](https://github.com/nim-lang/Nim/issues/11042))
- Fixed "Crash dereferencing object via a view object"
  ([#15897](https://github.com/nim-lang/Nim/issues/15897))
- Fixed "Templates: Crash with gensym'ed proc & method call"
  ([#20002](https://github.com/nim-lang/Nim/issues/20002))
- Fixed "Bug with effect system and forward declarations"
  ([#6559](https://github.com/nim-lang/Nim/issues/6559))
- Fixed "compiler flag `--hintAsError[XDeclaredButNotUsed]:on` causes unavoidable error in `fatal.nim` that `goToBasedException` is never used"
  ([#20149](https://github.com/nim-lang/Nim/issues/20149))
- Fixed "`type A* = A` with `B = (A,)` causes compiler to run infinitely"
  ([#18983](https://github.com/nim-lang/Nim/issues/18983))
- Fixed "compiler flag --clib prefixes unnecessary path component to library name"
  ([#16937](https://github.com/nim-lang/Nim/issues/16937))
- Fixed "Improve error message when instantiating generics that lack a type"
  ([#19882](https://github.com/nim-lang/Nim/issues/19882))
- Fixed "Static linking with a .lib file not working"
  ([#15955](https://github.com/nim-lang/Nim/issues/15955))
- Fixed "Internal error on trying to iterate on an empty array/seq"
  ([#19224](https://github.com/nim-lang/Nim/issues/19224))
- Fixed "Custom pragma ignored on field of variant obj if in multiple branches"
  ([#11415](https://github.com/nim-lang/Nim/issues/11415))
- Fixed "regression(1.04): reset broken in VM; incorrect VM handling of var params"
  ([#12994](https://github.com/nim-lang/Nim/issues/12994))
- Fixed "Nimc crash on ambiguous proc cast"
  ([#18886](https://github.com/nim-lang/Nim/issues/18886))
- Fixed "Generics: type mismatch "SomeunsignedInt or Natural""
  ([#7446](https://github.com/nim-lang/Nim/issues/7446))
- Fixed "Crash when passing a template to a generic function expecting a procedure"
  ([#19700](https://github.com/nim-lang/Nim/issues/19700))
- Fixed " Error: illegal context for 'nimvm' magic if 'nimvm' is used with single branch 'when'"
  ([#12517](https://github.com/nim-lang/Nim/issues/12517))
- Fixed "Regression: compile error using `when/elif/else`  and `typedesc` in template"
  ([#19426](https://github.com/nim-lang/Nim/issues/19426))
- Fixed "Illegal capture of closure iterator, when should be legal"
  ([#20152](https://github.com/nim-lang/Nim/issues/20152))
- Fixed "Generic proc instantiation and tuple types"
  ([#4466](https://github.com/nim-lang/Nim/issues/4466))
- Fixed "Use of _ (as var placeholder) inside a template causes XDeclaredButNotUsed hints"
  ([#12094](https://github.com/nim-lang/Nim/issues/12094))
- Fixed "`sink` causes crash in VM"
  ([#19201](https://github.com/nim-lang/Nim/issues/19201))
- Fixed "Can't instantiate a static value of generic type"
  ([#6637](https://github.com/nim-lang/Nim/issues/6637))
- Fixed "Use of _ (as var placeholder) inside a template causes XDeclaredButNotUsed hints"
  ([#12094](https://github.com/nim-lang/Nim/issues/12094))
- Fixed "regression(0.18.0 => devel): `import times; echo low(Time)` gives OverflowDefect"
  ([#16264](https://github.com/nim-lang/Nim/issues/16264))
- Fixed "implicit compile time conversion int to ranged float causes compiler `fatal` error"
  ([#20148](https://github.com/nim-lang/Nim/issues/20148))
- Fixed "range of uint64 shows signed upper bound"
  ([#20272](https://github.com/nim-lang/Nim/issues/20272))
- Fixed "Returning procedures with different noSideEffect pragmas"
  ([#14216](https://github.com/nim-lang/Nim/issues/14216))
- Fixed "Invalid codegen when returning `var tuple` from a template"
  ([#19149](https://github.com/nim-lang/Nim/issues/19149))
- Fixed "regression (0.19=> 0.20 onwards): adding doc comment in importc proc makes it silently noop at CT"
  ([#17121](https://github.com/nim-lang/Nim/issues/17121))
- Fixed "Nim doesn't catch wrong var {.global.} initialization"
  ([#3505](https://github.com/nim-lang/Nim/issues/3505))
- Fixed "Error: internal error: yield in expr not lowered"
  ([#13583](https://github.com/nim-lang/Nim/issues/13583))
- Fixed "Invalid type in slice generated by parallel transform"
  ([#20958](https://github.com/nim-lang/Nim/issues/20958))
- Fixed "`SIGSEGV` when `cast` is Improperly Formatted"
  ([#21027](https://github.com/nim-lang/Nim/issues/21027))
- Fixed "Extremely confusing error message with invalid syntax `of: '+':`"
  ([#20922](https://github.com/nim-lang/Nim/issues/20922))
- Fixed "Nim crashes in fixAbstractType"
  ([#16758](https://github.com/nim-lang/Nim/issues/16758))
- Fixed "Dangerous implicit type conversion from auto + generics"
  ([#15836](https://github.com/nim-lang/Nim/issues/15836))
- Fixed "Error: internal error: getTypeDescAux(tyFromExpr) when using auto + arc, works with refc"
  ([#20588](https://github.com/nim-lang/Nim/issues/20588))
- Fixed "static arg for `[]` causes deref to fail in typeof within template"
  ([#11705](https://github.com/nim-lang/Nim/issues/11705))
- Fixed "`internal error: getTypeDescAux(tyEmpty)` with `for t, f in @[]` and templates"
  ([#21109](https://github.com/nim-lang/Nim/issues/21109))
- Fixed "SIGSEGV possibly caused by literal type"
  ([#16541](https://github.com/nim-lang/Nim/issues/16541))
- Fixed "{.compileTime.} tuple destructuring - crash on 0.20, bad codegen on 0.19"
  ([#11634](https://github.com/nim-lang/Nim/issues/11634))
- Fixed "`for ai in a` has quadratic complexity in VM when `a` is const"
  ([#16790](https://github.com/nim-lang/Nim/issues/16790))
- Fixed "`Error: internal error: cannot map the empty seq type to a C type` with `@[]`"
  ([#21360](https://github.com/nim-lang/Nim/issues/21360))
- Fixed "SIGSEGV from typed macros"
  ([#17864](https://github.com/nim-lang/Nim/issues/17864))
- Fixed "[vm] Set/string/seq inside loop not initialized properly"
  ([#10938](https://github.com/nim-lang/Nim/issues/10938))
- Fixed "return type inference broken for generic closures"
  ([#16654](https://github.com/nim-lang/Nim/issues/16654))
- Fixed "Invalid C code can be generated when using std/sugar arrow syntax without specifying types"
  ([#20704](https://github.com/nim-lang/Nim/issues/20704))
- Fixed "Incorrect number of types needed to call a proc with an argument being a sum of generics"
  ([#6231](https://github.com/nim-lang/Nim/issues/6231))
- Fixed "Compiler hangs when using generics"
  ([#8295](https://github.com/nim-lang/Nim/issues/8295))
- Fixed "[Codegen] function call is not emitted"
  ([#21272](https://github.com/nim-lang/Nim/issues/21272))
- Fixed "Crash in compiler when using system.any by accident."
  ([#14255](https://github.com/nim-lang/Nim/issues/14255))
- Fixed "std/json should parse blank object"
  ([#21638](https://github.com/nim-lang/Nim/issues/21638))
- Fixed "nim-1.4.0 regression: expandMacros compilation error"
  ([#15691](https://github.com/nim-lang/Nim/issues/15691))
- Fixed "Warning from unittest test macro about bare except clause in 1.6.12"
  ([#21731](https://github.com/nim-lang/Nim/issues/21731))
- Fixed "Adding item to an empty seq crashes sometimes"
  ([#21780](https://github.com/nim-lang/Nim/issues/21780))
- Fixed "Empty seq with indirection in arc"
  ([#11267](https://github.com/nim-lang/Nim/issues/11267))
- Fixed "Can't use empty sets as tuple field values (unless the set is a var/let value)"
  ([#6213](https://github.com/nim-lang/Nim/issues/6213))
- Fixed "Regression of type inference when using templates and a proc with the same name as one of them"
  ([#20807](https://github.com/nim-lang/Nim/issues/20807))
- Fixed "ICE returning `@[]` as `seq[int]`"
  ([#21377](https://github.com/nim-lang/Nim/issues/21377))
- Fixed "Confusing error message (methods can't have same names as fields if UFCS is used)"
  ([#3748](https://github.com/nim-lang/Nim/issues/3748))
- Fixed "attempting to call undeclared routine: 'case'"
  ([#20283](https://github.com/nim-lang/Nim/issues/20283))
- Fixed "`getImpl` on types return incorrect tree in `when` branches"
  ([#16639](https://github.com/nim-lang/Nim/issues/16639))
- Fixed "noReturn pragma doesn't work when we add a doc comment"
  ([#9839](https://github.com/nim-lang/Nim/issues/9839))
- Fixed "At a certain level nested generics cause causes the typechecker to get stuck"
  ([#20348](https://github.com/nim-lang/Nim/issues/20348))
- Fixed "Compiler quits SILENTLY when compiling code with generic types."
  ([#20416](https://github.com/nim-lang/Nim/issues/20416))
- Fixed "..< cannot be used in typedef"
  ([#20248](https://github.com/nim-lang/Nim/issues/20248))
- Fixed "line number missing from stacktrace "
  ([#14444](https://github.com/nim-lang/Nim/issues/14444))
- Fixed "SIGSEGV on AsyncHttpServer when compiling with -d:threadsafe and --threads:on running on a thread"
  ([#21734](https://github.com/nim-lang/Nim/issues/21734))
- Fixed "Private field is not resolved properly in templates"
  ([#3770](https://github.com/nim-lang/Nim/issues/3770))
- Fixed "Calling template through from generic function across module fails to build"
  ([#20900](https://github.com/nim-lang/Nim/issues/20900))
- Fixed "`--mm:orc` invalid `free` with `{.noSideEffect.}` in `template` that puts `seq[byte]` in `object`"
  ([#22058](https://github.com/nim-lang/Nim/issues/22058))
- Fixed "-d:lto doesn't work on OSX: invalid linker name in argument '-fuse-ld=lld'; + other issues with -d:lto"
  ([#15578](https://github.com/nim-lang/Nim/issues/15578))
- Fixed "[Views] Regression: cannot cast to `lent UncheckedArray`"
  ([#21674](https://github.com/nim-lang/Nim/issues/21674))
- Fixed "Varargs broken in 1.6.0 when len is 0 and preceding block arguments."
  ([#19015](https://github.com/nim-lang/Nim/issues/19015))
- Fixed "Destructor not called for all fields when raising"
  ([#21245](https://github.com/nim-lang/Nim/issues/21245))
- Fixed "[nimscript] local variable is a hidden global with strformat and conditional branch and string in-place append &="
  ([#21704](https://github.com/nim-lang/Nim/issues/21704))
- Fixed "Enum with int64.high() value crashes compiler"
  ([#21280](https://github.com/nim-lang/Nim/issues/21280))
- Fixed "parseFloat Inf bug"
  ([#21847](https://github.com/nim-lang/Nim/issues/21847))
- Fixed "Incorrect enum field access can cause internal error"
  ([#21863](https://github.com/nim-lang/Nim/issues/21863))
- Fixed "C compiler error when using length of var openArray argument as a default value for an argument"
  ([#10964](https://github.com/nim-lang/Nim/issues/10964))
- Fixed "[duplicate] Generic casting doesn't work in VM"
  ([#9423](https://github.com/nim-lang/Nim/issues/9423))



The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v1.6.12...v1.6.14).

