---
title: "Nim in 2018: A short recap"
author: The Nim Team
---

There were several big news in the Nim world in 2018 -- two new major releases, partnership with Status, and much more.
But let us go chronologically.


## FOSDEM 2018 participation

The first week of February is reserved for FOSDEM, where members of Nim core development team were promoting the newly published book [Nim in Action](https://book.picheta.me/), selling Nim T-shirts, and meeting with Nim developers.


## Version 0.18

In March 2018, [version 0.18](https://nim-lang.org/blog/2018/03/01/version-0180-released.html) has been released.
With more than 1300 commits since the previous version, it was the biggest release of Nim so far.

It introduced [`strformat` module](https://nim-lang.org/docs/strformat.html) with `fmt` and `&` operators for formatted string literals, the ability to have testable documentation examples with `runnableExamples`, and numerous `async` improvements.
The TLSF algorithm has been implemented to reduce memory fragmentation, which made `alloc` and `dealloc` O(1) operations.


## Partnership with Status.im

In August the partnership with [Status](https://status.im/) was announced.

The Status team has chosen the Nim programming language as a base for the implementation of a sharding client for Ethereum, named [Nimbus](https://github.com/status-im/nimbus).
With this partnership Status will support the Nim team with funding and resources needed to stay focused on the development of the Nim programming language.

This allowed hiring two full-time developers, tasked with fixing bugs, responding to issues, and developing the compiler, the standard library and the tooling.


## Version 0.19

Version 0.19, [released in September](https://nim-lang.org/blog/2018/09/26/version-0190-released.html), took the crown from 0.18 as the biggest release yet, with more than 1400 new commits.

The biggest change introduced is that the `nil` state for strings and sequences is gone -- the default value for these are `""` and `@[]` (an empty string, and an empty sequence, respectively).
This eliminates a major confusion-point for beginners, and makes Nim more pleasant for everybody.

This version introduced `experimental` as a pragma and a command line switch that can enable specific language extensions (it is not an all-or-nothing switch, like before).
Other notable additions include `func` as an alias for a procedure with no side effects, supporting `except` in the `export` statement, so called "for-loop macros", `async` working with exception handling (now it is possible to use `await` in a `try` statement), and more.


## Hacktoberfest

In October our community participated in Hacktoberfest, resulting in impressive 275 closed issues and 160 merged pull requests -- more detailed documentation, improved tests, general cleanup, and much more.
These improvements will be part of 0.20 release, and some of them are already backported to the latest bugfix release -- [0.19.2](https://nim-lang.org/blog/2018/12/31/version-0192-released.html).


## Nim in 2019

If you're interested in seeing and hearing what has been done in 2018 directly from the core developers, take a look at [Nim Development Blog 2018](https://www.youtube.com/watch?v=xUsAKstP-AQ) on Youtube.

We have switched to a different release model, with a stable branch (currently that's v0.19.x) which receives bugfixes, it is aimed at daily usage, and Nimble package development should target this version; and a devel branch which will become a new major release -- v0.20, and serve as a release candidate for v1.0.

In 2019, the Nim team will continue to work towards that goal, which will mark the end of breaking changes to Nim.
We are focusing on the main areas shown in [Nim community survey 2018](https://nim-lang.org/blog/2018/10/27/community-survey-results-2018.html) as needed before Nim v1.0:
* better documentation
* better standard library
* stabilization
* implementing destructors and move semantics for a more flexible concurrency model and reduced memory usage

Community help is, as always, welcome.
Report [issues and bugs](https://github.com/nim-lang/nim/issues), make [pull requests](https://github.com/nim-lang/nim/pulls), consider [donating](https://nim-lang.org/donate.html) or becoming a [sponsor](https://nim-lang.org/sponsors.html).
