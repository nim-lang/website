---
title: Hacktoberfest with Nim
author: The Nim Team
---


# Hacktoberfest with Nim

[Hacktoberfest](https://hacktoberfest.digitalocean.com/) is an annual event happening in October which celebrates open source software and encourages meaningful contributions to the open source ecosystem.

To win a T-shirt, you must sign up on the [Hacktoberfest site](https://hacktoberfest.digitalocean.com/) and make five pull requests to any repo on Github by the end of October.
Even if you don't manage to make five pull requests, you win Hacktoberfest stickers.

Nim would like to encourage you to participate in Hacktoberfest by contributing to [Nim repo](https://github.com/nim-lang/nim) or any other Nim-related repos.



## How can you help?

* bug-fixing
* improving documentation
* writing a library



### Bug fixing

[Nim repo](https://github.com/nim-lang/nim) has more than 1400 open issues, which might be overwhelming to start.
Here are some categories you might find interesting:

* Why don't you start with some of [easy issues](https://github.com/nim-lang/nim/issues?q=is%3Aopen+is%3Aissue+label%3AEasy)?
* You can help with [cleanup](https://github.com/nim-lang/nim/issues?q=is%3Aopen+is%3Aissue+label%3ACleanup).
* You don't want to write code? Plenty of issues involve [documentation](https://github.com/nim-lang/nim/issues?q=is%3Aopen+is%3Aissue+label%3ADocumentation).
* Everybody uses stdlib. How about fixing one of more than 200 issues in [stdlib](https://github.com/nim-lang/nim/issues?q=is%3Aopen+is%3Aissue+label%3AStdlib)?
* You want to earn some money while fixing bugs? Here are the issues having a [bounty](https://github.com/nim-lang/nim/issues?q=is%3Aopen+is%3Aissue+label%3Abounty).
* What should be our priority for fixing? Take a look at [high priority issues](https://github.com/nim-lang/nim/issues?q=is%3Aopen+is%3Aissue+label%3A"High+Priority").



### Improving documentation

Poor documentation is often mentioned when people discuss Nim.
Let's make it better together!

Based on [this research](https://gist.github.com/GULPF/6d49e74af9992f8fc65476a9264488a0), the most used modules are: strutils, os, tables, math, sequtils, macros, times, unittest and json -- improving these would be beneficial to most people, but feel free to choose any other Nim module.

For example, in the [tables module](https://nim-lang.org/docs/tables.html) what is missing is:
* a general example which shows a usage of `OrderedTable` and `CountTable`,
* for each procedure, a short example which shows the results of applying it.

How to go about improving these?
Open the [source file for tables module](https://github.com/nim-lang/Nim/blob/master/lib/pure/collections/tables.nim) and you'll see that the general documentation is at the top of the file, and to make an example, put it inside of a indented `code-block` like this:

```
## .. code-block:: nim
##
##   import tables
##   # my example here
```



### Writing a library

There is a [list of needed libraries](https://github.com/nim-lang/needed-libraries/issues), can you help us with it?

Once you have written a library, you can send a PR to [nimble package repo](https://github.com/nim-lang/nimble) to include your package in the official list of packages.

If writing a library seems like a too demanding task, you can help improve [one of the existing Nim packages](https://nimble.directory/) by adding a feature, fixing a bug, or writing more informative documentation.



## I want to help, but I've run into some problem

If you need any help, the Nim community is very welcoming.
Ask a question in [Nim's IRC Channel on Freenode](irc://freenode.net/nim), [Nim's room on Gitter](https://gitter.im/nim-lang/Nim) or the [Nim Telegram group](https://t.me/nim_lang) and somebody will help you.

Happy coding!