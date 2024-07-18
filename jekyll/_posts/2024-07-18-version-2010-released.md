---
title: "Nim version 2.0.10 released"
author: The Nim Team
---

The Nim team is happy to announce Nim version 2.0.10, our fifth patch release for Nim 2.0.

Version 2.0.10 is a small release, containing just [10 commits](https://github.com/nim-lang/Nim/compare/v2.0.8...v2.0.10),
but it brings important improvements to Nim 2.0.8, released two weeks ago.

The reason for another quick release is because this version (finally!) fixes the problem with the memory allocator
and there is no need to use the `-d:useMalloc` workaround anymore.

Check out if the package manager of your OS already ships version 2.0.10 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 2.0.10 is as easy as:

```bash
$ choosenim 2.0.10
```

If you are on OSX ARM, `choosenim` will not work for you.
Please choose an alternative method of installing or updating.

Alternatively, you can download Nim 2.0.10 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2024-07-17-version-2-0-92e505577e8b6b9214b6fcdd7fe1b0e9a244023b).




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

- Fixed "`Error: generic instantiation too nested` after using many `compiles(...)`"
  ([#23790](https://github.com/nim-lang/Nim/issues/23790))
- Fixed "system.=destroy does not accept non-var types"
  ([#22286](https://github.com/nim-lang/Nim/issues/22286))
- Fixed "std/isolation raises warning about how =destroy may raise unlisted Exception `Exception`"
  ([#23129](https://github.com/nim-lang/Nim/issues/23129))

The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v2.0.8...v2.0.10).
