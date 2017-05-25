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

The binaries from the zip file live inside the ``bin`` directory.
It is common for Nim developers to include two directories in their
[``PATH`` environment variable](https://en.wikipedia.org/wiki/PATH_(variable)):

* the aforementioned ``bin`` directory
* ``%USERPROFILE%\.nimble\bin`` (where ``%USERPROFILE%`` is the home directory)

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

## Use the Microsoft C/C++ Compiler backend instead of MinGW

As an alternative to MinGW, Nim also supports the Microsoft C/C++ Optimizing Compiler
that is distributed either as part of [Visual Studio](https://www.visualstudio.com/vs/) or 
as a standalone installation with the [Visual C++ Build Tools](http://landinghub.visualstudio.com/visual-cpp-build-tools).

However, normally you don't include the Microsoft Compiler in your `PATH` environment
variable, as it contains a rather complex (*some say bloated*) environment setup that
might conflict with your day-to-day Windows operations.  
For that reason, Nim is configured by default to use the `vccexe` tool **since Version 0.16.0**
for the `vcc` compiler backend. This tool will automatically setup the build environment for the
Microsoft C/C++ compiler and forward the build inctructions to the compiler.

Unfortunately, the `vccexe` tool is not included in the standard Nim release for Version 0.16.0.
And it will have to be built from source from the default Nim installation.

## Building the `vccexe` tool with VCC from source

Here's how to build `vccexe` from source using the *vcc* compiler backend without MinGW.

1. Open a Developer Command Prompt  
   Use **either** of the following methods:
   <ul>
     <li>
        Use the Start Menu to launch the Developer Command Prompt
        <br/>
        For x86 (32-bit) and VS2017: <code>x86 Native Tools Command Prompt for VS 2017</code>
        <br/>
        For x64 (64-bit) and VS2017: <code>x64 Native Tools Command Prompt for VS 2017</code>
        <br/>
        Other Visual Studio installations and the Visual C++ Build Tools all install similarly
        named Start Menu entries. Take care to select the architecture that matches your Nim
        installation architecture.
     </li>
     <li>
        Call the <code>vcvarsall.bat</code> script that loads the Microsoft Compiler environment.
        <br/>
        In a regular Command Prompt execute the following command:
        <br/>
        For x86 (32-bit) and Visual Studio 2015: <code>CALL "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" x86</code>
        <br/>
        For x64 (64-bit) and Visual Studio 2015: <code>CALL "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" x64</code>
        <br/>
        Older Versions of Visual Studio use the <code>VS120COMNTOOLS</code>, <code>VS110COMNTOOLS</code>
        <code>VS100COMNTOOLS</code> and <code>VS90COMNTOOLS</code> environment variables.
        <br/>
        Visual Studio 2017 does not set permanent environment variables, instead locate the <code>vcvarsall.bat</code> file
        located in <code>VC\Auxiliary\Build</code> under your VS2017 install directory instead.
     </li>
   </ul>

2. The `nim.cfg` configuration file located in the `config` folder is set up to use 
   `vccexe` for the vcc compiler backend.  
   All settings that refer to `vccexe.exe` must **temporarily** be changed/overridden  
   to refer to `cl.exe` instead. Make sure to be able to revert these changes in step 5.  
   Least disruptive is to create a `nim.cfg` file under `%APPDATA%`
   (`C:\Users\<Username>\AppData\Roaming\nim.cfg`) with the following settings
   ```
   vcc.exe = "cl.exe"
   vcc.linkerexe = "cl.exe"
   ```
3. In your Developer Command Prompt that you have set up in step 1, navigate to the installation root
   of your Nim installation.
4. Execute:  
   `nim compile --cc:vcc -o:bin\vccexe tools\vccenv\vccexe`
5. Revert the changes made in step 2 by deleting the lines added to the `%APPDATA%\nim.cfg` file.  
   If you want to use the `vcc` compiler backend by default, add the following to your `nim.cfg`:
   ```
   cc = vcc
   ```
   You can always force Nim to use the `vcc` compiler backend by adding `--cc:vcc` to your nim
   command (as shown in step 4).

# Other dependencies

There are a number of other dependencies that you may need to install in order
to use Nim. They include:

* PCRE
* OpenSSL

Windows users can download the DLLs for these
[here]({{ site.baseurl }}/download/dlls.zip).
