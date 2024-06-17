---
title: "Nim version 2.0.6 released"
author: The Nim Team
---

The Nim team is happy to announce Nim version 2.0.6, our third, and the largest by far, patch release for Nim 2.0.

Version 2.0.6 contains (exactly!) [200 commits](https://github.com/nim-lang/Nim/compare/v2.0.4...v2.0.6) and brings bugfixes and improvements to Nim 2.0.4, released two months ago.

The reason for this many commits in this release is that this is planned as the last 2.0.x release before Nim 2.2 and we wanted to give you the best Nim 2.0 experience in case you won't be able to switch immediately to Nim 2.2.

**NOTE**: This release fixes the problem with `--threads:on`, and there's no need for the `-d:useMalloc` workaround anymore.

Check out if the package manager of your OS already ships version 2.0.6 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 2.0.6 is as easy as:

```bash
$ choosenim 2.0.6
```

If you are on OSX ARM, `choosenim` will not work for you.
Please choose an alternative method of installing or updating.

Alternatively, you can download Nim 2.0.6 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2024-03-28-version-2-0-b47747d31844c6bd9af4322efe55e24fefea544c).




# Donating to Nim

We would like to encourage you to donate to Nim.
The donated money will be used to further improve Nim by creating bounties
for the most important bugfixes and features.

You can donate via:

* [Open Collective](https://opencollective.com/nim)
* Bitcoin: `1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ`

If you are a company, we also offer commercial support.




# Bugfixes

These reported issues were fixed:

- Fixed "`rand(bool)` always returns `false`"
  ([#22360](https://github.com/nim-lang/Nim/issues/22360))
- Fixed "Compiler crashes with staticBoundsCheck on"
  ([#22362](https://github.com/nim-lang/Nim/issues/22362))
- Fixed "Unspecified generic on default value segfaults the compiler"
  ([#20883](https://github.com/nim-lang/Nim/issues/20883))
- Fixed "Passing Natural to bitops.BitsRange[T] parameter in generic proc is compile error"
  ([#18823](https://github.com/nim-lang/Nim/issues/18823))
- Fixed "Illegal capture when should be legal? (part 2)"
  ([#20891](https://github.com/nim-lang/Nim/issues/20891))
- Fixed "nim compiler assertion fail when literal integer is passed as template argument for array size"
  ([#12938](https://github.com/nim-lang/Nim/issues/12938))
- Fixed "Can't instantiate generic in some cases"
  ([#21760](https://github.com/nim-lang/Nim/issues/21760))
- Fixed "Borrowing std/times.format causes "Error: illformed AST""
  ([#19304](https://github.com/nim-lang/Nim/issues/19304))
- Fixed "nimsuggest: Incorrect error reported during overload resolution with procedures with static parameters"
  ([#22448](https://github.com/nim-lang/Nim/issues/22448))
- Fixed "Exceptions in top level statements of submodule not being reported/handled"
  ([#22469](https://github.com/nim-lang/Nim/issues/22469))
- Fixed "returning string inside a loop unnecessarily generates `=sink`"
  ([#21722](https://github.com/nim-lang/Nim/issues/21722))
- Fixed ""environment misses" for type reference in iterator access nested in closure"
  ([#22548](https://github.com/nim-lang/Nim/issues/22548))
- Fixed "Default value does not work with object's discriminator"
  ([#22613](https://github.com/nim-lang/Nim/issues/22613))
- Fixed "internal error: no generic body"
  ([#1500](https://github.com/nim-lang/Nim/issues/1500))
- Fixed "type binding fails for type alias with extra generic parameter"
  ([#21742](https://github.com/nim-lang/Nim/issues/21742))
- Fixed "Procs with constructor pragma doesn't initialize object's fields"
  ([#22662](https://github.com/nim-lang/Nim/issues/22662))
- Fixed "=copy hook for seq appears to be broken"
  ([#22664](https://github.com/nim-lang/Nim/issues/22664))
- Fixed "Size calculation thinks type is infinitely recursive with shared section and pragma"
  ([#22713](https://github.com/nim-lang/Nim/issues/22713))
- Fixed "Generated enum `case` code may trigger `-Wmaybe-uninitialized`"
  ([#22246](https://github.com/nim-lang/Nim/issues/22246))
- Fixed ""unknown hint" should not be an error - it should itself be a `hint` that can be enabled/disabled"
  ([#22706](https://github.com/nim-lang/Nim/issues/22706))
- Fixed "Varargs conversions produce erroneous ConvFromXtoItselfNotNeeded warnings"
  ([#10542](https://github.com/nim-lang/Nim/issues/10542))
- Fixed "Compilation fails when using fusion's 'Some' inside a generic proc"
  ([#20435](https://github.com/nim-lang/Nim/issues/20435))
- Fixed "func `strutils.join` for non-strings uses proc `$` which can have side effects"
  ([#22696](https://github.com/nim-lang/Nim/issues/22696))
- Fixed "Different results on orc/refc or global/procedure scope with orc"
  ([#22787](https://github.com/nim-lang/Nim/issues/22787))
- Fixed "[Renderer] SIGSEGV when trying to render invalid AST"
  ([#8893](https://github.com/nim-lang/Nim/issues/8893))
- Fixed "`AnyEnumConv` warning when iterating over `enum`"
  ([#22790](https://github.com/nim-lang/Nim/issues/22790))
- Fixed "ORC AssertionDefect `not containsManagedMemory(n.typ)`"
  ([#19250](https://github.com/nim-lang/Nim/issues/19250))
- Fixed "enumutils items[HoleyEnum] example code produces "unsafe" warnings"
  ([#22844](https://github.com/nim-lang/Nim/issues/22844))
- Fixed "`Table`, `CountTable`, and `HashSet` warn on `UnsafeDefault` `del`/`excl` `requiresInit` key type"
  ([#22883](https://github.com/nim-lang/Nim/issues/22883))
- Fixed ""Error: borrow from proc return type mismatch: 'lent string'" when borrowing `[]` from Table"
  ([#22902](https://github.com/nim-lang/Nim/issues/22902))
- Fixed "`AnyEnumConv` warning when iterating over `set`"
  ([#22860](https://github.com/nim-lang/Nim/issues/22860))
- Fixed "Cannot prove that result is initialized for a placeholder base method returning a lent"
  ([#22673](https://github.com/nim-lang/Nim/issues/22673))
- Fixed "`std/options` don’t consider closure iterators to be pointer types"
  ([#22932](https://github.com/nim-lang/Nim/issues/22932))
- Fixed "Defaulting a value to a type silently works in ref object"
  ([#22996](https://github.com/nim-lang/Nim/issues/22996))
- Fixed "Different type inferred when setting a default value for an array field"
  ([#22926](https://github.com/nim-lang/Nim/issues/22926))
- Fixed "Problem removing cstring unsafe conversion warning"
  ([#23001](https://github.com/nim-lang/Nim/issues/23001))
- Fixed "Undeclared identifier in Unicode gives Unhelpful error message"
  ([#23060](https://github.com/nim-lang/Nim/issues/23060))
- Fixed "macro is evaluated twice in generic context"
  ([#9381](https://github.com/nim-lang/Nim/issues/9381))
- Fixed "Type mismatch error when importing strutils on platforms where ints are less then 32-bits wide"
  ([#23125](https://github.com/nim-lang/Nim/issues/23125))
- Fixed "Importing module with path concatenation inside templates not working anymore"
  ([#23167](https://github.com/nim-lang/Nim/issues/23167))
- Fixed "Cannot get repr of range type of enum"
  ([#23139](https://github.com/nim-lang/Nim/issues/23139))
- Fixed "ambiguous call with `$` when using `distinct`"
  ([#23172](https://github.com/nim-lang/Nim/issues/23172))
- Fixed "Tuple destructuring is broken with closure iterators"
  ([#15924](https://github.com/nim-lang/Nim/issues/15924))
- Fixed "Compiler error (illegal read) on tuple unpacking in a `for` loop"
  ([#23180](https://github.com/nim-lang/Nim/issues/23180))
- Fixed "`system.insert` wipes the string if `item` is an empty string"
  ([#23223](https://github.com/nim-lang/Nim/issues/23223))
- Fixed "const cstring incorrectly cgen'd (pointer is copied, pointing to garbage)"
  ([#12334](https://github.com/nim-lang/Nim/issues/12334))
- Fixed "copy generated for non-copyable type"
  ([#22218](https://github.com/nim-lang/Nim/issues/22218))
- Fixed "1.6 to 2.0 regression with `UncheckedArray[string]`/`toOpenArray` resulting in `SIGSEGV`"
  ([#23247](https://github.com/nim-lang/Nim/issues/23247))
- Fixed "Compiler segfaults when passing static parameter to non static macro parameter"
  ([#22909](https://github.com/nim-lang/Nim/issues/22909))
- Fixed "Refrain from using `sprintf()`, which triggers warnings in macOS 13/Xcode 14.1 `clang`"
  ([#23304](https://github.com/nim-lang/Nim/issues/23304))
- Fixed "Error in proc that modifies instances of a recursive type defined with a concept"
  ([#22723](https://github.com/nim-lang/Nim/issues/22723))
- Fixed "{.union.} pragma is ignored on NimVM"
  ([#13481](https://github.com/nim-lang/Nim/issues/13481))
- Fixed "Regression from 1.6 to 2.0/devel with `nim c -c` `SIGSEGV` with `template`/`raises: []`"
  ([#22284](https://github.com/nim-lang/Nim/issues/22284))
- Fixed "`close(File)` and `setFilePos(File, int64, ...)` can be used in `func`"
  ([#22166](https://github.com/nim-lang/Nim/issues/22166))
- Fixed "NRVO can kick in on `exportc, dynlib` procedures"
  ([#23401](https://github.com/nim-lang/Nim/issues/23401))
- Fixed "Pushing `used` suppresses the `XDeclaredButNotUsed` hint for some identifiers, but not others"
  ([#22939](https://github.com/nim-lang/Nim/issues/22939))
- Fixed "Converter and openArray together generate the wrong C code."
  ([#22597](https://github.com/nim-lang/Nim/issues/22597))
- Fixed "Invalid C++ code generation when returning var T"
  ([#10219](https://github.com/nim-lang/Nim/issues/10219))
- Fixed "ICE when trying to repr nnkMutableTy in macro"
  ([#15751](https://github.com/nim-lang/Nim/issues/15751))
- Fixed "Lambdas expanded from template arguments crash the compiler"
  ([#22846](https://github.com/nim-lang/Nim/issues/22846))
- Fixed "Warning is ignored when using flags `--warningAsError` and `--verbosity` together"
  ([#23429](https://github.com/nim-lang/Nim/issues/23429))
- Fixed "`set[uint8].len` returns a random number when passed to a proc as a `var`"
  ([#23422](https://github.com/nim-lang/Nim/issues/23422))
- Fixed "Wrong type in object construction error message"
  ([#23494](https://github.com/nim-lang/Nim/issues/23494))
- Fixed "`Error: unhandled exception: injectdestructors.nim(425, 12) n.kind != nkSym or not hasDestructor(c, n.sym.typ)` with ARC or ORC during compilation"
  ([#23505](https://github.com/nim-lang/Nim/issues/23505))
- Fixed "`<expr> is` crashes nimsuggest"
  ([#23518](https://github.com/nim-lang/Nim/issues/23518))
- Fixed "Top level variables are moved sometimes"
  ([#23524](https://github.com/nim-lang/Nim/issues/23524))
- Fixed "`nim c -c` on `{.push emit.}`: `Error: unhandled exception: field 'sons' is not accessible for type 'TNode' using 'kind = nkIdent' [FieldDefect]`"
  ([#23525](https://github.com/nim-lang/Nim/issues/23525))
- Fixed "anonymous closure iterators doesn't work with global variable in JS"
  ([#23522](https://github.com/nim-lang/Nim/issues/23522))
- Fixed "Stack trace with wrong line number when the proc called inside for loop"
  ([#23536](https://github.com/nim-lang/Nim/issues/23536))
- Fixed "`Error: fatal error: invalid kind for lastOrd(tyGenericParam)` in compiler given invalid array declaration"
  ([#23531](https://github.com/nim-lang/Nim/issues/23531))
- Fixed "`Error: internal error: openArrayLoc: ref array[0..0, int]` with `new array[1, int]` and `toOpenArray`"
  ([#23321](https://github.com/nim-lang/Nim/issues/23321))
- Fixed "`internal error: getTypeDescAux` with `void` in generic array instantiation"
  ([#23419](https://github.com/nim-lang/Nim/issues/23419))
- Fixed "`typeinfo.extendSeq` generates random values"
  ([#23556](https://github.com/nim-lang/Nim/issues/23556))
- Fixed "`value out of range [RangeDefect]` in getFileInfo() for a specific file (file handle overflow?)"
  ([#23442](https://github.com/nim-lang/Nim/issues/23442))
- Fixed "Invalid styleCheck:hint for enum/func conflict"
  ([#22409](https://github.com/nim-lang/Nim/issues/22409))
- Fixed "Invalid codegen when trying to mannualy delete distinct seq"
  ([#23552](https://github.com/nim-lang/Nim/issues/23552))
- Fixed "Update unicode.nim: cmpRunesIgnoreCase: fix doc format"
  ([#23560](https://github.com/nim-lang/Nim/issues/23560))
- Fixed "Destructor not called for object subclass created in template and immediately passed as argument"
  ([#23440](https://github.com/nim-lang/Nim/issues/23440))
- Fixed "Viewtype codegen error turns a single proc call into two"
  ([#15778](https://github.com/nim-lang/Nim/issues/15778))
- Fixed "sink parameters sometimes not copied even when there are later reads (refc)"
  ([#23354](https://github.com/nim-lang/Nim/issues/23354))
- Fixed "SIGSEGV with object variants and RTTI"
  ([#23690](https://github.com/nim-lang/Nim/issues/23690))
- Fixed "ORC runs into infinite recursion"
  ([#22927](https://github.com/nim-lang/Nim/issues/22927))



The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v2.0.4...v2.0.6).



