---
title: "Nim in 2017: A short recap"
author: Dominik Picheta
---

This year has been filled with some pretty major achievements for us, because
of this I decided to write a little article summarising what we've accomplished
in 2017 and to give a bit of a preview of what's in store for 2018.

## The first Nim book

<div class="center">
  <a href="https://book.picheta.me/">
    <img src="https://pbs.twimg.com/media/DHI3ogxXsAAvrRE.jpg:large" alt="Three Nim in Action books, fanned out" width="400"/>
  </a>
</div>

* Nim in Action, the first Nim programming language book, went into production
  in late 2016 and I received the first printed copies in the following summer.
* Of course, being the author, I am incredibly proud of this.
* This book is considered ["canon"](https://en.wikipedia.org/wiki/Canon_(fiction))
  for Nim v1. This means that we will do our
  best to not break anything that is contained within it for version 1.0.
  So don't be
  afraid to buy a copy thinking that it will be out of date by the time 1.0
  is released.

## Nim at FOSDEM

<div class="center">
  <a href="https://fosdem.org/2018/stands/">
    <img src="https://fosdem.org/2018/support/promote/wide.png" alt="FOSDEM 2018" width="500"/>
  </a>
</div>

* Nim is coming to FOSDEM!
* We are very happy to say that we have been allocated a stand at FOSDEM 2018
  in Brussels. A lot of Nim folks (including the Nim creator Andreas Rumpf and
  myself) will be there to sell t-shirts, books and to promote Nim.
* Join us on 3 & 4 February 2018 in Brussels!

## Nim in production

* Reel Valley, a game by [Onset Game](https://onsetgame.com/), written 100%
  in Nim has been released on
  [Facebook](https://apps.facebook.com/reelvalley/?utm_source=nim_2017) and
  more recently on
  [Android](https://play.google.com/store/apps/details?id=com.onsetgame.reelvalley).
* We now have a wiki page listing multiple companies using
  [Nim in production](https://github.com/nim-lang/Nim/wiki/Companies-using-Nim).
* Companies are [searching for Nim programmers](https://forum.nim-lang.org/t/3402).

## Work towards v1.0

* 3 releases this year: 0.16.0, 0.17.0 and 0.17.2
* Upcoming release 0.18.0 contains many bug fixes and improvements, in particular
  a lot of stdlib changes.
  See the current changelog [here](https://github.com/nim-lang/Nim/blob/devel/changelog.md#v0180---ddmmyyyy).
  * "Upcoming" async has finally been merged.
  * A large revamp of the ``times`` module, with more to come.
    (Thanks [@GULPF](https://github.com/GULPF))
  * Multiple modules have been moved out of the stdlib to Nimble packages.
    (Thanks [@lcrees](https://github.com/lcrees/))
  * Fixes to our handling of SSL certificate checks.
    (Thanks [@FedericoCeratto](https://github.com/FedericoCeratto))
  * The memory manager now implements the TLSF algorithm with the benefit that
    ``alloc`` and ``dealloc`` are now O(1) operations.
  * Many more changes by our awesome and devoted community.
* Version 1.0 will mark the end of breaking changes to Nim.
  This won't mean that Nim development will cease, many improvements will
  continue to be made and your source won't require any changes to compile
  with each Nim release.
  * There will be some caveats to this which we will outline in the future.
  * We are already very good at exercising restraint when creating breaking
   changes, often creating a deprecation path to ease the pain of our users.
   This isn't always the case though, after v1 is release it will be.

## Nim livestreams

* We wanted to attract more developers to Nim by hosting live coding streams on Twitch.
* [Araq](https://go.twitch.tv/araq4k) hosted livestreams where he worked on the compiler. You might find
 these useful if you're interested in compiler development.
  * [Pointer free programming](https://www.youtube.com/watch?v=EC9zCXlvY2k)
  * [Thinking about destructors](https://www.youtube.com/watch?v=KNUDGZuqfQM)
  * [Pretty printing](https://www.youtube.com/watch?v=UV38gQfcb9c)
  * [Random bug fixing](https://www.youtube.com/watch?v=E2qlDKm_WzE)
* [dom96](https://go.twitch.tv/d0m96) hosted livestreams where he fixed stdlib bugs, created Nimble packages,
  and enhanced the Nim IRC bot. You might find these useful if you want to
  learn how to develop Nim software or fix stdlib bugs.
  * [Enhancing the Nim programming language IRC bot](https://www.youtube.com/watch?v=CkXZjjWD8EI)
  * [Creating a web driver package and fixing stdlib bugs](https://www.youtube.com/watch?v=583BwZ7uSro)
  * [Extending web driver package, stock notifier and Nimble](https://www.youtube.com/watch?v=UQ4RvUlXIDI)
  * [Fixing stdlib bugs in the Nim programming language](https://www.youtube.com/watch?v=RggcZEXZA-g)

As always, I'd like to invite
you to join our community to give us feedback or just to chill out with us,
all the information you need to do so is available on our
[community](https://nim-lang.org/community.html) page.

Thank you all for your incredible support so far, and have a happy new year!