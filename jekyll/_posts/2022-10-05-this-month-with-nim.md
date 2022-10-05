---
title: "This Month with Nim: September 2022"
author: The Nim Community
excerpt: "Nodejs update, assignment macros, OpenSHMEM bindings, and a TCP monitor"
---


## [Node](https://github.com/juancarlospaco/nodejs)

#### Author: [Juan Carlos](https://github.com/juancarlospaco)

New APIs for the browser implemented recently

- [File IO API 💾](https://juancarlospaco.github.io/nodejs/nodejs/jsfilesystemhandle)
- [GeoLocation API 🌎](https://juancarlospaco.github.io/nodejs/nodejs/jsgeolocation)
- [EyeDropper API 🌈](https://juancarlospaco.github.io/nodejs/nodejs/jseyedropper)
- [Speech Synth API 🔊](https://juancarlospaco.github.io/nodejs/nodejs/jsspeechsynthesis)
- [USB API](https://juancarlospaco.github.io/nodejs/nodejs/jswebusb)
- [Bluetooth API](https://juancarlospaco.github.io/nodejs/nodejs/jsbluetooth)
- [Game controller API 🎮](https://juancarlospaco.github.io/nodejs/nodejs/jsgamepad)
- [Battery API 🔋](https://juancarlospaco.github.io/nodejs/nodejs/jsbattery)
- [Video Subtitles API 🎬](https://juancarlospaco.github.io/nodejs/nodejs/jswebvtt)
- [Payments API 💸](https://juancarlospaco.github.io/nodejs/nodejs/jspayments)
- [QR-Codes and Bar-Codes API](https://juancarlospaco.github.io/nodejs/nodejs/jsbarcodes)
- [Share API](https://juancarlospaco.github.io/nodejs/nodejs/jsshare)
- [Sanitizer API](https://juancarlospaco.github.io/nodejs/nodejs/jssanitizer)
- [Temporal API ⏰](https://juancarlospaco.github.io/nodejs/nodejs/jstemporal)
- [IndexedDB API](https://github.com/juancarlospaco/nodejs/blob/main/src/nodejs/jsindexeddb.nim) (by Tandy)
- WebSockets API (by Tandy)
- Multisync for JS (by Tandy)

Nodejs is your toolbox with 70+ modules for JavaScript, Node, browser and more!

- [https://github.com/juancarlospaco/nodejs](https://github.com/juancarlospaco/nodejs)





## [QWatcher](https://github.com/pouriyajamshidi/qwatcher)

#### Author: [Pouriya Jamshidi](https://github.com/pouriyajamshidi)

 `qwatcher` is designed to help monitor TCP connections and diagnose buffer and connectivity issues on Linux machines related to input and output queues.





## [nim-sos](https://github.com/ct-clmsn/nim-sos)

#### Author: [Christopher Taylor](https://github.com/ct-clmsn)

[nim-sos](https://github.com/ct-clmsn/nim-sos) provides users the ability to program parallel applications.
In the Single-Program-Many-Data (SPMD) style for supercomputers using the Nim programming language.

nim-sos:
- wraps the existing [Sandia OpenSHMEM library](https://github.com/Sandia-OpenSHMEM/SOS) implemented by Sandia National Laboratory.
- implements distributed symmetric array and distributed symmetric scalar support using the underlying OpenSHMEM wrapper.
- provides the Nim programming language distributed symmetric shared memory and Partitioned Global Address Space (PGAS) support.





## [assigns](https://github.com/metagn/assigns)

#### Author: [metagn](https://github.com/metagn)

[assigns](https://github.com/metagn/assigns) is a library for unpacking assignment and basic pattern matching.
Its advantage over other libraries with the same goal is that it has a simple, lightweight implementation that allows for overloading matching syntaxes based on the type of the matched value.

```nim
import assigns

# unpacking assignment:
type Person = tuple[name: string, age: int]
(age: a, name: n) := ("John Smith", 30).Person
assert (a, n) == (30, "John Smith")

# pattern matching:
proc fizzbuzz(n: int): string =
  match (n mod 3, n mod 5):
  of (0, 0): "FizzBuzz"
  of (0, _): "Fizz"
  of (_, 0): "Buzz"
  else: $n

for i in 1..100:
  echo fizzbuzz(i)

# custom implementation:
import assigns/impl, std/macros

type LinkedList[T] {.acyclic.} = ref object
  leaf: T
  next: LinkedList[T]

implementAssign LinkedList: # sugar for defining the overloading macro
  # skip bracket:
  let newLhs = if lhs.kind == nnkBracket and lhs.len == 1: lhs[0] else: lhs
  # check for | operator:
  if newLhs.kind == nnkInfix and newLhs[0].eqIdent"|":
    # overloadably assign both parts
    newStmtList(
      open(newLhs[1], newDotExpr(rhs, ident"leaf")),
      open(newLhs[2], newDotExpr(rhs, ident"next")))
  else:
    # use default assignment syntax if expression is not understood
    default()

let list = LinkedList[int](leaf: 1, next:
  LinkedList[int](leaf: 2, next:
    LinkedList[int](leaf: 3, next: nil)))

x | [(< 5) | [y | _]] := list
assert (x, y) == (1, 3)
```

Can be installed with `nimble install assigns`. More information in [docs](https://metagn.github.io/assigns/docs/assigns.html).





----




## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
