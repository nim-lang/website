---
title: "Benchmarking the Beast"
author: W. Gordon Goodsman (GordonBGood)
excerpt: "Benchmarking with the Sieve of Eratosthenes with efficient cache use "
---

<div class="sidebarblock">
  <div class="content">
    <div class="title">Guest post</div>
    <div class="paragraph">
      This is a guest post by W. Gordon Goodsman (GordonBGood).
      If you would like to publish articles as a guest author on nim-lang.org then get in touch with us via
      <a href="https://twitter.com/nim_lang">Twitter</a> or <a href="https://nim-lang.org/community.html">otherwise</a>.
    </div>
  </div>
</div>

# Nim: Efficient, Expressive, Elegant - Comparing these Aspects

## Introduction

This will be a series of blog posts showing what makes Nim such a great general purpose language that is true to its goals of being efficient, expressive, and elegant.  This first article of the series develops a benchmark program that demonstrates all three.  Further articles in the series will, first, move into a more ambitious application developed from the benchmark, then show that Nim has overcome many/most of the reasons programmers may not have taken to it in its earlier years, using more modern features to further advance the application, and finally look at new experimental features and examine how those features may make Nim competitive to any computer language in the wild, at least in the general sense as in not being specialized to any one niche.

Other than highlighting the good points of Nim, part of the reason this post is timely is that it explains the intricacies of efficient Sieve of Eratosthenes composite number culling as used in a ["Dave's Garage Software Drag Racing"](https://www.youtube.com/channel/UCNzszbnvQeFzObW0ghk0Ckw) competition [hosted on GitHub](https://github.com/PlummersSoftwareLLC/Primes).  This cross-referenced blog post should help explain why the Nim entry solution 3 is so fast using the technique of Extreme Loop Unrolling.

## History of using the Sieve of Eratosthenes as a benchmark

In the Dawns of Time (much previous to the start of Nimrod/Nim development), there was an article published in [Byte magazine, July 1980 issue, page 180](https://archive.org/details/byte-magazine-1981-09/page/n3/mode/2up "downloadable archive link") on benchmarking computers and computer languages using an Odds-Only Sieve of Eratosthenes (sieving only the odd numbers, as two is the only even prime).  Of course, back then computers and computer languages were no where near the sophistication of today, and the author of the article wasn't all that experienced either, so the program listing in that article shows some flaws, but the idea was sound as I am going to show in this article.  A couple of the basic ideas that the author, Jim Gilbreath, missed were that composite number culling can start at the square of each base prime as earlier composites will have already been culled by lower value base primes, and culling can stop when the base prime value reaches the square root of the sieving range, but that would not impact the implementation's use as a benchmark - it would just make the task slower than it needed to be.

In the Beginning of Time (not long after the start of Nimrod/Nim development), our own Dennis Felsing (@def or def-) published a blog post "What is Special about Nim" in which [he used a version of the Sieve of Eratosthenes to use as a benchmark](https://hookrace.net/blog/what-is-special-about-nim/#nim-runtime-26-s) to try to show that Nim was at least as fast as most languages.  That version is reproduced here as follows:

```nim
import math

proc eratosthenes(n: int): auto =
  result = newSeq[int8](n + 1)
  result[0] = 1; result[1] = 1

  for i in 0 .. int sqrt(float n):
    if result[i] == 0:
      for j in countup(i*i, n, i):
        result[j] = 1

discard eratosthenes(100_000_000)
```

As one can see, that version fixes the problems I mentioned about the old Byte magazine version in that culling starts at the square of the base primes found and stops when the base primes reach the square root of the range, but now he no longer sieves odd numbers only, meaning that there are almost two and a half million culling operations up to a hundred million rather than just under a hundred million for odds-only culling; again, that doesn't matter for use as a benchmark, but it still means as an application, it is about two and a half times slower than necessary.

However, as a benchmark, it does suffer from some major problems in what the timing actually indicates, as follows:

1. The program uses a hundred million bytes of storage, which means that the algorithm isn't very expandable for larger ranges as one might like to test.  Use of one byte to represent each possible composite number is very wasteful since each eight bits then represent just one state of being a composite number or not.
2. Use of the one-huge-memory-array algorithm means that the storage and the culling loops run well beyond the range of the CPU cache sizes which are generally about 16 Kilobytes for the L1 cache and about 128 Kilobytes for the L2 cache.  Memory access time for the L1 cache is generally about one CPU clock cycle, it is something about eight clock cycles for the L2 cache, and it is up to many tens of cycles for the main RAM memory access to which this algorithm would have to often resort.

So the blog post finds that the benchmark runs the same speed as the C version, but that isn't very meaningful as both are bottle-necked by the speed of RAM memory access and of course that is the same since the benchmark was run on the same machine; the fact that it shows that these are over ten times faster than the Python equivalent code isn't surprising considering that the Python code was interpreted, and if these weren't bottle-necked, the difference could be up to something closer to a hundred times faster.

# Goals of a new Sieve of Eratosthenes (SoE) Benchmark

In order to be better able to reveal the speed of the generated code from compiled languages such as C, Rust, and Nim, an improved SoE algorithm needs to be used that by its design leads to fast execution.  The design elements then are as follows:

1. Although it isn't important for a benchmark, in order to use this work for a later more sophisticated application, odds-only culling may as well be used.  This simple form of wheel factorization reduces the memory use by a factor of two at no cost in time per culling operation.  This is a simple form of wheel factorization because every other bit in a representation of all numbers represents even numbers that will be culled on the first pass with a base prime of two, so organizing the bits into two "bit planes" with one containing all the evens and the other the odds, it is readily apparent that the evens bit plane can be discarded.  The odds bit plane is then said to contain the residuals of a modulo two operation, and culling across it is still by the base prime value per cull.
2. As many composite number representations as possible should be packed into a given CPU l1 cache size, which means that only one bit is used for each.  Along with using odds-only sieving, this will allow a reasonable size of culling range much larger than the eight or sixteen thousand range that were used in the Byte magazine article.  For some implementations, this will mean some extra CPU instructions spent "bit-twiddling", but even for those, there will be a net gain due to the better use of cache, and as will be seen, use of "Extreme Loop Unrolling" can even avoid the run time "bit-twiddling".  Memory use is now reduced by a further factor of eight for a total reduction of sixteen times.
3. Rather than using some of the "bit-twiddling" operations involving bit shifts in order to produce a mask for the indexed bit position, one can use an eight element Look-Up-Table (LUT) that is easier and thus faster for the compiler to use.
4. Finally, one can develop the mentioned "Extreme Loop Unrolling" algorithm, which works as follows:
   1. The base primes have been reduced to only odd values.
   2. Culling across bytes means that culling is across even values since bytes have eight bits.
   3. Doing this, a repeating modulo pattern occurs where the same indexed bit position will be marked for every eight culls and the byte masked will be exactly the base prime value away from when that bit position was last marked as culled.
   4. The above means that each repeating pattern for a given base prime value only differs by the bit position at which it starts, for eight possibilities.
   5. Due to modulo mathematics, there are only differing patterns for the base prime values modulo eight, and since all base prime values are odd means that the least significant bit is always a one, there are only four varieties of culling pattern.  These four patterns times the eight possible starting positions means there are only 32 total culling patterns.
   6. Because each of these possible culling patterns is fixed for a given pattern possibility, one can use constant (immediate) masking values for the eight-pattern culling positions, meaning "bit-twiddling" isn't necessary.
   7. For a given possible culling pattern for a given base prime value, each byte index is a constant offset developed from the base prime value from the first byte index in the eight pattern, which means that if one causes the compiler to use register indexing from a base register (which most efficient C-type compilers automatically do), if eight registers are available then the whole loop can be done using register operations, and if there are two more registers available to hold the base prime value and the loop ending limit value, then the whole culling for a given range can be done entirely using register operations other than the read/modify/write operation that actually marks a bit as culled.
   8. The above technique only works efficiently for smaller values of base prime where the culling span does not exceed the number of bytes in the CPU L1 cache, and actually less than that as there is a significant setup time for the loop and also a loss of time for the extra branch-prediction miss caused by the computed pattern selection of one of the 32 patterns, as this selection appears to be random to the CPU and thus can't be efficiently predicted.

The above algorithm may appear to be incomprehensible when first encountered, but it is actually quite simple when one sees it implemented further down this post.

## Implementation not including loop unrolling

The following SoE benchmark uses all of the techniques from above except for extreme loop unrolling and includes multiple culling pass loops so that the number of culling operations is about the same as for the naive version above:

```nim
import std/monotimes
from times import inMilliseconds

const cLOOPS {.intdefine.} = 1225

# avoids some "bit-twiddling" for better speed...
const cBITMSK = [ 1'u8, 2, 4, 8, 16, 32, 64, 128 ]

proc benchSoE(): iterator(): int {.closure.} =
  # represents primes up to 262146
  var cmpsts = newSeq[uint8](16384) # starts at zero -> all prime
  let cmpstsa = cast[int](cmpsts[0].addr)
  for _ in 0 ..< cLOOPS: 
    for i in 0 .. 254: # to (sqrt(262146) - 3) / 2 index
      if (cmpsts[i shr 3] and cBITMSK[i and 7]) == 0'u8: # for base prime
        let bp = i +% i +% 3 # for start index of bp squared...
        for c in countup((i +% i) *% (i +% 3) +% 3, 131071, bp):
          let cp = cast[ptr uint8](cmpstsa + (c shr 3))
          cp[] = cp[] or cBITMSK[c and 7] # pointer is 10% faster
  return iterator(): int {.closure.} =
    yield 2 # the only even prime
    for i in 0 .. 131071: # separate iteration over results
      if (cmpsts[i shr 3] and cBITMSK[i and 7]) == 0'u8:
        yield i +% i +% 3

let strt = getMonotime()
let answr = benchSoE()
let elpsd = (getMonotime() - strt).inMilliseconds
var cnt = 0; for _ in answr(): cnt += 1
echo "Found ", cnt, " primes to 262146 for ", cLOOPS,
     " loops in ", elpsd, " milliseconds."
```

Where Dennis's program takes about 1.4 seconds to run at 2.9 GHz, this new version runs about the same number of culling operations in about 0.27 seconds on the same machine with both compiled using  the "-d:release -d:danger" compiler command line definitions to turn off all checking (checking is done in the code itself), meaning it is about five times faster per culling operation in spite of bit-packing, and takes about 3.5 CPU clock cycles per culling operation (or less on more modern CPU's) instead of about 17.  But we aren't finished; there is still Extreme Loop Unrolling.

## Implementation including Extreme Loop Unrolling

Now comes where features of Nim, especially the macro facility, comes into play in writing a short implementation of the 32 cases of the Extreme Loop Unrolling algorithm.  Following is the promised explanation of how it works:

First, for each loop the pattern needs to be set, so for example for the cases where the base prime ends in a 3 when modulo 8 (3, 11, 19, etc.) and culling starts at bit position zero, the loop code needs to be as follows:

```nim
  while culla < endalmt:
    let cptr0 = cast[ptr uint8](culla)
    cptr0[] = cptr0[] or 1'u8
    let cptr1 = cast[ptr uint8](culla + strt1)
    cptr1[] = cptr1[] or 8'u8
    let cptr2 = cast[ptr uint8](culla + strt2)
    cptr2[] = cptr2[] or 64'u8
    let cptr3 = cast[ptr uint8](culla + strt3)
    cptr3[] = cptr3[] or 2'u8
    let cptr4 = cast[ptr uint8](culla + strt4)
    cptr4[] = cptr4[] or 16'u8
    let cptr5 = cast[ptr uint8](culla + strt5)
    cptr5[] = cptr5[] or 128'u8
    let cptr6 = cast[ptr uint8](culla + strt6)
    cptr6[] = cptr6[] or 4'u8
    let cptr7 = cast[ptr uint8](culla + strt7)
    cptr7[] = cptr7[] or 32'u8
    culla += bpint
```

where `cptr0`/`culla`, `cptr1..7`, `endalmt`, and `bpint` should each be a CPU register.  It can be seen that this eight-loop has very little loop overhead.  When compiled to x86_64 code using gcc/c, the following assembly code is produced:

```
.L271:
  or	BYTE PTR [rax], 1
  or	BYTE PTR [rdi+rax], 8
  or	BYTE PTR [r8+rax], 64
  or	BYTE PTR [r9+rax], 2
  or	BYTE PTR [r10+rax], 16
  or	BYTE PTR [r11+rax], 128
  or	BYTE PTR [rbx+rax], 4
  or	BYTE PTR [rcx+rax], 32
  add	rax, rsi
  cmp	r12, rax
  jg	.L271
```
In it, one can see that there are just the eight marking as composite `or` indexed read/modify/write instructions and the loop overhead of adding the base prime value to the base register and looping if it tests as less than the limit.  In modern CPU's, the loop overhead is mostly elided away for multiple repeated loops leaving the eight single clock cycle marking instructions per loop.

The 32 varieties of these loops are prefixed by code initializing all of the registers, and each of the above variety of loop includes a conventional culling loop to handle the case where the eight-loop limit can't cull the entire buffer, leaving a remainder averaging 3.5 loops (zero to seven single-cull loops).

The Nim manual cautions against using unnecessary macros, but for this application, a macro is completely appropriate instead of having to invoke a template 32 times as we can use the macro to cause the repetition to produce the 1943 lines of Nim code with just a 70-line macro.  If one enables one of the last commented lines at the end of the following macro, the compiler will show the generated Abstract Syntax Tree (AST) with the `astGenRepr` function or the actual Nim code output with the `toStrLit` function, which might be applied to show just one of the 32 cases as produced the above (element 9) or the entire almost two thousand lines by showing the entire result.  The following code, including the macro, can replace the `benchSoE` proc in the above code (also adding `import macros` at the head of the file):

```nim
macro unrollLoops(ca, sz, strtndx, bp: untyped) =
  let cmpstsalmtid = "cmpstsalmt".newIdentNode
  let szbitsid = "szbits".newIdentNode
  let strtndx0id = "strtndx0".newIdentNode
  let strt0id = "strt0".newIdentNode
  let strt7id = "strt7".newIdentNode
  let endalmtid = "endalmt".newIdentNode
  let bpintid = "bpint".newIdentNode
  let cullaid = "culla".newIdentNode
  result = quote do:
    let `szbitsid` = `sz` shl 3
    let `cmpstsalmtid` = `ca` + `sz`
    let `bpintid` = `bp`.int
    let `strtndx0id` = `strtndx`
    let `strt0id` = `strtndx0id` shr 3
  for i in 1 .. 7:
    let strtndxido = newIdentNode("strtndx" & $(i - 1))
    let strtndxidn = newIdentNode("strtndx" & $i)
    let strtid = newIdentNode("strt" & $i)
    result.add quote do:
      let `strtndxidn` = `strtndxido` + `bp`
      let `strtid` = (`strtndxidn` shr 3) - `strt0id`
  let csstmnt = quote do:
    case (((`bpintid` and 0x6) shl 2) + (`strtndx0id` and 7)).uint8
    of 0'u8: break
  csstmnt.del 1 # delete last dummy "of"
  for n in 0'u8 .. 0x3F'u8: # actually used cases...
    let pn = (n shr 2) or 1'u8
    let cn = n and 7'u8
    let mod0id = newLit(cn)
    let cptr0id = "cptr0".newIdentNode
    let loopstmnts = nnkStmtList.newTree()
    for i in 0'u8 .. 7'u8:
      let mskid = newLit(1'u8 shl ((cn + pn * i.uint8) and 7).int)
      let cptrid = ("cptr" & $i).newIdentNode
      let strtid = ("strt" & $i).newIdentNode
      if i == 0'u8:
        loopstmnts.add quote do:
          let `cptrid` = cast[ptr uint8](`cullaid`)
      else:      
        loopstmnts.add quote do:
          let `cptrid` = cast[ptr uint8](`cullaid` + `strtid`)
      loopstmnts.add quote do:
        `cptrid`[] = `cptrid`[] or `mskid`
    loopstmnts.add quote do:
      `cullaid` += `bpintid`
    let ofbrstmnts = quote do:
      while `cullaid` < `endalmtid`:
        `loopstmnts`
      `cullaid` = ((`cullaid` - `ca`) shl 3) or `mod0id`.int
      while `cullaid` < `szbitsid`:        
        let `cptr0id` = cast[ptr uint8](`ca` + (`cullaid` shr 3))
        `cptr0id`[] = `cptr0id`[] or cBITMSK[`cullaid` and 7]
        `cullaid` += `bpintid`
    csstmnt.add nnkOfBranch.newTree(
      newLit(n),
      ofbrstmnts
    )
  for n in 0x40'u8 .. 255'u8: # fill in defaults for remaining possibilities
    csstmnt.add nnkOfBranch.newTree(
      newLit(n),
      nnkStmtList.newTree(
        nnkBreakStmt.newTree(
          newEmptyNode()
        )
      )
    )
  result.add quote do:
    let `endalmtid` = `cmpstsalmtid` - `strt7id`
    var `cullaid` = `ca` + `strt0id`
    `csstmnt`
#  echo csstmnt[9].astGenRepr # see AST for a given case
#  echo csstmnt[9].toStrLit # see code for a given case
#  echo result.toStrLit # see entire produced code at compile time

proc benchSoE(): iterator(): int {.closure.} =
  var cmpsts = newSeq[byte](16384)
  let cmpstsa = cast[int](cmpsts[0].addr)
  for _ in 0 ..< cLOOPS:
    for i in 0 .. 254: # cull to square root of limit
      if (cmpsts[i shr 3] and cBITMSK[i and 7]) == 0'u8: # if prime -> cull its composites
        let bp = i +% i +% 3
        let swi = (i +% i) *% (i +% 3) +% 3
        unrollLoops(cmpstsa, 16384, swi, bp)
  return iterator(): int {.closure.} =
    yield 2 # the only even prime
    for i in 0 .. 131071: # separate iteration over results
      if (cmpsts[i shr 3] and cBITMSK[i and 7]) == 0'u8:
        yield i +% i +% 3
```
Running the code with the above substitution in the same non-checking release mode as before results in a run time that is about 2.5 times faster than the previous version and over ten times faster than the naive implementation, meaning that the culling operation time is this ratio faster per operation.  For a modern CPU, one can calculate that it uses just over one CPU clock cycle per cull operation (198273 culling operations per loop).

Now, this speed can't quite be maintained for a real application with larger ranges and thus larger base prime values as there will come a point where the overheads of the loop unrolling overcomes its benefit, but that is for quite large ranges of about a hundred million; as well, the loss above that point increases slowly since the base prime values only grow as the square root of the entire sieved range and also the base primes density becomes more sparse with increasing range such that using a page segmented implementation to count the primes up to ten's of billions only increases the time per culling operation to about two CPU clock cycles each, meaning that the average is still much less than pure "bit-twiddling".

## Analysis as compared to other languages

So in order to be able to assert that Nim is "Efficient, Expressive, and Elegant", one needs to compare it to something; since Nim's design goals are in that order, languages that aren't as efficient will be rejected from the outset.  This means the following:

1. Languages such as Python and R are not comparable in the context of performance/efficiency because their default implementations are interpreted and thus much slower. As well, almost all languages in this same category are dynamically typed (which contributes to their lack of competitive performance), which make them ineffective if applied to the many of the kinds of programming tasks to which Nim can be applied. Among the host of other languages in this category are all of the Lisp-based languages such as Scheme/Racket/Common Lisp and also Clojure, which is both a dynamically typed language and a Just In Time compiled language that also fits into the next section.
2. Languages which are Just-In-Time (JIT) compiled are generally less efficient because the generated JIT code is generally about three times slower due to the limitations of being "safe" placed on their runtime and less optimizations being possible in time-limited JIT compilation; such languages include Java, Kotlin, C#, and F#.  An interesting exception is Julia which uses the LLVM IR system to entirely compile a program when it is run; once this significant pre-compilation time is lost, the rest of the program can run extremely fast.  Julia has powerful macros and pointer operations and runs the conventional "bit-twiddling" algorithm about as fast as Nim or other compiled languages.  Where Julia loses is in general effectiveness as it is a dynamically typed language and also loses in elegance in its syntax with required code block `end` keywords reminds one of writing Fortran code.  As for "Extreme Loop Unrolling", Julia requires a "PointerArithmetic" package to do this which, like most of the other languages in this category, isn't as efficient as the native pointers available in other compiled languages so can't match the macro combined with pointer manipulation as can be implemented in Nim.
3. Haskell actually does have AST macros using "Template Haskell" and if using the optional LLVM backend along with GHC Haskell primitives can produce very efficient code for even the Extreme Loop Unrolling algorithm, which does not depend on memory management/Garbage Collection since just one fixed `seq`/(unboxed primitive)Array is used.  The Haskell source code is very elegant, but where it might lose out in effectiveness is due to its steep learning curve in using it effectively with its very different functional programming paradigms including Monadic code and non-strictness (laziness).  Nim doesn't really compete directly with Haskell as they are two entirely different programming paradigms.  One disadvantage that Haskell has for this algorithm is that "Template Haskell" code needs to be run from a separate source code file.
4. Languages competitive as to efficiency and general programming paradigm are the fully compiled languages such as C/C++, Chapel, and Rust, all of which can perform the loop unrolling algorithm at about the speed as the above Nim program.  C/C++ and Chapel lose out as to elegance and somewhat as to effectiveness as they don't have proper macros (C/C++ so-called preprocessor "macros" are really just text substitution templates), and Rust, which does have proper AST macros and pointer operations but loses out to being somewhat more verbose (although it gains in safety, which is not yet one of Nim's primary goals as it is for Rust; however, Nim's future goals do include "safety" about equivalent to that of Rust, which will be discussed in depth in a later article) also currently need to be compiled from a separate source file just as for Haskell's "Template Haskell", thus if one were to want to use them for this algorithm, the result would not be quite as effective nor as elegant as the Nim solution.  The "macro_rules" types of macro are more like what Nim would call templates, and can be used but require invoking the template for each of the 32 varieties of pattern, so neither as effective nor as elegant.

For reference's sake, following is Rust code that implements the Extreme Loop Unrolling algorithm, which is just a tiny amount slower than the Nim code:

```rust
// compile with `-O` for full optimization

use std::time::Instant;

// do it 1225 times to get a reasonable execution time span...
const NUMLOOPS: usize = 1225;

// bit position mask LUT faster than "bit-twiddling"...
static BITMASK: [u8; 8] = [ 1, 2, 4, 8, 16, 32, 64, 128 ];

macro_rules! unrollfnc {
    ( $x:expr ) => ({
        fn f(cmpsts: &mut Vec<u8>, bp: usize, cullpos: &mut usize) {
            let cp1 = *cullpos + bp; let cp2 = cp1 + bp; let cp3 = cp2 + bp;
            let cp4 = cp3 + bp; let cp5 = cp4 + bp; let cp6 = cp5 + bp;
            let r7 = (((cp6 + bp) >> 3) - (*cullpos >> 3)) as isize;
            let r6 = ((cp6 >> 3) - (*cullpos >> 3)) as isize;
            let r5 = ((cp5 >> 3) - (*cullpos >> 3)) as isize;
            let r4 = ((cp4 >> 3) - (*cullpos >> 3)) as isize;
            let r3 = ((cp3 >> 3) - (*cullpos >> 3)) as isize;
            let r2 = ((cp2 >> 3) - (*cullpos >> 3)) as isize;
            let r1 = ((cp1 >> 3) - (*cullpos >> 3)) as isize;
            unsafe {
                #[allow(unused_mut)] // mut so can be offset from
                let mut cmpstsp: *mut u8 = cmpsts.get_unchecked_mut(0);
                let mut r0p: *mut u8 = cmpsts.get_unchecked_mut(*cullpos >> 3);
                #[allow(unused_mut)] // mut so can be compared with mut r0p
                let mut rlmtp: *mut u8 = cmpstsp.offset(cmpsts.len() as isize - r7);
                while r0p < rlmtp {
                    *r0p |= (1u8 << ($x & 7));
                    *(r0p.offset(r1)) |= 1u8 << (($x + (($x >> 2) | 1)) & 7);
                    *(r0p.offset(r2)) |= 1u8 << (($x + (2 * (($x >> 2) | 1))) & 7);
                    *(r0p.offset(r3)) |= 1u8 << (($x + (3 * (($x >> 2) | 1))) & 7);
                    *(r0p.offset(r4)) |= 1u8 << (($x + (4 * (($x >> 2) | 1))) & 7);
                    *(r0p.offset(r5)) |= 1u8 << (($x + (5 * (($x >> 2) | 1))) & 7);
                    *(r0p.offset(r6)) |= 1u8 << (($x + (6 * (($x >> 2) | 1))) & 7);
                    *(r0p.offset(r7)) |= 1u8 << (($x + (7 * (($x >> 2) | 1))) & 7);
                    r0p = r0p.offset(bp as isize);
                }
                *cullpos = ((r0p.offset_from(cmpstsp) as usize) << 3) + ($x & 7);
            }
        }
        f
    })
}

static UNROLLED: [fn(&mut Vec<u8>, usize, &mut usize); 32] = [
    unrollfnc!(0), unrollfnc!(1), unrollfnc!(2), unrollfnc!(3),
    unrollfnc!(4), unrollfnc!(5), unrollfnc!(6), unrollfnc!(7),
    unrollfnc!(8), unrollfnc!(9), unrollfnc!(10), unrollfnc!(11),
    unrollfnc!(12), unrollfnc!(13), unrollfnc!(14), unrollfnc!(15),
    unrollfnc!(16), unrollfnc!(17), unrollfnc!(18), unrollfnc!(19),
    unrollfnc!(20), unrollfnc!(21), unrollfnc!(22), unrollfnc!(23),
    unrollfnc!(24), unrollfnc!(25), unrollfnc!(26), unrollfnc!(27),
    unrollfnc!(28), unrollfnc!(29), unrollfnc!(30), unrollfnc!(31) ];

fn soe_bench(loops: usize) -> Box<dyn Iterator<Item = usize>> {
    let ndxlmt = 131071;
    let mut cmpsts = vec![0u8; 16384];
 
    for _ in 1 .. loops {
        for ndx in 0 .. 254 { // to index of square root of range
            if (cmpsts[ndx >> 3] & BITMASK[ndx & 7]) == 0 {
                let bp = ndx + ndx + 3; // common setup code...
                let mut cullpos = (ndx + ndx) * (ndx + 3) + 3;
                unsafe {
                    let cullfnc = UNROLLED.get_unchecked(
                                    ((bp & 6) << 2) | (cullpos & 7));
                    cullfnc(&mut cmpsts, bp, &mut cullpos);
                }
                while cullpos < ndxlmt {
                    unsafe { // avoids array bounds check, which is already done above
    	                let cptr = cmpsts.get_unchecked_mut(cullpos >> 3);
    	                *cptr |= BITMASK[cullpos & 7];
                    }
                    cullpos += bp;
                }
            }
        }
    }
 
    Box::new((-1 .. ndxlmt as isize).into_iter().filter_map(move |i| {
                if i < 0 { Some(2) } else {
                    if cmpsts[i as usize >> 3] & BITMASK[i as usize & 7] == 0 {
                        Some((i + i + 3) as usize) } else { None } }
    }))
}

fn main() {
    let strt = Instant::now(); 
    let rslt = soe_bench(NUMLOOPS); 
    let elpsd = strt.elapsed();
 
    let count = rslt.count();
    let secs = elpsd.as_secs();
    let millis = (elpsd.subsec_nanos() / 1000000) as u64;
    let dur = secs * 1000 + millis;
    println!("Found {} primes up to 262146 for {} loops in {} milliseconds.",
             count, NUMLOOPS, dur);
}
```

The above Rust version with identical algorithm is not quite as fast as the Nim version; upon inspection of the produced assembler code, one sees that it is missing a Extreme Loop Unrolling loop optimization for the loop overhead (or has reversed an optimization due to Loop Strength Reduction, which is a known issue with the current LLVM backend).  Thus, is is adding some fraction of a CPU clock cycle per eight-cull loop.

Which language one finds most elegant is partly due to bias or willingness to adapt of an "offside rule" whitespace-significant language like Nim or the somewhat dated curly bracket code block designators/semicolon statement separators type of language such as Rust.

## Conclusion

This implementation of a mini CPU benchmark shows that Nim does fully accomplish its design goals for this application and is perhaps better for this or similar tasks than any other current language.  Of the modern compiled "system programming" type of languages, it compares most closely with Rust, with Rust currently having better built-in code safety but Nim having a better template/macro system.  As well, Nim offers more memory management options, including several implementations of garbage collection, reference counting, an even now reference counting with cyclic reference breaker which is unique to Nim.

As to the resulting mini benchmark, when fully optimized it is just measuring the compiler's ability to reduce the culling operations to the single read/modify/write `or` instruction and minimum loop overhead, but when comparing the relative results across different CPU's, it is amazing how well the results correlate to results from the major benchmarking suites such as Geekbench or Passmark for their CPU-only assessments.
