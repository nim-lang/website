---
layout: page
title: Windows installation
css_class: install_windows
current: Install
---


<h1 class="text-centered page-title main-heading">Install Nim on Windows</h1>

# Manual installation

<div class="center">
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}_x32.zip"
    class="pure-button pure-button-primary download-button">
    <i class="fa fa-file-archive-o" aria-hidden="true"></i>
    Download x86 zip
  </a>
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}_x32.zip.sha256"
    class="pure-button">
    <i class="fa fa-file-text-o" aria-hidden="true"></i>
    SHA256
  </a>
</div>

<div class="center">
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}_x64.zip"
    class="pure-button pure-button-primary download-button">
    <i class="fa fa-file-archive-o" aria-hidden="true"></i>
    Download x86_64 zip
  </a>
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}_x64.zip.sha256"
    class="pure-button">
    <i class="fa fa-file-text-o" aria-hidden="true"></i>
    SHA256
  </a>
</div>

# Notes about binary installation

The installation using the provided zip files should be fairly
straightforward. Simply extract the files into the desired installation
directory, and run ``finish.exe``.

## Configuring the ``PATH`` environment variable

The binaries from the zip file live inside the ``bin`` directory.
It is common for Nim developers to include two directories in their
[``PATH`` environment variable](https://en.wikipedia.org/wiki/PATH_(variable)):

* the aforementioned ``bin`` directory
* ``%USERPROFILE%\.nimble\bin`` (where ``%USERPROFILE%`` is the home directory)

The zip file includes a simple application called ``finish.exe`` that can
attempt to add the first directory into your ``PATH``.
This tool also checks for the presence of a C compiler and can install ``MingW``,
the GNU C compiler collection for Windows.

# Notes about compiler dependencies

The Nim compiler needs a C compiler in order to compile software. You can
use ``finish.exe`` to install MingW.

The following versions of MingW are known to work with the latest version of
Nim.

<!-- TODO: Instructions on what to do with these 7z files? -->

* 32 bit - [mingw32.7z]({{ site.baseurl }}/download/mingw32.7z)
* 64 bit - [mingw64.7z]({{ site.baseurl }}/download/mingw64.7z)

# Other dependencies

There are a number of other dependencies that you may need to install in order
to use Nim. They include:

* PCRE
* OpenSSL

Windows users can download the DLLs for these
[here]({{ site.baseurl }}/download/dlls.zip).  Place the DLLs in the same
directory as `nim.exe`.


# Installation using ``choosenim``

[``choosenim``](https://github.com/dom96/choosenim#choosenim) is an
installer for the Nim programming language. It allows you
to easily switch between versions of Nim, whether that is the latest stable
release or the latest development version.


# Install Nim using Scoop

[Scoop](https://scoop.sh/) is a command-line installer for Windows.
It can install Nim with following command line that also automatically install gcc and set PATH.

```
scoop install nim
```

Update Nim:

```
scoop update
scoop update nim
```
