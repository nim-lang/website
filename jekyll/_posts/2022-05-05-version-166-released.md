---
title: "Version 1.6.6 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.6.6, our third patch release for
Nim 1.6.

Version 1.6.6 is a result of three months of hard work, and it contains
[55 commits](https://github.com/nim-lang/Nim/compare/v1.6.4...v1.6.6),
bringing some general improvements over 1.6.4.

Besides all the bugfixes (you can see the list of them at the bottom of this post),
we have focused on having the standard library use consistent styles for
variable names so it can be used in projects which force a consistent style
with `--styleCheck:usages` option.
Also, ARC/ORC are now considerably faster at method dispatching,
bringing its performance back on the level of the `refc` memory management. 

We would recommend to all of our users to upgrade and use version 1.6.6.



# Installing Nim 1.6

## New users

Check out if the package manager of your OS already ships version 1.6.6 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6.6 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.6.6 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2022-05-05-version-1-6-0565a70eab02122ce278b98181c7d1170870865c).



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

- Fixed "std.streams fails to compile with TCC compiler on Windows and --cpu:amd64"
  ([#16326](https://github.com/nim-lang/Nim/issues/16326))
- Fixed "Compiler version 1.6.0 does not work on Windows XP"
  ([#19038](https://github.com/nim-lang/Nim/issues/19038))
- Fixed "`os.putEnv` does not compile on cpp backend on Windows"
  ([#19292](https://github.com/nim-lang/Nim/issues/19292))
- Fixed "JS target defines gcc"
  ([#19059](https://github.com/nim-lang/Nim/issues/19059))
- Fixed "`static int __tcc_cas(` function in *JavaScript* output when having CC = tcc"
  ([#19330](https://github.com/nim-lang/Nim/issues/19330))
- Fixed "CPU detection for i386"
  ([#19577](https://github.com/nim-lang/Nim/issues/19577))
- Fixed "not flushing stdout in `MSYS`"
  ([#19584](https://github.com/nim-lang/Nim/issues/19584))
- Fixed "Nim-1.6 segfault"
  ([#19569](https://github.com/nim-lang/Nim/issues/19569))
- Fixed "Nim compiler crashing when using control flow statements inside try-catch block on a closure iterator"
  ([#19575](https://github.com/nim-lang/Nim/issues/19575))
- Fixed "Remove deprecated typo poDemon"
  ([#19631](https://github.com/nim-lang/Nim/issues/19631))
- Fixed "useless `overflowChecks` runtime check generated even when one of `a div b` constant"
  ([#19615](https://github.com/nim-lang/Nim/issues/19615))
- Fixed "{.byref,exportc.} types are not output into --header file"
  ([#19445](https://github.com/nim-lang/Nim/issues/19445))
- Fixed "`nim check` reports incorrect errors for nimscript"
  ([#19440](https://github.com/nim-lang/Nim/issues/19440))
- Fixed "Is there proper way to syntax check .nims file?"
  ([#3858](https://github.com/nim-lang/Nim/issues/3858))
- Fixed "dial ignoring buffered parameter"
  ([#19650](https://github.com/nim-lang/Nim/issues/19650))
- Fixed "`nim dump` and other information obtaining commands execute top-level `exec` statements in nims files"
  ([#8219](https://github.com/nim-lang/Nim/issues/8219))
- Fixed "Bug using nested loops in closure iterators"
  ([#18474](https://github.com/nim-lang/Nim/issues/18474))
- Fixed "Import/except doesn't work on devel"
  ([#18986](https://github.com/nim-lang/Nim/issues/18986))
- Fixed "Can't check if stderr is static"
  ([#19680](https://github.com/nim-lang/Nim/issues/19680))
- Fixed "View of seq[T] when T has `seq` attribute won't iter with ARC/ORC, but `len` returns correct number of elements"
  ([#19435](https://github.com/nim-lang/Nim/issues/19435))
- Fixed "StringStream created from string segfaults on write when when using arc"
  ([#19707](https://github.com/nim-lang/Nim/issues/19707))
- Fixed "minor NimNode comment repr() regression 1.0.10 to 1.2.9"
  ([#16307](https://github.com/nim-lang/Nim/issues/16307))
- Fixed "Method dispatch is slow"
  ([#18612](https://github.com/nim-lang/Nim/issues/18612))
- Fixed "Possibly spurious no tuple type for constructor error"
  ([#18409](https://github.com/nim-lang/Nim/issues/18409))
- Fixed "Error with anonymous tuples passed to concept function arguments."
  ([#19730](https://github.com/nim-lang/Nim/issues/19730))


The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v1.6.4...v1.6.6).
