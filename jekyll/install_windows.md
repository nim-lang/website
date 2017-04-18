---
layout: page
title: Windows installation
css_class: install_windows
current: Install
---


<h1 class="text-centered page-title main-heading">Install Nim on Windows</h1>

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

The following versions of MingW are known to work with the latest version of
Nim.

<!-- TODO: Instructions on what to do with these 7z files? -->

* 32 bit - [mingw32-6.3.0.7z]({{ site.baseurl }}/download/mingw32-6.3.0.7z)
* 64 bit - [mingw64-6.3.0.7z]({{ site.baseurl }}/download/mingw64-6.3.0.7z)

# Other dependencies

There are a number of other dependencies that you may need to install in order
to use Nim. They include:

* PCRE
* OpenSSL

Windows users can download the DLLs for these
[here]({{ site.baseurl }}/download/dlls.zip).