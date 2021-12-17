---
title: "Version 1.6.2 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.6.2, our first patch release for
Nim 1.6.

Version 1.6.2 is a result of two month of hard work, and it contains
[41 commits](https://github.com/nim-lang/Nim/compare/v1.6.0...v1.6.2),
fixing more than 15 reported issues and bringing some general improvements over 1.6.0.

We would recommend to all of our users to upgrade and use version 1.6.2.


# Installing Nim 1.6

## New users

Check out if the package manager of your OS already ships version 1.6.2 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.6.2 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.6.2 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2021-12-17-version-1-6-9084d9bc02bcd983b81a4c76a05f27b9ce2707dd).



# Donating to Nim

We would like to encourage you to donate to Nim.
The donated money will be used to further improve Nim by creating bounties
for the most important bugfixes and features.

You can donate via:

* [Open Collective](https://opencollective.com/nim)
* [Patreon](https://www.patreon.com/araq)
* [BountySource](https://salt.bountysource.com/teams/nim)
* [PayPal](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=FLWX5V2PMAXAU)
* Bitcoin: `1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ`

If you are a company, we also offer commercial support.


# Bugfixes

These reported issues were fixed:

- Fixed "SYS_getrandom undeclared compiling nim 1.6.0 stdlib on linux kernel < 3.17 (including RHEL7)"
  ([#19052](https://github.com/nim-lang/Nim/issues/19052))
- Fixed "Compiler terminated with IndexDefect if `--gc:arc` or `--gc:orc` given, when proc return a global variable with `lent` or `var` type"
  ([#18971](https://github.com/nim-lang/Nim/issues/18971))
- Fixed "Errors initializing an object of RootObj with the C++ backend"
  ([#18410](https://github.com/nim-lang/Nim/issues/18410))
- Fixed "Stack traces broken with arc/orc"
  ([#19078](https://github.com/nim-lang/Nim/issues/19078))
- Fixed "isolate happily compiles despite not being able to prove the absence of captured refs"
  ([#19013](https://github.com/nim-lang/Nim/issues/19013))
- Fixed "PragmaExpr erroneously added to enum type"
  ([#19011](https://github.com/nim-lang/Nim/issues/19011))
- Fixed "RVO not applied to object with large array"
  ([#14470](https://github.com/nim-lang/Nim/issues/14470))
- Fixed "Compile error from backend gcc when generic int type is defined"
  ([#19051](https://github.com/nim-lang/Nim/issues/19051))
- Fixed "Varargs broken in 1.6.0 when len is 0 and preceding block arguments."
  ([#19015](https://github.com/nim-lang/Nim/issues/19015))
- Fixed "VM replaces declared type with alias"
  ([#19198](https://github.com/nim-lang/Nim/issues/19198))
- Fixed "regression: effectless inner template declared as side effect"
  ([#19159](https://github.com/nim-lang/Nim/issues/19159))
- Fixed "variables in closure iterators loop are not correctly unassigned"
  ([#19193](https://github.com/nim-lang/Nim/issues/19193))
- Fixed "Unexported converters propagate through imports and affect code"
  ([#19213](https://github.com/nim-lang/Nim/issues/19213))
- Fixed "[arc] of operation segfaults for a ptr object containing traced reference"
  ([#19205](https://github.com/nim-lang/Nim/issues/19205))
- Fixed "Static linking with a .lib file not working"
  ([#15955](https://github.com/nim-lang/Nim/issues/15955))


This release also includes these improvements:

- Allow converting static vars to openArray
  ([PR #19047](https://github.com/nim-lang/Nim/pull/19047))
- Do not break interpolation for field init message string
  ([PR #19085](https://github.com/nim-lang/Nim/pull/19085))
- fixes another effect inference bug
  ([PR #19100](https://github.com/nim-lang/Nim/pull/19100))
- fix nimindexterm in rst2tex/doc2tex
  ([PR #19106](https://github.com/nim-lang/Nim/pull/19106))
- Remove tlsEmulation enabled from Windows + GCC config
  ([PR #19119](https://github.com/nim-lang/Nim/pull/19119))
- fixes .raises inference for newSeq builtin under --gc:orc
  ([PR #19158](https://github.com/nim-lang/Nim/pull/19158))
- Fix undeclared `SYS_getrandom` on emscripten
  ([PR #19144](https://github.com/nim-lang/Nim/pull/19144))
- Merge file size fields correctly on Windows
  ([PR #19141](https://github.com/nim-lang/Nim/pull/19141))
- fix marshal bugs in VM
  ([PR #19161](https://github.com/nim-lang/Nim/pull/19161))
- allow `HSlice` bounded by constants of distinct types
  ([PR #19219](https://github.com/nim-lang/Nim/pull/19219))
- fixes a possible 'javascript:' protocol exploit
  ([PR #19134](https://github.com/nim-lang/Nim/pull/19134))
- let Nim support Nimble 0.14 with lock-file support
  ([PR #19236](https://github.com/nim-lang/Nim/pull/19236))
- nimRawSetjmp: support Windows
  ([PR #19197](https://github.com/nim-lang/Nim/pull/19197))
- Don't read \0 in uri.hostname
  ([PR #19148](https://github.com/nim-lang/Nim/pull/19148))
- json: limit recursion depth
  ([PR #19252](https://github.com/nim-lang/Nim/pull/19252))
