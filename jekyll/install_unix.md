---
layout: page
title: Unix installation
css_class: install_unix
current: Install
---

<h1 class="text-centered page-title main-heading">Install Nim on Unix</h1>

# Installation using ``choosenim``

[``choosenim``](https://github.com/nim-lang/choosenim) is an
installer for the Nim programming language. It allows you
to easily switch between versions of Nim, whether that is the latest stable
release or the latest development version.

To install the latest stable release of Nim using ``choosenim``, just run the
following in your terminal, then follow the onscreen instructions:

```bash
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
```

# Manual installation

## Pre-built binaries for Linux

If you're not sure which version (64-bit or 32-bit) to pick, it is very likely
that you want the 64-bit version (x86\_64):

<div class="center">
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}-linux_x64.tar.xz"
    class="pure-button pure-button-primary download-button">
    <i class="fa fa-file-archive-o" aria-hidden="true"></i>
    Download x86_64 tarball
  </a>
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}-linux_x64.tar.xz.sha256"
    class="pure-button">
    <i class="fa fa-file-text-o" aria-hidden="true"></i>
    SHA256
  </a>
</div>

If you know what you're doing and you're sure you need a 32-bit version,
you can download it below:

<div class="center">
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}-linux_x32.tar.xz"
    class="pure-button pure-button-primary download-button">
    <i class="fa fa-file-archive-o" aria-hidden="true"></i>
    Download x86 tarball
  </a>
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}-linux_x32.tar.xz.sha256"
    class="pure-button">
    <i class="fa fa-file-text-o" aria-hidden="true"></i>
    SHA256
  </a>
</div>

## Source archive

<div class="center">
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}.tar.xz"
    class="pure-button pure-button-primary download-button">
    <i class="fa fa-file-archive-o" aria-hidden="true"></i>
    Download source tarball
  </a>
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}.tar.xz.sha256"
    class="pure-button">
    <i class="fa fa-file-text-o" aria-hidden="true"></i>
    SHA256
  </a>
</div>

After downloading the compressed archive, extract its contents into the
desired installation directory. Pre-built binaries are provided in the
binary distribution.

For the source distribution, open a new terminal window, ``cd`` into the
extracted directory, and execute the following commands:

```bash
sh build.sh
bin/nim c koch
./koch boot -d:release
./koch tools
```

## Configuring the ``PATH`` environment variable for a manual installation

The compiler and tool binaries live inside the ``bin`` directory.
It is common for Nim developers to include two directories in their
[``PATH`` environment variable](https://en.wikipedia.org/wiki/PATH_(variable)):

* the aforementioned ``bin`` directory
* ``~/.nimble/bin`` (where ``~`` is the home directory)

# Notes about compiler dependencies

The Nim compiler needs a C compiler in order to compile software. You must
install this separately and ensure that it is in your ``PATH``.

## macOS

Simply install the latest version of ``clang`` available on your system.
You can do this by:

* Opening a new terminal window
* Executing ``xcode-select --install``
* Clicking on the "Install" button in the dialog box that appears.

**Source:** [Quora](https://www.quora.com/How-do-I-successfully-set-up-LLVM-clang-on-Mac-OS-X-El-Capitan/answer/James-McInnes-1?srid=hq2O)

## Linux

You probably already have a compiler installed. If not, use your package
manager to install either ``gcc`` or ``clang``.

## Other dependencies

There are a number of other dependencies that you may need to install in order
to use Nim. They include:

* PCRE
* OpenSSL

You can use your package manager to install these dependencies when
necessary.



# Installation using package managers

## Arch Linux

```
pacman -S nim
```

## Debian / Ubuntu

```
apt-get install nim
```

## Docker

The community managed [Docker images](https://hub.docker.com/r/nimlang/nim/)
are published on Docker Hub and include
the compiler and Nimble. There are images for standalone scripts as well as
Nimble packages.

Get the latest stable image:

```
docker pull nimlang/nim
```

The latest development version:

```
docker pull nimlang/nim:devel
```

## FreeBSD

```
pkg install nim
```

## macOS

```
brew install nim
```

## OpenBSD

```
pkg_add nim
```

## openSUSE

```
zypper in nim
```

## Void Linux

```
xbps-install -S nim
```
