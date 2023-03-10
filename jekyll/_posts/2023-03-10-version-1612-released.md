---
title: "Version 1.6.12 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.6.12, our sixth patch release for
Nim 1.6.

Version 1.6.12 is a result of almost four months of hard work, and it contains
[51 commits](https://github.com/nim-lang/Nim/compare/v1.6.10...v1.6.12),
bringing some general improvements over 1.6.10.

We would recommend to all of our users to upgrade and use version 1.6.12.




# Installing Nim 1.6

## New users

Check out if the package manager of your OS already ships version 1.6.12 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6.12 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.6.12 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2023-03-10-version-1-6-1aa9273640c0c51486cf3a7b67282fe58f360e91).




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

- Fixed "sizeof object containing a `set` is wrong"
  ([#20914](https://github.com/nim-lang/Nim/issues/20914))
- Fixed "Missing bounds check for `len(toOpenArray..)`"
  ([#20954](https://github.com/nim-lang/Nim/issues/20954))
- Fixed "Add warning for bare `except:` clause"
  ([#19580](https://github.com/nim-lang/Nim/issues/19580))
- Fixed "Little Copyright notice inconsistency"
  ([#20906](https://github.com/nim-lang/Nim/issues/20906))
- Fixed "std/deques: wrong result after calling shrink"
  ([#21278](https://github.com/nim-lang/Nim/issues/21278))
- Fixed "`io.readLine` adds '\00' char to the end"
  ([#21273](https://github.com/nim-lang/Nim/issues/21273))
- Fixed "New JS mdoe issue: return + ref ints."
  ([#21317](https://github.com/nim-lang/Nim/issues/21317))
- Fixed "Bad codegen for passed var seq to proc returning array[] converted to seq with @"
  ([#21333](https://github.com/nim-lang/Nim/issues/21333))
- Fixed "Templates allowed to use ambiguous identifier"
  ([#1027](https://github.com/nim-lang/Nim/issues/1027))
- Fixed "Mutating a var parameter through a mutable view triggers SIGSEGV"
  ([#20422](https://github.com/nim-lang/Nim/issues/20422))
- Fixed "macOS use SecRandomCopyBytes instead of getentropy"
  ([#20466](https://github.com/nim-lang/Nim/issues/20466))
- Fixed "gcc error when constructing an object that has the same name in the same file name in 2 different directories"
  ([#20139](https://github.com/nim-lang/Nim/issues/20139))


The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v1.6.10...v1.6.12).

