---
title: "Version 1.6.4 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.6.4, our second patch release for
Nim 1.6.

Version 1.6.4 is a result of a month and a half of hard work, and it contains
[33 commits](https://github.com/nim-lang/Nim/compare/v1.6.2...v1.6.4),
fixing one major regression and bringing some general improvements over 1.6.2.

The most important [fix](https://github.com/nim-lang/Nim/pull/19385) is for
the [C FFI regression](https://github.com/nim-lang/Nim/issues/19342)
introduced in 1.6.2.

We would recommend to all of our users to upgrade and use version 1.6.4.



# Installing Nim 1.6

## New users

Check out if the package manager of your OS already ships version 1.6.4 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6.4 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.6.4 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2022-02-09-version-1-6-7994556f3804c217035c44b453a3feec64405758).



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

- Fixed "Potential C FFI regression"
  ([#19342](https://github.com/nim-lang/Nim/issues/19342))
- Fixed "re.split unexpected results with zero-width characters"
  ([#14468](https://github.com/nim-lang/Nim/issues/14468))
- Fixed "Out-of-bounds in strformat"
  ([#19107](https://github.com/nim-lang/Nim/issues/19107))
- Fixed "Adding an empty list to a non-empty list breaks the latter list"
  ([#19297](https://github.com/nim-lang/Nim/issues/19297))
- Fixed "Wrong result when using varargs with var arguments."
  ([#16617](https://github.com/nim-lang/Nim/issues/16617))
- Fixed "Adding an empty `DoublyLinkedList` to a non-empty `DoublyLinkedList` breaks the latter list"
  ([#19314](https://github.com/nim-lang/Nim/issues/19314))
- Fixed "Silent FFI bug when passing array inside object using gc:orc"
  ([#19497](https://github.com/nim-lang/Nim/issues/19497))

The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v1.6.2...v1.6.4).
