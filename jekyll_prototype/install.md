---
layout: page
title: Install
version: 0.16.0
css_class: install
---

<h1 class="text-centered page-title main-heading">Install Nim</h1>
<h1>Binaries</h1>
<div class="pure-g">
  <div class="pure-u-1 pure-u-md-2-5 os-box">
    <i class="fa fa-windows fa-5x" aria-hidden="true"></i>
    <div class="links">
      <p>
        <a href="{{ site.baseurl }}/download/nim-{{ page.version }}_x32.zip">
          nim-{{ page.version }}_x32.zip
        </a>
          (<a href="{{ site.baseurl }}/download/nim-{{ page.version }}_x32.zip.sig">SHA256</a>)
      </p>
      <p>
        <a href="{{ site.baseurl }}/download/nim-{{ page.version }}_x64.zip">
          nim-{{ page.version }}_x64.zip
        </a>
          (<a href="{{ site.baseurl }}/download/nim-{{ page.version }}_x64.zip.sig">SHA256</a>)
      </p>
    </div>
  </div>
</div>

# Notes about binary installation

The installation using the provided zip files should be fairly
straightforward. Simply extract the files into the desired installation
directory.

## Configuring the ``PATH`` environment variable

The binaries from the zip file live inside the ``bin`` folder.
It is common for Nim developers to include two directories in their
[``PATH`` environment variable](https://en.wikipedia.org/wiki/PATH_(variable)):

* the aforementioned ``bin`` folder
* ``~/.nimble/bin`` (where ``~`` is ``C:\Users\username\.nimble``)

The zip file includes a simple application called ``finish.exe`` that can
attempt to add the first directory into your ``PATH``.
This tool also attempts to check for the
presence of a C compiler. But because of differences between platforms,
command shells and bugs in ``finish.exe``, the modifications to the ``PATH``
variable may fail or you may see a false error message regarding your
C compiler.

# Notes about compiler dependencies

The Nim compiler needs a C compiler in order to compile software. You must
install this separately and ensure that it is in your ``PATH``.

## Windows

The following versions of MingW are known to work with the latest version of
Nim.

<!-- TODO: Instructions on what to do with these 7z files? -->

* 32 bit - [mingw32-6.3.0.7z]({{ site.baseurl }}/download/mingw32-6.3.0.7z)
* 64 bit - [mingw64-6.3.0.7z]({{ site.baseurl }}/download/mingw64-6.3.0.7z)

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

Windows users can download the DLLs for these
[here]({{ site.baseurl }}/download/dlls.zip). Linux and macOS users can
install these using their package manager.

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

# Installation from source

<div class="pure-g">
  <div class="pure-u-1 pure-u-md-4-5 os-box">
    <i class="fa fa-windows fa-5x" aria-hidden="true"></i>
    <i class="fa fa-apple fa-5x" aria-hidden="true"></i>
    <i class="fa fa-linux fa-5x" aria-hidden="true"></i>
    <div class="links">
      <p>
        <a href="{{ site.baseurl }}/download/nim-{{ page.version }}.tar.xz">
          nim-{{ page.version }}.tar.xz
        </a>
          (<a href="{{ site.baseurl }}/download/nim-{{ page.version }}.tar.xz.sig">SHA256</a>)
      </p>
    </div>
  </div>
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

* the aforementioned ``bin`` folder
* ``~/.nimble/bin``

# Nightlies

For instructions on how to build from GitHub, refer to the
[readme](https://github.com/nim-lang/Nim#compiling).