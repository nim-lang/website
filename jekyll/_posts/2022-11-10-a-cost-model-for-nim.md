---
title: "A cost model for Nim"
author: Andreas Rumpf (Araq)
excerpt: "This blog post is the beginning of a cost model for the implementation that is available via `Nim devel` aka Nim version 2."
---




## A cost model for Nim

> It is impossible to design a system so perfect that no one needs to be
> good.
>
> --- T. S. Eliot

This blog post is the beginning of a cost model for the implementation
that is available via "Nim devel" aka Nim version 2.

This implementation was designed for **embedded, hard real-time
systems**. Generally speaking, assuming you have enough RAM (which is
about **64 kB**) all of Nim's language features are supported --
including exception handling and heap based storage. The implementation
of these features also works on bare metal, without an operating system.




## Heap based storage

Why the focus on embedded, hard realtime systems? Because when you do
these well you can also do everything else well! The algorithms used are
oblivious of the heap size, Nim's memory management works well with a
64 kB sized heap but also scales to a 16 gigabyte heap, for example.

Memory can be shared effectively between threads without copying in Nim
version 2. The complexity of allocation and deallocation is O(1) and
Nim's default allocator is completely lockfree. Fragmentation is low
(average is 15% - worst case is 25%) as it is based on the
[TLSF](http://www.gii.upv.es/tlsf/) algorithm. The lockfree ideas have
been taken from [mimalloc](https://github.com/microsoft/mimalloc).

That means that the cost of `new(x)` or `ObjectRef(fields)` is O(1) for
the allocation and O(`sizeof(x[])`) for the required initialization. If
the object constructor initializes every field *explicitly* the
*implicit* initialization step is optimized out.

The cost of destruction of a subgraph starting at the root `x` is O(N)
where N is the number of nodes in the subgraph. A subgraph of acyclic
data is immediately destroyed when the refcount of its root reaches 0.

Cyclic data is harder to reason about and best avoided. Nevertheless, if
you end up creating cyclic data the system remains "deterministic" and responsive
at all times. You can influence the cycle collector via a new API:

``` nim
proc GC_runOrc*()
  ## Forces a cycle collection pass. The runtime depends on your program
  ## but it does not trace acyclic objects.

proc GC_enableOrc*()
  ## Enables the cycle collector subsystem of `--mm:orc`.

proc GC_disableOrc*()
  ## Disables the cycle collector subsystem of `--mm:orc`.
```

The idea is that you can schedule a cycle collection when it is
"convenient" for your program. In other words when your program is
currently not busy. However, in my experiments with Nim's async event
loop I saw no benefits in doing so. The lesson to take away here is
**"relax, you'll be fine"**.





## Deterministic exception handling

### Subtype checking in O(1)

Starting with version 2 the `of` operator which is also used implicitly
in the `except E as ex` construct is finally as fast as it should be:
It's a range check followed by a memory fetch. The cost is O(1).

Nim's exceptions are based on a good old-fashioned type hierarchy that
supports runtime polymorphism. The different exception classes can vary
in size. As such, exceptions are allocated on the heap. However, it is
possible to preallocate them. The standard library does not do this yet
-- pull requests are welcome!



### Goto based exception handling

When you compile to C code, exception handling is implemented by setting
an internal error flag that is queried after every function call that
can raise. `setjmp` is not used anymore. To improve the precision of the
compiler's abilities to reason about which call "can raise", make
wise usage of the `.raises: []` annotation. The error path is
intertwined with the success path with the resulting instruction cache
benefits and drawbacks.

The involved costs are about 2-4 machine instructions after a call that
can raise. (There are known ways to optimize this further into one
instruction for the most common architectures.) This overhead is
annoying but at least it is optimized out for tail calls.



### Table based exception handling

When you compile to C++ code, the C++ implementation of exception
handling is used, typically it is based on exception handling tables.



### Which one is better

It depends on your program which implementation strategy performs
better.

There are rumors that a table based exception implementation lacks
"predictable" performance and so should not be used for hard realtime
systems. If these rumors are still true then the goto based exception
handling should be preferred.






## Collections and their costs

### Arrays, objects, tuples and sets

These are mapped to linear sections of storage, directly embedded into
the parent collection, that means that if no `ref` or `ptr` indirections
are involved, they are allocated on the stack. (This is nothing new, it
was always true for every Nim version and memory management mode.)

The reason why these can be embedded directly is simple: They are of a
fixed size that is known at compile-time.

Flexible buffer handling can be done with `openArray` which is a
`(pointer, length)` pair. Both arrays and sequences can be passed to a
parameter that takes an `openArray`.



### Seqs and strings

Seqs and strings are `(len, p)` pairs, `p` points to a block of memory,
sometimes called "payload". The payload contains information about the
available capacity followed by the elements, these are stored in order
with no further indirections.

Nim does not implement C++'s "small string optimization" (SSO) for
the following reasons:

-   Strings and seqs in Nim are binary compatible, `cast`'ing between
    them is supported.
-   SSO makes *moves* slightly slower and Nim is good at moving data
    around rather than copying.
-   SSO makes the performance harder to predict as small strings are
    significantly faster to create than long strings. (The storage for
    long strings needs to be requested from an allocator). SSO also
    implies that the number of memory indirections differs between long
    and short strings.

Instead, string *literals* in Nim cause no allocations and can be
shallow copied in an O(1) operation.

If you disagree with this design choice and want to have strings that do
SSO, there are external packages available
([ssostrings](https://github.com/planetis-m/ssostrings),
[shorteststring](https://github.com/metagn/shorteststring)).



### Hash tables

Most of Nim's standard library collections are based on hashing and
only offer O(1) behavior on the *average* case. Usually this is not good
enough for a hard realtime setting and so these have to be avoided. In
fact, throughout Nim's history people found cases of pathologically bad
performance for these data structures. Instead containers based on
BTrees can be used that offer O(log N) operations for
lookup/insertion/deletion. A possible implementation can be found
[here](https://github.com/nim-lang/fusion/blob/master/src/fusion/btreetables.nim).






## Threads, locks and condition variables

For better or worse, Nim maps threads, locks and condition variables to
the corresponding POSIX (or Windows) APIs and mechanisms. This means
their costs are not under Nim's control. Using an operating system
designed for hard realtime systems is a good idea.

If your domain is not "hard" realtime but "soft" realtime on a
conventional OS, you can "pin" a thread to particular core via
`system.pinToCpu`. `pinToCpu` can mitigate the jitter conventional
operating systems can introduce.






## Other gotchas

When targeting embedded devices there are many platform specific knobs
and quirks that are beyond the scope of this document. You need to be
aware that Nim's default debug mode is probably too costly so right
away you should use `-d:release` or a combination of switches like
`--stackTrace:off --opt:size --overflowChecks:off --panics:on` not to
mention the selection of your CPU and OS and setting up a C cross
compiler.

Feel free to join [Nim's discord embedded
channel](https://discord.com/channels/371759389889003530/756920870525730947)
and ask for help!





## Conclusion

Nim's new implementation is excellent for embedded devices but it is
the nature of constrained devices to need specialized solutions like
custom containers. For example, a specialized growable array container
could save memory if it lacks a "capacity" field and uses only a 16
bit integer to track the current length. Custom containers are easy to
create in Nim and they work well together with the builtin constructs
because they speak a common
[protocol](https://nim-lang.org/docs/destructors.html).

How to write an array that can grow at runtime without storing the
capacity is left as an exercise for the reader. Happy hacking!





## Donating to Nim

Nim is free and open source. Our work and time is not free. Please
consider sponsoring our work!

You can donate via:

- [Open Collective](https://opencollective.com/nim)
- [BountySource](https://salt.bountysource.com/teams/nim)
- [PayPal](https://www.paypal.com/donate/?hosted_button_id=KYXH3BLJBHZTA)
- Bitcoin: 1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ

If you are a company, we also offer commercial support.
