---
title: "Write Tracking for Nim (Part 2)"
author: Araq
---

7 years ago I wrote how Nim would get ["write
tracking"](https://nim-lang.org/araq/writetracking.html)
as an alternative to adding `const` to Nim's type system.
This year it finally made it into Nim nightly!
Since then the feature was reimplemented and all the details how it works did change.

My special thanks go to [Clyybber](https://github.com/Clyybber) who
simplified my initial proposal (see
<https://github.com/nim-lang/RFCs/issues/234>) so that this feature
could be added to Nim without any new pragma at all! Quite an
achievement.


Status quo
----------

Nim already has a strong notion of immutability, every parameter that
does not use the `var T` type modifier is immutable.
In fact, Nim's parameter passing semantics continue to be one of my
favorite features of the language and are a hidden gem.
Nim gets the defaults exactly right.
However, as usual, pointers complicate matters.
This code compiles without any warning:

```nim
type
  Node = ref object
    data: string
    next: Node

func count(n: Node): int =
  result = 0
  var it = n
  while it != nil:
    inc result
    it = it.next
  # nasty code here:
  n.data = "mutated!"
```

The reason is that while `n` itself is a parameter and immutable, `n.data`
remains mutable due to the pointer indirection! This is sometimes called
"shallow immutability".

As a reminder, the `func x(args)` notation is a shortcut for
`proc x(args) {.noSideEffect.}`.


Flawed idea: const T
--------------------

The problem of adding `const` to a type system is that it's inconvenient.
To see why, let us imagine that a `const` type modifier would be added to Nim.
`proc p(param: const T)` then would mean that no location reachable from
`param` is allowed to be mutated by `p`.
This is sometimes called "deep immutability".

So far, so good:

```nim
func p(n: const Node) =
  # does not compile:
  n.data = "mutated!"
```

But our `count` example has a problem:

```nim
type
  Node = ref object
    data: string
    next: Node # note: this is not 'const Node' as some operations
               # on singly linked lists really can mutate this field.

func count(n: const Node): int =
  result = 0
  var it: const Node = n
  while it != nil:
    inc result
    it = it.next
    #  ^ this would require an implicit conversion from 'Node' to 'const Node'!
```

The type of the `next` field is `Node` and not `const Node` and so the naive
iteration over a singly linked list does not work.
Now you can argue that the iteration mechanism should be hidden inside an
iterator anyway where we can also hide the dangerous looking but benign type conversion.

Unfortunately there are many more examples where these type conversions would come up.
In fact, for many simple operations like `id` or `select` what to use as the
return type is problematic:

```nim
func select(cond: bool; a, b: const Node): Node =
  result = if cond: a else: b
  # type mismatch: cannot convert from 'const Node' to 'Node'

proc mutate(a, b: Node) =
  let x = select(false, a, b)
  x.data = "mutated!"
```

Since this doesn't compile, let's try a different variant:

```nim
func select(cond: bool; a, b: const Node): const Node =
  result = if cond: a else: b

proc mutate(a, b: Node) =
  let x = Node(select(false, a, b))
  #        ^  convert back to a mutable node
  x.data = "mutated!"
```

The problem with this solution is that it shouldn't be `select`'s business to
decide for me that the selected node cannot be mutated afterwards, that's the
caller's choice to make.
These problems are not unique to Nim, for instance in C++ you cannot pass a
`vector<string>` to a `vector<const string>`.


Idea: Mutation is an effect
---------------------------

There is a better way to model deep immutability.
What we really want to say is that `select` does not mutate any node passed
to it, the dangerous pattern to watch out for is something like
`x.field = value` or `x[] = value`, stores to the heap.
(Here "heap" means the heap according to formal semantics, I'm not talking about
the heap-vs-stack memory region that a typical language implementation uses.)

If we attach an effect like `storeEffect` to patterns like `param.field = value`
we can effectively communicate the dangerous operations via Nim's existing
effect system.
Now Clyybber's brilliant insight was that this effect can be incorporated into
the existing `noSideEffect` effect!
No new effect is required, we simply tweak the language definition!

`noSideEffect` in Nim means "does not access a global or thread-local variable
nor does it call a routine that does".
We add another criterion to what it means to have a "side effect":

Mutating an object reachable from a parameter does count as a side effect.

There is a new experimental mode written as `{.experimental: "strictFuncs".}`
to enable this stricter interpretation of what a "side effect" means.

Here is how it looks in practice:

```nim
{.experimental: "strictFuncs".}

type
  Node = ref object
    data: string
    next: Node

func count(n: Node): int =
  result = 0
  var it = n
  while it != nil:
    inc result
    it = it.next
  # does not compile anymore!
  n.data = "mutated!"
  #  Error: 'count' can have side effects
  # an object reachable from 'n' is potentially mutated
```

As usual, the devil is in the details.
Any algorithm that we use should be smart enough to detect hidden mutations 
via local aliases:

```nim
{.experimental: "strictFuncs".}

type
  Node = ref object
    data: string
    next: Node

func p(n: Node) =
  let x = n
  let y = x
  y.data = "mutated!"
```

And indeed the compiler is smart:

```nim
func p(n: Node) =
  # Error: 'p' can have side effects
  # an object reachable from 'n' is potentially mutated
  let x = n
  let y = x # is the statement that connected the mutation to the parameter
  y.data = "mutated!" #  the mutation is here
```

It is not fooled by function calls either:

```nim
func id(n: Node): Node = n

func p(n: Node) =
  let x = id n
  let y = id x
  y.data = "mutated!"
```

Internally the compiler constructs an abstract graph and looks for
subgraphs that are both mutated and "connected" to an input parameter.
The analysis does not depend on the control flow, two locations
`a` and `b` are connected if there is a pattern like `a = f(b)` in the source code.


Mutability via var
------------------

Some mutations remain to be allowed and do not count as a "side" effect:

```nim
func add*[T](s: var seq[T]; x: sink T) =
  # valid: mutates 's'.
  let oldLen = s.len
  setLen s, oldLen + 1
  s[oldLen] = x
```

The idea here is that no matter what `T` is instantiated with, `x` should be
deeply immutable, but the seq `s` is mutated.
Mutations to `var T` parameters remain valid.


Summary
-------

"strict" funcs are an answer to a long standing design question, fit
Nim's existing design in a most natural way ("hey, this is the
definition of side effect that I always had in mind!") and can enable
Nim's optimizer to be more effective.

If you use Nim devel (1.3.x) this feature is already available to you
and can be accessed via `{.experimental: "strictFuncs".}`
in your source code or via `--experimental:strictFuncs` on the command line.
Please try it out and give us your feedback!
