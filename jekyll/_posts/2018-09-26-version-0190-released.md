---
title: "Version 0.19.0 released"
author: The Nim Team
---

The Nim team is happy to announce that the latest release of Nim,
version 0.19.0, is now available. Nim is a systems programming language that
focuses on performance, portability and expressiveness.

# Installing 0.19.0

If you have installed a previous version of Nim using ``choosenim``,
getting Nim 0.19.0 is as easy as:

```bash
$ choosenim update stable
```

If you don't have it already, you can get ``choosenim`` by following
[these instructions](https://github.com/dom96/choosenim) or you can install
Nim by following the instructions on our
[install](https://nim-lang.org/install.html) page.


# What's new in 0.19.0

The ``nil`` state for strings/seqs is gone. Instead the default value for
these is ``"" / @[]``. Use ``--nilseqs:on`` for a transition period. This
eliminates a large class of bugs that used to plague the average Nim code
out there, including Nim's standard library.

Accessing the binary zero terminator in Nim's native strings
is now invalid. Internally a Nim string still has the trailing zero for
zero-copy interoperability with ``cstring``. Compile your code with the
new switch ``--laxStrings:on`` if you need a transition period.

These changes to strings and seqs give us more flexibility in how they
are implemented and indeed alternative implementations are in development.

``experimental`` is now a pragma and a command line switch that can enable
specific language extensions, it is not an all-or-nothing switch anymore.
We think this leads to a more robust development process where it's clearly
documented which parts of Nim are bleeding edge and which parts can be relied
upon.

Other notable language additions:

- Dot calls combined with explicit generic instantiations can now be written
  as ``x.y[:z]`` which is transformed into ``y[z](x)`` by the parser.
- ``func`` is now an alias for ``proc {.noSideEffect.}``.
- Anonymous tuples with a single element can now be written as ``(1,)`` with a
  trailing comma.

- In order to make ``for`` loops and iterators more flexible to use Nim now
  supports so called "for-loop macros". See
  the [manual](https://nim-lang.org/docs/manual.html#macros-for-loop-macros) for more details.
  This feature enables a Python-like generic ``enumerate`` implementation.

- Case statements can now be rewritten via macros. See the [manual](https://nim-lang.org/docs/manual.html#macros-case-statement-macros) for more information.
  This feature enables custom pattern matching.

- The command syntax now supports keyword arguments after the first comma.

- Thread-local variables can now be declared inside procs. This implies all
  the effects of the ``global`` pragma.

- Nim now supports the ``except`` clause in the ``export`` statement.

- Range float types, example ``range[0.0 .. Inf]``. More details in language manual.


## Breaking changes to be mindful of

- The default location of ``nimcache`` for the native code targets was
  changed. Read [the compiler user guide](https://nim-lang.org/docs/nimc.html#generated-c-code-directory)
  for more information.
- Lots of deprecated symbols in the standard library that have been deprecated for
  quite some time now like ``system.expr`` or the old type aliases starting with a ``T``
  or ``P`` prefix have been removed.
- The exception hierarchy was slightly reworked, ``SystemError`` was renamed to
  ``CatchableError`` and is the new base class for any exception that is guaranteed to
  be catchable. This change should have minimal impact on most existing Nim code.


## Async improvements

The "closure iterators" that Nim's ``async`` macro is based on has been
rewritten from the ground up and so ``async`` works completely with
exception handling. Finally it is possible to use ``await`` in a ``try``
statement!


## Nimble 0.9.0

This release includes a brand new version of Nimble. The new version
contains a breaking change which you should read up on if you own
hybrid packages. There are also the usual bug fixes and this release
contains a lot of them.

For more information, see the
[Nimble v0.9.0 changelog](https://github.com/nim-lang/nimble/blob/master/changelog.markdown#090---19092018).

## Contributors to v0.19.0

Our contributors are amazing, and there is
[far too many](https://github.com/nim-lang/Nim/graphs/contributors) to list
here. Big thanks to all of you, we couldn't have pulled off this release
without you!

# Changelog

## Changes affecting backwards compatibility

### Breaking changes in the standard library

- ``re.split`` for empty regular expressions now yields every character in
  the string which is what other programming languages chose to do.
- The returned tuple of ``system.instantiationInfo`` now has a third field
  containing the column of the instantiation.

- ``cookies.setCookie`` no longer assumes UTC for the expiration date.
- ``strutils.formatEng`` does not distinguish between ``nil`` and ``""``
  strings anymore for its ``unit`` parameter. Instead the space is controlled
  by a new parameter ``useUnitSpace``.

- The ``times.parse`` and ``times.format`` procs have been rewritten.
  The proc signatures are the same so it should generally not break anything.
  However, the new implementation is a bit stricter, which is a breaking change.
  For example ``parse("2017-01-01 foo", "yyyy-MM-dd")`` will now raise an error.

- ``proc `-`*(a, b: Time): int64`` in the ``times`` module has changed return type
  to ``times.Duration`` in order to support higher time resolutions.
  The proc is no longer deprecated.

- The ``times.Timezone`` is now an immutable ref-type that must be initialized
  with an explicit constructor (``newTimezone``).

- ``posix.Timeval.tv_sec`` has changed type to ``posix.Time``.

- ``math.`mod` `` for floats now behaves the same as ``mod`` for integers
  (previously it used floor division like Python). Use ``math.floorMod`` for the old behavior.

- For string inputs, ``unicode.isUpper`` and ``unicode.isLower`` now require a
  second mandatory parameter ``skipNonAlpha``.

- For string inputs, ``strutils.isUpperAscii`` and ``strutils.isLowerAscii`` now
  require a second mandatory parameter ``skipNonAlpha``.

- ``osLastError`` is now marked with ``sideEffect``
- The procs ``parseHexInt`` and ``parseOctInt`` now fail on empty strings
  and strings containing only valid prefixes, e.g. "0x" for hex integers.

- ``terminal.setCursorPos`` and ``terminal.setCursorXPos`` now work correctly
  with 0-based coordinates on POSIX (previously, you needed to use
  1-based coordinates on POSIX for correct behaviour; the Windows behaviour
  was always correct).

- ``lineInfoObj`` now returns absolute path instead of project path.
  It's used by ``lineInfo``, ``check``, ``expect``, ``require``, etc.

- ``net.sendTo`` no longer returns an int and now raises an ``OSError``.
- `threadpool`'s `await` and derivatives have been renamed to `blockUntil`
  to avoid confusions with `await` from the `async` macro.



## Library additions

- ``re.split`` now also supports the ``maxsplit`` parameter for consistency
  with ``strutils.split``.
- Added ``system.toOpenArray`` in order to support zero-copy slicing
  operations. This is currently not yet available for the JavaScript target.
- Added ``getCurrentDir``, ``findExe``, ``cpDir`` and  ``mvDir`` procs to
  ``nimscript``.
- The ``times`` module now supports up to nanosecond time resolution when available.
- Added the type ``times.Duration`` for representing fixed durations of time.
- Added the proc ``times.convert`` for converting between different time units,
  e.g days to seconds.
- Added the proc ``algorithm.binarySearch[T, K]`` with the ```cmp``` parameter.
- Added the proc ``algorithm.upperBound``.
- Added inverse hyperbolic functions, ``math.arcsinh``, ``math.arccosh`` and ``math.arctanh`` procs.
- Added cotangent, secant and cosecant procs ``math.cot``, ``math.sec`` and ``math.csc``; and their hyperbolic, inverse and inverse hyperbolic functions, ``math.coth``, ``math.sech``, ``math.csch``, ``math.arccot``, ``math.arcsec``, ``math.arccsc``, ``math.arccoth``, ``math.arcsech`` and ``math.arccsch`` procs.
- Added the procs ``math.floorMod`` and ``math.floorDiv`` for floor based integer division.
- Added the procs ``rationals.`div```, ``rationals.`mod```, ``rationals.floorDiv`` and ``rationals.floorMod`` for rationals.
- Added the proc ``math.prod`` for product of elements in an openArray.
- Added the proc ``parseBinInt`` to parse a binary integer from a string, which returns the value.
- ``parseOct`` and ``parseBin`` in parseutils now also support the ``maxLen`` argument similar to ``parseHexInt``.
- Added the proc ``flush`` for memory mapped files.
- Added the ``MemMapFileStream``.
- Added a simple interpreting event parser template ``eventParser`` to the ``pegs`` module.
- Added ``macros.copyLineInfo`` to copy lineInfo from other node.
- Added ``system.ashr`` an arithmetic right shift for integers.


## Library changes

- The stdlib module ``future`` has been renamed to ``sugar``.
- ``macros.callsite`` is now deprecated. Since the introduction of ``varargs``
  parameters this became unnecessary.

- ``macros.astGenRepr``, ``macros.lispRepr`` and ``macros.treeRepr``
  now escapes the content of string literals consistently.
- ``macros.NimSym`` and ``macros.NimIdent`` is now deprecated in favor
  of the more general ``NimNode``.
- ``macros.getImpl`` now includes the pragmas of types, instead of omitting them.
- ``macros.hasCustomPragma`` and ``macros.getCustomPragmaVal`` now
  also support ``ref`` and ``ptr`` types, pragmas on types and variant
  fields.
- ``system.SomeReal`` is now called ``SomeFloat`` for consistency and
  correctness.
- ``algorithm.smartBinarySearch`` and ``algorithm.binarySearch`` is
  now joined in ``binarySearch``. ``smartbinarySearch`` is now
  deprecated.
- The `terminal` module now exports additional procs for generating ANSI color
  codes as strings.
- Added the parameter ``val`` for the ``CritBitTree[int].inc`` proc.
- An exception raised from a ``test`` block of ``unittest`` now shows its type in
  error message.
- The ``compiler/nimeval`` API was rewritten to simplify the "compiler as an
  API". Using the Nim compiler and its VM as a scripting engine has never been
  easier. See ``tests/compilerapi/tcompilerapi.nim`` for an example of how to
  use the Nim VM in a native Nim application.
- Added the parameter ``val`` for the ``CritBitTree[T].incl`` proc.
- The proc ``tgamma`` was renamed to ``gamma``. ``tgamma`` is deprecated.
- The ``pegs`` module now exports getters for the fields of its ``Peg`` and ``NonTerminal``
  object types. ``Peg``s with child nodes now have the standard ``items`` and ``pairs``
  iterators.
- The ``accept`` socket procedure defined in the ``net`` module can now accept
  a nil socket.


## Language additions

- Dot calls combined with explicit generic instantiations can now be written
  as ``x.y[:z]`` which is transformed into ``y[z](x)`` by the parser.
- ``func`` is now an alias for ``proc {.noSideEffect.}``.
- In order to make ``for`` loops and iterators more flexible to use Nim now
  supports so called "for-loop macros". See
  the [manual](https://nim-lang.org/docs/manual.html#macros-for-loop-macros) for more details.
  This feature enables a Python-like generic ``enumerate`` implementation.

- Case statements can now be rewritten via macros. See the [manual](https://nim-lang.org/docs/manual.html#macros-case-statement-macros) for more information.
  This feature enables custom pattern matchers.

- the `typedesc` special type has been renamed to just `type`.
- `static` and `type` are now also modifiers similar to `ref` and `ptr`.
  They denote the special types `static[T]` and `type[T]`.
- Forcing compile-time evaluation with `static` now supports specifying
  the desired target type (as a concrete type or as a type class)
- The `type` operator now supports checking that the supplied expression
  matches an expected type constraint.


## Language changes

- Anonymous tuples with a single element can now be written as ``(1,)`` with a
  trailing comma. The underlying AST is ``nnkTupleConstr(newLit 1)`` for this
  example. ``nnkTupleConstr`` is a new node kind your macros need to be able
  to deal with!
- Indexing into a ``cstring`` for the JS target is now mapped
  to ``charCodeAt``.
- Assignments that would "slice" an object into its supertype are now prevented
  at runtime. Use ``ref object`` with inheritance rather than ``object`` with
  inheritance to prevent this issue.
- The ``not nil`` type annotation now has to be enabled explicitly
  via ``{.experimental: "notnil"}`` as we are still not pleased with how this
  feature works with Nim's containers.
- The parser now warns about inconsistent spacing around binary operators as
  these can easily be confused with unary operators. This warning will likely
  become an error in the future.
- The ``'c`` and ``'C'`` suffix for octal literals is now deprecated to
  bring the language in line with the standard library (e.g. ``parseOct``).
- The dot style for import paths (e.g ``import path.to.module`` instead of
  ``import path/to/module``) has been deprecated.

- The `importcpp` pragma now allows importing the listed fields of generic
  C++ types. Support for numeric parameters have also been added through
  the use of `static[T]` types.
  (#6415)

- Native C++ exceptions can now be imported with `importcpp` pragma.
  Imported exceptions can be raised and caught just like Nim exceptions.
  More details in language manual.

- ``nil`` for strings/seqs is finally gone. Instead the default value for
  these is ``"" / @[]``. Use ``--nilseqs:on`` for a transition period.

- Accessing the binary zero terminator in Nim's native strings
  is now invalid. Internally a Nim string still has the trailing zero for
  zero-copy interoperability with ``cstring``. Compile your code with the
  new switch ``--laxStrings:on`` if you need a transition period.

- The command syntax now supports keyword arguments after the first comma.

- Thread-local variables can now be declared inside procs. This implies all
  the effects of the ``global`` pragma.

- Nim now supports the ``except`` clause in the export statement.

- Range checked floating point types, for example ``range[0.0 .. Inf]``,
  are now supported.
- The ``{.this.}`` pragma has been deprecated. It never worked within generics and
  we found the resulting code harder to read than the more explicit ``obj.field``
  syntax.
- "Memory regions" for pointer types have been deprecated, they were hardly used
  anywhere. Note that this has **nothing** to do with the ``--gc:regions`` switch
  of managing memory.

- The exception hierarchy was slightly reworked, ``SystemError`` was renamed to
  ``CatchableError`` and is the new base class for any exception that is guaranteed to
  be catchable. This change should have minimal impact on most existing Nim code.


### Tool changes

- ``jsondoc2`` has been renamed ``jsondoc``, similar to how ``doc2`` was renamed
  ``doc``. The old ``jsondoc`` can still be invoked with ``jsondoc0``.

### Compiler changes

- The undocumented ``#? braces`` parsing mode was removed.
- The undocumented PHP backend was removed.

- The VM's instruction count limit was raised to 3 million instructions in
  order to support more complex computations at compile-time.

- Support for hot code reloading has been implemented for the JavaScript
  target. To use it, compile your code with `--hotCodeReloading:on` and use a
  helper library such as LiveReload or BrowserSync.

- A new compiler option `--cppCompileToNamespace` puts the generated C++ code
  into the namespace "Nim" in order to avoid naming conflicts with existing
  C++ code. This is done for all Nim code - internal and exported.

- Added ``macros.getProjectPath`` and ``ospaths.putEnv`` procs to Nim's virtual
  machine.

- The ``deadCodeElim`` option is now always turned on and the switch has no
  effect anymore, but is recognized for backwards compatibility.

- ``experimental`` is now a pragma / command line switch that can enable specific
  language extensions, it is not an all-or-nothing switch anymore.

- Nintendo Switch was added as a new platform target. See [the compiler user guide](https://nim-lang.org/docs/nimc.html)
  for more info.

- macros.bindSym now capable to accepts not only literal string or string constant expression.
  bindSym enhancement make it also can accepts computed string or ident node inside macros /
  compile time functions / static blocks. Only in templates / regular code it retains it's
  old behavior.
  This new feature can be accessed via {.experimental: "dynamicBindSym".} pragma/switch.

- On Posix systems the global system wide configuration is now put under ``/etc/nim/nim.cfg``,
  it used to be ``/etc/nim.cfg``. Usually it does not exist, however.

- On Posix systems the user configuration is now looked under ``$XDG_CONFIG_HOME/nim/nim.cfg``
  (if ``XDG_CONFIG_HOME`` is not defined, then under ``~/.config/nim/nim.cfg``). It used to be
  ``$XDG_CONFIG_DIR/nim.cfg`` (and ``~/.config/nim.cfg``).

  Similarly, on Windows, the user configuration is now looked under ``%APPDATA%/nim/nim.cfg``.
  This used to be ``%APPDATA%/nim.cfg``.


## Bugfixes

- Fixed "constructor pragma leads to "Most Vexing Parse" in c++ code gen"
  ([#6837](https://github.com/nim-lang/Nim/issues/6837))

- Fixed "[RFC] newFileStream(string, FileMode) returns nil"
  ([#5588](https://github.com/nim-lang/Nim/issues/5588))
- Fixed "Search feature doesn't work on all docs pages "
  ([#7294](https://github.com/nim-lang/Nim/issues/7294))
- Fixed "Wrong comparison with empty string in version 0.18"
  ([#7291](https://github.com/nim-lang/Nim/issues/7291))
- Fixed "doc2 css troubles"
  ([#5293](https://github.com/nim-lang/Nim/issues/5293))
- Fixed "SIGSEGV when passing empty array to strutils format"
  ([#7293](https://github.com/nim-lang/Nim/issues/7293))
- Fixed "strip() weird behavior "
  ([#7159](https://github.com/nim-lang/Nim/issues/7159))
- Fixed "On Windows: When app type is GUI, error message can't be seen, about missing DLL file or procedure"
  ([#7212](https://github.com/nim-lang/Nim/issues/7212))
- Fixed "Compiler crash: multiple exception types with infix as"
  ([#7115](https://github.com/nim-lang/Nim/issues/7115))
- Fixed "C++ template object: Internal Error mangleRecFieldName"
  ([#6415](https://github.com/nim-lang/Nim/issues/6415))
- Fixed "Undefined Behavior when using const/let tables (Nim v0.18.1)"
  ([#7332](https://github.com/nim-lang/Nim/issues/7332))
- Fixed "Codegen: forward type declarations can be used more aggressively"
  ([#7339](https://github.com/nim-lang/Nim/issues/7339))
- Fixed "asyncfile getFileSize issue in linux"
  ([#7347](https://github.com/nim-lang/Nim/issues/7347))
- Fixed "Compiler manual is not that clear about int literal"
  ([#7304](https://github.com/nim-lang/Nim/issues/7304))
- Fixed "Bad error message when writing to a data structure within read-only object"
  ([#7335](https://github.com/nim-lang/Nim/issues/7335))
- Fixed "Compiler crash using @[int]"
  ([#7331](https://github.com/nim-lang/Nim/issues/7331))
- Fixed "Redefinition of object in C when a proc with sink param is defined."
  ([#7364](https://github.com/nim-lang/Nim/issues/7364))
- Fixed "[Regression] Missing type declarations in C code if members are used in {.emit.}"
  ([#7363](https://github.com/nim-lang/Nim/issues/7363))
- Fixed "(regression) dereferencing pointer to incomplete type"
  ([#7392](https://github.com/nim-lang/Nim/issues/7392))
- Fixed "In nested try statements finally is not executed"
  ([#7414](https://github.com/nim-lang/Nim/issues/7414))
- Fixed "json.to doesn't work when Option[T] is inside an array"
  ([#7433](https://github.com/nim-lang/Nim/issues/7433))
- Fixed "https://nim-lang.org/docs/lib.html => If you are reading this you are missing nimblepkglist.js..."
  ([#7400](https://github.com/nim-lang/Nim/issues/7400))
- Fixed "json.to and Option[T] fails on JNull in JSON list literal"
  ([#6902](https://github.com/nim-lang/Nim/issues/6902))
- Fixed "inconsistent escaping of string literals"
  ([#7473](https://github.com/nim-lang/Nim/issues/7473))
- Fixed "streams.readLine(): string should raise IOError, but doesn't"
  ([#5281](https://github.com/nim-lang/Nim/issues/5281))

- Fixed "Duplicate definition in cpp codegen"
  ([#6986](https://github.com/nim-lang/Nim/issues/6986))
- Fixed "error at compile-time when case branch has implicit return"
  ([#7407](https://github.com/nim-lang/Nim/issues/7407))
- Fixed "Still some issues with Static[T]"
  ([#6843](https://github.com/nim-lang/Nim/issues/6843))
- Fixed "[regression] compiler/nimeval `execute("echo 1")` => Error: cannot 'importc' variable at compile time"
  ([#7522](https://github.com/nim-lang/Nim/issues/7522))
- Fixed "Too many digits from float32 to string"
  ([#7252](https://github.com/nim-lang/Nim/issues/7252))
- Fixed "SIGSEGV: Illegal storage access. (Attempt to read from nil?)"
  ([#7528](https://github.com/nim-lang/Nim/issues/7528))
- Fixed "Catching C++ exceptions in Nim"
  ([#3571](https://github.com/nim-lang/Nim/issues/3571))
- Fixed "[RFC] Naming convention for in-place mutating procs"
  ([#7551](https://github.com/nim-lang/Nim/issues/7551))
- Fixed "Compiler SIGSEGV when trying to use invalid subrange type"
  ([#6895](https://github.com/nim-lang/Nim/issues/6895))
- Fixed "Internal error: invalid kind for first(tyTuple) with parallel block"
  ([#2779](https://github.com/nim-lang/Nim/issues/2779))
- Fixed "type checking issue when using an empty sequence embedded in a table"
  ([#3948](https://github.com/nim-lang/Nim/issues/3948))
- Fixed "Deprecate ``callsite`` builtin"
  ([#7369](https://github.com/nim-lang/Nim/issues/7369))
- Fixed "JS codegen - indexing into cstring."
  ([#4470](https://github.com/nim-lang/Nim/issues/4470))

- Fixed "strutils.formatEng relies on a distinction of "" and nil string"
  ([#6205](https://github.com/nim-lang/Nim/issues/6205))
- Fixed "timeToTimeInfo issue"
  ([#3678](https://github.com/nim-lang/Nim/issues/3678))
- Fixed "checking object type for a pragma is not possible"
  ([#7451](https://github.com/nim-lang/Nim/issues/7451))
- Fixed "nnkBracketExpr.newTree now returns tuple of NimNodes breaking newTree chaining"
  ([#7610](https://github.com/nim-lang/Nim/issues/7610))

- Fixed ""newNilLitNode" printed when some objects' AST is dumped shold be "newNilLit""
  ([#7595](https://github.com/nim-lang/Nim/issues/7595))

- Fixed "string.replace() should throw an error when used with an empty string"
  ([#7507](https://github.com/nim-lang/Nim/issues/7507))
- Fixed "Threadpool `awaitAny()` problem on macOS"
  ([#7638](https://github.com/nim-lang/Nim/issues/7638))
- Fixed "TLineInfo on windows 32bit"
  ([#7654](https://github.com/nim-lang/Nim/issues/7654))
- Fixed "Object slicing can bite our arses"
  ([#7637](https://github.com/nim-lang/Nim/issues/7637))
- Fixed "A warning for unused but conflicting procs would be nice"
  ([#6393](https://github.com/nim-lang/Nim/issues/6393))
- Fixed "Using var return types will result in segfaults in some cases"
  ([#5113](https://github.com/nim-lang/Nim/issues/5113))
- Fixed "Borrowing for ``var T`` and ``lent T`` to improve Nim's memory safety"
  ([#7373](https://github.com/nim-lang/Nim/issues/7373))
- Fixed "Documentation/implementation mismatch for --genScript flag"
  ([#802](https://github.com/nim-lang/Nim/issues/802))
- Fixed "httpclient.generateHeaders() not setting Content-Length if body.len=0"
  ([#7680](https://github.com/nim-lang/Nim/issues/7680))
- Fixed "generic object descended from generic ref object sigmatch bug"
  ([#7600](https://github.com/nim-lang/Nim/issues/7600))
- Fixed "array construction of ptr generic object with subtype relation failed"
  ([#7601](https://github.com/nim-lang/Nim/issues/7601))
- Fixed "ambiguously typed/tuple combination with auto result type leads to a compile-time crash with SIGSEGV"
  ([#7663](https://github.com/nim-lang/Nim/issues/7663))
- Fixed "nim --linedir:on c file segfaults"
  ([#7730](https://github.com/nim-lang/Nim/issues/7730))
- Fixed "Better compiler warning/error messages"
  ([#7749](https://github.com/nim-lang/Nim/issues/7749))

- Fixed "Issues with finish.exe"
  ([#7747](https://github.com/nim-lang/Nim/issues/7747))

- Fixed "changed "encodeUrl" in lib/pure/uri.nim."
  ([#7700](https://github.com/nim-lang/Nim/issues/7700))
- Fixed "Unexpected import required"
  ([#7738](https://github.com/nim-lang/Nim/issues/7738))
- Fixed "Strange interaction of add for string without explicit initialization"
  ([#7766](https://github.com/nim-lang/Nim/issues/7766))
- Fixed "Command invocation syntax doesn't work with unary operators"
  ([#7582](https://github.com/nim-lang/Nim/issues/7582))
- Fixed "Command invocation syntax doesn't work with unary operators"
  ([#7582](https://github.com/nim-lang/Nim/issues/7582))
- Fixed "3x performance regression"
  ([#7743](https://github.com/nim-lang/Nim/issues/7743))
- Fixed "seq is still nil in compile time"
  ([#7774](https://github.com/nim-lang/Nim/issues/7774))
- Fixed "Compiler segfault on sink proc for type with destructor under special condition"
  ([#7757](https://github.com/nim-lang/Nim/issues/7757))
- Fixed "Windows getch() does not correctly account for control keys"
  ([#7764](https://github.com/nim-lang/Nim/issues/7764))
- Fixed "thread local variable `threadvar` not working as expected (differs from C++ thread_local and D static)"
  ([#7565](https://github.com/nim-lang/Nim/issues/7565))
- Fixed "Setting a timeout causes assertion failures in httpclient"
  ([#2753](https://github.com/nim-lang/Nim/issues/2753))
- Fixed "Can't convert expression when surrounded with parens using %*"
  ([#7817](https://github.com/nim-lang/Nim/issues/7817))
- Fixed "Line number missing in stdlib trace"
  ([#6832](https://github.com/nim-lang/Nim/issues/6832))
- Fixed "Filter skips lines with only single character"
  ([#7855](https://github.com/nim-lang/Nim/issues/7855))
- Fixed "[regression] nimscript.task crash the compiler"
  ([#7696](https://github.com/nim-lang/Nim/issues/7696))
- Fixed "IndexError in streams.readStr()"
  ([#7877](https://github.com/nim-lang/Nim/issues/7877))
- Fixed "IndexError in streams.readStr()"
  ([#7877](https://github.com/nim-lang/Nim/issues/7877))
- Fixed "generic "Error: cannot instantiate: 'T'" with overload(regression)"
  ([#7883](https://github.com/nim-lang/Nim/issues/7883))
- Fixed "marshal.store generates invalid JSON"
  ([#7881](https://github.com/nim-lang/Nim/issues/7881))
- Fixed "inconsistent internal representation of generic objects array construction"
  ([#7818](https://github.com/nim-lang/Nim/issues/7818))
- Fixed "There's no `$` for openArray"
  ([#7940](https://github.com/nim-lang/Nim/issues/7940))
- Fixed "array and openarray arg vs. ptr/ref generic polymorphic issue"
  ([#7906](https://github.com/nim-lang/Nim/issues/7906))
- Fixed "Yield in try generate stack error "
  ([#7969](https://github.com/nim-lang/Nim/issues/7969))
- Fixed "Bad codegen (runtime crash) when catching exceptions in a proc with no stack trace"
  ([#7982](https://github.com/nim-lang/Nim/issues/7982))
- Fixed "`$` doesn't work for CritBitTree[void]"
  ([#7987](https://github.com/nim-lang/Nim/issues/7987))
- Fixed "Assertion  at runtime with await and json.to()"
  ([#7985](https://github.com/nim-lang/Nim/issues/7985))
- Fixed "[critbits[int]] When using `inc` to add new keys, only the first added key gets the value 1"
  ([#7990](https://github.com/nim-lang/Nim/issues/7990))
- Fixed "Error: obsolete usage of 'defined', use 'declared' instead"
  ([#7997](https://github.com/nim-lang/Nim/issues/7997))

- Fixed "C++ codegen: importcpp breaks for generic types."
  ([#7653](https://github.com/nim-lang/Nim/issues/7653))
- Fixed "Bad line info in async code"
  ([#6803](https://github.com/nim-lang/Nim/issues/6803))
- Fixed "tmacrostmt immediate pragma cannot be removed"
  ([#5930](https://github.com/nim-lang/Nim/issues/5930))
- Fixed "parseBinInt"
  ([#8018](https://github.com/nim-lang/Nim/issues/8018))
- Fixed "RFC: Import Module Namespaces"
  ([#7250](https://github.com/nim-lang/Nim/issues/7250))
- Fixed "All symbols in concepts should be open by default"
  ([#7222](https://github.com/nim-lang/Nim/issues/7222))
- Fixed "static[T] issue with default arguments"
  ([#6928](https://github.com/nim-lang/Nim/issues/6928))
- Fixed "Compiler crash when casting a proc with asm statement to a pointer"
  ([#8076](https://github.com/nim-lang/Nim/issues/8076))
- Fixed "[regression]: nim doc <program.nim> produces <.html> instead of <program.html>"
  ([#8097](https://github.com/nim-lang/Nim/issues/8097))

- Fixed "[Regression] times.format interferes with strformat"
  ([#8100](https://github.com/nim-lang/Nim/issues/8100))
- Fixed "Regression: SIGSEGV caused by using `is` with string"
  ([#8129](https://github.com/nim-lang/Nim/issues/8129))
- Fixed "uninitialized procs variables are not nil at compile time"
  ([#6689](https://github.com/nim-lang/Nim/issues/6689))
- Fixed "unixToNativePath cause IndexError with Empty string or ".""
  ([#8173](https://github.com/nim-lang/Nim/issues/8173))

- Fixed "Octal int literal behavior differs from `parseOct` - change `parseOct`?"
  ([#8082](https://github.com/nim-lang/Nim/issues/8082))

- Fixed "[travis] flaky test: "No output has been received" caused by no prompt on "already exists. Overwrite?" after `nimble install`"
  ([#8227](https://github.com/nim-lang/Nim/issues/8227))

- Fixed "noSideEffect in os module"
  ([#5880](https://github.com/nim-lang/Nim/issues/5880))
- Fixed "missing `ospaths.absolutePath` function to get absolute path from a path"
  ([#8174](https://github.com/nim-lang/Nim/issues/8174))
- Fixed "Render bug with prefix and implicit string/cstring conversion"
  ([#8287](https://github.com/nim-lang/Nim/issues/8287))

- Fixed "ospaths.isAbsolute: uncovering out of bound bugs after updating to 0.18.1 from 0.18.0: empty string and nil string now checked for out of bound errors"
  ([#8251](https://github.com/nim-lang/Nim/issues/8251))
- Fixed "`Error: cannot 'importc' variable at compile time` shows wrong context"
  ([#7405](https://github.com/nim-lang/Nim/issues/7405))
- Fixed "[regression] [times.format] Error: attempting to call undeclared routine: 'format'"
  ([#8273](https://github.com/nim-lang/Nim/issues/8273))
- Fixed "`htmlparser.untilElementEnd` is not GC-safe"
  ([#8338](https://github.com/nim-lang/Nim/issues/8338))
- Fixed "`nim check` internal error"
  ([#8230](https://github.com/nim-lang/Nim/issues/8230))
- Fixed "`nim doc` fails when source file contains `doAssertRaises` in isMainModule"
  ([#8223](https://github.com/nim-lang/Nim/issues/8223))
- Fixed "Windows: can't compile with var name "far""
  ([#8345](https://github.com/nim-lang/Nim/issues/8345))
- Fixed "Render bug: procs with single if statement get incorrent indentation"
  ([#8343](https://github.com/nim-lang/Nim/issues/8343))
- Fixed "json.nim macro `to` does not support objects with distinct types"
  ([#8037](https://github.com/nim-lang/Nim/issues/8037))
- Fixed "macros.hasCustomPragma() crashes when working with variant fields"
  ([#8371](https://github.com/nim-lang/Nim/issues/8371))
- Fixed "await inside stmtListExpr inside a case stmt crashes compiler"
  ([#8399](https://github.com/nim-lang/Nim/issues/8399))

- Fixed "[os] failed operations (eg existsOrCreateDir) should show runtime context (eg file/dir) it failed for"
  ([#8391](https://github.com/nim-lang/Nim/issues/8391))

- Fixed "[ospaths] ospaths.nim says OSX is FileSystemCaseSensitive:true but should be false ; cmpPaths seems wrong"
  ([#8349](https://github.com/nim-lang/Nim/issues/8349))
- Fixed "excessiveStackTrace:on shows non-absolute file in stacktrace"
  ([#7492](https://github.com/nim-lang/Nim/issues/7492))

- Fixed "`nim doc foo` generates stuff that should be under a .gitignore'd directory"
  ([#8323](https://github.com/nim-lang/Nim/issues/8323))
- Fixed "type mismatch shows wrong type for union types T1|T2|T3|T4: only keeps T1 or T2, discards rest"
  ([#8434](https://github.com/nim-lang/Nim/issues/8434))
- Fixed "devel branch encodings.convert broken on Windows"
  ([#8468](https://github.com/nim-lang/Nim/issues/8468))
- Fixed "--app:gui gives an error on osx."
  ([#2576](https://github.com/nim-lang/Nim/issues/2576))
- Fixed "non ordinal enums are not allowed in set constructor"
  ([#8425](https://github.com/nim-lang/Nim/issues/8425))
- Fixed "[nimweb] ./koch web -o:/tmp/d13/ => `o` is actually unused and docs output dir hardcoded regardless of o"
  ([#8419](https://github.com/nim-lang/Nim/issues/8419))
- Fixed "seq/string initialized with `add` or `setLen` being deallocated"
  ([#7833](https://github.com/nim-lang/Nim/issues/7833))
- Fixed "alloc fails after 4GB"
  ([#7894](https://github.com/nim-lang/Nim/issues/7894))
- Fixed "[feature request] macros.bindSym can accept computed string"
  ([#7827](https://github.com/nim-lang/Nim/issues/7827))
- Fixed "tfragment_alloc.nim (which allocates 4GB) often makes appveyor fail with out of memory"
  ([#8509](https://github.com/nim-lang/Nim/issues/8509))
- Fixed "`echo` not thread safe on windows, causing [appveyor] flaky test: Failure: reOutputsDiffer in tforstmt.nim"
  ([#8511](https://github.com/nim-lang/Nim/issues/8511))
- Fixed "./koch xz doesn't check for dirty work tree"
  ([#7292](https://github.com/nim-lang/Nim/issues/7292))
- Fixed "non ordinal enums are not allowed in set constructor"
  ([#8425](https://github.com/nim-lang/Nim/issues/8425))
- Fixed "bad example in https://nim-lang.org/docs/docgen.html"
  ([#8215](https://github.com/nim-lang/Nim/issues/8215))
- Fixed "Ability to set a NimNode's lineinfo"
  ([#5617](https://github.com/nim-lang/Nim/issues/5617))
- Fixed "winlean.nim has wrong definition for moveFileExA"
  ([#8421](https://github.com/nim-lang/Nim/issues/8421))
- Fixed "shr operator should keep the sign bit on signed types."
  ([#6255](https://github.com/nim-lang/Nim/issues/6255))
- Fixed "proposal (with implementation): `undistinct(T)`"
  ([#8519](https://github.com/nim-lang/Nim/issues/8519))
- Fixed "`.cache/projectname` pollutes `.cache` - put in `.cache/Nim/projectname` instead"
  ([#8599](https://github.com/nim-lang/Nim/issues/8599))

- Fixed "Iterating closure iterator in nested function is empty"
  ([#8550](https://github.com/nim-lang/Nim/issues/8550))
- Fixed "[TODO] [feature] Nim error messages should show line contents, would save lots of debugging time"
  ([#7586](https://github.com/nim-lang/Nim/issues/7586))
- Fixed "Converter: {lit} parameter constraint is not respected in implicit conversion"
  ([#7520](https://github.com/nim-lang/Nim/issues/7520))
- Fixed "`mapIt` still can't be used with `openArray` even after #8543, #8567: fails during bootstrap"
  ([#8577](https://github.com/nim-lang/Nim/issues/8577))
- Fixed "Config should be in its own directory"
  ([#8653](https://github.com/nim-lang/Nim/issues/8653))
- Fixed "sequtils.toSeq produces the sequence from the iterator twice if compiles(iter.len) == true"
  ([#7187](https://github.com/nim-lang/Nim/issues/7187))
- Fixed "`$` for Option[string] types should double-quote the output"
  ([#8658](https://github.com/nim-lang/Nim/issues/8658))

- Fixed "Config should be in its own directory"
  ([#8653](https://github.com/nim-lang/Nim/issues/8653))
- Fixed "[feature request] compile time check for experimental features"
  ([#8644](https://github.com/nim-lang/Nim/issues/8644))
- Fixed "Changes in typedesc reforms"
  ([#8126](https://github.com/nim-lang/Nim/issues/8126))
- Fixed "json.% regression"
  ([#8716](https://github.com/nim-lang/Nim/issues/8716))
- Fixed "`nim doc2 --project -o:doc/ ` cannot find files in subdirectories"
  ([#8218](https://github.com/nim-lang/Nim/issues/8218))
- Fixed "`onFailedAssert` does not affect `doAssert`"
  ([#8719](https://github.com/nim-lang/Nim/issues/8719))

- Fixed "[travis] [async] flaky test: tests/async/t7758.nim"
  ([#8756](https://github.com/nim-lang/Nim/issues/8756))
- Fixed "float literals are treated differently between manual and compiler"
  ([#8766](https://github.com/nim-lang/Nim/issues/8766))
- Fixed "[cmdline] [minor] `--hint.foo:on` as alias for `--hint[foo]:on`: avoids edge cases with `[` that needs to be escaped on cmd line + other places"
  ([#8739](https://github.com/nim-lang/Nim/issues/8739))

- Fixed "Duplicate member error for union types"
  ([#8781](https://github.com/nim-lang/Nim/issues/8781))
- Fixed "nim c compiler/nimblecmd.nim fails:  Error: type mismatch: got <StringTableRef, string>"
  ([#8776](https://github.com/nim-lang/Nim/issues/8776))
- Fixed "Compiler crash with $, converter and generics"
  ([#4766](https://github.com/nim-lang/Nim/issues/4766))
- Fixed "[unidecode] Fix the `unidecode` example"
  ([#8768](https://github.com/nim-lang/Nim/issues/8768))
- Fixed "[unidecode] Make `loadUnidecodeTable` use the path to unicode.dat on user's system by default"
  ([#8767](https://github.com/nim-lang/Nim/issues/8767))
- Fixed "marshal.load() regression?"
  ([#7854](https://github.com/nim-lang/Nim/issues/7854))
- Fixed "[unidecode] Fix the `unidecode` example"
  ([#8768](https://github.com/nim-lang/Nim/issues/8768))
- Fixed "Converter applied when it should not be"
  ([#8049](https://github.com/nim-lang/Nim/issues/8049))
- Fixed "Pure enums allow using the same name but allow nonqualification with quirky behaviour"
  ([#8066](https://github.com/nim-lang/Nim/issues/8066))

- Fixed "Correctly redirect stderr when using osproc's posix_spawn backend"
  ([#8624](https://github.com/nim-lang/Nim/issues/8624))
- Fixed "`errorStream` doesn't seem to work"
  ([#8442](https://github.com/nim-lang/Nim/issues/8442))
- Fixed "Nested template: SIGSEGV at compile-time"
  ([#8052](https://github.com/nim-lang/Nim/issues/8052))
- Fixed "`Error: undeclared identifier: '|'` when using `|` inside a `runnableExamples:`"
  ([#8694](https://github.com/nim-lang/Nim/issues/8694))
- Fixed "runnableExamples doesn't work at module level"
  ([#8641](https://github.com/nim-lang/Nim/issues/8641))
- Fixed "[runnableExamples] `Hint: operation successful: runnableExamples` even though operation failed: compile error is ignored"
  ([#8831](https://github.com/nim-lang/Nim/issues/8831))
- Fixed "`runnableExamples` don't have own scope for imports"
  ([#7285](https://github.com/nim-lang/Nim/issues/7285))
- Fixed "`nim check` segfaults"
  ([#8028](https://github.com/nim-lang/Nim/issues/8028))
- Fixed "addQuoted gives unquoted result on cstring (works on string)"
  ([#8847](https://github.com/nim-lang/Nim/issues/8847))
- Fixed "[nimscript] exception handling broken: `except BaseClass` doesn't work"
  ([#8740](https://github.com/nim-lang/Nim/issues/8740))
- Fixed "Unary `.` operator can't be parsed"
  ([#8797](https://github.com/nim-lang/Nim/issues/8797))
- Fixed "system.on_raise works only for "single level""
  ([#1652](https://github.com/nim-lang/Nim/issues/1652))
- Fixed "Final facelifiting nimrod -> nim"
  ([#2032](https://github.com/nim-lang/Nim/issues/2032))
- Fixed "marshal: document usage of "to""
  ([#3150](https://github.com/nim-lang/Nim/issues/3150))
- Fixed "Name conflict between template and proc parameter"
  ([#4750](https://github.com/nim-lang/Nim/issues/4750))
- Fixed "Operator overloading bug with unittest check macro"
  ([#5252](https://github.com/nim-lang/Nim/issues/5252))
- Fixed "nim check crash due to typo"
  ([#5745](https://github.com/nim-lang/Nim/issues/5745))
- Fixed "Regression (?): ICE in transformImportAs"
  ([#8852](https://github.com/nim-lang/Nim/issues/8852))
- Fixed "generic match error"
  ([#1156](https://github.com/nim-lang/Nim/issues/1156))
- Fixed "Adding a mention of the `unsafeAddr` operator to the Nim manual"
  ([#5038](https://github.com/nim-lang/Nim/issues/5038))
- Fixed "`using` types should have higher precedence"
  ([#8565](https://github.com/nim-lang/Nim/issues/8565))
- Fixed "Add noSignalHandler documentation and examples"
  ([#8224](https://github.com/nim-lang/Nim/issues/8224))
- Fixed "`-d:identifier` is case insensitive (not partially case insensitive)"
  ([#7506](https://github.com/nim-lang/Nim/issues/7506))
- Fixed "addQuitProc argument requires {.noconv.} not documented"
  ([#5794](https://github.com/nim-lang/Nim/issues/5794))
- Fixed "Compilation error does not point to the actual wrong parameter"
  ([#8043](https://github.com/nim-lang/Nim/issues/8043))
- Fixed "Clean up examples"
  ([#7725](https://github.com/nim-lang/Nim/issues/7725))
- Fixed "Documentation footer timestamp is not UTC"
  ([#7305](https://github.com/nim-lang/Nim/issues/7305))
- Fixed "Regression: compiler stack overflow in transformIteratorBody/lowerStmtListExprs"
  ([#8851](https://github.com/nim-lang/Nim/issues/8851))
- Fixed "The `writeStackTrace` proc listed twice in docs"
  ([#3655](https://github.com/nim-lang/Nim/issues/3655))
- Fixed "Error: unhandled exception: n.kind == nkStmtListExpr  [AssertionError]"
  ([#8243](https://github.com/nim-lang/Nim/issues/8243))
- Fixed "The `writeStackTrace` proc listed twice in docs"
  ([#3655](https://github.com/nim-lang/Nim/issues/3655))
- Fixed "Regression: stack trace line numbers are messed up for asserts"
  ([#8928](https://github.com/nim-lang/Nim/issues/8928))

- Fixed "Regression bug in lines()"
  ([#8961](https://github.com/nim-lang/Nim/issues/8961))
- Fixed "Core dump for RTree module -- regression"
  ([#8883](https://github.com/nim-lang/Nim/issues/8883))

- Fixed "`system.cmp` returns different results for string on different operating systems"
  ([#8930](https://github.com/nim-lang/Nim/issues/8930))
- Fixed "scanf Invalid node kind nnkBracketExpr for macros.`$`"
  ([#8925](https://github.com/nim-lang/Nim/issues/8925))

- Fixed "Regression bug in lines()"
  ([#8961](https://github.com/nim-lang/Nim/issues/8961))
- Fixed "Typetraits arity: off-by-one for arrays"
  ([#8965](https://github.com/nim-lang/Nim/issues/8965))
- Fixed "`strutils.nim(1533, 29) Error: illegal conversion from '-1' to '[0..9223372036854775807]'` with strutils.replace on empty string at CT"
  ([#8911](https://github.com/nim-lang/Nim/issues/8911))
- Fixed "Iterators in combination with closures misbehave"
  ([#3837](https://github.com/nim-lang/Nim/issues/3837))
- Fixed "procCall is not documented"
  ([#4329](https://github.com/nim-lang/Nim/issues/4329))
- Fixed "scanf Invalid node kind nnkBracketExpr for macros.`$`"
  ([#8925](https://github.com/nim-lang/Nim/issues/8925))
- Fixed "Add exports section to documentation generator"
  ([#1616](https://github.com/nim-lang/Nim/issues/1616))
- Fixed "Improve error message for redefinitions"
  ([#447](https://github.com/nim-lang/Nim/issues/447))
- Fixed "[minor] operator symbols in anchor text disappear, causing anchor clashes"
  ([#7500](https://github.com/nim-lang/Nim/issues/7500))

- Fixed "Incorrect executable name of the C compiler when performing crosscompilation"
  ([#8081](https://github.com/nim-lang/Nim/issues/8081))
- Fixed "[ICE/regression] when proc with var return type interacting with method"
  ([#9076](https://github.com/nim-lang/Nim/issues/9076))