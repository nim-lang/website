---
title: "Version 0.19.4 released"
author: The Nim Team
---

The Nim team is happy to announce that the latest release of Nim,
version 0.19.4, is now available. Nim is a systems programming language that
focuses on performance, portability and expressiveness.

This is mostly a bugfix release of version 0.19.2.
There are no breaking changes.
The most important bugfixes are:

- The mark&sweep GC had a serious performance regression that has been fixed.
- The produced tarballs now support `koch tests`.
- Json escaping has been fixed.
- The documentation for `async` procs was missing, fixed.


## Installing 0.19.4

If you have installed a previous version of Nim using ``choosenim``,
getting Nim 0.19.4 is as easy as:

```bash
$ choosenim update stable
```

If you don't have it already, you can get ``choosenim`` by following
[these instructions](https://github.com/dom96/choosenim) or you can install
Nim by following the instructions on our
[install](https://nim-lang.org/install.html) page.


### Bugfixes

