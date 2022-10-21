---
title: "Version 1.4.2 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.4.2, our first patch release for
Nim 1.4.

Version 1.4.2 is a result of one month of hard work, and it contains
[229 commits](https://github.com/nim-lang/Nim/compare/v1.4.0...v1.4.2),
fixing more than 90 reported issues.

This is a large patch release, bringing lots of bugfixes and improvements
that didn't make it for the 1.4.0 release.

If you are still on Nim 1.0.x, and would like to know about new features
available in Nim 1.2 and 1.4, check out our
[version 1.2.0 release article](https://nim-lang.org/blog/2020/04/03/version-120-released.html) and
[version 1.4.0 release article](https://nim-lang.org/blog/2020/10/16/version-140-released.html).

We would recommend to all of our users to upgrade and use version 1.4.2.


# Installing Nim 1.4

## New users

Check out if the package manager of your OS already ships version 1.4.2 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.4.2 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.4.2 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2020-11-30-version-1-4-3fb5157ab1b666a5a5c34efde0f357a82d433d04).



# Donating to Nim

We would like to encourage you to donate to Nim.

The donated money will be used to further improve Nim:
- Bugs need to be fixed, the documentation can be improved, compiler error
  messages can always be better.
- The most exciting upcoming feature, that has the greatest impact to all
  of our users, is [incremental compilation](https://github.com/nim-lang/RFCs/issues/46).
- Incremental compilation will also be the foundation for further tooling
  improvements like `nimsuggest` (autocompletion, find usages).


You can donate via:

* [Open Collective](https://opencollective.com/nim)
* [Patreon](https://www.patreon.com/araq)
* [PayPal](https://www.paypal.com/donate/?hosted_button_id=KYXH3BLJBHZTA)
* Bitcoin: bc1qzgw3vsppsa9gu53qyecyu063jfajmjpye3r2h4

If you are a company, we also offer commercial support.
Please get in touch with us via `support@nim-lang.org`.
As a commercial backer, you can decide what features and bugfixes should
be prioritized.



# Bugfixes

- Fixed "dbQuote additional escape regression"
  ([#15560](https://github.com/nim-lang/Nim/issues/15560))
- Fixed "[ARC] Finalizer with a do notation proc crashes the compiler"
  ([#15599](https://github.com/nim-lang/Nim/issues/15599))
- Fixed "./koch drnim: git checkout ... fails (invalid git hash)"
  ([#15639](https://github.com/nim-lang/Nim/issues/15639))
- Fixed "Testament does not check memory leaks with Valgrind"
  ([#15631](https://github.com/nim-lang/Nim/issues/15631))
- Fixed "Templates can't be made discardable"
  ([#13609](https://github.com/nim-lang/Nim/issues/13609))
- Fixed "Taking a view of `var openArray[T]` generates broken C"
  ([#15652](https://github.com/nim-lang/Nim/issues/15652))
- Fixed "Regression: parsecsv from newGZFileStream"
  ([#12410](https://github.com/nim-lang/Nim/issues/12410))
- Fixed "NimVM generic procs that take anonymous tuples gives nil access error."
  ([#15662](https://github.com/nim-lang/Nim/issues/15662))
- Fixed "net.`$` is not printing a zero group smaller than the compressed group"
  ([#15698](https://github.com/nim-lang/Nim/issues/15698))
- Fixed "map, mapIt, filter cause a segfault at compile time in a static block when passed an inline function"
  ([#15363](https://github.com/nim-lang/Nim/issues/15363))
- Fixed "const Table losing object variant data at runtime"
  ([#8007](https://github.com/nim-lang/Nim/issues/8007))
- Fixed "regression(1.0.2 => 1.0.4) VM register messed up depending on unrelated context"
  ([#15704](https://github.com/nim-lang/Nim/issues/15704))
- Fixed "VM: nil procvar treated as not nil in VM, causing FieldDefect and further errors"
  ([#15595](https://github.com/nim-lang/Nim/issues/15595))
- Fixed "ICE with sequtils + algorithm (mapIt, sortedByIt) + json "
  ([#10456](https://github.com/nim-lang/Nim/issues/10456))
- Fixed "Size of packed enum of byte is 2 byte; if highest value is 0xFF but should be 1"
  ([#15752](https://github.com/nim-lang/Nim/issues/15752))
- Fixed "OrderedTable.== throws error on empty table: unhandled exception: index out of bounds..."
  ([#15750](https://github.com/nim-lang/Nim/issues/15750))
- Fixed "strictFunc: system `&` is considered to have side effects under arc mode"
  ([#15756](https://github.com/nim-lang/Nim/issues/15756))
- Fixed "JSON parsing fails for integer values greater than BiggestInt.max "
  ([#15413](https://github.com/nim-lang/Nim/issues/15413))
- Fixed "yet another cmpIgnoreStyle bug"
  ([#7686](https://github.com/nim-lang/Nim/issues/7686))
- Fixed "`1 mod 0` gives NaN with JS backend"
  ([#7127](https://github.com/nim-lang/Nim/issues/7127))
- Fixed "Discarding a dom.Node raises a javascript error"
  ([#15638](https://github.com/nim-lang/Nim/issues/15638))
- Fixed "Regression: overriding streams.write(T) does not work on 0.19 anymore"
  ([#9091](https://github.com/nim-lang/Nim/issues/9091))
- Fixed "Converter is applied to the first parameter of operator instead of last"
  ([#9165](https://github.com/nim-lang/Nim/issues/9165))
- Fixed "Recursion using concepts crashes compiler"
  ([#8012](https://github.com/nim-lang/Nim/issues/8012))
- Fixed "Union types in javascript"
  ([#7658](https://github.com/nim-lang/Nim/issues/7658))
- Fixed "Ambiguous call error when it's not"
  ([#7416](https://github.com/nim-lang/Nim/issues/7416))
- Fixed "Codegen does not like shadowed parameter"
  ([#7374](https://github.com/nim-lang/Nim/issues/7374))
- Fixed "incomplete code generation when using a compile time variable at run time (undeclared identifier)"
  ([#6036](https://github.com/nim-lang/Nim/issues/6036))
- Fixed "Compiler doesn't warn when using {.global.} and {.threadvar.} on JS backend despite it not working"
  ([#11625](https://github.com/nim-lang/Nim/issues/11625))
- Fixed "Discarding output with nested for/if statements"
  ([#14227](https://github.com/nim-lang/Nim/issues/14227))
- Fixed "regression: docgen drops enum doc comments"
  ([#15702](https://github.com/nim-lang/Nim/issues/15702))
- Fixed "regression(1.0): codegen error with `locals`"
  ([#12682](https://github.com/nim-lang/Nim/issues/12682))
- Fixed "[JS] `$` on an enum in an if expression causes bad codegen"
  ([#15651](https://github.com/nim-lang/Nim/issues/15651))
- Fixed "Error upon conditional declaration inside a template"
  ([#3670](https://github.com/nim-lang/Nim/issues/3670))
- Fixed "Compiler crash when a value in enum is converted to the enum itself"
  ([#15145](https://github.com/nim-lang/Nim/issues/15145))
- Fixed "[AssertionDefect] json.to(type) on object with Option[ref object] field"
  ([#15815](https://github.com/nim-lang/Nim/issues/15815))
- Fixed "Crash with const tuple unpacking"
  ([#15717](https://github.com/nim-lang/Nim/issues/15717))
- Fixed "JS codegen can produce extreme switch statements with `case a of range`"
  ([#8821](https://github.com/nim-lang/Nim/issues/8821))
- Fixed "cannot `capture result`, produces unhelpful eror"
  ([#15594](https://github.com/nim-lang/Nim/issues/15594))
- Fixed "Code that work in 1.2.6, but not 1.4.0"
  ([#15804](https://github.com/nim-lang/Nim/issues/15804))
- Fixed "C-backend link failure for let with {.global, compileTime.} pragma"
  ([#12640](https://github.com/nim-lang/Nim/issues/12640))
- Fixed "json.to crashes (SIGSEGV) when object attribute is a JsonNode and the key is not there"
  ([#15835](https://github.com/nim-lang/Nim/issues/15835))
- Fixed "Cannot use custom pragmas in `ref object`"
  ([#8457](https://github.com/nim-lang/Nim/issues/8457))
- Fixed "GC_ref on empty string fails with [GCASSERT] incRef: interiorPtr"
  ([#10307](https://github.com/nim-lang/Nim/issues/10307))
- Fixed "VM segmentation faults with swap"
  ([#15463](https://github.com/nim-lang/Nim/issues/15463))
- Fixed "`$`(s: WideCString) changes result to repr on --gc:arc"
  ([#15663](https://github.com/nim-lang/Nim/issues/15663))
- Fixed "unittest.check rejects with a type error, code that Nim otherwise accepts"
  ([#15618](https://github.com/nim-lang/Nim/issues/15618))
- Fixed "Type mismatch on init of static[T] object with T being a static[U]"
  ([#11142](https://github.com/nim-lang/Nim/issues/11142))
- Fixed "sizeof array with static N crash in type section"
  ([#12636](https://github.com/nim-lang/Nim/issues/12636))
- Fixed "--gc:arc segfaults when returning `result` from a proc"
  ([#15609](https://github.com/nim-lang/Nim/issues/15609))
- Fixed "Error: 'newHttpHeaders' can have side effects"
  ([#15851](https://github.com/nim-lang/Nim/issues/15851))
- Fixed "template that overloads [] accessor does not compile"
  ([#8829](https://github.com/nim-lang/Nim/issues/8829))
- Fixed "Simple type definition crash"
  ([#12897](https://github.com/nim-lang/Nim/issues/12897))
- Fixed "`mapIt` from `sequtils` not working in `{.push compile_time.}` context"
  ([#12558](https://github.com/nim-lang/Nim/issues/12558))
- Fixed "--gc:arc/orc Error: unhandled exception: 'sym' is not accessible using discriminant 'kind' of type 'TNode' [FieldDefect]"
  ([#15707](https://github.com/nim-lang/Nim/issues/15707))
- Fixed "incorrect type inference with static: Error: ordinal type expected"
  ([#15858](https://github.com/nim-lang/Nim/issues/15858))
- Fixed "constructor causes SIGBUS if a destroy is defined"
  ([#14601](https://github.com/nim-lang/Nim/issues/14601))
- Fixed "internal error: getTypeDescAux(tyOr) on sink UnionType argument"
  ([#15825](https://github.com/nim-lang/Nim/issues/15825))
- Fixed "Console apps in Windows can rise OSError"
  ([#15874](https://github.com/nim-lang/Nim/issues/15874))
- Fixed "nim doc cannot grok IOSelectorsException"
  ([#12471](https://github.com/nim-lang/Nim/issues/12471))
- Fixed "Method dispatch silently breaks on non-ref objects"
  ([#4318](https://github.com/nim-lang/Nim/issues/4318))
- Fixed "Cannot take the compile-time sizeof Atomic types"
  ([#12726](https://github.com/nim-lang/Nim/issues/12726))
- Fixed "Setting subscript index of cstring is allowed and generates bad code"
  ([#14157](https://github.com/nim-lang/Nim/issues/14157))
- Fixed "Compiler crash using if as an expression with a noreturn branch"
  ([#15909](https://github.com/nim-lang/Nim/issues/15909))
- Fixed "docgen fatal: `result[0].kind == nkSym`  [AssertionDefect]"
  ([#15916](https://github.com/nim-lang/Nim/issues/15916))
- Fixed "Iterator for sharedlist won't iterate all items."
  ([#15941](https://github.com/nim-lang/Nim/issues/15941))
- Fixed "Embedded templates with iterators fails to compile"
  ([#2771](https://github.com/nim-lang/Nim/issues/2771))
- Fixed "C++ Atomics in union: ::<unnamed union>::<unnamed struct>::field with constructor not allowed in anonymous aggregate"
  ([#13062](https://github.com/nim-lang/Nim/issues/13062))
- Fixed "memory corruption in tmarshall.nim"
  ([#9754](https://github.com/nim-lang/Nim/issues/9754))
- Fixed "JS backend doesn't handle float->int type conversion "
  ([#8404](https://github.com/nim-lang/Nim/issues/8404))
- Fixed "The "try except" not work when the "OSError: Too many open files" error occurs!"
  ([#15925](https://github.com/nim-lang/Nim/issues/15925))
- Fixed "`lent` gives wrong results with -d:release"
  ([#14578](https://github.com/nim-lang/Nim/issues/14578))
- Fixed "backticks : Using reserved keywords as identifiers is not documented"
  ([#15806](https://github.com/nim-lang/Nim/issues/15806))
- Fixed "backticks : Using reserved keywords as identifiers is not documented"
  ([#15806](https://github.com/nim-lang/Nim/issues/15806))
- Fixed "backticks : Using reserved keywords as identifiers is not documented"
  ([#15806](https://github.com/nim-lang/Nim/issues/15806))
- Fixed "backticks : Using reserved keywords as identifiers is not documented"
  ([#15806](https://github.com/nim-lang/Nim/issues/15806))
- Fixed "Program SIGSEGV when using '--gc:orc'"
  ([#15753](https://github.com/nim-lang/Nim/issues/15753))
- Fixed "Assignment to `Option[T]` doesn't call destructor on existing contained value"
  ([#15910](https://github.com/nim-lang/Nim/issues/15910))
- Fixed "In for loop `_` is accessible"
  ([#15972](https://github.com/nim-lang/Nim/issues/15972))
- Fixed "Pragma codegenDecl doesn't work inside iterators"
  ([#6497](https://github.com/nim-lang/Nim/issues/6497))
- Fixed "`nim js --gc:arc` gives bad error:  undeclared identifier: '+!'"
  ([#16033](https://github.com/nim-lang/Nim/issues/16033))
- Fixed "create a new function definitions got Internal error: environment misses:"
  ([#14847](https://github.com/nim-lang/Nim/issues/14847))
- Fixed "Nim emits #line 0 C preprocessor directives with --debugger:native, with ICE in gcc-10"
  ([#15942](https://github.com/nim-lang/Nim/issues/15942))
- Fixed "Serializing and deserializing a `proc` SIGSEV's"
  ([#16022](https://github.com/nim-lang/Nim/issues/16022))
- Fixed "Small tutorial error"
  ([#16047](https://github.com/nim-lang/Nim/issues/16047))
- Fixed "`lent` codegen error for c++ (works with c,js,vm)"
  ([#15958](https://github.com/nim-lang/Nim/issues/15958))
- Fixed "sink var/var sink both accepted; sink var leads to bad codegen and strange behavior"
  ([#15671](https://github.com/nim-lang/Nim/issues/15671))
- Fixed "tfuturevar fails when activated"
  ([#9695](https://github.com/nim-lang/Nim/issues/9695))
- Fixed "db_sqlite: Error: undeclared field: 'untypedLen'"
  ([#16080](https://github.com/nim-lang/Nim/issues/16080))
- Fixed "xmlparser removes significant white space"
  ([#14056](https://github.com/nim-lang/Nim/issues/14056))
- Fixed "nre.escapeRe is not gcsafe"
  ([#16103](https://github.com/nim-lang/Nim/issues/16103))
- Fixed "`macros.getImpl` still return incorrect AST for Sym "XXX:ObjectType" "
  ([#16110](https://github.com/nim-lang/Nim/issues/16110))
- Fixed ""Error: internal error: genRecordFieldAux" - in the "version-1-4" branch"
  ([#16069](https://github.com/nim-lang/Nim/issues/16069))
- Fixed "Tracking memory leaks under ORC (mostly with async)"
  ([#15076](https://github.com/nim-lang/Nim/issues/15076))
- Fixed "Const seq into sink arg: =copy operator not found"
  ([#16120](https://github.com/nim-lang/Nim/issues/16120))
- Fixed "Copying of a sink parameter into a variable not allowed"
  ([#16119](https://github.com/nim-lang/Nim/issues/16119))
- Fixed "Memleak in AsyncHttpServer with arc/orc"
  ([#16154](https://github.com/nim-lang/Nim/issues/16154))
