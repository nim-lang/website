---
title: "Version 0.19.2 released"
author: The Nim Team
---

The Nim team is happy to announce that the latest release of Nim,
version 0.19.2, is now available. Nim is a systems programming language that
focuses on performance, portability and expressiveness.

This is mostly a bugfix release of version 0.19.0.
It adds RISC-V support and there are no breaking changes.
The most important bugfixes are:

- ``spawn`` can handle the empty seqs/strings that are internally
  represented as ``nil``.
- The most pressing bugs of the documentation generator have been fixed.
- async streaming of the httpclient has been fixed.


## Installing 0.19.2

If you have installed a previous version of Nim using ``choosenim``,
getting Nim 0.19.2 is as easy as:

```bash
$ choosenim update stable
```

If you don't have it already, you can get ``choosenim`` by following
[these instructions](https://github.com/dom96/choosenim) or you can install
Nim by following the instructions on our
[install](https://nim-lang.org/install.html) page.

### Compiler changes

- Added support for the RISC-V 64 bit architecture named riscv64
(e.g. [HiFive](https://www.sifive.com/boards/hifive-unleashed))

### Bugfixes

- Fixed "Nim 0.19.0 docs have incorrect Source/Edit links"
  ([#9083](https://github.com/nim-lang/Nim/issues/9083))
- Fixed "Json: compilation fails with aliased type"
  ([#9111](https://github.com/nim-lang/Nim/issues/9111))
- Fixed "https://nim-lang.org/docs/nre.html gives 404 error"
  ([#9119](https://github.com/nim-lang/Nim/issues/9119))
- Fixed "Leaving `\\` at the end of a path in `copyDir` removes every file's first char"
  ([#9126](https://github.com/nim-lang/Nim/issues/9126))
- Fixed "nim doc SIGSEGV: Illegal storage access."
  ([#9140](https://github.com/nim-lang/Nim/issues/9140))
- Fixed "[doc] List of broken links in the doc site"
  ([#9109](https://github.com/nim-lang/Nim/issues/9109))
- Fixed "Fix incorrect examples in nre docs"
  ([#9053](https://github.com/nim-lang/Nim/issues/9053))
- Fixed "Clean up root of repo and release archives"
  ([#4934](https://github.com/nim-lang/Nim/issues/4934))
- Fixed "Concept/converter/generics-related compiler crash"
  ([#7351](https://github.com/nim-lang/Nim/issues/7351))
- Fixed "converter + concept causes compiler to quit without error"
  ([#6249](https://github.com/nim-lang/Nim/issues/6249))
- Fixed "Error: internal error"
  ([#6533](https://github.com/nim-lang/Nim/issues/6533))
- Fixed "Methods break static[T] (internal error: nesting too deep)"
  ([#5479](https://github.com/nim-lang/Nim/issues/5479))
- Fixed "Memory error when checking if a variable is a string in concept"
  ([#7092](https://github.com/nim-lang/Nim/issues/7092))
- Fixed "Internal error when using array of procs"
  ([#5015](https://github.com/nim-lang/Nim/issues/5015))
- Fixed "[Regression] Compiler crash on proc with static, used to compile in nim 0.16"
  ([#5868](https://github.com/nim-lang/Nim/issues/5868))
- Fixed "fixes/8099"
  ([#8451](https://github.com/nim-lang/Nim/issues/8451))
- Fixed "distinct generic typeclass not treated as distinct"
  ([#4435](https://github.com/nim-lang/Nim/issues/4435))
- Fixed "multiple dynlib pragmas with function calls conflict with each other causing link time error"
  ([#9222](https://github.com/nim-lang/Nim/issues/9222))
- Fixed "\0 in comment replaced with 0 in docs"
  ([#8841](https://github.com/nim-lang/Nim/issues/8841))
- Fixed "Async readAll in httpclient produces garbled output."
  ([#8994](https://github.com/nim-lang/Nim/issues/8994))
- Fixed "`runnableExamples` should be run by `nim doc` even if symbol is not public"
  ([#9216](https://github.com/nim-lang/Nim/issues/9216))
- Fixed "[regression] project `config.nims` not being read anymore"
  ([#9264](https://github.com/nim-lang/Nim/issues/9264))
- Fixed "Using iterator within another iterator fails"
  ([#3819](https://github.com/nim-lang/Nim/issues/3819))
- Fixed "`nim js -o:dirname main.nim` writes nothing, and no error shown"
  ([#9154](https://github.com/nim-lang/Nim/issues/9154))
- Fixed "devel docs in nim-lang.github.io `Source` links point to master instead of devel"
  ([#9295](https://github.com/nim-lang/Nim/issues/9295))
- Fixed "Regular Expressions: replacing empty patterns only works correctly in nre"
  ([#9306](https://github.com/nim-lang/Nim/issues/9306))
- Fixed "counting the empty substring in a string results in infinite loop"
  ([#8919](https://github.com/nim-lang/Nim/issues/8919))
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
- Fixed "SIGSEGV when converting `lines` to closure iterator, most likely caused by defer"
  ([#5321](https://github.com/nim-lang/Nim/issues/5321))
- Fixed "Compiler crash when creating a variant type"
  ([#6220](https://github.com/nim-lang/Nim/issues/6220))
- Fixed "old changelogs should be kept instead of erased"
  ([#9376](https://github.com/nim-lang/Nim/issues/9376))

- Fixed "Crash when closing an unopened file on debian 8."
  ([#9456](https://github.com/nim-lang/Nim/issues/9456))
- Fixed "nimpretty joins regular and doc comment"
  ([#9400](https://github.com/nim-lang/Nim/issues/9400))
- Fixed "nimpretty changes indentation level of trailing comment"
  ([#9398](https://github.com/nim-lang/Nim/issues/9398))
- Fixed "Some bugs with nimpretty"
  ([#8078](https://github.com/nim-lang/Nim/issues/8078))
- Fixed "nimpretty not idempotent: keeps adding newlines below block comment"
  ([#9483](https://github.com/nim-lang/Nim/issues/9483))
- Fixed "nimpretty shouldn't format differently whether there's a top-level newline"
  ([#9484](https://github.com/nim-lang/Nim/issues/9484))
- Fixed "nimpretty shouldn't change file modif time if no changes => use os.updateFile"
  ([#9499](https://github.com/nim-lang/Nim/issues/9499))
- Fixed "nimpretty adds a space before type, ptr, ref, object in wrong places"
  ([#9504](https://github.com/nim-lang/Nim/issues/9504))
- Fixed "nimpretty badly indents block comment"
  ([#9500](https://github.com/nim-lang/Nim/issues/9500))
- Fixed "nimpretty wrongly adds empty newlines inside proc signature"
  ([#9506](https://github.com/nim-lang/Nim/issues/9506))
- Fixed "Duplicate definition in cpp codegen"
  ([#6986](https://github.com/nim-lang/Nim/issues/6986))
- Fixed "`nim doc strutils.nim` fails on 32 bit compiler with AssertionError on a RunnableExample"
  ([#9525](https://github.com/nim-lang/Nim/issues/9525))
- Fixed "using Selectors, Error: undeclared field: 'OSErrorCode'"
  ([#7667](https://github.com/nim-lang/Nim/issues/7667))

- Fixed "strutils.multiReplace() crashes if search string is """
  ([#9557](https://github.com/nim-lang/Nim/issues/9557))
- Fixed "Type which followed by a function and generated by a template will not shown in docs generated by `nim doc`"
  ([#9235](https://github.com/nim-lang/Nim/issues/9235))
- Fixed "Module docs: 2 suggestions..."
  ([#5525](https://github.com/nim-lang/Nim/issues/5525))
- Fixed "Missing docstrings are replaced with other text"
  ([#9169](https://github.com/nim-lang/Nim/issues/9169))
- Fixed "templates expand doc comments as documentation of other procedures"
  ([#9432](https://github.com/nim-lang/Nim/issues/9432))
- Fixed "Path in error message has `..\..\..\..\..\`  prefix since 0.19.0"
  ([#9556](https://github.com/nim-lang/Nim/issues/9556))
- Fixed "Nim/compiler/pathutils.nim(226, 12) `canon"/foo/../bar" == "/bar"`  [AssertionError]" ([#9507](https://github.com/nim-lang/Nim/issues/9507))

- Fixed "[Regression] Borrow stringify operator no longer works as expected"
  ([#9322](https://github.com/nim-lang/Nim/issues/9322))
- Fixed "[NimScript] Error: arguments can only be given if the '--run' option is selected"
  ([#9246](https://github.com/nim-lang/Nim/issues/9246))
- Fixed "nim check: `internal error: (filename: "vmgen.nim", line: 1119, column: 19)`"
  ([#9609](https://github.com/nim-lang/Nim/issues/9609))
- Fixed "`optInd` missing indent specification in grammar.txt"
  ([#9608](https://github.com/nim-lang/Nim/issues/9608))
- Fixed "nimpretty should hardcode indentation amount to 2 spaces"
  ([#9502](https://github.com/nim-lang/Nim/issues/9502))
- Fixed "Nimpretty adds instead of removes incorrect spacing inside backticks"
  ([#9673](https://github.com/nim-lang/Nim/issues/9673))
- Fixed "Compiler segfault (stack overflow) compiling code on 0.19.0 that works on 0.18.0"
  ([#9694](https://github.com/nim-lang/Nim/issues/9694))
