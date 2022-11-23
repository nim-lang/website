---
title: "Version 1.6.10 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.6.10, our fifth patch release for
Nim 1.6.

Version 1.6.10 is a result of almost four months of hard work, and it contains
[29 commits](https://github.com/nim-lang/Nim/compare/v1.6.8...v1.6.10),
bringing some general improvements over 1.6.8.

This version brings [OpenSSL 3 support](https://github.com/nim-lang/Nim/pull/20669)
to Nim 1.6, and large allocations and deallocations for ARC/ORC are now
[faster](https://github.com/nim-lang/Nim/pull/20489).

We would recommend to all of our users to upgrade and use version 1.6.10.




# Installing Nim 1.6

## New users

Check out if the package manager of your OS already ships version 1.6.10 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6.10 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.6.10 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2022-11-21-version-1-6-f1519259f85cbdf2d5ff617c6a5534fcd2ff6942).




# Donating to Nim

We would like to encourage you to donate to Nim.
The donated money will be used to further improve Nim by creating bounties
for the most important bugfixes and features.

You can donate via:

* [Open Collective](https://opencollective.com/nim)
* [Patreon](https://www.patreon.com/araq)
* [BountySource](https://salt.bountysource.com/teams/nim)
* [PayPal](https://www.paypal.com/donate/?hosted_button_id=KYXH3BLJBHZTA)
* Bitcoin: `1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ`

If you are a company, we also offer commercial support.




# Bugfixes

These reported issues were fixed:

- Fixed "--styleCheck:off does not work (and --styleCheck:hint is now the default?)"
  ([#20397](https://github.com/nim-lang/Nim/issues/20397))
- Fixed "`dereferencing pointer to incomplete type` error with gcc 9.4 with statics/`cast`"
  ([#20141](https://github.com/nim-lang/Nim/issues/20141))
- Fixed "`strutils.find` uses cstring optimization that stops after \0"
  ([#19500](https://github.com/nim-lang/Nim/issues/19500))
- Fixed "Nimpretty mangles numeric literal procs"
  ([#20553](https://github.com/nim-lang/Nim/issues/20553))
- Fixed "Regression in proc symbol resolution; Error: attempting to call routine "
  ([#18990](https://github.com/nim-lang/Nim/issues/18990))
- Fixed "`of` operator doesn't consider generics under orc/arc"
  ([#20391](https://github.com/nim-lang/Nim/issues/20391))
- Fixed ""incompatible type" when mixing float32 and cfloat in generics"
  ([#19349](https://github.com/nim-lang/Nim/issues/19349))
- Fixed "`cannot generate code for: mSlice` with `toOpenArray`"
  ([#19969](https://github.com/nim-lang/Nim/issues/19969))
- Fixed "-mm flag is ignored on latest Nim 1.7.1 be4bd8"
  ([#20426](https://github.com/nim-lang/Nim/issues/20426))



The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v1.6.8...v1.6.10).
