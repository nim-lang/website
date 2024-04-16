---
title: "Versions 2.0.4 and 1.6.20 released"
author: The Nim Team
---

The Nim team is happy to announce two releases:
- the latest Nim, version 2.0.4
- LTS release, version 1.6.20


For the majority of our users, v2.0.4 contains [23 commits](https://github.com/nim-lang/Nim/compare/v2.0.2...v2.0.4) and brings bugfixes and improvements to Nim 2.0.2, released four months ago.


For those users who haven't switched to [Nim v2.0](https://nim-lang.org/blog/2023/08/01/nim-v20-released.html) yet, we have released the ninth patch release for Nim 1.6.x.
It is a small release with [13 commits](https://github.com/nim-lang/Nim/compare/v1.6.18...v1.6.20).






# Installing Nim 2.0.4

## New users

Check out if the package manager of your OS already ships version 2.0.4 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 2.0.4 is as easy as:

```bash
$ choosenim 2.0.4
```

If you are on OSX ARM, `choosenim` will not work for you.
Please choose an alternative method of installing or updating.

Alternatively, you can download Nim 2.0.4 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2024-03-28-version-2-0-b47747d31844c6bd9af4322efe55e24fefea544c).




# Donating to Nim

We would like to encourage you to donate to Nim.
The donated money will be used to further improve Nim by creating bounties
for the most important bugfixes and features.

You can donate via:

* [Open Collective](https://opencollective.com/nim)
* Bitcoin: `1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ`

If you are a company, we also offer commercial support.




# Bugfixes

These reported issues were fixed:

- Fixed "import sth from mymodule is compiles and trying to see module sthfrommymodule"
  ([#23148](https://github.com/nim-lang/Nim/issues/23148))
- Fixed "Operations on inline toOpenArray len return a wrong result"
  ([#23280](https://github.com/nim-lang/Nim/issues/23280))
- Fixed "Nimsuggest segfault with invalid assignment to table"
  ([#22753](https://github.com/nim-lang/Nim/issues/22753))


The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v2.0.2...v2.0.4).




&nbsp;

&nbsp;





# Installing Nim 1.6.20

## New users

If you are a new user, we highly recommend that you start with Nim 2.0.x — see the sections above on how to install it.


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6.20 is as easy as:

```bash
$ choosenim 1.6.20
```

If you are on OSX ARM, `choosenim` will not work for you.
Please choose an alternative method of installing or updating.

Alternatively, you can download Nim 1.6.20 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2024-04-07-version-1-6-19fdbfc173bfccb64cb64e0a963e69f52f71fc73).





# Bugfixes

These reported issues were fixed:

- Fixed "import sth from mymodule is compiles and trying to see module sthfrommymodule"
  ([#23148](https://github.com/nim-lang/Nim/issues/23148))
- Fixed "Operations on inline toOpenArray len return a wrong result"
  ([#23280](https://github.com/nim-lang/Nim/issues/23280))
- Fixed "[Backport 2.0] Itanium mangling scheme"
  ([#23301](https://github.com/nim-lang/Nim/issues/23301))
- Fixed "Nimsuggest segfault with invalid assignment to table"
  ([#22753](https://github.com/nim-lang/Nim/issues/22753))

The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v1.6.18...v1.6.20).
