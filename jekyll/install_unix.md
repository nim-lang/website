---
layout: page
title: Unix installation
css_class: install_unix
current: Install
---


<h1 class="text-centered page-title main-heading">Install Nim on Unix</h1>

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

# Notes about installation from source

After downloading the compressed archive, extract its contents into the
desired installation directory.

Open a new terminal window, ``cd`` into the extracted directory, and
execute the following commands:

```bash
sh build.sh
bin/nim c koch
./koch tools
```

## Configuring the ``PATH`` environment variable

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

# Other dependencies

There are a number of other dependencies that you may need to install in order
to use Nim. They include:

* PCRE
* OpenSSL

You can use your package manager to install these dependencies when
necessary.

# Installation using a package manager

## macOS

```
brew install nim
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

## Arch Linux

```
pacman -S nim
```

## Void Linux

```
xbps-install -S nim
```

## FreeBSD

```
pkg install nim
```

