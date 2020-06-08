---
title: "Static Analysis"
author: Moerm
excerpt: "Nim is in an excellent position to “get married” with static analysis, and it doesn’t have to be based on some intermediate representation but can achieve a solution more similar to Spark."
---

<div class="sidebarblock">
  <div class="content">
    <div class="title">Guest post</div>
    <div class="paragraph">
      This is a guest post by Moerm. If you would like to publish articles as a guest author on nim-lang.org then get in touch with us via
      <a href="https://twitter.com/nim_lang">Twitter</a> or <a href="https://nim-lang.org/community.html">otherwise</a>.
    </div>
  </div>
</div>



## Intro

What is static analysis (SA)?
Well, static means 'not dynamic', i.e. not at or via runtime.
Static analysis is something that is done at or near compile time in the context of software development.
But static analysis is just one part of the formal chain, which is usually not fully used except for critical systems, such as train control systems.

The full formal chain starts with formal specification, an important pre-requisite of which is formal requirement assessment.
This part deals with the question "*what* is some software to do?".

The next step is formal design and modelling which deals with the question of *how* the software is doing it; usually this first describes -- in a formal way -- data and algorithms, then verifies the model and finally is (usually) used as a skeleton and To Do for the code.
This work's goal is roughly comparable to what SPARK is to Ada, i.e. it is what allows Nim programs to be formally verified for correctness.



## A more elaborate look

What does it mean to say that some code is 'correct' anyway?

To answer that question we must first understand the context and see the full picture by widening our view and seeing what 'software development' means.
Software development can be described as a somewhat strange process that is about translating from -- and understanding! -- one language, namely that of a client, who thinks in *their* language and within *their* world, which may be astrophysics, sales, or manufacturing.
And they often don't mention what they consider as well-known.
That's the 'incoming' side.

On the other side, the 'outgoing' one, there is hardware which, as every developer with some experience knows, has its own treacherous spots.
There is a complex third part too, because usually the software we build does not run directly on hardware but on usually multiple intermediate layers such as the OS and libraries.

When some project is critical we definitely want a formal specification, also including pragmatic factors that are not relevant for the desired functionality itself but which are valuable or even critical for us to know.
One obvious example is a list of operating systems and architectures on which the code will have to run.
Another less obvious example is the question how closely the code will be observed (e.g. log files) and what failure responses are acceptable.

But again and keep that in mind: The statement that *our* code is proven to be correct is the *maximal* statement we can make, and frankly one that is very hard to achieve and very rare, because we only control 1 of many layers yet need to interact with them or depend on them.



## Static analysis

Static (program) analysis is the formal chain element we as software developers are most concerned about.

The common "definition", let me quote Wikipedia, *"Static program analysis is the analysis of computer software that is performed without actually executing programs ..."* is correct but at the same time utterly insufficient and next to useless.

Why?
Because we must differentiate between a compiler writer and a developer or, in other words, between the question "is the code per se correct?" and "is the code logically correct?".
From a compilers perspective the following code:
```nim
let foo: uint32 = 0 # init var
var myArray : array[0 .. 511, uint32] # our array
# ...
foo = myArray[100] # assign some element to foo
```
is correct.
The types match and the index is within bounds.
That is what a compiler cares about.

Does it make sense to assign `myArray[100]` to `foo` is *not* a question a compiler is concerned about.
You, however, should be concerned about it.
Why?
Because you want and need your code to do *something sensible* and what it needs to do, or in other words, you want your code to implement some algorithm.

What one *does* need static analysis for is basically to check algorithmic correctness - but if one implements that, one may as well make use of that capability to offload quite a bit of compiler work to static analysis.

Let me give you an example: ranges.
What is a range really?
It is basically the same as writing `var month : uint8 invar 0 < month <= 12`, i.e. a variable declaration with an invariant.

An invariant is a condition that must hold true during the life-time of the item (e.g. a variable) it is related to.
Most languages and SA tools allow that an invariant can not hold under some clearly defined conditions.

In fact, the example above is very close to the notation of an existing model checker with static analysis.
Now, if one has say a string array with the month names, accessing that array by a month number will always be within bounds if the month number is declared as above.

Putting it more generally: Always nail down your types as tightly as possible.
That very simple rule is an important rule to achieve error free code.

Let me give you another example: Nim's `low` and `high` notation which provides an array's (or sequence's) lowest and highest valid index.
It too can be seen as an invariant, namely as `loop_var.min <= loop_var <= loop_var.high`.
If I wanted to get the same in C I would have to write a bunch of annotations for a static verifier like Frama-C.
Both of those examples deal with problems that are high up on the list of errors creating real-world vulnerabilities.



## Static analysis, part 2

Let us look at a dead simple function that simply returns the argument value (of two args) that is lower, i.e. a `min` function.
A no-brainer, right?
Well, it depends on some factors, especially on the argument type.

If we declare it as `func min(a: int, b: int) : int` as it's often done, then we may run into problems.
Say for example `a` is -128, `b` is 0, and `int` is 8 bits on some of the architectures we address.
What will the result be?
Presumably `-128`.

What we really want to do is to say that the result really is the minimum of the two values provided; but the minimum of two numbers is a *mathematical* statement.
Our goal is of a *mathematical* nature and what we really mean to achieve is something like:
"This function takes two numbers and returns the one with the lower value -- *and* all three, the two parameters and the return value, are elements of the set of natural numbers, e.g. between -128 and +127".

Now, assume that our `min` function came with the following specification:
```nim
func min(a: int, b: int): int
  require((INT_MIN <= a < INT_MAX) and (INT_MIN <= b < INT_MAX))
  ensure((INT_MIN <= result < INT_MAX) and ((result == a and result < b) or (result == b and result < a)))
```

This might look like a decent and sensible specification -- but it isn't, mainly for three reasons:
1. it's too dependent on concrete circumstances (like word width), i.e. it's what sometimes is called a "programmers spec" (as opposed to a mathematical spec) and only repeats the declaration in other words,
2. the declaration (code) is probably not precise enough, i.e. 'uintX' (e.g. 'uint16') probably would be better and would implicitly make the spec shorter, and
3. the spec isn't clear and complete; what if `a == b`? In that case the postcondition won't hold.

Here is a better spec:
```nim
func min(a: int16, b: int16): int16
  ensure((result == a and result <= b) or (result == b and result <= a))
```

The precondition is now automatically created by the compiler (based on the precise parameter type) and the, now also simpler, postcondition also covers the case where `a == b`.

"But I *want* a general and generic `min` function!" you say?
Well, then keep the first version above and just correct the postcondition, but think twice whether this really is what you want.
Rule of thumb: Nail everything (e.g. types) down as tightly as possible.

The main point of this example was however something different, namely that a postcondition (usually) should make statements related to what the function *does*, related to the algorithm implemented.
In other words: It should be sufficient for an observer to look *only* at the specification (and ignore the function body) in order to know what a function does.

Being at that I'll quickly deviate to an issue that sometimes comes up in SA related discussions: "why would we need quantors, especially the `exists` quantor?".
To answer that let me quickly introduce another `min` function, one that works on a list:
```nim
func min(values: seq[int32]): int32 # find lowest val in list 'values'
  postcondition(*???*)
```

How are we to specify a postcondition (again: ideally one that also tells us what the function does) when we do not even know how many values the function will get passed?
Solution: We submit that there exists no element in the parameter list that is smaller than `result`.

We could also use the `all` quantor and play with the indices into the list but that would quickly get ugly.
It's easier and, more importantly, more clear to state something like `ensures(not exists x in values: x < result)` (read like "there is no element in the list `values` that is smaller than `result`").



## Static analysis, part 3

So, how does all that work?
There are different ways but at least nowadays pretty much all static analysers use Hoare triples, often also called "Design by Contract" (DbC), as a basic framework.
Hoare triples have 3 parts (no surprise there), namely a *precondition*, a *postcondition*, and optionally *invariants*.

They are useful to make statements about functions/procedures.
One typical and good way to describe it is a DbC "schoolbook" explanation:
A precondition is a promise the caller must fulfill, and a postcondition is a promise the callee must fulfill.
Or to put it very simply: if a function/procedure is called with a state (usually the parameters) meeting the preconditions then it *will definitely* meet its postconditions once it's done (at function exit).

Small but important side note: most decent static analysers do not limit the state specifications in pre and postconditions to parameters and return values but can deal with *any reachable* state (e.g. global variables), although parameters and return values are the classical and most used case.

Unfortunately preconditions (often written as "require") are often misunderstood and/or only (ab)used for simple parameter checking, e.g. to avoid null pointers.
And that's halfway OK but preconditions can do much more.

For a simple example think of a function that is meant to only deal with an odd parameter value.
Prime numbers might be a use case (except for `2`).
Imagine that we wanted a function that only works on potential prime numbers, maybe a refining stage in a prime sieve.
The definition and preconditions might look like this:

```nim
func someSieve(const num: uint64): bool # primes aren't negative and can get big
  where precondition(lastDigit(num) not in['0','5']) and (num > 2) and (num % 2 == 1))
  # body
```

Again, note that this is telling the function itself, the static verifier, and any caller something, namely that the `num` parameter must not end in 0 or in 5 (prime numbers don't end in 0 or 5), is greater than 2 (we don't care about 1 and 2), is odd (an even number > 2 can't be prime), and is `<= MAX_UINT64` (implicit via the type).

You noted my little trick with `lastDigit`?
Well, actually it's not really a trick but a handy device: `lastDigit` is called a "ghost function", which is a function that only exists at analysis/verification time (but normally not at run-time) but otherwise acts (almost) just like any function.
The full truth is that a ghost function (in almost any analyser offering them) is a purely mathematical (abstract) function, sometimes called "lemma".
The interesting point for you is that a ghost function is useful for two things:
1. keeping your conditions and invariants looking clean (readability is important!), and
2. to do what functions do, i.e. to be reusable (certain condition elements occur multiple times in a code corpus so it can be handy to put them into a ghost function); plus they vanish when compiling.

Postconditions (often written as "ensure") do quite the same thing but at function exit.
They specify state related conditions that the function guarantees to hold.

For example, if we stated that a given function never returns a negative value or a value greater than 42 we could express that like this
```nim
func someFunc(a: int32): uint32 # ...
  where postcondition(0 <= result <= 42)
```

Again, keep in mind that we make a *mathematical* statement albeit one that (usually) is related to *code* variables.
Although it should be noted that a decent static analyser also makes use of code elements, e.g. variable declarations, and includes them in its working.

Let's quickly return to invariants because they play a major role with control mechanisms.
One particularly interesting point in static analysis is to make sure that loops properly terminate.

In languages where the loop control element, e.g. the variable `i` in `for(i = 0; i < 42; i++)`, is read-only the problem is less critical, but in languages like C where the loop control element can be assigned to and might "jump around" quite a bit it can become really problematic.

Enter loop invariants (whose scope is typically limited to the loop).
One example is a so called 'decrementor' (editor note: not to be confused with [Dementor](https://vignette.wikia.nocookie.net/harrypotter/images/4/49/DementorConceptArt.jpg) :)), a type of loop invariant which starts with some value (e.g. the max value of the control element) and counts down one after each loop iteration.
The analyser then tries to prove that the decrementor eventually reaches zero.

If conditions on the other hand are rather simple.
All the analyser must do is to look at the control element domain (its "range") and for the two possible cases and the "pivot" point.
Remember, the analyser looks from a mathematical perspective.
Whether `i` is `1` or `41` in an `if(i < 42)` clause makes little difference to an analyser.
What it sees is (assuming `i` being an `uint16`) that the domain of `i` is `0 <= i < 65536` and that 42 is within the domain and the "pivot" which means that the domain is split into two, namely `0 <= i < 42` and `42 <= i < 65536` which represent the entry gate to the `if` and the `else` part.

Now we are at a point where we can understand some more things, for example why some analysers (like Spark) are particularly helpful: it's because they are intimately interwoven with the "host language" (Ada) and hence understand a lot of the information the compiler has available (and vice versa).
A more modest and limited but somewhat similar situation can be found with LLVM based analysers because they too have access to a lot of information albeit on the intermediate code level.

Nim too is in an excellent position to "get married" with static analysis due to the fact that it already has quite a few of "hidden invariants", e.g. ranges and quite some other helpful factors and generally a quite clean basic syntax.
Probably even more importantly, Nim analysis doesn't have to be based on some intermediate representation (and hence limited like e.g. LLVM) but can achieve a solution more similar to Spark.
Static analysis will also help Nim development tremendously because we can for example make it a rule that only adequately specified and successfully verified code will be accepted.

Solving isn't the problem of static analysis any more, so what is a static analyser then?
It is the "bridge" between code and math/solving; it is what collects all the bits and pieces of information contained in the code, as well as the information provided by the person "annotating" the code and feeds it in a meaningful and relevant manner to the solver.

Sounds simple?
Well, yes, in theory but in real life it seems to be a complicated and hard job; the fact that only extremely few languages offer some SA facilities as well as the fact that SA is largely used only in rather few very sensitive projects strongly suggests that SA is *not* that simple.
Another fact that also seems to confirm that view is the fact that there are only about a dozen or two actually usable and used static analysers, all of which are either somewhat limited or way too complex for most developers including quite experienced ones.



## Conclusion

Static Analysis -- and I mean SA tightly coupled to its "host language" -- offers two big things, namely:
1. the *only* way known so far to achieve justified confidence in code by *proving* it's bug free, and
2. an actually usable and even reasonably convenient way for mere mortal developers to achieve that confidence.

With a caveat: a static analyser can't do miracles; it largely can only prove correct what you feed to it.
If you don't provide statements/conditions to be verified you won't get much out of it.

You've probably heard of the fully verified seL4 kernel.
Well, they did take the hard route (back then they had to) and it took them about a decade of very skilled specialists work.
Compare that to Ada/Spark, probably still *the* example of a programming language coming (since some years) with a "built in" (actually quite tightly coupled) static analyser.
I still remember my first experience with it.
It was almost a dream having come true, not even just because it was something one could actually use without a PhD, but also because efficiency of use and even some convenience have a tangible and significant influence on our income as developers; we usually simply can't afford to invest way more time in "annotation" than in writing code.

If there is one thing that you should take with you from this article it is this:
The compiler which is unnerving you with its warnings is *your friend*.
SA is some kind of an extended version of this.
SA is *your friend*, and a powerful one!
Make your choice: you can have the static analyser point out problematic spots to you, or you can have your customers pointing them out (and cursing at you).

The other point you should take away is that SA is (based on) *another* specification of what you are coding.
It is *not* a disadvantage but an *advantage* that it's not exactly like code/your programming language.
It allows you to express your algorithms in a somewhat similar notation but having checked *the algorithm* as well as the program implementation.

In fact, I suggest to even go further and to consider the specification the important part and coding as some "secondary work".
Programming is "just" the part of implementing the "how?".
And indeed in highly sensitive environments, one *first* properly specifies (formally) *what* is done, what conditions must be met and what the state has to be before and after some module or procedure, and actually implementing the module and/or procedures is only the second to last step (the last step is verification and testing).

Also note one particularly useful and beautiful side effect of that:
if some procedure or module needed to be changed, say due to some administrative change, that change could not create harm to the whole system *iff* the specification ("annotations") is sufficiently complete and tight.

I expect some future Nim version X (with a not complete but reasonable level of SA) to be a leap comparable to Ada/Spark, and potentially an even more significant leap because Nim is a language that is (or soon will be) much more used -- and much easier to use -- than Ada.
I'll dance in joy once a Nim version with a `-d:verify` switch becomes available.
