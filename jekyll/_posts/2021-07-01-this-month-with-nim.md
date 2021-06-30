---
title: "This Month with Nim: June 2021"
author: The Nim Community
excerpt: "Three interesting projects our users worked on in June"
---

## [Dik](https://github.com/juancarlospaco/dik)

#### Author: [Juan Carlos](https://github.com/juancarlospaco)

Dik is a dictionary implemented as `{ array[char]: Option[T] }`

- [Cute pet.](https://en.wikipedia.org/wiki/Dik-dik)
- Destructors.
- Resize in-place.
- Sorted and hashed.
- Same size as Table.
- Dollar and `pretty`.
- `toSeq` and `toDik`.
- Tests for everything.
- Documentation with examples.
- Same size and speed as `Table`.
- 1 file, 300 lines, 0 dependencies.
- `newDikOfCap` for custom capacity.
- Keys are stored as `array` of `char`.
- Values are stored as `seq` of `Option[T]`.
- Can be used like `seq` or like `Table`.
- `len` for lenght and `cap` for capacity.
- Get items by `string` or `openArray[char]`.
- Get items by index or `BackwardsIndex` or `Slice[int]`.
- Iterators, including `enumerated` yields `(index, key, value)`.
- From stdlib uses only `options` for `Option[T]`, `hashes` for `hash(T)`.

```nim
import std/options ## For Option[T] ops.
import std/json    ## For heterogeneous values.
import dik

var myDik = {"key0": %*{"foo": 42, "bar": 3.14}, "key1": %*["baz", true]}.toDik

doAssert myDik.len == 2                        # Length
doAssert myDik.cap == 2                        # Capacity
doAssert sizeOf(myDik) == 32

doAssert myDik[1].get == %*["baz", true]       # Get by index
doAssert myDik[^1].get == %*["baz", true]      # Get by BackwardsIndex
doAssert myDik["key1"].get == %*["baz", true]  # Get by key
doAssert myDik[1..1][0].get == %*["baz", true] # Get by Slice[int]

echo myDik.pretty                              # Pretty-print
doAssert myDik.toSeq is seq[Option[JsonNode]]  # Dik to seq
doAssert "key0" in myDik                       # contains(key)
myDik.del "key1"                               # Delete an item

for (index, key, value) in myDik.enumerated:   # Iterators
  doAssert index == 0
  doAssert key == "key0"
  doAssert value.get == %*{"foo": 42, "bar": 3.14}

# Can store the lack of a value, without using "nil".
myDik["key1"] = none JsonNode
doAssert not(myDik[1].isSome)
doAssert myDik[1] == myDik["key1"]

clear myDik
doAssert myDik.len == 0
doAssert $myDik == "{:}"

```


## [Whois.nim](https://gitea.com/Thisago/whois.nim)

#### Authors: [@Thisago](https://github.com/thisago)

The Whois.nim is a simple whois client.
With cache!

```nim
import whois

echo whois("duckduckgo.com")

# or

var domain = "metager.org".toDomain # convert to a `Domain` instance
domain.update() # Get data from API

echo domain
```


## [libFuzzer](https://github.com/planetis-m/libfuzzer)

#### Author: [@planetis-m](https://github.com/planetis-m)

Thin interface for LLVM/Clang libFuzzer, an in-process, coverage-guided, evolutionary fuzzing engine.
Fuzzing is an automated bug finding technique, where randomized inputs are fed to a target program in order to get it to crash.
With fuzzing, you can increase your test coverage to find edge cases and trigger bugs more effectively.

```nim
proc fuzzMe(data: openarray[byte]): bool =
  result = data.len >= 3 and
    data[0].char == 'F' and
    data[1].char == 'U' and
    data[2].char == 'Z' and
    data[3].char == 'Z' # :‑<

proc initialize(): cint {.exportc: "LLVMFuzzerInitialize".} =
  {.emit: "N_CDECL(void, NimMain)(void); NimMain();".}

proc testOneInput(data: ptr UncheckedArray[byte], len: int): cint {.
    exportc: "LLVMFuzzerTestOneInput", raises: [].} =
  result = 0
  discard fuzzMe(data.toOpenArray(0, len-1))
```

It takes a split second for libFuzzer to perform ~40.000 runs.
Behind the scenes it uses value profiling to guide the fuzzer past these comparisons much more efficiently than simply hoping to stumble on the exact sequence of bytes by chance.


----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim) to add your project to the next month's blog post.
