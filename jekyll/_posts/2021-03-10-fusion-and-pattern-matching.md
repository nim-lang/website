---
title: "Pattern matching in Nim"
author: haxscramper
excerpt: "Nim fusion and pattern matching"
---

<div class="sidebarblock">
  <div class="content">
    <div class="title">Guest post</div>
    <div class="paragraph">
      This is a guest post by haxscramper.
      If you would like to publish articles as a guest author on nim-lang.org then get in touch with us via
      <a href="https://twitter.com/nim_lang">Twitter</a> or <a href="https://nim-lang.org/community.html">otherwise</a>.
    </div>
  </div>
</div>


# Nim fusion

[Fusion](https://github.com/nim-lang/fusion) contains Nim modules that are meant to
be treated as an extension to the stdlib.
Currently, the following modules are present:

- `fusion/smartptrs` - C++-like unique/shared pointers
- `fusion/btreetables` - sorted associative containers
- `fusion/matching` - pattern matching implementation using Nim macros - the main focus of this article
- `fusion/htmlparser` - HTML parser
- `fusion/astdsl` - karax-style DSL for constructing an AST
- `fusion/filepermissions` - convenience functions for working with file permissions.

The documentation index can be found [here](https://nim-lang.github.io/fusion/theindex.html).

To install `fusion` simply run `nimble install fusion`.
To try it out without installing, use the [Nim playground](https://play.nim-lang.org/#ix=2Qzc).


```nim
import fusion/matching

{.experimental: "caseStmtMacros".}

case [(1, 3), (3, 4)]:
  of [(1, @a), _]:
    echo a

  else:
    echo "Match failed"
```


# Pattern matching introduction

The new pattern matching library introduces support for two very useful concepts:
**pattern matching** and **object destructuring**.

Pattern matching is a mechanism that allows you to check a particular object against
a pattern --- you could think of it mainly as a way to reduce boilerplate code when
comparing objects for equality, checking if a value is within range, checking if a
particular key is present in a table and so on.

```nim
import std/json, fusion/matching

{.experimental: "caseStmtMacros".}

# JSON is very simple data format, but illustrates a lot of useful features
# of pattern matching
case parseJson("""{ "key" : "value" }"""):
  # No longer necessary to check if key is present - it is done
  # automatically
  of { "key" : JInt() }:
    discard

  # Extracting values from nested data structures also becomes much easier.
  of { "key" : (getStr: @val) }:
    echo val
    assert val is string
```

Output:

    value


Object destructuring allows you to extract values from particular
fields in an object.
It is very common in dynamic programming languages such as Python.
The simplest form of destructuring is already supported by Nim --- tuple unpacking:

```nim
let (val1, val2) = ("some", 12)
```

And with pattern matching you can now unpack sequences, tables and custom objects:

```nim
[(@first, @second), all @trail] := [(12, 3), (33, 4), (12, 33)]
echo first, ", ", second, ", ", trail
```

Output:

    12, 3, @[(33, 4), (12, 33)]



# Using pattern matching in regular code

The main purpose of pattern matching is a simplification of conditions and
consecutive checks.
It is especially useful when paired with
[object variants](https://nim-lang.org/docs/tut2.html#object-oriented-programming-object-variants),
but can also be used to do a lot of other things, such as
[key-value pairs matching](https://nim-lang.github.io/fusion/src/fusion/matching.html#matching-different-things-kvminuspairs-matching)
and extensive support for
[sequence matching](https://nim-lang.github.io/fusion/src/fusion/matching.html#matching-different-things-sequence-matching).
A special syntactic sugar is provided for very common use cases, such as `Option[T]`
checking (similar to `if let` in Rust):

```nim
import std/options

if Some(@val) ?= some("hello"):
  echo val, ". Is string? ", val is string
```

Output:

    hello. Is string? true


And matching tree structures of case objects (such as an AST).
For `enum`, conforming to the [NEP1 style guide](https://nim-lang.org/docs/nep1.html#introduction-naming-conventions)
naming conventions, you can omit the prefix entirely, leading to code that looks
roughly like this:

```nim
case <some AST node>:
  # Node kind is `nnkIdent`, but it is possible to omit `nnk`
  of Ident(strVal: @name):
    echo "Found ident: ", name

  # Extracting subnodes from infix expression.
  of InfixExpr[Ident(strVal: "+"), @lhs, @rhs]:
    ...

  # Matching if statements with *exactly* two branches.
  # No need to worry about indexing exceptions - `len` is checked accordingly
  # during pattern matching.
  of IfStmt[ElifBranch[@cond1, _], ElifBranch[@cond2, _]]:
    ...
```


# Using pattern matching for writing macros

Nim macros are one of the most powerful parts of the language, but they might
seem a little intimidating for newcomers, especially when it comes to implementing
a macro for solving a particular problem at hand.

This article gives an example on how one can easily create a relatively complex macro
using the new pattern matching library.

We will be creating a macro for dataflow programming, with support for some operations
from the `std/sequtils` module (map/filter/each).
The macro won't be covering all possible combinations and use cases as it would make
the implementation significantly more complicated.


## First step - design the DSL

When writing a macro, it is very useful to just write DSL code (as if you already
had the macro) and what you expect it to generate.
Decide *what you want to do* and *how it should look like*.
In our case, the input could look roughly like this:

```
flow lines("/etc/passwd"):
  map[_, seq[string]]:
    it.split(":")
  keepIf:
    it.len > 1 and
    it.matches [_.startsWith("systemd"), .._]
  each:
    echo it
```

And it should generate a loop that looks like this:

```nim
var res = seq[ResType]
for it0 in lines("/etc/passwd"):
  let it1 = it0.split(":")
  if it1.len > 1 and it1.matches [_.startsWith("systemd"), .._]:
    echo it1
```


## Analyze the DSL parse tree

Now the question is - how to transform the first into the second?
We will start by first looking at the output for `dumpTree` on the `flow` macro:

```
dumpTree:
  flow lines("/etc/passwd"):
    map[_, seq[string]]:
      it.split(":")
```

Output:

```nim
 1  StmtList
 2    Command
 3      Ident "flow"
 4      Call
 5        Ident "lines"
 6        StrLit "/etc/passwd"
 7      StmtList
 8        Call
 9          BracketExpr
10            Ident "map"
11            Ident "_"
12            BracketExpr
13              Ident "seq"
14              Ident "string"
15          StmtList
16            Call
17              DotExpr
18                Ident "it"
19                Ident "split"
20              StrLit ":"
```

This load of text might seem a little confusing at first, but in the end it can be
taken apart quite easily (and that is exactly what we will be doing).
First, on line 3, we see the `flow` identifier (`Ident "flow"`) - this is the start of our macro.
Then, on the next line is a `lines("/etc/passwd")` argument. `StmtList` on lines
`7-20` is the actual body of the `flow` macro - the `map` section etc.
We will get into their internal structure a little later.


## Intermediate representation

After we a have rough outline of the input AST, it is time to decide on how this
particular macro can be implemented.

I usually try to introduce some kind of intermediate representation for the DSL in
order to make things more organized and decouple the parsing stage from code generation.
This might make the implementation a little longer, but more extensible and robust.
You can, without a doubt, just go directly to code generation, but for a more complex
DSL I would still recommend using some kind of IR.

In this particular case, the DSL structure for the `flow` macro can be described as:

```nim
type
  FlowStageKind = enum
    fskMap # Stage for element conversion
    fskFilter # Filter elements
    fskEach # Execute action without returning value

  FlowStage = object
    outputType: Option[NimNode] # Assert result type
    kind: FlowStageKind # Type of the stage
    body: NimNode # Stage body
```

It directly maps on the input DSL.
`map` should create a `fskMap` stage, `filter` creates `fskFilter` and so on.
Optionally you can specify the output type like this: `map [ExpectedOutput]`.
The macro will work in two stages: first it will convert the input representation into
an intermediate representation, and then it will generate the resulting AST.


## Pattern matching

Now, after we have good understanding of what exactly we want to do - the question is 'how?'.
That's where [`fusion/matching`](https://nim-lang.github.io/fusion/src/fusion/matching.html)
comes particularly handy - we already identified all patterns, and now it is only a matter
of writing this down in code.

Without pattern matching, you'd be left with a long series of repeating `[0][0][0]`
and `if kind == nnkBracketExpr` in order to retrieve parts from the DSL and validate input.

Before we proceed to writing patterns for the whole DSL, it is important to consider
the three possible cases of writing a stage.
The first once is very simple - no type specified, only a stage identifier:

```nim
dumpTree:
  map:
    body
```

Output:

    StmtList
      Call
        Ident "map"
        StmtList
          Ident "body"

But a single stage with a type parameter can be written using two different ways - both
are **syntactically correct**, but have different parse trees:

With space between `map` and `[a]`:

```nim
dumpTree:
  map [a]:
    body
```

Output:
```
StmtList
  Command
    Ident "map"
    Bracket
      Ident "a"
    StmtList
      Ident "body"
```

Without space between `map` and `[a]`:

```nim
dumpTree:
  map[a]:
    body
```

Output:
```
StmtList
  Call
    BracketExpr
      Ident "map"
      Ident "a"
    StmtList
```

The difference is due to the
[method call syntax](https://nim-lang.org/docs/manual.html#procedures-method-call-syntax) -
`map[a]` is treated as a bracket expression (like array subscript), but `map [a]`
is parsed as a procedure `map` call, with argument `[a]` (passing an array to a
function).


## `fusion/matching`

Let's make a small digression in order to better understand how the new pattern
matching library can help us here.

We will be focusing on the parts that are relevant to our task - for more details you
can read the [documentation](https://nim-lang.github.io/fusion/src/fusion/matching.html).

When writing Nim macros you are mostly dealing with
[NimNode](https://nim-lang.org/docs/macros.html#the-ast-in-nim) objects - first to
process input AST, and then to generate new code.
The AST is comprised of [case objects](https://nim-lang.org/docs/manual.html#types-object-variants).
Usually, the first part of the macro involves lots of checks for the correct node kind,
followed by iteration over the subnodes to extract the input data.
Pattern matching simplifies this, allowing to directly write expected patterns
for the AST, with syntax closely matching that of `dumpTree`.

For example - if we have code like `map[string]` it has the following tree representation:

```nim
dumpTree:
  map[string]
```

Output:

    StmtList
      BracketExpr
        Ident "map"
        Ident "string"

And can be matched using the following pattern:

```nim
body.assertMatch:
  BracketExpr:
    @head
    @typeParam
```

Notice the similarity between the AST and a pattern for matching - each node has `kind` field,
which describes what kind of node this is.
In this case we are interested in the first and second subnodes of the `BracketExpr`
node - flow stage kind and type parameter respectively.

As we have already seen earlier, `map [string]` and `map[string]` are parsed
differently - the first one is handled as one-element array passed to `map` as function
argument, and the second is a bracket expression.
[Method call syntax](https://nim-lang.org/docs/manual.html#procedures-method-call-syntax)
usually makes programming a DSL a little harder - you need to check for both
alternatives, remember which index each capture should be in, etc.

With pattern matching though it becomes quite easy to do - adding a second
alternative will be enough.

```nim
body.matches:
  # More compact way of writing `BracketExpr`
  BracketExpr[@head, @typeParam] |
  Command[@head, Bracket[@typeParam]]
```

It should also be possible to omit type parameters from the DSL entirely - they are
quite nice and would allow for better type checking, but could become quite annoying to write.
So, we should also expect someone to just write `map` - without any type qualifications.
To handle this case we add a third alternative for pattern:

```nim
body.matches:
  BracketExpr[@head, @typeParam] |
  Command[@head, Bracket[@typeParam]] |
  (@head is Ident())
```

This brings one important change: The `typeParam` capture is no longer `NimNode` - the type
has changed to `Option[NimNode]`, because not all alternatives have this variable.
`head` is still a `NimNode` just as before - all possible alternatives contain
this variable, so it would be set if the input matches.

----

This example shows really well how pattern matching can help to handle different
alternative syntaxes.
Another very powerful feature is sequence matching - sadly in this particular
example we had no need for it, but I decided to still showcase it.
Consider a [procedure declaration](https://nim-lang.org/docs/macros.html#statements-procedure-declaration)
AST - suppose we need to match name, arguments, and return type.
Usually, part of a case statement would look similar to this:

```nim
of nnkProcDef:
  let name = arg[0]
  let returnType = arg[3][0]
  let arguments = arg[3][1 .. ^1]
```

This is not particularly complicated, but with pattern matching it all becomes:

```
ProcDef[@name, _, _, [@returnType, all @arguments], .._]
```


## Flow macro implementation

Our first stage would be processing the input into a `FlowStage`.
We already have a way to extract the data from the input AST - using pattern matching.

```nim
macro flow(arg, body: untyped): untyped =
  var stages: seq[FlowStage]
  for elem in body:
    if elem.matches(
        Call[BracketExpr[@ident, opt @outType], @body] |
        # `map[string]:`
        Command[@ident is Ident(), Bracket [@outType], @body] |
        # `map [string]:`
        Call[@ident is Ident(), @body]
        # just `map:`, without type argument
      ):
        stages.add FlowStage(
          kind: identToKind(ident),
          outputType: outType,
          body: body
        )
```

After that, we have all necessary information for generating the result code.
If the last stage is not `each`, i.e. there is a return value after each iteration,
we need to determine the type of the result sequence and then append to it on
each iteration.

```nim
if stages[^1].kind notin {fskEach}:
  # If last stage has return type (not `each`) then we need to
  # accumulate results in temporary variable.
  result = quote do:
    var `resId`: seq[#[ Type of the expression ]#]

    for it0 {.inject.} in `arg`:
      `resId`.add #[ Expression to evaluate]#

    `resId`
else:
  # Otherwise just iterate each element
  result = quote do:
    for it0 {.inject.} in `arg`:
      #[ Expression to evaluate ]#
```


### Get the result type

Each stage of the dataflow has a type, and potentially defines variables.
In addition to that - each stage uses the special variable `it` - that has to be
injected separately for each stage, **but** at the same time it is used for
communicating values between stages.

```nim
flow [1,2,3]:
  map:
    it * 2
  map:
    $it
```

is equivalent to:

```nim
var res: seq[#[ Type of the expression ]#]

for it in [1, 2, 3]:
  let it = it * 2
  let it = $it
  res.add it

res
```

As you can clearly see, such code would not even compile due to the redefinition
errors.
There are two possible ways to solve this problem - kind of obvious, and not-all-that-obvious.
Let's start with the first one - since each variable can be redefined in the new
scope we can just do:

```nim
for it in [1, 2, 3]:
  block:
    let it = it * 2
    block:
      let it = $it
      echo "Add result - ", it
```

Output:

    Add result - 2
    Add result - 4
    Add result - 6


And it would compile and work perfectly fine.
But now we have a problem of getting the type of the expression itself - everything
is fine as long as you only use `map` - after all `block:` is an expression,
and we can have something like this:

```nim
echo typeof((block:
               let it = 1
               block:
                 let it = it * 2
                 block: $it))
```

Output:

    string


Not the prettiest code in the world, by all means - but it will become even worse
when we have to deal with `filter`, `each`, injected variables and iterators.

The second alternative is to use declare a proc with an `auto` return type and
assign the result of the expression to it.
In that case, the compiler will figure out the return type for us.

```nim
proc hello[T](a: T): auto =
  for c in "ee":
    result = (12, "som", "ee", a)

echo typeof hello[int]
```

Output:

    proc (a: int): (int, string, string, int) {.noSideEffect, gcsafe, locks: 0.}


Now we only need to write code generation for `#[ Expression to evaluate ]#` and
substitute `result =` when necessary.


### Create the evaluation expression

1. Body rewrite

   Each stage in `flow` injects an `it` variable - the result of the evaluation from 
   the previous stage.
   To avoid getting redefinition errors from multiple `let it = <expression>` on
   each stage, we will replace each occurrence of `it` with `it<stage-index>`.
   For the first stage it would be `it -> it1`, the second one is `it -> it2` and so on.

   `rewrite` takes an input `NimNode` and either returns it as-is (if no rewriting is necessary)
   or, in case of the identifier `it` (`Ident(strVal: "it")`), converts it into a new
   one with the corresponding index.

   ```nim
   proc rewrite(node: NimNode, idx: int): NimNode =
     case node:
       of Ident(strVal: "it"):
         result = ident("it" & $idx)
       of (kind: in nnkTokenKinds): # `nnkTokenKinds` is a set of node
                                    # kinds that don't have subnodes.
                                    # These ones are returned without any
                                    # modifications.
         result = node
       else:
         # For node kinds with subnodes, rewriting must be done
         # recursively
         result = newTree(node.kind)
         for subn in node:
           result.add subn.rewrite(idx)
   ```

2. Create eval expression

   For each stage, we rewrite the body and then append a new chunk of generated code
   to the result.

   ```nim
   func evalExprFromStages(stages: seq[FlowStage]): NimNode =
     result = newStmtList()
     for idx, stage in stages:
       # Rewrite body
       let body = stage.body.rewrite(idx)


       case stage.kind:
         # If stage is a filter it is converted into `if` expression
         # and new new variables are injected.
         of fskFilter:
           result.add quote do:
             let stageOk = ((`body`))
             if not stageOk:
               continue

         of fskEach:
           # `each` has no variables or special formatting - just
           # rewrite body and paste it back to resulting code
           result.add body
         of fskMap:
           # Create new identifier for injected node and assign
           # result of `body` to it.
           let itId = ident("it" & $(idx + 1))
           result.add quote do:
             let `itId` = `body`

           # If output type for stage needs to be explicitly checked
           # create type assertion.
           if Some(@expType) ?= stage.outputType:
             result.add makeTypeAssert(expType, stage.body, itId)
   ```


### Result type implementation

```nim
func typeExprFromStages(stages: seq[FlowStage], arg: NimNode): NimNode =
  let evalExpr = evalExprFromStages(stages)
  var
    resTuple = nnkPar.newTree(ident "it0")

  for idx, stage in stages:
    if st.kind notin {fskFilter}:
      resTuple.add ident("it" & $(idx + 1))

  let lastId = newLit(stages.len - 1)

  result = quote do:
    block:
      (
        proc(): auto = # `auto` annotation allows to derive type
                       # of the proc from any assignment within the
                       # proc body - we take advantage of this,
                       # and avoid building type expression
                       # manually.
          for it0 {.inject.} in `arg`:
            `evalExpr`
            result = `resTuple`
#           ^^^^^^^^^^^^^^^^^^^
#           |
#           Type of the return will be derived from this assignment.
#           Even though it is placed within loop body, it will still
#           derive necessary return type
      )()[`lastId`]
#      ^^^^^^^^^^^^
#      | |
#      | Get last element from proc return type
#      |
#      After proc is declared we call it immediately
```



### Final `flow` implementation

```nim
macro flow(arg, body: untyped): untyped =
  var stages: seq[FlowStage]
  for elem in body:
    if elem.matches(
        Call[BracketExpr[@ident, opt @outType], @body] |
        # `map[string]:`
        Command[@ident is Ident(), Bracket [@outType], @body] |
        # `map [string]:`
        Call[@ident is Ident(), @body]
        # just `map:`, without type argument
      ):
        stages.add FlowStage(
          kind: identToKind(ident),
          outputType: outType,
          body: body
        )

  let evalExpr = evalExprFromStages(stages)

  if stages[^1].kind notin {fskEach}:
    # If last stage has return type (not `each`) then we need to
    # accumulate results in temporary variable.
    let resExpr = typeExprFromStages(stages, arg)
    let lastId = ident("it" & $stages.len)
    let resId = ident("res")
    result = quote do:
      var `resId`: seq[typeof(`resExpr`)]

      for it0 {.inject.} in `arg`:
        `evalExpr`
        `resId`.add `lastid`

      `resId`
  else:
    result = quote do:
      for it0 {.inject.} in `arg`:
        `evalExpr`


  result = newBlockStmt(result)
```

An example of the macro in action:

```nim
let res = flow lines("/etc/passwd"):
  map[seq[string]]:
    it.split(":")
  filter:
    let shell = it[^1]
    it.len > 1 and shell.endsWith("bash")
  map:
    shell
```

Generated code:

```nim
let res = block:
  var res: seq[typeof(block:
    # largely duplicated code for getting type of the expression.
    proc (): auto = for it0 in lines("/etc/passwd"):
      let it1 = split(it0, ":", -1)
      let stageOk`gensym10271 =
        let shell = it1[BackwardsIndex(1)]
          1 < len(it1) and
            endsWith(shell, "bash")
      if not stageOk`gensym10271:
        continue
      let it3 = shell
      result = (it0, it1, it3)()[2]
  )]

  # Actual implementation
  for it0 in lines("/etc/passwd"):
    let it1 = split(it0, ":", -1)
    let stageOk`gensym10267 =
      let shell = it1[BackwardsIndex(1)]
        1 < len(it1) and
          endsWith(shell, "bash")
    if not stageOk`gensym10267:
      continue
    let it3 = shell
    add(res, it3)
  res
```

An example of a flow state mismatch error:

```nim
let res = flow lines("/etc/passwd"):
  map[seq[char]]:
    it.split(":")
```

Output:
```
Error:

Expected type seq[char], but expression it.split(":") has type of seq[string]
```

## Notes

- Implementation of this macro was largely inspired by
  [`zero_functional`](https://github.com/zero-functional/zero-functional).
- Full flow macro implementation can be seen
  [here](https://github.com/nim-lang/fusion/blob/ea18f8559c514b227b148300a2900b3e2a282b0d/tests/tmatching.nim#L1878) -
  it is a part of the test suite for the library, but a lot of comments from the article are still present.
- I tried to write the [test suite](https://github.com/nim-lang/fusion/blob/master/tests/tmatching.nim)
  in a way that would make it easier to use as an example as well, and while for the most part it
  does not have such level of implementation comments, it could still be treated as an example on how to use this library.
- This library is still being developed - some minor bugs and inconsistencies could be expected, as
  well as ergonomics improvements.
  Consequently, some internal implementation details (mutability of captured variables for example)
  can change in the future.
  When [view types](https://nim-lang.org/docs/manual_experimental.html#view-types) implementation
  would become a non-experimental feature, captures would be done using immutable views instead.
- I personally see this library as a stepping stone for adding pattern matching support in Nim core -
  thanks to unparalleled metaprogramming capabilities, even features like that can be tested in external
  libraries before being included in the language itself (instead of making almost irreversible additions
  and dealing with fallback/bad design choices later).
  This means, first and foremost, that DSL usability and ergonomics feedback is welcome, as well as
  discussions about parts that don't seem particularly useful overall (and might potentially be deleted).
  - For initial discussion about this library implementation you can see [RFC #245](https://github.com/nim-lang/RFCs/issues/245)
  - First implementation [PR](https://github.com/nim-lang/fusion/pull/33) also has some discussions
    that led to partial implementation change.
  - Current implementation does not require changing language syntax **at all**, but a suggestion was
    made to make `let` usable in contexts other than direct variable declaration, making it possible for syntaxes like
    `let [all elems] = @[1, 2, 3, 4]` as opposed to current `[all @elems] := @[1, 2, 3, 4]`.
    Latter one, while not particularly different, creates new way of introducing variables, which might be unwanted.
