---
title: "Version 0.19.2 released"
author: The Nim Team
---

The Nim team is happy to announce that the latest release of Nim,
version 0.19.2, is now available. Nim is a systems programming language that
focuses on performance, portability and expressiveness.

This is a bugfix release of version 0.19.0. No new features or breaking changes.
The most important bugfixes are:

- ``spawn`` can handle the empty seqs/strings that are internally
  represented as ``nil``.
- The most pressing bugs of the documentation generator have been fixed.
- async streaming of the httpclient has been fixed.


# Installing 0.19.2

If you have installed a previous version of Nim using ``choosenim``,
getting Nim 0.19.2 is as easy as:

```bash
$ choosenim update stable
```

If you don't have it already, you can get ``choosenim`` by following
[these instructions](https://github.com/dom96/choosenim) or you can install
Nim by following the instructions on our
[install](https://nim-lang.org/install.html) page.
