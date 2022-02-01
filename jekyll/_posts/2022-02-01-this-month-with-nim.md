---
title: "This Month with Nim: Feburary 2022"
author: The Nim Community
excerpt: "January and December introduced cool and interesting libraries."
---

## [MCD](https://gitlab.com/malicious-commit-detector/mcd)

#### Author: [EchoPouet](https://gitlab.com/EchoPouet)
MCD (Malicious Commit Detector) is an application to detect which commit generates malicious code detection by antivirus software.

MCD use the [Virus Total](https://www.virustotal.com) web API to detect malicious code in files.
You need a API key that you can get with a free Virus Total account.
A pro account is prefered if you have lot of files to check because the free version limit the number of request.

To analyse your project commits, you must create a file to explain how build the project that you will test.

The file is a TOML format it must contains these keys:

* project_dir : path of the project source code. Absolute path or relative to this file.
* build_dir : folder where the commands must be run. Relative path to project_dir.
* build_command : a list of succesive commands to run to build your project. Relative path to project_dir.
* file_path : a list of all files to analyse. Relative path to project_dir.

To analyze the project's master branch, run the following command:
```
.\mcd.exe detectCommit -a=XXXXXXXXXX -c=c:\Users\A\mcd\tests\mcd-config.toml -b=master
Configuration file: c:\Users\A\mcd\tests\mcd-config.toml
🔍 Commit "70740ce"
🔨 Build
⏳ Wait analyze 25 sec ...
  analyze not completed, wait 25 sec ...
  analyze not completed, wait 25 sec ...
  analyze not completed, wait 25 sec ...
❌ malicious.exe
🔍 Commit "c92584b"
🔨 Build
⏳ Wait analyze 25 sec ...
  analyze not completed, wait 25 sec ...
  analyze not completed, wait 25 sec ...
  analyze not completed, wait 25 sec ...
✔️ malicious.exe
Commit "c92584b" is the last commit without generated malicous files
```


## [grab](https://github.com/metagn/grab)

#### Author: [metagn](https://github.com/metagn)
Adds a `grab` statement for installing and importing Nimble packages
directly through Nim code, similar to Groovy's Grape and `@Grab`. Works
with NimScript, as all the computation is done at compile time.

This installs the package globally, and can affect compilation time. For
this reason it should generally only be used for scripts and snippets and
the like.

```nim
import grab

# install the package `regex` if not installed already, and import it
grab "regex"

assert "abc.123".match(re"\w+\.\d+")

# run install command with the given arguments
grab package("-y https://github.com/arnetheduck/nim-result@#HEAD",
             name = "result", forceInstall = true): # clarify package name to correctly query path
  # imports from the package directory
  import results

func works(): Result[int, string] =
  result.ok(123)

func fails(): Result[int, string] =
  result.err("abc")

assert works().isOk
assert fails().error == "abc"
```

Install with:

```
nimble install grab
```

## [Slicerator](https://github.com/beef331/slicerator)

#### Author: [Jason Beetham](https://github.com/beef331/slicerator)

Slicerator is a package with a bunch of goodies for iterators.
From implementing an `[]` iterator for `openarray`s for 0 copy slicing iterations, to being able to make a closure from an inline iterator it's got useful features.
The following is a showcase of just some of the features:
```nim
import slicerator
var myIter = asClosure("hello".items)
assert peek(myIter) == 'h'
assert peek(myIter) == 'h'
assert myIter() == 'h'
assert myIter() == 'e'
reset(myIter)
assert myIter() == 'h'

const data = [10, 20, 30, 40, 50, 60]
for i, x in chain data.pairs.unpack(index, val).map(val * 30):
  assert index == i
  assert data[index] * 30 == x
let a = zip(data.items, "helloWorld".items, "myIter")
assert a == @[(10, 'h', 'm'), (20, 'e', 'y'), (30, 'l', 'I'), (40, 'l', 't'), (50, 'o', 'e'), (60, 'W', 'r')]

```

----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
