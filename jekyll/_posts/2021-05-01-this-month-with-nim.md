---
title: "This Month with Nim: April 2021"
author: The Nim Community
excerpt: "Three interesting packages our users worked on in April"
---


## Nimjl

#### Author: Regis Caillaud ([Clonkk](https://github.com/Clonkk/))

Nimjl is a bridge to call Julia code from Nim. It is to Julia what Nimpy is to Python. 

Useful to leverage Julia's powerful ecosystem in Numerical computing.
Practical for integrating Julia code in Nim application without rewriting everything.

And for those who prefers code to word here's a small example of sorting a Nim sequence using Julia's sort function ! 
```nim
import nimjl
import random
import sequtils
import sugar

jlVmInit() 
var seqRand: seq[int64] = newSeqWith(12, rand(100)).map(x => x.int64)
echo seqRand
discard jlCall("sort!", seqRand)
echo seqRand
jlVmExit() 
``` 
Did that pique your curiosity ? You can check-it out [here](https://github.com/Clonkk/nimjl) or read more [examples](https://github.com/Clonkk/nimjl/tree/master/examples) !


## [Datarray](https://github.com/liquidev/datarray)

#### Author: [liquidev](https://github.com/liquidev)

Datarray aims to make data oriented design easy, by abstracting away the common struct of arrays pattern that exhibits much better cache efficiency than the usual, object oriented-style array of structs.
The creation of this library was inspired by [this blog post](https://blog.royalsloth.eu/posts/the-compiler-will-optimize-that-away/).

Here's an example of how to use a datarray to manipulate data efficiently:
```nim
import std/random
import datarray

# declare a struct with fields that should be transformed into arrays
type
  Ant = object
    name: string
    color: string
    isWarrior: bool
    age: int32

# create and initialize the datarray with some data to operate on
var antColony: Datarray[1000, Ant]
randomize()
for ant in antColony:
  # `ant` is of a special type - `VarElement[Ant]`, which holds a pointer to the
  # datarray's memory, its length, and the relevant index of the element we're
  # operating on. there also exists an `Element[T]` for non-var datarrays that
  # prohibits assignment to fields.
  # the special . and .= operators can be used to access or modify the fields:
  ant.name = sample ["joe", "josh", "dave"]
  ant.color = sample ["red", "black", "brown"]
  ant.isWarrior = rand(1.0) < 0.5
  ant.age = int32 rand(1 .. 3)
  # {} and {}= can also be used if you prefer to avoid using experimental
  # language features, but to get stabilized, experimental features need testing
  # so it's your choice ;)

# query the data using the `select` macro
var numChosen = 0
for index, (age, color) in select antColony:
  # this macro invocation creates two templates inside of the loop,
  # `age` and `color`, which desugar to something like this:
  # antColony.ith(index, age)
  # to save typing.
  if age > 1 and color == "red":
    inc numChosen
echo "found ", numChosen, " red ants older than 1 year"
```

Because a datarray is quite a generic and flexible container, it can be used to implement a variety of different things, eg. an ECS framework, or a simple and fast database.
A dynamically allocated variant, `DynDatarray`, is also available, if the size needs to be determined at runtime, but I've yet to implement a dynamically *resizable* datarray as of writing this.

[Benchmarks](https://github.com/liquidev/datarray#benchmarks) show that using an struct of arrays is about 2-3x faster than using an array of structs, so if you want to write fast programs that take full advantage of your CPU, start using datarrays now!

The library is still growing and lacks many useful features, so suggestions are welcome.


## [Loki](https://github.com/beshrkayali/loki)

#### Author: [Beshr Kayali](https://github.com/beshrkayali)

Loki is a small library for writing line-oriented command interpreters (or cli programs) in Nim that is inspired by Python's cmd lib.

Version 0.3 is released this month, and it adds the functionality of automatically generating a TOC and "help" command. 

Quick example:

```nim
import loki, strutils, options
from sequtils import zip

loki(myHandler, input):
  do_greet name:
   ## Get a nice greeting!
   if isSome(name):
    echo("Hello ", name.get, "!")
   else:
    echo("Hello there!")
  do_add num1, num2:
    if isSome(num1) and isSome(num2):
      echo("Result is ", parseInt(num1.get) + parseInt(num2.get))
    else:
      echo("Provide two numbers to add them")
  do_EOF:
    write(stdout, "Bye!\n")
    return true
  default:
    write(stdout, "*** Unknown syntax: ", input.text , " ***\n")

let myCmd = newLoki(
  handler=myHandler,
  intro="Welcome to my CLI!\n",
)

myCmd.cmdLoop
```

And  an example run: https://asciinema.org/a/iMA7pIq2f7sy8X44pkCPhNmOt

----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim) to add your project to the next month's blog post.
