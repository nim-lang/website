---
title: "Version 0.15.0 released"
author: [Dominik Picheta, Andreas Rumpf]
---

We're happy to announce that the latest release of Nim, version 0.15.0, is now
available!

As always, you can grab the latest version from the
[downloads page]({{ site.baseurl }}/install.html).

This release includes almost 180 bug fixes and improvements. To see a full list
of changes, take a look at the detailed changelog
[below](#changelog).

Some of the most significant changes in this release include: improvements to
the documentation, addition of a new ``multisync`` macro, and a new
``HttpClient`` implementation.

## Documentation

All pages in the documentation now contain a search box and a drop down to
select how procedures should be sorted. This allows you to search for
procedures, types, macros and more from any documentation page.

<a href="{{ site.baseurl }}/assets/news/images/0.15.0/doc_search.gif">
  <img src="{{ site.baseurl }}/assets/news/images/0.15.0/doc_search.gif" alt="Doc search" style="width:100%"/>
</a>

Sorting the procedures by type shows a more natural table of contents. This
should also help you to find procedures and other identifiers.

<a href="{{ site.baseurl }}/assets/news/images/0.15.0/doc_sort.gif">
  <img src="{{ site.baseurl }}/assets/news/images/0.15.0/doc_sort.gif" alt="Doc sort" style="width:100%"/>
</a>

## Multisync macro

The ``multisync`` macro was implemented to enable you to define both
synchronous and asynchronous IO procedures without having to duplicate a
lot of code.

As an example, consider the ``recvTwice`` procedure below:

```nim
proc recvTwice(socket: Socket | AsyncSocket): Future[string] {.multisync.} =
  result = ""
  result.add(await socket.recv(25))
  result.add(await socket.recv(20))
```

The ``multisync`` macro will transform this procedure into the following:

```nim
proc recvTwice(socket: Socket): string =
  result = ""
  result.add(socket.recv(25))
  result.add(socket.recv(20))

proc recvTwice(socket: AsyncSocket): Future[string] {.async.} =
  result = ""
  result.add(await socket.recv(25))
  result.add(await socket.recv(20))
```

Allowing you to use ``recvTwice`` with both synchronous and asynchronous sockets.

## HttpClient

Many of the ``httpclient`` module's procedures have been deprecated in
favour of a new implementation using the ``multisync`` macro. There are now
two types: ``HttpClient`` and ``AsyncHttpClient``. Both of these implement the
same procedures and functionality, the only difference is timeout support and
whether they are blocking or not.

See the [httpclient](http://nim-lang.org/docs/httpclient.html) module
documentation for more information.

## Changelog

### Changes affecting backwards compatibility

- The ``json`` module now uses an ``OrderedTable`` rather than a ``Table``
  for JSON objects.

- The [`split`` `(doc)](http://nim-lang.org/docs/strutils.html#split,string,set[char],int)
  procedure in the ``strutils`` module (with a delimiter of type
  ``set[char]``) no longer strips and splits characters out of the target string
  by the entire set of characters. Instead, it now behaves in a
  similar fashion to ``split`` with ``string`` and ``char``
  delimiters. Use ``splitWhitespace`` to get the old behaviour.

- The command invocation syntax will soon apply to open brackets
  and curlies too. This means that code like ``a [i]`` will be
  interpreted as ``a([i])`` and not as ``a[i]`` anymore. Likewise
  ``f (a, b)`` means that the tuple ``(a, b)`` is passed to ``f``.
  The compiler produces a warning for ``a [i]``::

    Warning: a [b] will be parsed as command syntax; spacing is deprecated

  See [Issue #3898](https://github.com/nim-lang/Nim/issues/3898) for the
  relevant discussion.

- Overloading the special operators ``.``, ``.()``, ``.=``, ``()`` now
  needs to be enabled via the ``{.experimental.}`` pragma.

- ``immediate`` templates and macros are now deprecated.
  Use ``untyped`` [(doc)](http://nim-lang.org/docs/manual.html#templates-typed-vs-untyped-parameters)
  parameters instead.

- The metatype ``expr`` is deprecated. Use ``untyped``
  [(doc)](http://nim-lang.org/docs/manual.html#templates-typed-vs-untyped-parameters) instead.

- The metatype ``stmt`` is deprecated. Use ``typed``
  [(doc)](http://nim-lang.org/docs/manual.html#templates-typed-vs-untyped-parameters) instead.

- The compiler is now more picky when it comes to ``tuple`` types. The
  following code used to compile, now it's rejected:

  ```nim
  import tables
  var rocketaims = initOrderedTable[string, Table[tuple[k: int8, v: int8], int64]]()
  rocketaims["hi"] = {(-1.int8, 0.int8): 0.int64}.toTable()
  ```

  Instead be consistent in your tuple usage and use tuple names for named tuples:

  ```nim
  import tables
  var rocketaims = initOrderedTable[string, Table[tuple[k: int8, v: int8], int64]]()
  rocketaims["hi"] = {(k: -1.int8, v: 0.int8): 0.int64}.toTable()
  ```

- Now when you compile console applications for Windows, console output
  encoding is automatically set to UTF-8.

- Unhandled exceptions in JavaScript are now thrown regardless of whether
  ``noUnhandledHandler`` is defined. But the stack traces should be much more
  readable now.

- In JavaScript, the ``system.alert`` procedure has been deprecated.
  Use ``dom.alert`` instead.

- De-deprecated ``re.nim`` because there is too much code using it
  and it got the basic API right.

- The type of ``headers`` field in the ``AsyncHttpClient`` type
  [(doc)](http://nim-lang.org/docs/httpclient.html#AsyncHttpClient)
  has been changed
  from a string table to the specialised ``HttpHeaders`` type.

- The ``httpclient.request``
  [(doc)](http://nim-lang.org/docs/httpclient.html#request,AsyncHttpClient,string,string,string)
  procedure which takes the ``httpMethod`` as a string
  value no longer requires it to be prefixed with ``"http"``
  (or similar).

- Converting a ``HttpMethod``
  [(doc)](nim-lang.org/docs/httpcore.html#HttpMethod)
  value to a string using the ``$`` operator will
  give string values without the ``"Http"`` prefix now.

- The ``Request``
  [(doc)](http://nim-lang.org/docs/asynchttpserver.html#Request)
  object defined in the ``asynchttpserver`` module now uses
  the ``HttpMethod`` type for the request method.

### Library Additions

- Added ``readHeaderRow`` and ``rowEntry`` to the ``parsecsv``
  [(doc)](http://nim-lang.org/docs/parsecsv.html) module
  to provide
  a lightweight alternative to python's ``csv.DictReader``.

- Added ``setStdIoUnbuffered`` proc to the ``system`` module to enable
  unbuffered I/O.

- Added ``center`` and ``rsplit`` to the ``strutils``
  [(doc)](http://nim-lang.org/docs/strutils.html) module
  to provide similar Python functionality for Nim's strings.

- Added ``isTitle``, ``title``, ``swapCase``, ``isUpper``, ``toUpper``,
  ``isLower``, ``toLower``, ``isAlpha``, ``isSpace``, and ``capitalize``
  to the ``unicode.nim``
  [(doc)](http://nim-lang.org/docs/unicode.html) module
  to provide unicode aware case manipulation and case
  testing.

- Added a new module ``strmisc``
  [(doc)](http://nim-lang.org/docs/strmisc.html)
  to hold uncommon string
  operations. Currently contains ``partition``, ``rpartition``
  and ``expandTabs``.

- Split out ``walkFiles`` in the ``os``
  [(doc)](http://nim-lang.org/docs/os.html) module to three separate procs
  in order to make a clear distinction of functionality. ``walkPattern`` iterates
  over both files and directories, while ``walkFiles`` now only iterates
  over files and ``walkDirs`` only iterates over directories.

- Added a synchronous ``HttpClient`` in the ``httpclient``
  [(doc)](http://nim-lang.org/docs/httpclient.html)
  module. The old
  ``get``, ``post`` and similar procedures are now deprecated in favour of it.

- Added a new macro called ``multisync`` allowing you to write procedures for
  synchronous and asynchronous sockets with no duplication.

- The ``async`` macro will now complete ``FutureVar[T]`` parameters
  automatically unless they have been completed already.

### Tool Additions

- The documentation is now searchable and sortable by type.
- Pragmas are now hidden by default in the documentation to reduce noise.
- Edit links are now present in the documentation.


### Compiler Additions

- The ``-d/--define`` flag can now optionally take a value to be used
  by code at compile time.
  [(doc)](http://nim-lang.org/docs/manual.html#implementation-specific-pragmas-compile-time-define-pragmas)

### Nimscript Additions

- It's possible to enable and disable specific hints and warnings in
  Nimscript via the ``warning`` and ``hint`` procedures.

- Nimscript exports  a proc named ``patchFile`` which can be used to
  patch modules or include files for different Nimble packages, including
  the ``stdlib`` package.

### Language Additions

- Added ``{.intdefine.}`` and ``{.strdefine.}`` macros to make use of
  (optional) compile time defines.
  [(doc)](http://nim-lang.org/docs/manual.html#implementation-specific-pragmas-compile-time-define-pragmas)

- If the first statement is an ``import system`` statement then ``system``
  is not imported implicitly anymore. This allows for code like
  ``import system except echo`` or ``from system import nil``.

### Bugfixes

The list below has been generated based on the commits in Nim's git
repository. As such it lists only the issues which have been closed
via a commit, for a full list see
[this link on Github](https://github.com/nim-lang/Nim/issues?utf8=%E2%9C%93&q=is%3Aissue+closed%3A%222016-06-22+..+2016-09-30%22+).

- Fixed "RFC: should startsWith and endsWith work with characters?"
  ([#4252](https://github.com/nim-lang/Nim/issues/4252))

- Fixed "Feature request: unbuffered I/O"
  ([#2146](https://github.com/nim-lang/Nim/issues/2146))
- Fixed "clear() not implemented for CountTableRef"
  ([#4325](https://github.com/nim-lang/Nim/issues/4325))
- Fixed "Cannot close file opened async"
  ([#4334](https://github.com/nim-lang/Nim/issues/4334))
- Fixed "Feature Request: IDNA support"
  ([#3045](https://github.com/nim-lang/Nim/issues/3045))
- Fixed "Async: wrong behavior of boolean operations on futures"
  ([#4333](https://github.com/nim-lang/Nim/issues/4333))
- Fixed "os.walkFiles yields directories"
  ([#4280](https://github.com/nim-lang/Nim/issues/4280))
- Fixed "Fix #4392 and progress on #4170"
  ([#4393](https://github.com/nim-lang/Nim/issues/4393))
- Fixed "Await unable to wait futures from objects fields"
  ([#4390](https://github.com/nim-lang/Nim/issues/4390))
- Fixed "TMP variable name generation should be more stable"
  ([#4364](https://github.com/nim-lang/Nim/issues/4364))
- Fixed "nativesockets doesn't compile for Android 4.x (API v19 or older) because of gethostbyaddr"
  ([#4376](https://github.com/nim-lang/Nim/issues/4376))
- Fixed "no generic parameters allowed for ref"
  ([#4395](https://github.com/nim-lang/Nim/issues/4395))
- Fixed "split proc in strutils inconsistent for set[char]"
  ([#4305](https://github.com/nim-lang/Nim/issues/4305))
- Fixed "Problem with sets in devel"
  ([#4412](https://github.com/nim-lang/Nim/issues/4412))
- Fixed "Compiler crash when using seq[PNimrodNode] in macros"
  ([#537](https://github.com/nim-lang/Nim/issues/537))
- Fixed "ospaths should be marked for nimscript use only"
  ([#4249](https://github.com/nim-lang/Nim/issues/4249))
- Fixed "Repeated deepCopy() on a recursive data structure eventually crashes"
  ([#4340](https://github.com/nim-lang/Nim/issues/4340))
- Fixed "Analyzing destructor"
  ([#4371](https://github.com/nim-lang/Nim/issues/4371))
- Fixed "getType does not work anymore on a typedesc"
  ([#4462](https://github.com/nim-lang/Nim/issues/4462))
- Fixed "Error in rendering empty JSON array"
  ([#4399](https://github.com/nim-lang/Nim/issues/4399))
- Fixed "Segmentation fault when using async pragma on generic procs"
  ([#2377](https://github.com/nim-lang/Nim/issues/2377))
- Fixed "Forwarding does not work for generics,  | produces an implicit generic"
  ([#3055](https://github.com/nim-lang/Nim/issues/3055))
- Fixed "Inside a macro, the length of the `seq` data inside a `queue` does not increase and crashes"
  ([#4422](https://github.com/nim-lang/Nim/issues/4422))
- Fixed "compiler sigsegv while processing varargs"
  ([#4475](https://github.com/nim-lang/Nim/issues/4475))
- Fixed "JS codegen - strings are assigned by reference"
  ([#4471](https://github.com/nim-lang/Nim/issues/4471))
- Fixed "when statement doesn't verify syntax"
  ([#4301](https://github.com/nim-lang/Nim/issues/4301))
- Fixed ".this pragma doesn't work with .async procs"
  ([#4358](https://github.com/nim-lang/Nim/issues/4358))
- Fixed "type foo = range(...) crashes compiler"
  ([#4429](https://github.com/nim-lang/Nim/issues/4429))
- Fixed "Compiler crash"
  ([#2730](https://github.com/nim-lang/Nim/issues/2730))
- Fixed "Crash in compiler with static[int]"
  ([#3706](https://github.com/nim-lang/Nim/issues/3706))
- Fixed "Bad error message "could not resolve""
  ([#3548](https://github.com/nim-lang/Nim/issues/3548))
- Fixed "Roof operator on string in template crashes compiler  (Error: unhandled exception: sons is not accessible [FieldError])"
  ([#3545](https://github.com/nim-lang/Nim/issues/3545))
- Fixed "SIGSEGV during compilation with parallel block"
  ([#2758](https://github.com/nim-lang/Nim/issues/2758))
- Fixed "Codegen error with template and implicit dereference"
  ([#4478](https://github.com/nim-lang/Nim/issues/4478))
- Fixed "@ in importcpp should work with no-argument functions"
  ([#4496](https://github.com/nim-lang/Nim/issues/4496))
- Fixed "Regression: findExe raises"
  ([#4497](https://github.com/nim-lang/Nim/issues/4497))
- Fixed "Linking error - repeated symbols when splitting into modules"
  ([#4485](https://github.com/nim-lang/Nim/issues/4485))
- Fixed "Error: method is not a base"
  ([#4428](https://github.com/nim-lang/Nim/issues/4428))
- Fixed "Casting from function returning a tuple fails"
  ([#4345](https://github.com/nim-lang/Nim/issues/4345))
- Fixed "clang error with default nil parameter"
  ([#4328](https://github.com/nim-lang/Nim/issues/4328))
- Fixed "internal compiler error: openArrayLoc"
  ([#888](https://github.com/nim-lang/Nim/issues/888))
- Fixed "Can't forward declare async procs"
  ([#1970](https://github.com/nim-lang/Nim/issues/1970))
- Fixed "unittest.check and sequtils.allIt do not work together"
  ([#4494](https://github.com/nim-lang/Nim/issues/4494))
- Fixed "httpclient package can't make SSL requests over an HTTP proxy"
  ([#4520](https://github.com/nim-lang/Nim/issues/4520))
- Fixed "False positive warning "declared but not used" for enums."
  ([#4510](https://github.com/nim-lang/Nim/issues/4510))
- Fixed "Explicit conversions not using converters"
  ([#4432](https://github.com/nim-lang/Nim/issues/4432))

- Fixed "Unclear error message when importing"
  ([#4541](https://github.com/nim-lang/Nim/issues/4541))
- Fixed "Change console encoding to UTF-8 by default"
  ([#4417](https://github.com/nim-lang/Nim/issues/4417))

- Fixed "Typedesc ~= Generic notation does not work anymore!"
  ([#4534](https://github.com/nim-lang/Nim/issues/4534))
- Fixed "unittest broken?"
  ([#4555](https://github.com/nim-lang/Nim/issues/4555))
- Fixed "Operator "or" in converter types seems to crash the compiler."
  ([#4537](https://github.com/nim-lang/Nim/issues/4537))
- Fixed "nimscript failed to compile/run -- Error: cannot 'importc' variable at compile time"
  ([#4561](https://github.com/nim-lang/Nim/issues/4561))
- Fixed "Regression: identifier expected, but found ..."
  ([#4564](https://github.com/nim-lang/Nim/issues/4564))
- Fixed "varargs with transformation that takes var argument creates invalid c code"
  ([#4545](https://github.com/nim-lang/Nim/issues/4545))
- Fixed "Type mismatch when using empty tuple as generic parameter"
  ([#4550](https://github.com/nim-lang/Nim/issues/4550))
- Fixed "strscans"
  ([#4562](https://github.com/nim-lang/Nim/issues/4562))
- Fixed "getTypeImpl crashes (SIGSEGV) on variant types"
  ([#4526](https://github.com/nim-lang/Nim/issues/4526))
- Fixed "Wrong result of sort in VM"
  ([#4065](https://github.com/nim-lang/Nim/issues/4065))
- Fixed "I can't call the random[T](x: Slice[T]): T"
  ([#4353](https://github.com/nim-lang/Nim/issues/4353))
- Fixed "invalid C code generated (function + block + empty tuple)"
  ([#4505](https://github.com/nim-lang/Nim/issues/4505))

- Fixed "performance issue: const Table make a copy at runtime lookup."
  ([#4354](https://github.com/nim-lang/Nim/issues/4354))
- Fixed "Compiler issue: libraries without absolute paths cannot be found correctly"
  ([#4568](https://github.com/nim-lang/Nim/issues/4568))
- Fixed "Cannot use math.`^` with non-int types."
  ([#4574](https://github.com/nim-lang/Nim/issues/4574))
- Fixed "C codegen fails when constructing an array using an object constructor."
  ([#4582](https://github.com/nim-lang/Nim/issues/4582))
- Fixed "Visual Studio 10 unresolved external symbol _trunc(should we support VS2010?)"
  ([#4532](https://github.com/nim-lang/Nim/issues/4532))
- Fixed "Cannot pass generic subtypes to proc for generic supertype"
  ([#4528](https://github.com/nim-lang/Nim/issues/4528))
- Fixed "Lamda-lifting bug leading to crash."
  ([#4551](https://github.com/nim-lang/Nim/issues/4551))
- Fixed "First-class iterators declared as inline are compiled at Nim side (no error message) and fail at C"
  ([#2094](https://github.com/nim-lang/Nim/issues/2094))
- Fixed "VS2010-warning C4090 : 'function' : different 'const' qualifiers"
  ([#4590](https://github.com/nim-lang/Nim/issues/4590))
- Fixed "Regression: type mismatch with generics"
  ([#4589](https://github.com/nim-lang/Nim/issues/4589))
- Fixed "„can raise an unlisted exception“ when assigning nil as default value"
  ([#4593](https://github.com/nim-lang/Nim/issues/4593))
- Fixed "upcoming asyncdispatch.closeSocket is not GC-safe"
  ([#4606](https://github.com/nim-lang/Nim/issues/4606))
- Fixed "Visual Studio 10.0 compiler errors, 12.0 warning"
  ([#4459](https://github.com/nim-lang/Nim/issues/4459))
- Fixed "Exception of net.newContext: result.extraInternalIndex == 0  [AssertionError]"
  ([#4406](https://github.com/nim-lang/Nim/issues/4406))
- Fixed "error: redeclaration of 'result_115076' with no linkage"
  ([#3221](https://github.com/nim-lang/Nim/issues/3221))
- Fixed "Compiler crashes on conversion from int to float at compile time"
  ([#4619](https://github.com/nim-lang/Nim/issues/4619))
- Fixed "wrong number of arguments regression in devel"
  ([#4600](https://github.com/nim-lang/Nim/issues/4600))
- Fixed "importc $ has broken error message (and is not documented)"
  ([#4579](https://github.com/nim-lang/Nim/issues/4579))
- Fixed "Compiler segfaults on simple importcpp in js mode [regression]"
  ([#4632](https://github.com/nim-lang/Nim/issues/4632))
- Fixed "Critical reference counting codegen problem"
  ([#4653](https://github.com/nim-lang/Nim/issues/4653))
- Fixed "tables.nim needs lots of {.noSideEffect.}"
  ([#4254](https://github.com/nim-lang/Nim/issues/4254))
- Fixed "Capture variable error when using ``=>`` macro"
  ([#4658](https://github.com/nim-lang/Nim/issues/4658))
- Fixed "Enum from char: internal error getInt"
  ([#3606](https://github.com/nim-lang/Nim/issues/3606))
- Fixed "Compiler crashes in debug mode (no error in release mode) with Natural discriminant in object variants"
  ([#2865](https://github.com/nim-lang/Nim/issues/2865))
- Fixed "SIGSEGV when access field in const object variants"
  ([#4253](https://github.com/nim-lang/Nim/issues/4253))
- Fixed "varargs cannot be used with template converter."
  ([#4292](https://github.com/nim-lang/Nim/issues/4292))
- Fixed "Compiler crashes when borrowing $"
  ([#3928](https://github.com/nim-lang/Nim/issues/3928))
- Fixed "internal error: genMagicExpr: mArrPut"
  ([#4491](https://github.com/nim-lang/Nim/issues/4491))
- Fixed "Unhelpful error message on importc namespace collision"
  ([#4580](https://github.com/nim-lang/Nim/issues/4580))
- Fixed "Problem with openarrays and slices"
  ([#4179](https://github.com/nim-lang/Nim/issues/4179))
- Fixed "Removing lines from end of file then rebuilding does not rebuild [js only?]"
  ([#4656](https://github.com/nim-lang/Nim/issues/4656))
- Fixed "getCurrentException and getCurrentExceptionMsg do not work with JS"
  ([#4635](https://github.com/nim-lang/Nim/issues/4635))
- Fixed "generic proc parameter is not inferred if type parameter has specifier"
  ([#4672](https://github.com/nim-lang/Nim/issues/4672))
- Fixed "Cannot instantiate generic parameter when it is parent type parameter"
  ([#4673](https://github.com/nim-lang/Nim/issues/4673))
- Fixed "deepCopy doesn't work with inheritance after last commit"
  ([#4693](https://github.com/nim-lang/Nim/issues/4693))
- Fixed "Multi-methods don't work when passing ref to a different thread"
  ([#4689](https://github.com/nim-lang/Nim/issues/4689))
- Fixed "Infinite loop in effect analysis on generics"
  ([#4677](https://github.com/nim-lang/Nim/issues/4677))
- Fixed "SIGSEGV when compiling NimYAML tests"
  ([#4699](https://github.com/nim-lang/Nim/issues/4699))

- Fixed "Closing AsyncEvent now also unregisters it on non-Windows platforms"
  ([#4694](https://github.com/nim-lang/Nim/issues/4694))
- Fixed "Don't update handle in upcoming/asyncdispatch poll() if it was closed"
  ([#4697](https://github.com/nim-lang/Nim/issues/4697))
- Fixed "generated local variables declared outside block"
  ([#4721](https://github.com/nim-lang/Nim/issues/4721))
- Fixed "Footer Documentation links, & Community link point to the wrong place under news entries"
  ([#4529](https://github.com/nim-lang/Nim/issues/4529))
- Fixed "Jester's macro magic leads to incorrect C generation"
  ([#4088](https://github.com/nim-lang/Nim/issues/4088))
- Fixed "cas bug in atomics.nim"
  ([#3279](https://github.com/nim-lang/Nim/issues/3279))
- Fixed "nimgrep PEG not capturing the pattern 'A'"
  ([#4751](https://github.com/nim-lang/Nim/issues/4751))
- Fixed "GC assert triggers when assigning TableRef threadvar"
  ([#4640](https://github.com/nim-lang/Nim/issues/4640))
- Fixed ".this pragma conflicts with experimental ptr dereferencing when names conflict"
  ([#4671](https://github.com/nim-lang/Nim/issues/4671))
- Fixed "Generic procs accepting var .importcpp type do not work [regression]"
  ([#4625](https://github.com/nim-lang/Nim/issues/4625))
- Fixed "C Error on tuple assignment with array"
  ([#4626](https://github.com/nim-lang/Nim/issues/4626))
- Fixed "module securehash not gcsafe"
  ([#4760](https://github.com/nim-lang/Nim/issues/4760))

- Fixed "Nimble installation failed on Windows x86."
  ([#4764](https://github.com/nim-lang/Nim/issues/4764))
- Fixed "Recent changes to marshal module break old marshalled data"
  ([#4779](https://github.com/nim-lang/Nim/issues/4779))
- Fixed "tnewasyncudp.nim test loops forever"
  ([#4777](https://github.com/nim-lang/Nim/issues/4777))
- Fixed "Wrong poll timeout behavior in asyncdispatch"
  ([#4262](https://github.com/nim-lang/Nim/issues/4262))
- Fixed "Standalone await shouldn't read future"
  ([#4170](https://github.com/nim-lang/Nim/issues/4170))
- Fixed "Regression: httpclient fails to compile without -d:ssl"
  ([#4797](https://github.com/nim-lang/Nim/issues/4797))
- Fixed "C Error on declaring array of heritable objects with bitfields"
  ([#3567](https://github.com/nim-lang/Nim/issues/3567))
- Fixed "Corruption when using Channels and Threads"
  ([#4776](https://github.com/nim-lang/Nim/issues/4776))
- Fixed "Sometimes Channel tryRecv() erroneously reports no messages available on the first call on Windows"
  ([#4746](https://github.com/nim-lang/Nim/issues/4746))
- Fixed "Improve error message of functions called without parenthesis"
  ([#4813](https://github.com/nim-lang/Nim/issues/4813))
- Fixed "Docgen doesn't find doc comments in macro generated procs"
  ([#4803](https://github.com/nim-lang/Nim/issues/4803))
- Fixed "asynchttpserver may consume unbounded memory reading headers"
  ([#3847](https://github.com/nim-lang/Nim/issues/3847))
- Fixed "TLS connection to api.clashofclans.com hangs forever."
  ([#4587](https://github.com/nim-lang/Nim/issues/4587))
