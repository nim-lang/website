---
title: "Mastering Nim - now available on Amazon"
author: Araq
excerpt: "My book 'Mastering Nim - A complete guide to the programming language' is now available on Amazon"
---



My book "Mastering Nim -- A complete guide to the programming language" is now
[available on Amazon](https://www.amazon.com/dp/B0B4R7B9YX).
(Also available from [amazon.de](https://www.amazon.de/dp/B0B4R7B9YX),
[amazon.co.uk](https://www.amazon.co.uk/dp/B0B4R7B9YX) and other Amazon domains.)


The book gives you a new introduction into Nim.
Simple examples of how to draw lines onto a canvas introduce you
into the basic concepts like control flow and function calls.
More advanced features such as iterators, generics
and templates are also covered in this introduction.

Here is [an excerpt](/assets/img/nim_book_excerpt.pdf).

The second and largest part of the book was based on Nim's online manual.
However, many examples have been added that are considered typical,
sections have been rewritten and throughout the manual personal advice is given.
Even though we tried very hard with Nim, no programming language is perfect.
So over the years a couple of "gotchas" for certain features have been found.
The book does cover most of them and offers mitigations and workarounds.

The third part is probably the most exciting for Nim experts:
It covers what macros are good for and how to master them.

First it teaches how AST introspection works and the differences between
`typed` and `untyped` trees are explained.
The various ways of constructing an AST are shown.

Well known macros like [`sugar.collect`](https://nim-lang.github.io/Nim/sugar.html#collect.m,untyped),
[`strformat.fmt`](https://nim-lang.github.io/Nim/strformat.html#fmt.m,staticstring,staticchar,staticchar)
or the parser domain specific language as found in [`strscans`](https://nim-lang.github.io/Nim/strscans.html)
are explained thoroughly.
Finally, it is shown how [Karax](https://github.com/karaxnim/karax)'s HTML
construction language works.
In fact, the algorithm described in the book is new and significantly easier to comprehend
than the one that Karax implements!


"Mastering Nim" is the culmination of a long period of experience of using Nim in practice.
I hope you find it as interesting to read as it was for me to write.
