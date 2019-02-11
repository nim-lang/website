---
layout: page
title: Unix installation
css_class: install_unix
current: Install
---

<h1 class="text-centered page-title main-heading">Install Nim on Unix</h1>

There are several ways to install Nim on Unix-like systems, depending on
your needs:

* If you just want to use the stable version of Nim, you may find it simplest
  to use your system's package manager.

* If you want to easily switch between versions of Nim,
  including switching between the stable version and the development
  nightlies, you may prefer ``choosenim``.

* If you want to contribute to the Nim project, or if you are using Nim on
  a less well supported platform, you may want a manual installation from
  source.

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

## Fedora

```
dnf install nim
```

## FreeBSD

```
pkg install nim
```

## macOS

```
brew install nim
```

## openSUSE

```
zypper in nim
```

## Void Linux

```
xbps-install -S nim
```

# Installation using ``choosenim``

[``choosenim``](https://github.com/dom96/choosenim#choosenim) is an
installer for the Nim programming language. It allows you
to easily switch between versions of Nim, whether that is the latest stable
release or the latest development version.

Run the following in your terminal, then follow the onscreen instructions:

```bash
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
```

Then you can easily switch between different versions of Nim:

```
$ choosenim stable
   Switched to Nim 0.19.2
$ choosenim devel
   Switched to Nim #devel
```

For more information, see ``choosenim --help``.

# Manual installation from source

You can check out Nim's source [from GitHub](https://github.com/nim-lang/Nim) 
or download a tarball:

<div class="center">
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}.tar.xz"
    class="pure-button pure-button-primary download-button">
    <i class="fa fa-file-archive-o" aria-hidden="true"></i>
    Latest Stable Source
  </a>
  <a href="{{ site.baseurl }}/download/nim-{{ site.nim_version }}.tar.xz.sha256"
    class="pure-button">
    <i class="fa fa-file-text-o" aria-hidden="true"></i>
    (Stable SHA256)
  </a>
  <a class="pure-button" 
      href="https://github.com/nim-lang/nightlies/releases">
  Browse Nightly Sources
  </a>
</div>

After downloading the compressed archive, extract its contents into the
desired installation directory.

Open a new terminal window, ``cd`` into the extracted directory, and
execute the following commands:

```bash
sh build.sh
bin/nim c koch
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

