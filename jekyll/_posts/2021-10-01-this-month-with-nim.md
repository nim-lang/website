---
title: "This Month with Nim: September 2021"
author: The Nim Community
excerpt: "Four interesting projects our users worked on in September"
---

## [Kombinator](https://gitlab.com/ArMour85/kombinator)

#### Author: [ArMour85](https://gitlab.com/ArMour85)

Application to run a command line with lot of combinations of values.

Kombinator parses a TOML configuration file in and generate combinations of commandline invocations.

An example configuration file is as follows:
```toml
cmd = "ffmpeg -i $here/../ForBiggerFun.mp4 -s $heightx$width -c:v $codec -ab $audio_bitrate output-$audio_bitrate-$heightx$width-$codec.mp4"
height = [640, 800]
width = [480, 600]
codec = ["libx264", "libxvid"]
audio_bitrate = {min = 128, max = 192, step = 32}
```

Explanation of its usage can be seen [here](https://gitlab.com/ArMour85/kombinator#configuration-file)

## [Drawim](https://github.com/GabrielLasso/drawim)

#### Authors: [Gabriel Lasso](https://github.com/GabrielLasso)

A drawing library in Nim, inspired by p5js. Builds to native, using OpenGL, and to JavaScript, using HTML5 Canvas.

It allows you to create simulations, visualize structures, make 2D plots and even prototype 2D games with an easy and intuitive synax.

Example to draw a recursive tree:
```nim
import drawim, std/math

proc branch(len: int) =
  if (len < 1):
    return
  line(0, 0, 0, len)

  push()
  translate(0, len)
  rotate(PI / 5)
  branch(int(float(len)*0.7))
  pop()

  push()
  translate(0, len)
  rotate(-PI / 5)
  branch(int(float(len)*0.7))
  pop()

proc draw() =
  background(200)
  stroke(30, 150, 15)
  translate(int(width / 2), height)
  rotate(PI)

  branch(100)

run(600, 400, draw)
```
Result:
<p style="text-align: center;">
  <img width="auto" height="400" src="{{ site.baseurl }}/assets/thismonthwithnim/2021-10/drawim.png">
</p>

More examples:
- [Snake game](https://github.com/GabrielLasso/drawim/tree/master/examples/snake)
- [Orbits simulation](https://github.com/GabrielLasso/drawim/blob/master/examples/orbits.nim)
- [Sierpinski triangle](https://github.com/GabrielLasso/drawim/blob/master/examples/sierpinski.nim)
- [Ploting a function](https://github.com/GabrielLasso/drawim/blob/master/examples/xcubed.nim)
- [Game of life](https://github.com/GabrielLasso/drawim/blob/master/examples/gameoflife.nim)
- [And more](https://github.com/GabrielLasso/drawim/tree/master/examples)

## [Nim for Beginners #26 Reference Objects](https://youtu.be/kkSAVKKIoVc)

#### Author: [Kiloneie](https://github.com/Kiloneie)

In this video I talk about Reference Objects, what they are, their use cases and a brief talk about Nim's memory management model.

Chapters/sub chapters of this video:

-  What are reference objects ?
       Reference object definition
       "repr" procedure for outputting advanced data types
        Dereferencing a reference object
        Reference objects are passed by reference
        new() procedure for reference types

- Reference object use cases
        Shared ownership

-  Nim's memory management
        Values created on the stack
        Values created on the heap
        .acyclic and .cursor annotations for optimization(just a mention)

## [Loony](https://github.com/nim-works/loony)

#### Author: [cabboose](https://github.com/shayanhabibi), [disruptek](https://github.com/disruptek)

Multi-threading can be a headache.
Especially when it’s so difficult to organise and efficiently communicate between your worker threads.
Most of the time you end up with a data-racey unsafe hot mess.
Why does it have to be so difficult to safely pass reference objects between threads with some level of determinism?
Locks are cumbersome; you have to consider all the possibilities of dead-locking and friends!

Do you wish there was some **simple** and **flexible** solution to your multi-threaded nightmare?

Say hello to this loo-natic: Loony.
Loony is a lock-free (no dead locks!) multi-producer multi-consumer leak-free FIFO queue!
Don’t be concerned by the details of having to distribute work between threads using multiple queues when you can use loony.

Loony can handle up to **32, 255** consumer and **64, 610** producer threads lock-free (default is 512/1025; see README for details).

Any ref object can be passed through loony. The API? Dead simple:

```nim
import loony

type
  YourRefObjectHere = ref object
var ruhroh = new YourRefObjectHere

var lqueue = newLoonyQueue[YourRefObjectHere]()
# Setting up your loony queue is as simple as this!

lqueue.push ruhroh
# Don’t be concerned with having to get Consumer/Producer permissions!
# Do what you were born to do and ~move it move it ~ move it move it

var scooby = lqueue.pop()
```

Are you worried about memory validity? Don’t be!
If you’re not too savvy, the standard `push` and `pop` api use atomic thread fences to ensure your CPU caches are synchronised.

Does this have performance costs though?
Sure does; however this will be removed with future iterations of the project in conjunction with development of CPS.

You can always use `unsafePush` and `unsafePop` if you can handle the memory synchronisation yourself!
The only difference is that we don’t call atomic thread fences for you!


----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim) to add your project to the next month's blog post.
