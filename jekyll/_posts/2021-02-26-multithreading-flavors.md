---
title: "Multithreading flavors: Choosing the right scheduler for the right job"
author: Mamy Ratsimbazafy (mratsim)
excerpt: "Demystifying multithreading for IO and multithreading for Compute."
---

<div class="sidebarblock">
  <div class="content">
    <div class="title">Guest post</div>
    <div class="paragraph">
      This is a guest post by Mamy Ratsimbazafy (mratsim). If you would like to publish articles as a guest author on nim-lang.org then get in touch with us via
      <a href="https://twitter.com/nim_lang">Twitter</a> or <a href="https://nim-lang.org/community.html">otherwise</a>.
    </div>
  </div>
</div>


_Disclaimer: This post represent my current understanding as of December 2020 and might not age well._

With the advent of multicores CPU, developers are urge to blast through performance bottlenecks by exploiting more cores. Hence we are attracted to multithreading solutions like light is attracted by a black hole.

What is often missed is that there is no one size fits all and that your application 'tasks' come in varying flavors that require specific approaches to multithreading. I hope after this post that you will be at ease with IO tasks and Compute tasks and the tradeoff between latency and throughput and why those differences are critical for choosing how to distribute your tasks on multiple cores.



## Anatomy of tasking

Through this document, we call a 'task' a standalone unit of work.
Tasks are scheduled by a 'scheduler' and executed on execution resources managed by an 'executor'.

Tasks are said to be standalone because they carry both their function and the complete 'execution environment' needed to execute that function. So at minimum a task is:

```Nim
type TaskTyped[Params] = object
  fn: proc(env: Params) {.nimcall.} # a function pointer
  env: Params

type TaskTypeErased[EnvSize: static int] = object
  fn: proc(env: pointer) {.nimcall.} # a function pointer
  env: array[EnvSize, byte] # type erased environment
```

Astute readers will think, what's the difference with a closure? Well, a task often carries more metadata to help the scheduler manage execution resources efficiently.

'Execution resources' are threads, GPUs, clusters abstracted away by an 'executor' like a threadpool or a GPU driver.
The resource can also be a single hardware thread with tasks interleaved by the means of coroutines, fibers or in the case of Nim, closure iterators.

The role of a 'scheduler' is to multiplex M tasks on N hardware resources.
A scheduler can be:
- as simple as a FIFO task queue on top of a threadpool,
- as delegated as the kernel event queues,
- or as complex as [Weave](https://github.com/mratsim/weave)'s per-thread deques with support for nested parallelism, adaptative work stealing, fine-grained task dependencies and lazy parallel for-loop splitting.



## Introducing task flavors: IO tasks and Compute tasks

Now that we have the foundations and the vocabulary to talk about tasking, let's look into what kind of work we want to execute.

I distinguish between 'IO tasks' and 'compute tasks'. IO tasks are tasks that depend on IO to make progress, usually either the disk or the network but also the console or peripherals like mouse or keyboards.

A compute task is likely very familiar to people in:
- scientific computing (solvers, linear algebra, physics, biology, statistics, ...)
- rendering and image processing
- games: physics, path finding, animation, rendering, AI
- finance: Monte-Carlo simulation for pricing
- cryptography
- compression
- video encoding

Compute tasks need the CPU to work to make progress.
We can even distinguish compute tasks that are 'CPU-bound' like raytracing or cryptography those that are memory-bound like copying or adding matrices
and the hybrid: those that are 'memory-bound' unless data layout has been carefully done so that the CPU is always kept busy
like optimized matrix multiplication or games' Entity Component System.

An IO task would be:
- waiting for or initiating a remote connection
- serving or loading web pages
- sending or receiving a message
- sending or receiving a RPC or REST query
- waiting for keyboard, mouse or joystick inputs
- logging to disk or console
- creating or deleting a file
- downloading a file
- flushing changes to disk

IO tasks are bottlenecked by IO which is orders of magnitude slower than the CPU and its memory.
See [Latency numbers every programmer should know](https://gist.github.com/hellerbarde/2843375).
```
    L1 cache reference ......................... 0.5 ns
    Branch mispredict ............................ 5 ns
    L2 cache reference ........................... 7 ns
    Mutex lock/unlock ........................... 25 ns
    Main memory reference ...................... 100 ns
    Compress 1K bytes with Zippy ............. 3,000 ns  =   3 µs
    Send 2K bytes over 1 Gbps network ....... 20,000 ns  =  20 µs
    SSD random read ........................ 150,000 ns  = 150 µs
    Read 1 MB sequentially from memory ..... 250,000 ns  = 250 µs
    Round trip within same datacenter ...... 500,000 ns  = 0.5 ms
    Read 1 MB sequentially from SSD* ..... 1,000,000 ns  =   1 ms
    Disk seek ........................... 10,000,000 ns  =  10 ms
    Read 1 MB sequentially from disk .... 20,000,000 ns  =  20 ms
    Send packet CA->Netherlands->CA .... 150,000,000 ns  = 150 ms

And in a more human scale (x1 billion)

### Minute:
    L1 cache reference                  0.5 s         One heart beat (0.5 s)
    Branch mispredict                   5 s           Yawn
    L2 cache reference                  7 s           Long yawn
    Mutex lock/unlock                   25 s          Making a coffee

### Hour:
    Main memory reference               100 s         Brushing your teeth
    Compress 1K bytes with Zippy        50 min        One episode of a TV show (including ad breaks)

### Day:
    Send 2K bytes over 1 Gbps network   5.5 hr        From lunch to end of work day

### Week
    SSD random read                     1.7 days      A normal weekend
    Read 1 MB sequentially from memory  2.9 days      A long weekend
    Round trip within same datacenter   5.8 days      A medium vacation
    Read 1 MB sequentially from SSD    11.6 days      Waiting for almost 2 weeks for a delivery

### Year
    Disk seek                           16.5 weeks    A semester in university
    Read 1 MB sequentially from disk    7.8 months    Almost producing a new human being
    The above 2 together                1 year

### Decade
    Send packet CA->Netherlands->CA     4.8 years     Average time it takes to complete a bachelor's degree
```

On a 3GHz CPU, a simple instruction like addition would be 0.33 ns, unfortunately
while CPU have greatly improved over the years and can be parallelized, memory, disk and network didn't enjoy the same growth and are now way slower.

What does this all means?

Remember, to make progress a compute task needs execution resources and IO tasks can make progress without execution resources (you don't need the CPU to do something to make a user type faster on the keyboard and your message won't be sent faster by having a beefier CPU)

It means that compute tasks are all about having your CPU cores work efficiently together while IO tasks are all about having your CPU wait efficiently for requests and completion events.



## Improving performance

Now that we know the difference between IO tasks and Compute tasks we want to improve performance of our applications.
So how do we work more efficiently or how do we wait more efficiently? Actually what is performance for a compute task and an IO task?

As you likely suspect, performance for compute task and IO task is different in the vast majority of cases.

For compute task, say processing an image, what is important is processing the whole image as fast as possible, it doesn't matter if we start processing the upper left corner first but finish processing last. Hence a compute task performance is often measured in terms of throughput: how fast can you process the total work.

For an IO task, say serving a web page to multiple users or handling keyboard key presses, what is important is answering individual queries as early as possible, a query requested first should be resolved before those that came after. Hence an IO task performance is often measured in terms of latency: how long do you have to wait until the specific work you requested is done.


### Optimizing compute tasks

So how do you improve performance of compute tasks?
You need to keep your CPU busy and maximize working time, this implies:
- having information on task dependencies or the lack thereof to enable parallelism.
- minimizing context switching.
- keep data in fast memory cache and avoid polluting your cache with irrelevant data.


### Optimizing IO tasks

IO tasks require tight integration with the kernel to know when an IO task is completed since IO like networking, disk, peripherals all depend on the kernel. For optimization this means:
- Scheduling a task as soon as the IO event is completed/ready.
- Batching: wait on multiple events to minimize overhead and overlap waits.

_A note on multithreading:_

Just like having N students working toward a degree doesn't divide the time to get it by N, multithreading IO doesn't help you process them faster, but you can process more of them.
Also, multithreading for IO is often in the context of a web server, it is very likely that each connection is using both cryptography and compression which are compute task that might hinder scalability on a single-threaded IO executor. It's worth noticing that the only reason compression is valuable is because transferring more data (IO) takes more time than compressing/decompressing it (Compute).


### No one size fits all

Unfortunately, a single scheduler would be hard-pressed to please the needs of both compute and IO tasks.

Dealing with IO tasks require syscalls, syscalls have a high overhead compared to basic compute operation (about 150x more costly than an addition at minimum) and they also pollute the CPU caches with kernel data potentially flushing user data from memory, significantly affecting compute tasks.

Optimizing Compute tasks requires keeping it and its data hot in cache for as long as necessary but to ensure fairness and low latency, an IO scheduler need to keep track of task budgets and deschedule them when they go over.

Furthermore, IO tasks require First-In First-Out ordering, but the most efficient scheduling for Compute is often LIFO because the latest in is the most likely task to have the data still hot in caches.

Consequently don't use Weave or OpenMP (yes Nim can use OpenMP with the `||` operator) for IO tasks, it's made for compute. And don't use asyncdispatch for compute.



## Basic multithreading designs

So you decided to introduce multiple threads in your program, you know what you want to optimize between total workload/throughput or invidual requests fairness/latency.

Here are 2 simple multithreading designs for your application, with and without a scheduler.

_Reminder:_

The only components necessary for multithreading are tasks (function + environment) and execution resources, a scheduler is an optional component to optimize multiplexing M tasks on N hardware resources but besides introducing complexity certain workload might not need it at all.


### 1. The Producer-Consumer design

With this design, you separate you application into functional modules. From some inputs tasks are produced sent to the corresponding modules which in turn do their processing and create new tasks for modules downstream until all tasks are done.
A typical example is for a game would be:
- An UI thread listening to network and keyboard/mouse/controller inputs
- A rendering thread in charge of graphics
- A physics and animation thread
- An AI thread

Adding a scheduler to a producer-consumer design would make an actor framework.


### 2. The Executor design

With this design you have an executor that is in charge of managing your hardware resources.
The executor is typically for IO tasks either coroutines or an async/await abstraction over the kernel event queues. For compute task, it's a naive threadpool or a GPU.

An executor design with a scheduler would:
- likely use work-stealing to optimize load balancing
- For IO: implement a task budget system to optimize fairness
- For compute: use Weave techniques to optimize parallelism opportunities


### 3. Hybrid

We can mix the 2 models, i.e. have producer-consumer modules and have some having a threadpool to handle compute tasks.



## Conclusions & Takeaways

The work that has to be dispatched on multiple cores come in two flavors, IO and compute.
The low-level representation (Task = function + environment) and the high-level ergonomics (async/await vs spawn/sync) are very similar if not the same. However what we want to optimize is very different between IO and compute tasks, hence the scheduler is different.



## Rabbit holes

_When one door closes, another opens._

As I closed the door to your multithreading flavors confusion, let me open some new ones:
- Preemptive vs cooperative scheduling
- stackful vs stackless
- Readiness vs Completion (async IO / network programming)
- Data Parallelism vs Task Parallelism vs Dataflow parallelism
- Work sharing vs work stealing vs work requesting
- Child stealing vs continuation stealing (help-first vs work-first)
- Model of Computation: Kahn Process networks, Petri Nets, Communicating Sequential Processes, ...
