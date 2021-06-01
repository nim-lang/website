---
title: "This Month with Nim: May 2021"
author: The Nim Community
excerpt: "Four interesting projects our users worked on in May"
---

## Nim0, a subset of Nim language, with a compiler to a 32-bits RISC CPU and a runtime emulator

#### Author: [Pierre Métras](https://github.com/pmetras)

Nim0 is a toy language similar to Nim but much more limited (no fancy feature X; replace X by generics, templates, closures, imports, etc.).
It comes with a one-pass compiler to 32-bit RISC instructions and an emulator, and a few examples to show what you can do with it.

The interesting part in Nim0 is not the language itself but the [compiler source](https://gitlab.com/pmetras/nim0) in less than 4000 lines of commented code, with references to Niklaus Wirth's [Compiler Construction book](https://people.inf.ethz.ch/wirth/CompilerConstruction/index.html) that you can follow while reading the book, even if the book talks about Oberon-0.
When you have completed the book and added a few features to Nim0 compiler, you'll be ready to jump into hacking [Nim compiler](https://github.com/nim-lang/Nim).

Want to try it? Look at the simple instructions and detailed example at https://pmetras.gitlab.io/nim0/.


## Nimibook

#### Authors: [@pietroppeter](https://github.com/pietroppeter), [@clonkk](https://github.com/Clonkk), [@hugogranstrom](https://github.com/HugoGranstrom), [@zetashift](https://github.com/zetashift)

This month we collaboratively worked on [nimibook],
a port of [mdbook] to nim using [nimib].
Nimibook allows to create a nice looking book from nim code and markdown, making sure that nim code is running correctly and being able to incorporate code outputs in the final book.

The work started with the goal of using nimib to write [SciNim/getting-started], a guide for scientific libraries in Nim.
We are now close (not there yet) to a working version of nimibook and next month
we plan to start using it in SciNim/getting-started. Join us, we are having fun!

[mdbook]: https://rust-lang.github.io/mdBook/index.html
[nimib]: https://pietroppeter.github.io/nimib/
[SciNim/getting-started]: https://github.com/SciNim/getting-started
[nimibook]: https://pietroppeter.github.io/nimibook/


## [Kashae](https://github.com/beef331/kashae)

#### Author: [Jason Beetham](https://github.com/beef331)

After seeing the Python caching annotation, I was enthuised to make a caching library.
Kashae is the result of that enthusiasm, it has many optional features to change it's behaviour, though still needs some work and to be submitted to Nimble.
A small example of using the "unlimited" cache follows:
```nim
import kashae
proc fib(n: int): int {.cache.} =
  if n <= 1:
    result = n
  else:
    result = fib(n - 1) + fib(n - 2)
```

## [Susta](https://github.com/ajusa/susta)

#### Author: [@ajusa](https://github.com/ajusa)

Susta is a test runner that aids in print statement based testing.
You pass it a lists of Nim files to run, and it saves any output from stdout to a file. Then, when you run the tests again, it diffs the output with the saved output and reports any differences.
If the changes are what you expected, you can simply `accept` them to overwrite the old output.
It is a simple and easy way to write tests when you can't be bothered to write unit tests.
It especially shines when you want to catch regressions.

I plan on making it language agnostic and adding threading support to run tests in parallel in the near future.

It's a [super simple utility](https://github.com/ajusa/susta), and I hope folks enjoy using it!

----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim) to add your project to the next month's blog post.
