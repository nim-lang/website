---

title: "The new Nim channels implementation for ORC"
author: xflywind
excerpt: "The new channels library is efficient and safe to use"

---

# The new Nim channels implementation for ORC

Version 1.4 ships with the so-called ORC memory management algorithm. ORC is the existing ARC algorithm (first shipped in version 1.2) plus a cycle collector. The Nim devel branch introduces a new module called `std/isolation`, which allows us to pass `isolated` data to threads safely and easily - it prevents data races at compile time. Another recent addition to the devel branch is `std/channels`, which is designed for ORC. It combines `isolated` data and `channels`, and is efficient and safe to use.

**Note:** at the time of writing, to compile the below code you need to use a development version of the Nim compiler (from 2021-03-12 or later). However, it should also work in Nim 1.6.0 or later. 

## Background

A channel is a model for sharing memory via message passing. A thread is able to send or receive messages over a channel. It's like sending a letter to your friend: the postman is the channel, and your friend is the receiver. You might already know `system/channels`, which is the old channels implementation. What's better in the new implementation? With the old one, first you need to copy your letter and send the copy to your friend. Then your friend may mark something on the copied letter and it won't affect the original. This works fine, but it is not efficient. If you use the new implementation, you only need to put your letter in the mailbox. No need to copy it!

## The advantages

- Designed for ARC/ORC, no legacy code
- No need to `deepCopy`, just move data around
- No data races
- Based on [Michael & Scott lock-based queues](https://www.cs.rochester.edu/~scott/papers/1996_PODC_queues.pdf)

## Explore the new channels

**Note:** Be sure to compile your code with `--gc:orc –-threads:on -d:ssl`.

### Let's crawl the web

**todo_urls.json**

```json
{"url": ["https://google.com", "https://nim-lang.org"]}
```

**app.nim**

The main thread prepares tasks by reading `todo_urls.json`, and then it sends JSON data to a channel. The crawl thread does the actual work - it receives URL data from the channel and downloads the contents using the `httpclient` module.

```nim
import std/channels
import std/[httpclient, isolation, json]

var ch = newChannel[JsonNode]() # we need to send JsonNode

proc download(client: HttpClient, url: string) =
  let response = client.get(url)
  echo "content: ", response.body[0 .. 20] # prints the results

proc crawl =
  var client = newHttpClient() # the crawler
  var data: JsonNode
  ch.recv(data) # the JSON data
  if data != nil:
    for url in data["url"]:
      download(client, url.getStr)
  client.close()

proc prepareTasks(fileWithUrls: string): seq[Isolated[JsonNode]] =
  result = @[]
  for line in lines(fileWithUrls):
    result.add isolate(parseJson(line)) # parse JSON file

proc spawnCrawlers =
  var tasks = prepareTasks("todo_urls.json")
  for t in mitems tasks: # we need a mutable view of the items
    ch.send move t

var thr: Thread[void]
createThread(thr, crawl) # create crawl thread

spawnCrawlers()
joinThread(thr)
```

First, we import `std/channels`.

Then we can create a channel using `newChannel`, which returns a `Channel[T]`. It uses `mpmc` internally, which stands for "multiple producer, multiple consumer". The `elements` parameter is used to specify whether a channel is buffered or not. For an unbuffered channel, the sender and the receiver block until the other side is ready. Sending data to a buffered channel blocks only when the buffer is full. Receiving data from a buffered channel blocks when the buffer is empty.

`newChannel` is a generic proc - you can specify the types of the data you want to send or receive.

```nim
var chan1 = newChannel[int]()
# or
var chan2 = newChannel[string](elements = 1) # unbuffered channel
# or
var chan3 = newChannel[seq[string]](elements = 30) # buffered channel
```

The `send` proc takes data that we want to send to the channel. The passed data is moved around, not copied. Because `chan.send(isolate(data))` is very common to use, `template send[T](c: var Chan[T]; src: T) = chan.send(isolate(src))` is provided for convenience. For example, you can use `chan.send("Hello World")` instead of `chan.send(isolate("Hello World!"))`.

There are two useful procs for a receiver: `recv` and `tryRecv`. `recv` blocks until something is sent to the channel. In contrast, `tryRecv` doesn't block - if no message exists in the channel, it just fails and returns `false`. We can write a while loop to call `tryRecv`and handle a message when available.

### It is safe and convenient

The Nim compiler rejects the program below at compile time. It says that `expression cannot be isolated: s`. This is because `s` is a `ref object` - it may be modified somewhere and is not unique, so the variable cannot be isolated.


```nim
import std/[channels, json, isolation]

var chan = newChannel[JsonNode]()

proc spawnCrawlers =
  var s = newJString("Hello, Nim")
  chan.send isolate(s)
```

It is only allowed to pass a function call directly.

```nim
import std/[channels, json, isolation]

var chan = newChannel[JsonNode]()

proc spawnCrawlers =
  chan.send isolate(newJString("Hello, Nim"))
```

`Isolated` data can only be moved, not copied. It is implemented as a library without bloating Nim's core type system. The `isolate` proc is used to create an isolated subgraph from the expression `value`. Whether the expression `value` is isolated is checked at compile time. The `extract` proc is used to get the internal value of `Isolated` data.

```nim
import std/isolation

var data = isolate("string")
doAssert data.extract == "string"
doAssert data.extract == ""
```

By means of `Isolated` data, the channels become safer and more convenient to use.


## Benchmark

Here is a simple benchmark. We create 10 threads that send data to the channel and 5 threads that receive it.

```nim
# benchmark the new channel implementation with 
# `nim c -r --threads:on --gc:orc -d:newChan -d:danger app.nim`
#
# benchmark the old channel implementation with
# `nim c -r --threads:on -d:oldChan -d:danger app.nim`

import std/times

var
  sender: array[10, Thread[void]]
  receiver: array[5, Thread[void]] 
when defined(newChan):
  import std/[channels, isolation]
  var chan = newChannel[seq[string]](40)

  proc sendHandler() =
    chan.send(isolate(@["Hello, Nim"]))

  proc recvHandler() =
    var x: seq[string]
    chan.recv(x)
    discard x

elif defined(oldChan):
  var chan: Channel[seq[string]]

  chan.open(maxItems = 40)

  proc sendHandler() =
    chan.send(@["Hello, Nim"])
  proc recvHandler() =
    let x = chan.recv()
    discard x

template benchmark() =
  for i in 0 .. sender.high:
    createThread(sender[i], sendHandler)

  joinThreads(sender)
  for i in 0 .. receiver.high:
    createThread(receiver[i], recvHandler)

  let start = now()
  joinThreads(receiver)
  echo now() - start

benchmark()
```

The new implementation is much faster than the old one!


| Implementation                     | Elapsed time |
| ---------------------------------- | -----------: |
| system/channels + refc (-d:danger) |       433 μs |
| std/channels + orc (-d:danger)     |       137 μs |



## Summary

The new channels implementation makes ORC suitable for sharing data between threads. Data races are prevented at compile time by sending isolated subgraphs checked at compile time.

If you use the latest devel, you can run the example above and experiment with `std/channels` in your own programs. Please try it out and give us your feedback!

## Further information

- [Isolated data for Nim](https://github.com/nim-lang/RFCs/issues/244) 
- [Introduction to ARC/ORC in Nim](https://nim-lang.org/blog/2020/10/15/introduction-to-arc-orc-in-nim.html)
- [ORC - Vorsprung durch Algorithmen](https://nim-lang.org/blog/2020/12/08/introducing-orc.html)


-------

If you like this article and how we evolve Nim, please consider a donation. You can donate via:

- [Open Collective](https://opencollective.com/nim)

- [Patreon](https://www.patreon.com/araq)

- [PayPal](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=FLWX5V2PMAXAU)

- Bitcoin: 1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ


If you are a company, we also offer commercial support. Please get in touch with us via [support@nim-lang.org](mailto:support@nim-lang.org). As a commercial backer, you can decide what features and bugfixes should be prioritized.
