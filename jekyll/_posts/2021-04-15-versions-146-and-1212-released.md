---
title: "Versions 1.4.6 and 1.2.12 released"
author: The Nim Team
---

The Nim team is happy to announce the double patch release of versions 1.2.12 and 1.4.6.

Version 1.4.6 is our main release, which brings several improvements over
1.4.4, released a month ago.
As our [Community Survey](https://nim-lang.org/blog/2021/01/20/community-survey-results-2020.html)
has shown, most of our users use 1.4.x version, and this release is for them
and for all newcomers: we recommend you to install version 1.4.6.

We didn't forget the users who are still on the older versions and cannot
update to the latest stable version.
Version 1.2.12 is for them, and contains mostly just security fixes.
You can find more information about this version at the bottom of the article.

If you are still on Nim 1.2.x, and would like to know about new features
available in Nim 1.4, check out our
[version 1.4.0 release article](https://nim-lang.org/blog/2020/10/16/version-140-released.html).



# Version 1.4.6

Version 1.4.6 is our third patch release for Nim 1.4 and it brings several
fixes since version 1.4.4, released two month ago.


## Installing Nim 1.4.6

### New users

Check out if the package manager of your OS already ships version 1.4.6 or
install it as described [here](https://nim-lang.org/install.html).


### Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.4.6 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.4.6 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2021-04-15-version-1-4-2b6b08032348939e5d355a6cb4faa0169306c17f).



## Bugfixes since 1.4.4

- Fixed GC crash resulting from inlining of the memory allocation procs
  ([link](https://github.com/nim-lang/Nim/pull/17709))
- Fixed "isolate doesn't work"
  ([#17264](https://github.com/nim-lang/Nim/issues/17264))
- Fixed "regression since 1.4.2: vm crash with lists.SinglyLinkedRing"
  ([#16384](https://github.com/nim-lang/Nim/issues/16384))
- Fixed "Generics "sandwiched" between two modules don't mixin their scope symbols properly"
  ([#11225](https://github.com/nim-lang/Nim/issues/11225))
- Fixed "json.`%` raises `Defect` for `uint64`"
  ([#17383](https://github.com/nim-lang/Nim/issues/17383))
- Fixed "memory allocation during {.global.} init breaks GC"
  ([#17085](https://github.com/nim-lang/Nim/issues/17085))
- Fixed "incorrect raises effect for `$`(NimNode)"
  ([#17454](https://github.com/nim-lang/Nim/issues/17454))

Full changelog since v1.4.4 contains [19 commits](https://github.com/nim-lang/Nim/compare/v1.4.4...v1.4.6).




# Donating to Nim

We would like to encourage you to donate to Nim.

The donated money will be used to further improve Nim:
- Bugs need to be fixed, the documentation can be improved, compiler error
  messages can always be better.
- The most exciting upcoming feature, that has the greatest impact to all
  of our users, is [incremental compilation](https://github.com/nim-lang/RFCs/issues/46).
- Incremental compilation will also be the foundation for further tooling
  improvements like `nimsuggest` (autocompletion, find usages).


You can donate via:

* [Open Collective](https://opencollective.com/nim)
* [Patreon](https://www.patreon.com/araq)
* [PayPal](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=FLWX5V2PMAXAU)
* Bitcoin: `1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ`

If you are a company, we also offer commercial support.
Please get in touch with us via `support@nim-lang.org`.
As a commercial backer, you can decide what features and bugfixes should
be prioritized.




# Version 1.2.12

Version 1.2.12 is our sixth patch release for Nim 1.2 and it brings a couple of
new fixes since version 1.2.10, released two month ago.


## Installing Nim 1.2.12

### New users

We recommend you to install the newest Nim version (at the time of writing: 1.4.6, see above).
Check out if the package manager of your OS already ships Nim 1.4 or
install it as described [here](https://nim-lang.org/install.html).


### Existing users

If you have installed a previous version of Nim using `choosenim` and you
cannot switch to 1.4.x yet, getting Nim 1.2.12 is as easy as:

```bash
$ choosenim 1.2.12
```

Alternatively, you can download Nim 1.2.12 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2021-04-15-version-1-2-fb03c4b937ec4d96ca7b54c5527640f1ea8a9ad8).



## Bugfixes since 1.2.10

- Fixed GC crash resulting from inlining of the memory allocation procs
  ([link](https://github.com/nim-lang/Nim/pull/17709))
- Fixed "incorrect raises effect for `$`(NimNode)"
  ([#17454](https://github.com/nim-lang/Nim/issues/17454))

Full changelog since v1.2.10 contains [14 commits](https://github.com/nim-lang/Nim/compare/v1.2.10...v1.2.12).
