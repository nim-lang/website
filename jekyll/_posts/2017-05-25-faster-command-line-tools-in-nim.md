---
title: "Faster Command Line Tools in Nim"
author: Euan Torano
---

*This is a guest post by Euan Torano cross-posted from [Faster Command Line Tools in Nim](https://www.euantorano.co.uk/posts/faster-command-line-tools-in-nim/). If you would like to publish articles as a guest author on nim-lang.org then get in touch with us via [Twitter](https://twitter.com/nim_lang) or [otherwise](https://github.com/nim-lang/website/issues).*

After having read the blog post titled [`Faster Command Line Tools in D` by Jon Degenhardt](http://dlang.org/blog/2017/05/24/faster-command-line-tools-in-d/) on the D Blog, I was interested to see how Nim would stack up performing the same task.

Rather than explain the task again, I might as well quote the reference post that inspired me:

> It’s a common programming task: Take a data file with fields separated by a delimiter (comma, tab, etc), and run a mathematical calculation involving several of the fields. Often these programs are one-time use scripts, other times they have longer shelf life. Speed is of course appreciated when the program is used more than a few times on large files.
>
> The specific exercise we’ll explore starts with files having keys in one field, integer values in another. The task is to sum the values for each key and print the key with the largest sum.
>
> With the first field as key, second field as value, the key with the max sum is B, with a total of 13.
>
> Fields are delimited by a TAB, and there may be any number of fields on a line. The file name and field numbers of the key and value are passed as command line arguments.

## Implementing the Nim program, first try

This is quite a simple program. All that we need to do is read a file, parse it as CSV data with a tab delimiter and sum the counts.

Luckily, Nim's standard library has many useful modules to help with common tasks like these:

- The [streams](https://nim-lang.org/docs/streams.html) module provides a `FileStream` type for reading from and writing to files.
- The [parsecsv](https://nim-lang.org/docs/parsecsv.html) module provides a simple high performance CSV parser.
- The [tables](https://nim-lang.org/docs/tables.html) module provides a `CountTable` type designed to map a key to its number of occurrences - precisely the task we're trying to accomplish!

The code is pretty simple, so let's start by looking at it in its entirety:

```nim
import os, strutils, streams, tables, parsecsv

const
  Delim = '\t'

proc main() =
  if paramCount() < 3:
    quit("synopsis: " & getAppFilename() & " filename keyfield valuefield")

  let
    filename = paramStr(1)
    keyFieldIndex = parseInt(paramStr(2))
    valueFieldIndex = parseInt(paramStr(3))
    maxFieldIndex = max(keyFieldIndex, valueFieldIndex)

  var
    sumByKey = newCountTable[string]()
    file = newFileStream(filename, fmRead)

  if file == nil:
    quit("cannot open the file " & filename)

  defer: file.close()

  var csv: CsvParser
  open(csv, file, filename, separator=Delim)

  while csv.readRow():
    if len(csv.row) > maxFieldIndex:
      sumByKey.inc(csv.row[keyFieldIndex], parseInt(csv.row[valueFieldIndex]))

  if sumByKey.len() == 0:
    echo "No entries"
  else:
    let largest = sumByKey.largest()
    echo "max_key: ", largest[0], " sum: ", largest[1]

main()
```

Most of this should be pretty self explanatory. I've used the same names as those used in the D code samples provided in the original blog post to keep things looking similar.

Obviously the start of the program is all about making sure we have enough command line arguments, and collecting them up. In Nim, we use `paramStr()` from the [os](https://nim-lang.org/docs/os.html) module to access command line arguments.

From there, we create a new count table, open the CSV file for reading (`fmRead` opens the file in read mode) and start the CSV parser.

We then read through all of the rows in the CSV file, and if the row has enough fields to be a valid row, we increment its entry within the count table.

## Benchmarking Speed

With this initial implementation complete, I built it in release mode (`nim c -d:release test_csv.nim`) and benchmarked it against the Python implementation and the final optimised D implementation (`max_column_sum_by_key_v4b.d`).

The versions of the tools used in this post are as follows:

- **Python**: `Python 2.7.13`
- **DMD**: `DMD64 D Compiler v2.074.0`
- **LDC**: `LDC - the LLVM D compiler (1.2.0): based on DMD v2.072.2 and LLVM 4.0.0`
- **Nim**: `Nim Compiler Version 0.17.0 (2017-05-18) [MacOSX: amd64]`
- **Clang**: `Apple LLVM version 8.1.0 (clang-802.0.42)`

Testing was performed against the D version compiled using both the reference `DMD` D compiler, and the `LDC` LLVM based D compiler. The compilation switches used for the D versions were as follows:

- **DMD**: `dmd -O -release -inline -boundscheck=off -of=./D/csv_test ./D/csv_test.d`
- **LDC**: `ldc2 -of=./D/csv_test_ldc -O -release -boundscheck=off ./D/csv_test.d`

I then ran all of these implementations against [the same ngram file from the Google Books project](https://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-1gram-20120701-0.gz), making sure I got the expected output, which is as follows:

```
max_key: 2006 sum: 22569013
```

The benchmark was ran on my mid 2014 MacBook Pro with a 2.8GHz Intel Core i7 running macOS Sierra 10.12.4. The benchmark made use of the `repeat.rb` script from [Kostya's benchmarks project](https://github.com/kostya/benchmarks) to run each version 10 times and report the fastest run time. This script also provides the added bonus of providing the peak amount of memory used by each version. Here are the results:

```
Python...
max_key: 2006 sum: 22569013
21.70s
max_key: 2006 sum: 22569013
32.06s
max_key: 2006 sum: 22569013
17.83s
max_key: 2006 sum: 22569013
18.29s
max_key: 2006 sum: 22569013
23.73s
max_key: 2006 sum: 22569013
18.09s
max_key: 2006 sum: 22569013
17.58s
max_key: 2006 sum: 22569013
17.86s
max_key: 2006 sum: 22569013
16.92s
max_key: 2006 sum: 22569013
15.98s

MIN TIME: 15.98s
PEAK MEM: 7.9Mb

D (DMD)...
max_key: 2006 sum: 22569013
2.45s
max_key: 2006 sum: 22569013
2.33s
max_key: 2006 sum: 22569013
2.24s
max_key: 2006 sum: 22569013
2.36s
max_key: 2006 sum: 22569013
2.28s
max_key: 2006 sum: 22569013
2.21s
max_key: 2006 sum: 22569013
2.28s
max_key: 2006 sum: 22569013
2.21s
max_key: 2006 sum: 22569013
2.28s
max_key: 2006 sum: 22569013
2.30s

MIN TIME: 2.21s
PEAK MEM: 2.3Mb

D (LDC)...
max_key: 2006 sum: 22569013
1.42s
max_key: 2006 sum: 22569013
1.34s
max_key: 2006 sum: 22569013
1.34s
max_key: 2006 sum: 22569013
1.33s
max_key: 2006 sum: 22569013
1.88s
max_key: 2006 sum: 22569013
1.31s
max_key: 2006 sum: 22569013
1.35s
max_key: 2006 sum: 22569013
1.36s
max_key: 2006 sum: 22569013
1.29s
max_key: 2006 sum: 22569013
1.26s

MIN TIME: 1.26s
PEAK MEM: 2.4Mb

Nim...
max_key: 2006 sum: 22569013
1.36s
max_key: 2006 sum: 22569013
1.30s
max_key: 2006 sum: 22569013
1.31s
max_key: 2006 sum: 22569013
1.35s
max_key: 2006 sum: 22569013
1.36s
max_key: 2006 sum: 22569013
1.45s
max_key: 2006 sum: 22569013
1.47s
max_key: 2006 sum: 22569013
1.50s
max_key: 2006 sum: 22569013
1.53s
max_key: 2006 sum: 22569013
1.56s

MIN TIME: 1.30s
PEAK MEM: 1.9Mb
```

D (compiled with LDC and using the fifth iteration of the code from the original blog post) comes in fastest at 1.26 seconds. Nim comes in second, at 1.30 seconds - only 0.04 seconds behind.

Nim does use 0.5Mb less memory than the D version built with LDC, and is doing slightly more work - the `parsecsv` module will handle escaped values, unlike the naive approach of simply splitting strings on the tab character.

Python is clearly the loser, taking 12 times as long to complete the processing as the Nim version does and using 4 times the memory to do so.

This test also shows the gulf between the DMD and LDC compilers. The same code compiled with the DMD compiler takes almost a whole second longer to execute than it does when compiled with LDC, though it does use 0.1Mb less memory at its peak.

I'm sure that with some tuning, I could get the Nim version to perform even quicker, but for a 0.04 second time difference, I decided not to put that effort in.

## Benchmarking compilation times

Having come this far, I though I might as well benchmark how long compilation times are for the two D implementations and the Nim implementation. Obviously, the Python implementation is excluded from this test.

I cleared out all build artefacts (such as the `*.o` files for D and the `nimcache` folder for Nim) along with the built executables, then simply timed each build. Here are the results:

- **DMD**: `real 0m0.947s`
- **LDC**: `real 0m2.296s`
- **Nim**: `real 0m0.955s`

It turns out that the DMD compiler is much quicker than the LDC compiler. Obviously all the optimisations that LLVM makes take a little while longer to complete.

## Conclusion

And that was the end of my little test. It turns out that Nim can certainly hold its own when it comes to parsing CSV files.

I'd be interested to see how things run on other machines and operating systems to see how things are across platforms. I'm also sure there are far better ways I could benchmark these implementations, which is why I've [posted the project publicly on GitHub](https://github.com/euantorano/faster-command-line-tools-in-nim) - I'd welcome any enhancements to any of the versions or the benchmarking scripts, and would certainly welcome some more results to see how things stack up!