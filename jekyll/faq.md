---
layout: page
title: FAQ
css_class: faq
---

<h1 class="text-centered page-title main-heading">Frequently Asked Questions</h1>

# General questions

## Why yet another programming language?

Nim is one of the very few _programmable_ statically typed languages, and
combines the speed and memory efficiency of C, an expressive syntax,
memory safety and multiple target languages.

## How stable is Nim?

The compiler and stdlib are actively under development and have a suite of test
cases to ensure ongoing stability. Regular releases are posted every three to
six months that can be used as a base for projects requiring a stable foundation.
Breaking changes are rare but are [documented](https://nim-lang.org/blog/2018/03/01/version-0180-released.html)
in detail and can typically be managed with minimal effort. The compiler also
highlights deprecated features to provide sufficient notice and transition time
through changes.


## How about security and memory safety?

Nim provides memory safety by not performing pointer arithmetic, with
optional [checks](https://nim-lang.org/docs/manual.html#pragmas-compilation-option-pragmas), traced and untraced references and optional non-nullable types.
It supports Valgrind through the koch tool, and taint analysis.

## How is Nim licensed?

The Nim compiler and the library are MIT licensed.
This means that you can use any license for your own programs developed with
Nim.

## What about JVM/CLR backends?

JVM/CLR support is not in the nearest plans. However, since these VMs support FFI to C
it should be possible to create native Nim bridges, that transparently generate all the
glue code thanks to powerful metaprogramming capabilities of Nim.

## What about editor support?

- Visual Studio Code: [https://marketplace.visualstudio.com/items?itemName=kosz78.nim](https://marketplace.visualstudio.com/items?itemName=kosz78.nim)
- Emacs: [https://github.com/nim-lang/nim-mode](https://github.com/nim-lang/nim-mode)
- Vim: [https://github.com/zah/nimrod.vim/](https://github.com/zah/nimrod.vim)
- NeoVim: [https://github.com/alaviss/nim.nvim](https://github.com/alaviss/nim.nvim)
- QtCreator (4.1+): Included as experimental plugin.
- Scite: Included
- Gedit: The [Aporia .lang file](https://github.com/nim-lang/Aporia/blob/master/share/gtksourceview-2.0/language-specs/nim.lang).
- Geany: Included
- jEdit: [https://github.com/exhu/nimrod-misc/tree/master/jedit](https://github.com/exhu/nimrod-misc/tree/master/jedit)
- TextMate: [https://github.com/textmate/nim.tmbundle](https://github.com/textmate/nim.tmbundle)
- Sublime Text: [https://github.com/Varriount/NimLime](https://github.com/Varriount/NimLime)
- LiClipse: [http://www.liclipse.com/](http://www.liclipse.com/) (Eclipse based plugin)
- Howl: Included
- Notepad++: [https://github.com/jangko/nppnim/releases](https://github.com/jangko/nppnim/releases)
- Micro: Included
- Atom: [https://atom.io/packages/nim](https://atom.io/packages/nim)
- JetBrains IDEs: [https://plugins.jetbrains.com/plugin/15128-nim](https://plugins.jetbrains.com/plugin/15128-nim)
- Kakoune: Included
- For editors with LSP (Language Server Protocol) support (requires a separate syntax/indenting plugin): [https://github.com/PMunch/nimlsp](https://github.com/PMunch/nimlsp)

## What have been the major influences in the language's design?

The language borrows heavily from (in order of impact): Modula 3, Delphi,
Ada, C++, Python, Lisp, Oberon.

## Why is it named ``proc``?

*Procedure* used to be the common term as opposed to a *function* which is a
mathematical entity that has no side effects. And indeed in Nim ``func``
is syntactic sugar for ``proc {.noSideEffect.}``. Naming it ``def`` would not
make sense because Nim also provides an ``iterator`` and a ``method`` keyword,
whereas ``def`` stands for ``define``.


# Compilation FAQ

## Which option to use for the fastest executable?

For the standard configuration file, ``-d:danger`` makes the fastest binary possible
while disabling **all** runtime safety checks, so for most cases ``-d:release`` should
be enough. If supported by your compiler, you can also enable link-time optimization 
for an even faster executable: ``--passc:-flto`` or ``-d:lto`` on Nim 1.4+

## Which option to use for the smallest executable?

For the standard configuration file, ``-d:danger -d:strip --opt:size`` does the trick.
If supported by your compiler, you can also enable link-time optimization
the same way as described in the previous answer.

## How do I use a different C compiler than the default one?

Edit the ``config/nim.cfg`` file.
Change the value of the ``cc`` variable to one of the following:

| Abbreviation | C/C++ Compiler                          |
| ---------------- | --------------------------------------------|
|``gcc``           | GNU C compiler                              |
|``clang``         | Clang compiler                              |
|``vcc``           | Microsoft's Visual C++                      |
|``icc``           | Intel C compiler                            |
|``llvm_gcc``      | LLVM-GCC compiler                           |
|``tcc``           | Tiny C compiler                             |
|``bcc``           | Borland C compiler                          |
|``envcc``         | Your environment's default C compiler       |


Other C compilers are not officially supported, but might work too.

If your C compiler is not in the above list, try using the
*environment's default C compiler* (``envcc``). If the C compiler needs
different command line arguments try the ``--passc`` and ``--passl`` switches.
