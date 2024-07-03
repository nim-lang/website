---
title: "Nim version 2.0.8 released"
author: The Nim Team
---

The Nim team is happy to announce Nim version 2.0.8, our fourth patch release for Nim 2.0.

Version 2.0.8 is a small release, containing just [20 commits](https://github.com/nim-lang/Nim/compare/v2.0.6...v2.0.8), but it brings important improvements to Nim 2.0.6, released 10 days ago.

Major improvements in this release:
- Nim's allocator is now much more stable with `--threads:on`.
- Better support for `gcc14`.
- Optimized `setLen(0)` for uninitialized strings and seqs.
- Optimized `move` when used with `--mm:refc`.

Check out if the package manager of your OS already ships version 2.0.8 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 2.0.8 is as easy as:

```bash
$ choosenim 2.0.8
```

If you are on OSX ARM, `choosenim` will not work for you.
Please choose an alternative method of installing or updating.

Alternatively, you can download Nim 2.0.8 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2024-07-03-version-2-0-5935c3bfa9fec6505394867b23510eb5cbab3dbf).




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

- Fixed "[Semi-regression] C code contains backtick\`gensym"
  ([#23711](https://github.com/nim-lang/Nim/issues/23711))
- Fixed "`setLen(0)` allocates memory causing performance regression"
  ([#23742](https://github.com/nim-lang/Nim/issues/23742))
- Fixed "Sigsegv on std/tasks destructor"
  ([#23725](https://github.com/nim-lang/Nim/issues/23725))
- Fixed "`genericAssign` does not take care of the `importC` variables"
  ([#9940](https://github.com/nim-lang/Nim/issues/9940))
- Fixed "`move(table)` does not move the table"
  ([#23759](https://github.com/nim-lang/Nim/issues/23759))
- Fixed "Local variables can be prematurely moved to closure, causing use-after-move"
  ([#23748](https://github.com/nim-lang/Nim/issues/23748))
- Fixed "`tvatiteropenarray` test fails with c++"
  ([#19977](https://github.com/nim-lang/Nim/issues/19977))

The complete list of changes is available
[here](https://github.com/nim-lang/Nim/compare/v2.0.6...v2.0.8).
