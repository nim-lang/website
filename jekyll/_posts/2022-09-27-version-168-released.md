---
title: "Version 1.6.8 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.6.8, our fourth patch release for
Nim 1.6.

Version 1.6.8 is a result of almost four months of hard work, and it contains
[65 commits](https://github.com/nim-lang/Nim/compare/v1.6.6...v1.6.8),
bringing some general improvements over 1.6.6.

We would recommend to all of our users to upgrade and use version 1.6.8.



# Installing Nim 1.6

## New users

Check out if the package manager of your OS already ships version 1.6.8 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6.8 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.6.8 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2022-09-27-version-1-6-c9f46ca8c9eeca8b5f68591b1abe14b962f80a4c).



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

- Fixed "Add --gc:arc (or --mm:arc) induce different behavior when using converter"
  ([#19862](https://github.com/nim-lang/Nim/issues/19862))
- Fixed "Converting unsigned integer to float fails in VM"
  ([#19199](https://github.com/nim-lang/Nim/issues/19199))
- Fixed "regression(0.20.0 => devel): var params assignment gives silently wrong results in VM"
  ([#15974](https://github.com/nim-lang/Nim/issues/15974))
- Fixed "`genDepend` broken for duplicate module names in separate folders"
  ([#18735](https://github.com/nim-lang/Nim/issues/18735))
- Fixed "Orc booting compiler doesn't work with `newSeq` operations"
  ([#19404](https://github.com/nim-lang/Nim/issues/19404))
- Fixed "hasCustomPragma and getCustomPragmaVal don't work on fields with backticks"
  ([#20067](https://github.com/nim-lang/Nim/issues/20067))
- Fixed "Cant use `uint64` in case"
  ([#20031](https://github.com/nim-lang/Nim/issues/20031))
- Fixed "`nim jsondoc` output is broken"
  ([#20132](https://github.com/nim-lang/Nim/issues/20132))
- Fixed "Underscores are unnecessarily escaped in `db_mysql`"
  ([#20153](https://github.com/nim-lang/Nim/issues/20153))
- Fixed "Invalid codegen when `block` ends with `lent`"
  ([#20107](https://github.com/nim-lang/Nim/issues/20107))
- Fixed "`locals` doesn't work with ORC"
  ([#20162](https://github.com/nim-lang/Nim/issues/20162))
- Fixed "`reset` does not work on `set`"
  ([#19967](https://github.com/nim-lang/Nim/issues/19967))
- Fixed "selectRead and selectWrite are dangerous to use sockets with FD numbers bigger than `FD_SETSIZE` (1024) on \*nixes"
  ([#19973](https://github.com/nim-lang/Nim/issues/19973))
- Fixed "use-after-free bugs in object variants"
  ([#20305](https://github.com/nim-lang/Nim/issues/20305))
- Fixed "[ARC] C compiler error when using the result of a template in the subscript operator"
  ([#20303](https://github.com/nim-lang/Nim/issues/20303))
- Fixed "Calling nullary templates without () doesn't work inside calls inside other templates"
  ([#13515](https://github.com/nim-lang/Nim/issues/13515))
- Fixed "[Regression] Incorrect captures of pegs \ident macro in nim 1.6"
  ([#19104](https://github.com/nim-lang/Nim/issues/19104))
- Fixed "Windows gcc shipped with choosenim 1.6.4 with TLS emulation turned off : The application was unable to start correctly (0xc000007b)."
  ([#19713](https://github.com/nim-lang/Nim/issues/19713))



The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v1.6.6...v1.6.8).
