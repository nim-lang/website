---
title: "This Month with Nim: November 2021"
author: The Nim Community
excerpt: "November has brought one project, a blog post, and WASM-4 support."
---

## [xidoc](http://xidoc.nim.town/)

#### Author: [xigoi](https://github.com/xigoi)
xidoc is a markup language intended to be consistent and powerful.
It has a very straightforward syntax where everything is in the form of a command surrounded by square brackets.
For example: `[color #ff0; This text is yellow.]`
It can compile to HTML and LaTeX, allowing it to be used in many places.

Features include:

- Basic text styling (bold, italics, monospace, spoiler, ...)
- Document layout primitives (section, paragraph, title, ...)
- Shortcuts for common Unicode characters (dashes, pretty quotes, ...)
- Lists, tables, checkboxes
- LaTeX math with helper commands
- Code snippets and blocks with optional syntax highlighting
- Defining custom commands
- Including other xidoc files
- Ways to produce any code in the target language
- CSS styling when compiling to HTML
- Documentation of all commands with examples
- [Interactive playground](http://xidoc.nim.town/playground.html) for trying out a limited subset of the language in the browser

Some planned features:
- Inserting images
- Drawing vector images
- A proper module system
- Compiling to Markdown, plain text and gemtext

Check out [the project website](http://xidoc.nim.town/) to find out more.
I also wrote [an article](https://xigoi.neocities.org/why-i-created-a-markup-language.html) about the motivation for the project and how I went about implementing it.


## [Using Nim for Web Development in 2021](https://arhamjain.com/2021/11/22/nim-webdev.html)

#### Author: [ajusa](https://github.com/ajusa)
A quick (opinionated) overview of the Nim webdev ecosystem in 2021.
Goes into using Nim for frontend, templating, and backend frameworks.


## [Nim support for WASM-4](https://wasm4.org/)

WASM-4 is a low-level fantasy game console for building small games with WebAssembly.
Game cartridges (ROMs) are small, self-contained .wasm files.
Nim support was merged in [this PR](https://github.com/aduros/wasm4/pull/167) so go ahead and start making WASM-4 games with Nim!

----

## Reminders

We would like to remind you that we are running our annual Community Survey, and we would like to hear your opinions.
More details at [this link](https://nim-lang.org/blog/2021/11/22/community-survey-2021.html).

If you would like to practice your Nim skills by solving a series of small programming puzzles, join us in `#AdventOfNim` where we solve [Advent of Code](https://adventofcode.com/) puzzles.
More information on [the forum](https://forum.nim-lang.org/t/8657).

----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
