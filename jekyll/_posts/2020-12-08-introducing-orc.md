---
title: "ORC - Vorsprung durch Algorithmen"
author: Araq
excerpt: "ORC -  Algorithmic Advantages"
---


Version 1.4 ships with the so-called ORC memory management algorithm.
ORC is the existing ARC algorithm (first shipped in version 1.2) plus a
cycle collector. That's also where the name comes from -- the "O" stands
for a cycle and "RC" stands for "reference counting", which is the
algorithm's foundation.

The cycle collector is based on the pretty well known "trial deletion"
algorithm by Lins and others. I won't describe here how this algorithm
works -- you can read
[the paper](https://researcher.watson.ibm.com/researcher/files/us-bacon/Bacon01Concurrent.pdf)
for a good description.

As usual, I couldn't resist the temptation to improve the algorithm and
add more optimizations: The Nim compiler analyses the involved types and
only if it is potentially cyclic, code is produced that calls into the
cycle collector. This type analysis can be helped out by annotating a
type as `acyclic`. For example, this is how
a binary tree could be modeled:

```nim
type
  Node {.acyclic.} = ref object
    kids: array[2, Node]
    data: string
```

Unfortunately, the overhead of the cycle collector can be measurable in
practice. This annotation can be crucial in order to get ORC's
performance close to ARC's.

An innovation in ORC's design is that cyclic root candidates can be
registered and unregistered in constant time O(1). The consequence is
that at runtime we exploit the fact that data in Nim is rarely cyclic.



## ARC

ARC is Nim's pure reference-counting GC, however, many reference count
operations are optimized away: Thanks to move semantics, the
construction of a data structure does not involve RC operations. And
thanks to "cursor inference", another innovation of Nim's ARC
implementation, common data structure traversals do not involve RC
operations either! The performance of both ARC and ORC is independent of
the size of the heap.



## Benchmark

To put some weight behind my words, I wrote a simple benchmark showing
off these *algorithmic* differences. Please note that the benchmark was
written to stress the differences between ORC and Nim's other GCs; it's
not supposed to model realistic workloads (yet!).


<div class="language-nim highlighter-rouge"><pre class="highlight"><code>
<table class="line-nums-table"><tbody><tr><td class="blob-line-nums">1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
</td><td><span class="k">import</span> <span class="Identifier">asynchttpserver</span><span class="Punctuation">,</span> <span class="Identifier">asyncdispatch</span><span class="Punctuation">,</span> <span class="Identifier">strutils</span><span class="Punctuation">,</span> <span class="Identifier">json</span><span class="Punctuation">,</span> <span class="Identifier">tables</span><span class="Punctuation">,</span> <span class="Identifier">streams</span>

<span class="Comment"># about 135 MB of live data:</span>
<span class="k">var</span> <span class="Identifier">sessions</span><span class="Punctuation">:</span> <span class="Identifier">Table</span><span class="Punctuation">[</span><span class="Identifier">string</span><span class="Punctuation">,</span> <span class="Identifier">JsonNode</span><span class="Punctuation">]</span>
<span class="k">for</span> <span class="Identifier">i</span> <span class="k">in</span> <span class="mi">0</span> <span class="Operator">..&lt;</span> <span class="mi">10</span><span class="Punctuation">:</span>
  <span class="Identifier">sessions</span><span class="Punctuation">[</span><span class="Operator">$</span><span class="Identifier">i</span><span class="Punctuation">]</span> <span class="Operator">=</span> <span class="Identifier">parseJson</span><span class="Punctuation">(</span><span class="Identifier">newFileStream</span><span class="Punctuation">(</span><span class="s">&quot;1.json&quot;</span><span class="Punctuation">,</span> <span class="Identifier">fmRead</span><span class="Punctuation">)</span><span class="Punctuation">,</span> <span class="s">&quot;1.json&quot;</span><span class="Punctuation">)</span>

<span class="k">var</span> <span class="Identifier">served</span> <span class="Operator">=</span> <span class="mi">0</span>

<span class="k">var</span> <span class="Identifier">server</span> <span class="Operator">=</span> <span class="Identifier">newAsyncHttpServer</span><span class="Punctuation">(</span><span class="Punctuation">)</span>
<span class="k">proc</span> <span class="nf">cb</span><span class="Punctuation">(</span><span class="Identifier">req</span><span class="Punctuation">:</span> <span class="Identifier">Request</span><span class="Punctuation">)</span> <span class="Punctuation">{</span><span class="Operator">.</span><span class="Identifier">async</span><span class="Operator">.</span><span class="Punctuation">}</span> <span class="Operator">=</span>
  <span class="Identifier">inc</span> <span class="Identifier">served</span>
  <span class="Identifier">await</span> <span class="Identifier">req</span><span class="Operator">.</span><span class="Identifier">respond</span><span class="Punctuation">(</span><span class="Identifier">Http200</span><span class="Punctuation">,</span> <span class="s">&quot;Hello World&quot;</span><span class="Punctuation">)</span>
  <span class="k">if</span> <span class="Identifier">served</span> <span class="k">mod</span> <span class="mi">10</span> <span class="Operator">==</span> <span class="mi">0</span><span class="Punctuation">:</span>
    <span class="k">when</span> <span class="k">not</span> <span class="Identifier">defined</span><span class="Punctuation">(</span><span class="Identifier">memForSpeed</span><span class="Punctuation">)</span><span class="Punctuation">:</span>
      <span class="Identifier">GC_fullCollect</span><span class="Punctuation">(</span><span class="Punctuation">)</span>

<span class="Identifier">waitFor</span> <span class="Identifier">server</span><span class="Operator">.</span><span class="Identifier">serve</span><span class="Punctuation">(</span><span class="Identifier">Port</span><span class="Punctuation">(</span><span class="mi">8080</span><span class="Punctuation">)</span><span class="Punctuation">,</span> <span class="Identifier">cb</span><span class="Punctuation">)</span></td></tr></tbody></table>
</code></pre>
</div>


Lines 10-18 are the "Hello World" asynchronous HTTP server example from
Nim's standard library.

In lines 4-6, we load about 135MB of JSON data into the global `sessions` variable.
ORC never touches this memory after it has been loaded, even though it remains alive for the
rest of the program run. The older Nim GCs do have to touch this memory.
I compare ORC to Nim's "mark and sweep" GC (M&S) as M&S performs best on
this benchmark.

`GC_fullCollect` is called frequently in order to keep the memory
consumption close to the 135MB of RAM that the program needs in theory.

With the "wrk" benchmarking tool I get these numbers:

| Metric / algorithm | ORC         | M&S       |
| ------------------ | ----------: | --------: |
| Latency (Avg)      | 320.49 *u*s | 65.31 ms  |
| Latency (Max)      | 6.24 ms     | 204.79 ms |
| Requests/sec       | 30963.96    | 282.69    |
| Transfer/sec       | 1.48 MB     | 13.80 KB  |
| Max memory         | 137 MiB     | 153 MiB   |


That's right, ORC is **over 100 times faster** than the M&S GC. The
reason is that ORC only touches memory that the mutator touches, too.
This is a key feature that allows reasoning about performance on modern
machines. A generational GC could probably offer comparable guarantees.
In fact, ORC can be seen as a generational and incremental GC with the
additional guarantee that acyclic structures are freed as soon as they
become garbage.

Now what happens when the aggressive `GC_fullCollect` calls are not
done? I get these numbers:

| Metric / algorithm | ORC         | M&S (memForSpeed) |
| ------------------ | ----------: | ----------------: |
| Latency (Avg)      | 274.84 *u*s | 1.49 ms           |
| Latency (Max)      | 1.10 ms     | 46.41 ms          |
| Requests/sec       | 34948.95    | 39561.97          |
| Transfer/sec       | 1.67 MB     | 1.89 MB           |
| Max memory         | 137 MiB     | 333 MiB           |

M&S now wins in throughput, but not in latency. However, the memory
consumption rises to about 330MB; more than twice as much memory as the
program really requires!

ORC always wins on latency and memory consumption; plays nice with
destructors, and hence with custom memory management; is independent of
the heap sizes; tracks stack roots precisely and works cleanly with all
sanitizers the C/C++ ecosystem offers.

These results are typical for what we see in other programs:
Latency is reduced, there is little jitter and the memory consumption
remains close to the required minimum that a program needs.
Excellent results for embedded development!

Further advancements to the cycle collection algorithm itself are in development;
it turns out there are lots of ideas that the GC research overlooked.
Exciting times for Nim!



## Summary

To compile your code with ORC, use `--gc:orc` on the command line.

- ORC works out of the box with Valgrind and other C++ sanitizers.
  (Compile with `--gc:orc -g -d:useMalloc` for precise Valgrind
  checking.)
- ORC uses 2x less memory than classical GCs.
- ORC can be orders of magnitudes faster in throughput when memory
  consumption is important. It is comparable in throughput when memory
  consumption is not as important.
- ORC uses no CPU specific tricks; it works without hacks even on
  limited targets like Webassembly.
- ORC offers sub-millisecond latencies. It is well suited for (hard)
  realtime systems. There is no "stop the world" phase.
- ORC is oblivious to the size of the heap or the used stack space.

----

If you like this article and how we evolve Nim, please consider a
donation. You can donate via:

- [Open Collective](https://opencollective.com/nim)
- [Patreon](https://www.patreon.com/araq)
- [PayPal](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=FLWX5V2PMAXAU)
- Bitcoin: bc1qzgw3vsppsa9gu53qyecyu063jfajmjpye3r2h4
- Ethereum: 0xC1d472B409c1bdCd8C0E45515D18F08a55fE9fa8

If you are a company, we also offer commercial support. Please get in
touch with us via <support@nim-lang.org>. As a commercial backer, you
can decide what features and bugfixes should be prioritized.
