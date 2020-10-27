---
title: "Versions 1.2.8 and 1.0.10 released"
author: The Nim Team
---

The Nim team is happy to announce this double release of versions 1.2.8 and 1.0.10.


# Version 1.2.8

Version 1.2.8 is our fourth patch release for Nim 1.2 and it brings several new
fixes since version 1.2.6.


## Installing Nim 1.2.8

### New users

We recommend you to install the newest Nim version (1.4.0 at the time of writing).
Check out if the package manager of your OS already ships Nim 1.4 or
install it as described [here](https://nim-lang.org/install.html).


### Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.2.8 is as easy as:

```bash
$ choosenim 1.2.8
```

Alternatively, you can download Nim 1.2.8 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2020-10-26-version-1-2-dde13f38c9df76671866901852942ad6b942f8e5).


## Bugfixes since 1.2.6

- Fixed "Defer and --gc:arc"
  ([#15071](https://github.com/nim-lang/Nim/issues/15071))
- Fixed "Issue with --gc:arc at compile time"
  ([#15129](https://github.com/nim-lang/Nim/issues/15129))
- Fixed "Nil check on each field fails in generic function"
  ([#15101](https://github.com/nim-lang/Nim/issues/15101))
- Fixed "[strscans] scanf doesn't match a single character with $+ if it's the end of the string"
  ([#15064](https://github.com/nim-lang/Nim/issues/15064))
- Fixed "Crash and incorrect return values when using readPasswordFromStdin on Windows."
  ([#15207](https://github.com/nim-lang/Nim/issues/15207))
- Fixed "Inconsistent unsigned -> signed RangeDefect usage across integer sizes"
  ([#15210](https://github.com/nim-lang/Nim/issues/15210))
- Fixed "toHex results in RangeDefect exception when used with large uint64"
  ([#15257](https://github.com/nim-lang/Nim/issues/15257))
- Fixed "Mixing 'return' with expressions is allowed in 1.2"
  ([#15280](https://github.com/nim-lang/Nim/issues/15280))
- Fixed "proc execCmdEx doesn't work with -d:useWinAnsi"
  ([#14203](https://github.com/nim-lang/Nim/issues/14203))
- Fixed "memory corruption in tmarshall.nim"
  ([#9754](https://github.com/nim-lang/Nim/issues/9754))
- Fixed "Wrong number of variables"
  ([#15360](https://github.com/nim-lang/Nim/issues/15360))
- Fixed "defer doesnt work with block, break and await"
  ([#15243](https://github.com/nim-lang/Nim/issues/15243))
- Fixed "Sizeof of case object is incorrect. Showstopper"
  ([#15516](https://github.com/nim-lang/Nim/issues/15516))
- Fixed "Mixing 'return' with expressions is allowed in 1.2"
  ([#15280](https://github.com/nim-lang/Nim/issues/15280))
- Fixed "regression(1.0.2 => 1.0.4) VM register messed up depending on unrelated context"
  ([#15704](https://github.com/nim-lang/Nim/issues/15704))


Full changelog since v1.2.6 contains [53 commits](https://github.com/nim-lang/Nim/compare/v1.2.6...v1.2.8).



# Verson 1.0.10

Version 1.0.10 is our fifth patch release for Nim 1.0 for those users who haven't
yet switched to Nim 1.4, coming 3 months after the release of Nim 1.0.8.

If you are still on Nim 1.0.x, and would like to know about new features
available in Nim 1.2 and 1.4, check out our
[version 1.2.0 release article](https://nim-lang.org/blog/2020/04/03/version-120-released.html) and
[version 1.4.0 release article](https://nim-lang.org/blog/2020/10/16/version-140-released.html).


## Installing Nim 1.0.10

### New users

We recommend you to install the newest Nim version (1.4.0 at the time of writing).
Check out if the package manager of your OS already ships Nim 1.4 or
install it as described [here](https://nim-lang.org/install.html).


### Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.0.10 is as easy as:

```bash
$ choosenim 1.0.10
```

Alternatively, you can download Nim 1.0.10 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2020-10-26-version-1-0-0ca09f64cf6ecf2050b58bc26ebc622f856b4dc2).


## Bugfixes since 1.0.8

- Fixed "Defer and --gc:arc"
  ([#15071](https://github.com/nim-lang/Nim/issues/15071))
- Fixed "Nil check on each field fails in generic function"
  ([#15101](https://github.com/nim-lang/Nim/issues/15101))
- Fixed "Sizeof of case object is incorrect. Showstopper"
  ([#15516](https://github.com/nim-lang/Nim/issues/15516))
- Fixed "regression(1.0.2 => 1.0.4) VM register messed up depending on unrelated context"
  ([#15704](https://github.com/nim-lang/Nim/issues/15704))


Full changelog since v1.0.8 contains [22 commits](https://github.com/nim-lang/Nim/compare/v1.0.8...v1.0.10).
