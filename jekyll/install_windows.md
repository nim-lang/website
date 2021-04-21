---
layout: page
title: Windows installation
css_class: install_windows
current: Install
---


<h1 class="text-centered page-title main-heading">Install Nim on Windows</h1>

# Manual installation

If you are not sure which version (64-bit or 32-bit) to pick, it is very likely
that you want the 64-bit version (x86\_64):

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

If you know what you are doing and you are sure you need a 32-bit version,
you can download it below:

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
attempt to add both directories to your ``PATH``.
This tool also checks for the presence of a C compiler and can install ``MingW``,
the GNU C compiler collection for Windows.

## Compiler dependencies

The Nim compiler needs a C compiler in order to compile software. You can
use ``finish.exe`` to install MingW.

The following versions of MingW are known to work with the latest version of
Nim.

<!-- TODO: Instructions on what to do with these 7z files? -->

* 32 bit - [mingw32.7z]({{ site.baseurl }}/download/mingw32.7z)
* 64 bit - [mingw64.7z]({{ site.baseurl }}/download/mingw64.7z)


# Installation using ``choosenim``

[``choosenim``](https://github.com/dom96/choosenim#choosenim) is an
installer for the Nim programming language. It allows you
to easily switch between versions of Nim, whether that is the latest stable
release or the latest development version.
