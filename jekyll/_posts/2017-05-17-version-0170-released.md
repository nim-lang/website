---
title: "Version 0.17.0 released"
author: The Nim Team
---

The Nim team is happy to announce that the latest release of Nim,
version 0.17.0, is now available. Nim is a systems programming language that
focuses on performance, portability and expressiveness.

This release fixes the most important regressions introduced in version 0.16.0.
In particular memory manager and channel bugs have been fixed. There was also
many significant improvements to the language, in particular a lot of work was
put into concepts. Zahary has been leading this effort and we thank him for
his hard work. Be sure to check out the changelog [below](#changelog) for
a comprehensive list of changes.

The NSIS based
installer is not provided anymore as the Nim website moved to ``https`` and
this caused NSIS downloads to fail. The latest version of Nim for Windows can
still be downloaded as a zip archive from the
[downloads page]({{site.baseurl}}/install.html).

We would also like to invite you to test a brand new tool that aims to make
the installation and management of multiple Nim versions much easier. This tool
is called ``choosenim`` and allows you to install the latest version of Nim
with a single command.
Check out the
[installation instructions](https://github.com/dom96/choosenim#installation)
on GitHub to give it a go, but keep in mind that this tool is still
experimental.

This release also includes version 0.8.6 of the Nimble package manager,
be sure to check out its
[changelog](https://github.com/nim-lang/nimble/blob/master/changelog.markdown)
for a list of changes since its last release.

# Changelog

## Changes affecting backwards compatibility

- There are now two different HTTP response types, ``Response`` and
  ``AsyncResponse``. ``AsyncResponse``'s ``body`` accessor returns a
  ``Future[string]``!

  Due to this change you may need to add another ``await`` in your code.
- ``httpclient.request`` now respects the ``maxRedirects`` option. Previously
  redirects were handled only by ``get`` and ``post`` procs.
- The IO routines now raise ``EOFError`` for the "end of file" condition.
  ``EOFError`` is a subtype of ``IOError`` and so it's easier to distinguish
  between "error during read" and "error due to EOF".
- A hash procedure has been added for ``cstring`` type in ``hashes`` module.
  Previously, hash of a ``cstring`` would be calculated as a hash of the
  pointer. Now the hash is calculated from the contents of the string, assuming
  ``cstring`` is a null-terminated string. Equal ``string`` and ``cstring``
  values produce an equal hash value.
- Macros accepting `varargs` arguments will now receive a node having the
  `nkArgList` node kind. Previous code expecting the node kind to be `nkBracket`
  may have to be updated.
- ``memfiles.open`` now closes file handles/fds by default.  Passing
  ``allowRemap=true`` to ``memfiles.open`` recovers the old behavior.  The old
  behavior is only needed to call ``mapMem`` on the resulting ``MemFile``.
- ``posix.nim``: For better C++ interop the field
  ``sa_sigaction*: proc (x: cint, y: var SigInfo, z: pointer) {.noconv.}`` was
  changed
  to ``sa_sigaction*: proc (x: cint, y: ptr SigInfo, z: pointer) {.noconv.}``.
- The compiler doesn't infer effects for ``.base`` methods anymore. This means
  you need to annotate them with ``.gcsafe`` or similar to clearly declare
  upfront every implementation needs to fulfill these contracts.
- ``system.getAst templateCall(x, y)`` now typechecks the ``templateCall``
  properly. You need to patch your code accordingly.
- ``macros.getType`` and ``macros.getTypeImpl`` for an enum will now return an
  AST that is the same as what is used to define an enum.  Previously the AST
  returned had a repeated ``EnumTy`` node and was missing the initial pragma
  node (which is currently empty for an enum).
- ``macros.getTypeImpl`` now correctly returns the implementation for a symbol
  of type ``tyGenericBody``.
- If the dispatcher parameter's value used in multi method is ``nil``,
  a ``NilError`` exception is raised. The old behavior was that the method
  would be a ``nop`` then.
- ``posix.nim``: the family of ``ntohs`` procs now takes unsigned integers
  instead of signed integers.
- In Nim identifiers en-dash (Unicode point U+2013) is not an alias for the
  underscore anymore. Use underscores instead.
- When the ``requiresInit`` pragma is applied to a record type, future versions
  of Nim will also require you to initialize all the fields of the type during
  object construction. For now, only a warning will be produced.
- The Object construction syntax now performs a number of additional safety
  checks. When fields within case objects are initialized, the compiler will
  now demand that the respective discriminator field has a matching known
  compile-time value.
- On posix, the results of `waitForExit`, `peekExitCode`, `execCmd` will return
  128 + signal number if the application terminates via signal.
- ``ospaths.getConfigDir`` now conforms to the XDG Base Directory specification
  on non-Windows OSs. It returns the value of the ``XDG_CONFIG_DIR`` environment
  variable if it is set, and returns the default configuration directory,
  "~/.config/", otherwise.
- Renamed the line info node parameter for ``newNimNode`` procedure.
- The parsing rules of ``do`` changed.

    ```nim
    foo bar do:
      baz
    ```

  Used to be parsed as:

    ```nim
    foo(bar(do:
      baz))
    ```

  Now it is parsed as:

    ```nim
    foo(bar, do:
      baz)
    ```


Library Additions
-----------------

- Added ``system.onThreadDestruction``.

- Added ``dial`` procedure to networking modules: ``net``, ``asyncdispatch``,
  ``asyncnet``. It merges socket creation, address resolution, and connection
  into single step. When using ``dial``, you don't have to worry about the
  IPv4 vs IPv6 problem. ``httpclient`` now supports IPv6.

- Added `to` macro which allows JSON to be unmarshalled into a type.

    ```nim
    import json

    type
      Person = object
        name: string
        age: int

    let data = """
      {
        "name": "Amy",
        "age": 4
      }
    """

    let node = parseJson(data)
    let obj = node.to(Person)
    echo(obj)
    ```

Tool Additions
--------------

- The ``finish`` tool can now download MingW for you should it not find a
  working MingW installation.


Compiler Additions
------------------

- The name mangling rules used by the C code generator changed. Most of the time
  local variables and parameters are not mangled at all anymore. This improves
  the debugging experience.
- The compiler produces explicit name mangling files when ``--debugger:native``
  is enabled. Debuggers can read these ``.ndi`` files in order to improve
  debugging Nim code.


Language Additions
------------------

- The ``try`` statement's ``except`` branches now support the binding of a
caught exception to a variable:

    ```nim
      try:
        raise newException(Exception, "Hello World")
      except Exception as exc:
        echo(exc.msg)
    ```

    This replaces the ``getCurrentException`` and ``getCurrentExceptionMsg()``
    procedures, although these procedures will remain in the stdlib for the
    foreseeable future. This new language feature is actually implemented using
    these procedures.

    In the near future we will be converting all exception types to refs to
    remove the need for the ``newException`` template.

- A new pragma ``.used`` can be used for symbols to prevent
the "declared but not used" warning. More details can be
found [here](http://nim-lang.org/docs/manual.html#pragmas-used-pragma).
- The popular "colon block of statements" syntax is now also supported for
  ``let`` and ``var`` statements and assignments:

    ```nim
    template ve(value, effect): untyped =
      effect
      value

    let x = ve(4):
      echo "welcome to Nim!"
    ```

    This is particularly useful for DSLs that help in tree construction.


## Language changes

- The ``.procvar`` annotation is not required anymore. That doesn't mean you
  can pass ``system.$`` to ``map`` just yet though.


## Bugfixes

The list below has been generated based on the commits in Nim's git
repository. As such it lists only the issues which have been closed
via a commit, for a full list see
[this link on Github](https://github.com/nim-lang/Nim/issues?utf8=%E2%9C%93&q=is%3Aissue+closed%3A%222017-01-07+..+2017-05-16%22+).

- Fixed "Weird compilation bug"
  ([#4884](https://github.com/nim-lang/Nim/issues/4884))
- Fixed "Return by arg optimization does not set result to default value"
  ([#5098](https://github.com/nim-lang/Nim/issues/5098))
- Fixed "upcoming asyncdispatch doesn't remove recv callback if remote side closed socket"
  ([#5128](https://github.com/nim-lang/Nim/issues/5128))
- Fixed "compiler bug, executable writes into wrong memory"
  ([#5218](https://github.com/nim-lang/Nim/issues/5218))
- Fixed "Module aliasing fails when multiple modules have the same original name"
  ([#5112](https://github.com/nim-lang/Nim/issues/5112))
- Fixed "JS: var argument + case expr with arg = bad codegen"
  ([#5244](https://github.com/nim-lang/Nim/issues/5244))
- Fixed "compiler reject proc's param shadowing inside template"
  ([#5225](https://github.com/nim-lang/Nim/issues/5225))
- Fixed "const value not accessible in proc"
  ([#3434](https://github.com/nim-lang/Nim/issues/3434))
- Fixed "Compilation regression 0.13.0 vs 0.16.0 in compile-time evaluation"
  ([#5237](https://github.com/nim-lang/Nim/issues/5237))
- Fixed "Regression: JS: wrong field-access codegen"
  ([#5234](https://github.com/nim-lang/Nim/issues/5234))
- Fixed "fixes #5234"
  ([#5240](https://github.com/nim-lang/Nim/issues/5240))
- Fixed "JS Codegen: duplicated fields in object constructor"
  ([#5271](https://github.com/nim-lang/Nim/issues/5271))
- Fixed "RFC: improving JavaScript FFI"
  ([#4873](https://github.com/nim-lang/Nim/issues/4873))
- Fixed "Wrong result type when using bitwise and"
  ([#5216](https://github.com/nim-lang/Nim/issues/5216))
- Fixed "upcoming.asyncdispatch is prone to memory leaks"
  ([#5290](https://github.com/nim-lang/Nim/issues/5290))
- Fixed "Using threadvars leads to crash on Windows when threads are created/destroyed"
  ([#5301](https://github.com/nim-lang/Nim/issues/5301))
- Fixed "Type inferring templates do not work with non-ref types."
  ([#4973](https://github.com/nim-lang/Nim/issues/4973))
- Fixed "Nimble package list no longer works on lib.html"
  ([#5318](https://github.com/nim-lang/Nim/issues/5318))
- Fixed "Missing file name and line number in error message"
  ([#4992](https://github.com/nim-lang/Nim/issues/4992))
- Fixed "ref type can't be converted to var parameter in VM"
  ([#5327](https://github.com/nim-lang/Nim/issues/5327))
- Fixed "nimweb ignores the value of --parallelBuild"
  ([#5328](https://github.com/nim-lang/Nim/issues/5328))
- Fixed "Cannot unregister/close AsyncEvent from within its handler"
  ([#5331](https://github.com/nim-lang/Nim/issues/5331))
- Fixed "name collision with template instanciated generic inline function with inlined iterator specialization used from different modules"
  ([#5285](https://github.com/nim-lang/Nim/issues/5285))
- Fixed "object in VM does not have value semantic"
  ([#5269](https://github.com/nim-lang/Nim/issues/5269))
- Fixed "Unstable tuple destructuring behavior in Nim VM"
  ([#5221](https://github.com/nim-lang/Nim/issues/5221))
- Fixed "nre module breaks os templates"
  ([#4996](https://github.com/nim-lang/Nim/issues/4996))
- Fixed "Cannot implement distinct seq with setLen"
  ([#5090](https://github.com/nim-lang/Nim/issues/5090))
- Fixed "await inside array/dict literal produces invalid code"
  ([#5314](https://github.com/nim-lang/Nim/issues/5314))

- Fixed "asyncdispatch.accept() can raise exception inside poll() instead of failing future on Windows"
  ([#5279](https://github.com/nim-lang/Nim/issues/5279))
- Fixed "VM: A crash report should be more informative"
  ([#5352](https://github.com/nim-lang/Nim/issues/5352))
- Fixed "IO routines are poor at handling errors"
  ([#5349](https://github.com/nim-lang/Nim/issues/5349))
- Fixed "new import syntax doesn't work?"
  ([#5185](https://github.com/nim-lang/Nim/issues/5185))
- Fixed "Seq of object literals skips unmentioned fields"
  ([#5339](https://github.com/nim-lang/Nim/issues/5339))
- Fixed "``sym is not accessible`` in compile time"
  ([#5354](https://github.com/nim-lang/Nim/issues/5354))
- Fixed "the matching is broken in re.nim"
  ([#5382](https://github.com/nim-lang/Nim/issues/5382))
- Fixed "development branch breaks in my c wrapper"
  ([#5392](https://github.com/nim-lang/Nim/issues/5392))
- Fixed "Bad codegen: toSeq + tuples + generics"
  ([#5383](https://github.com/nim-lang/Nim/issues/5383))
- Fixed "Bad codegen: toSeq + tuples + generics"
  ([#5383](https://github.com/nim-lang/Nim/issues/5383))
- Fixed "Codegen error when using container of containers"
  ([#5402](https://github.com/nim-lang/Nim/issues/5402))
- Fixed "sizeof(RangeType) is not available in static context"
  ([#5399](https://github.com/nim-lang/Nim/issues/5399))
- Fixed "Regression: ICE: expr: var not init ex_263713"
  ([#5405](https://github.com/nim-lang/Nim/issues/5405))
- Fixed "Stack trace is wrong when assignment operator fails with template"
  ([#5400](https://github.com/nim-lang/Nim/issues/5400))
- Fixed "SIGSEGV in compiler"
  ([#5391](https://github.com/nim-lang/Nim/issues/5391))
- Fixed "Compiler regression with struct member names"
  ([#5404](https://github.com/nim-lang/Nim/issues/5404))
- Fixed "Regression: compiler segfault"
  ([#5419](https://github.com/nim-lang/Nim/issues/5419))
- Fixed "The compilation of jester routes is broken on devel"
  ([#5417](https://github.com/nim-lang/Nim/issues/5417))
- Fixed "Non-generic return type produces "method is not a base""
  ([#5432](https://github.com/nim-lang/Nim/issues/5432))
- Fixed "Confusing error behavior when calling slice[T].random"
  ([#5430](https://github.com/nim-lang/Nim/issues/5430))
- Fixed "Wrong method called"
  ([#5439](https://github.com/nim-lang/Nim/issues/5439))
- Fixed "Attempt to document the strscans.scansp macro"
  ([#5154](https://github.com/nim-lang/Nim/issues/5154))
- Fixed "[Regression] Invalid C code for _ symbol inside jester routes"
  ([#5452](https://github.com/nim-lang/Nim/issues/5452))
- Fixed "StdLib base64 encodeInternal crashes with out of bound exception"
  ([#5457](https://github.com/nim-lang/Nim/issues/5457))
- Fixed "Nim hangs forever in infinite loop in nre library"
  ([#5444](https://github.com/nim-lang/Nim/issues/5444))

- Fixed "Tester passes test although individual test in suite fails"
  ([#5472](https://github.com/nim-lang/Nim/issues/5472))
- Fixed "terminal.nim documentation"
  ([#5483](https://github.com/nim-lang/Nim/issues/5483))
- Fixed "Codegen error - expected identifier before ')' token (probably regression)"
  ([#5481](https://github.com/nim-lang/Nim/issues/5481))
- Fixed "mixin not works inside generic proc generated by template"
  ([#5478](https://github.com/nim-lang/Nim/issues/5478))
- Fixed "var not init (converter + template + macro)"
  ([#5467](https://github.com/nim-lang/Nim/issues/5467))
- Fixed "`==` for OrderedTable should consider equal content but different size as equal."
  ([#5487](https://github.com/nim-lang/Nim/issues/5487))
- Fixed "Fixed tests/tester.nim"
  ([#45](https://github.com/nim-lang/Nim/issues/45))
- Fixed "template instanciation crashes compiler"
  ([#5428](https://github.com/nim-lang/Nim/issues/5428))
- Fixed "Internal compiler error in handleGenericInvocation"
  ([#5167](https://github.com/nim-lang/Nim/issues/5167))
- Fixed "compiler crash in forwarding template"
  ([#5455](https://github.com/nim-lang/Nim/issues/5455))
- Fixed "Doc query re public/private + suggestion re deprecated"
  ([#5529](https://github.com/nim-lang/Nim/issues/5529))
- Fixed "inheritance not work for generic object whose parent is parameterized"
  ([#5264](https://github.com/nim-lang/Nim/issues/5264))
- Fixed "weird inheritance rule restriction"
  ([#5231](https://github.com/nim-lang/Nim/issues/5231))
- Fixed "Enum with holes broken in JS"
  ([#5062](https://github.com/nim-lang/Nim/issues/5062))
- Fixed "enum type and aliased enum type inequality when tested with operator `is` involving template"
  ([#5360](https://github.com/nim-lang/Nim/issues/5360))
- Fixed "logging: problem with console logger caused by the latest changes in sysio"
  ([#5546](https://github.com/nim-lang/Nim/issues/5546))
- Fixed "Crash if proc and caller doesn't define seq type - HEAD"
  ([#4756](https://github.com/nim-lang/Nim/issues/4756))
- Fixed "`path` config option doesn't work when compilation is invoked from a different directory"
  ([#5228](https://github.com/nim-lang/Nim/issues/5228))
- Fixed "segfaults module doesn't compile with C++ backend"
  ([#5550](https://github.com/nim-lang/Nim/issues/5550))
- Fixed "Improve `joinThreads` for windows"
  ([#4972](https://github.com/nim-lang/Nim/issues/4972))
- Fixed "Compiling in release mode prevents valid code execution."
  ([#5296](https://github.com/nim-lang/Nim/issues/5296))
- Fixed "Forward declaration of generic procs or iterators doesn't work"
  ([#4104](https://github.com/nim-lang/Nim/issues/4104))
- Fixed "cant create thread after join"
  ([#4719](https://github.com/nim-lang/Nim/issues/4719))
- Fixed "can't compile with var name "near" and --threads:on"
  ([#5598](https://github.com/nim-lang/Nim/issues/5598))
- Fixed "inconsistent behavior when calling parent's proc of generic object"
  ([#5241](https://github.com/nim-lang/Nim/issues/5241))
- Fixed "The problem with import order of asyncdispatch and unittest modules"
  ([#5597](https://github.com/nim-lang/Nim/issues/5597))
- Fixed "Generic code fails to compile in unexpected ways"
  ([#976](https://github.com/nim-lang/Nim/issues/976))
- Fixed "Another 'User defined type class' issue"
  ([#1128](https://github.com/nim-lang/Nim/issues/1128))
- Fixed "compiler fails to compile user defined typeclass"
  ([#1147](https://github.com/nim-lang/Nim/issues/1147))
- Fixed "Type class membership testing doesn't work on instances of generic object types"
  ([#1570](https://github.com/nim-lang/Nim/issues/1570))
- Fixed "Strange overload resolution behavior for procedures with typeclass arguments"
  ([#1991](https://github.com/nim-lang/Nim/issues/1991))
- Fixed "The same UDTC can't constrain two type parameters in the same procedure"
  ([#2018](https://github.com/nim-lang/Nim/issues/2018))
- Fixed "More trait/concept issues"
  ([#2423](https://github.com/nim-lang/Nim/issues/2423))
- Fixed "Bugs with concepts?"
  ([#2882](https://github.com/nim-lang/Nim/issues/2882))

- Fixed "Improve error messages for concepts"
    ([#3330](https://github.com/nim-lang/Nim/issues/3330))
- Fixed "Dynamic dispatch is not working correctly"
    ([#5599](https://github.com/nim-lang/Nim/issues/5599))
- Fixed "asynchttpserver may consume unbounded memory reading headers"
    ([#3847](https://github.com/nim-lang/Nim/issues/3847))
- Fixed "nim check crash due to missing var keyword"
    ([#5618](https://github.com/nim-lang/Nim/issues/5618))
- Fixed "Unexpected template resolution"
    ([#5625](https://github.com/nim-lang/Nim/issues/5625))
- Fixed "Installer fails to download mingw.zip"
    ([#5422](https://github.com/nim-lang/Nim/issues/5422))
- Fixed "Exception name and parent get lost after reraising"
    ([#5628](https://github.com/nim-lang/Nim/issues/5628))
- Fixed "generic ref object typeRel problem"
    ([#5621](https://github.com/nim-lang/Nim/issues/5621))
- Fixed "typedesc typeRel regression"
    ([#5632](https://github.com/nim-lang/Nim/issues/5632))
- Fixed "http client respects only one "Set-Cookie" header"
    ([#5611](https://github.com/nim-lang/Nim/issues/5611))
- Fixed "Internal assert when using ``compiles``"
    ([#5638](https://github.com/nim-lang/Nim/issues/5638))
- Fixed "Compiler crash for variant type."
    ([#4556](https://github.com/nim-lang/Nim/issues/4556))
- Fixed "MultipartData in httpclient.Post appears to break header"
    ([#5710](https://github.com/nim-lang/Nim/issues/5710))

- Fixed "setCookie incorrect timestamp format"
    ([#5718](https://github.com/nim-lang/Nim/issues/5718))
- Fixed "[Regression] strdefine consts cannot be passed to a procvar"
    ([#5729](https://github.com/nim-lang/Nim/issues/5729))
- Fixed "Nim's --nimblepaths picks 1.0 over #head"
    ([#5752](https://github.com/nim-lang/Nim/issues/5752))
- Fixed "Async writes are not queued up on Windows"
    ([#5532](https://github.com/nim-lang/Nim/issues/5532))
- Fixed "float32 literals are translated to double literals in C"
  ([#5821](https://github.com/nim-lang/Nim/issues/5821))
- Fixed "LibreSSL isn't recognized as legit SSL library"
  ([#4893](https://github.com/nim-lang/Nim/issues/4893))
- Fixed "exception when using json "to" proc"
  ([#5761](https://github.com/nim-lang/Nim/issues/5761))
