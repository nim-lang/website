---

title: "The new Nim channels implementation for ORC"
author: xflywind
excerpt: "The new channels library is efficient and safe to use"

---

# The new Nim channels implementation for ORC

Version 1.4 ships with the so-called ORC memory management algorithm. ORC is the existing ARC algorithm (first shipped in version 1.2) plus a cycle collector. The Nim devel branch also introduces a new module called `std/isolation`. With it we can pass `isolated` data to threads safely and easily. It prevents data races at compile time. Recently `std/channels` is merged to the devel branch which is designed for ORC. It combines `isolated` data and `channels` and is efficient and safe to use.

**Note:** you need the Nim devel branch to compile the code below.

## Background

A channel is a model for sharing memory via message passing. A thread is able to send or receive messages over a channel. It's like sending a letter to your friend. The postman is the channel. Your friend is the receiver.  You may know  `system/channels` already exists. What’s the difference between new channels implementation and the old one? If you use the old one, you need to copy your letter by hand first and send the copied one to your friend instead. Then your friend may mark something on the copied letter, it won’t affect the original letter. It works fine, however it is not efficient. If you use the new one, you only need to put your letter in the mailbox. No need to copy your letter!

## The advantages

- Designed for ARC/ORC, no legacy code
- No need to `deepcopy`, just move data around
- No data races
- Based on [Michael & Scott lock-based queues](https://www.cs.rochester.edu/~scott/papers/1996_PODC_queues.pdf)

## Explore the new channels

**Note:** Be sure to compile your code with `--gc:orc –-threads:on`.

### Let's crawl the web

**todo_urls.json**

```json
{"url": ["https://google.com", "https://nim-lang.org"]}
```

**app.nim**

The main thread prepares tasks via reading `todo_urls.txt`. Then it sends JSON data to a channel. The crawl thread does the crawlers’ work. It receives URL data from the channel and downloads the contents using `httpclient`.

```nim
import std/channels
import std/[httpclient, isolation, json]


var ch = initChan[JsonNode]() # we need to send JsonNode

proc download(client: HttpClient, url: string) =
  let response = client.get(url)
  echo "content: "
  echo response.body[0 .. 20]  # prints the results

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

proc spawnCrawlers  =
  var tasks = prepareTasks("todo_urls.json")
  for t in mitems tasks: # we need a mutable view of the items"
    ch.send move t

var thr: Thread[void]
createThread(thr, crawl) # create crawl thread

spawnCrawlers()
joinThread(thr)
```

First you need to import `std/channels`.

Then you can create a channel using `initChan`. It uses `mpmc` internally which stands for multiple producer, multiple consumer. The `elements` parameter is used to specify whether a channel is buffered or not.  For unbuffered channel, the sender and the receiver block until the other side is ready. Sending data to a buffered channel blocks only when the buffer is full. Receiving data from a buffered channel blocks when the buffer is empty.

`initChan` is a generic proc, you can specify the types of the data you want to send or receive.

```nim
var chan1 = initChan[int]()
# or
var chan2 = initChan[string](elements = 1) # unbuffered channel
# or
var chan3 = initChan[seq[string]](elements = 30) # buffered channel
```

`send` proc takes something we want to send to the channel.  The passed data is moved around, not copied. Because `chan.send(isolate(data))` is very common to use, `template send[T](c: var Chan[T]; src: T) = chan.send(isolate(src))` is provided for convenience. For example, you can use `chan.send("Hello World")` instead of `chan.send(isolate("Hello World!"))`.

There are two useful procs for a receiver: `recv` and `tryRecv`. `recv` blocks until something is sent to the channel. In contrast `tryRecv` doesn’t block. If no message exists in the channel, it just fails and returns `false`. We can write a while loop to call `tryRecv`and handle a message when available.

###  It is safe and convenient

The Nim compiler rejects the program below at compile time. It says that `expression cannot be isolated: s`. Because s is a ref object, may be modified somewhere and is not unique. So the variable cannot be isolated.


```nim
import std/[channels, json, isolation]

var chan = initChan[JsonNode]()

proc spawnCrawlers  =
  var s = newJString("Hello, Nim")
  chan.send isolate(s)
```

It is only allowed to pass a function call directly.

```nim
import std/[channels, json, isolation]

var chan = initChan[JsonNode]()

proc spawnCrawlers  =
  chan.send isolate(newJString("Hello, Nim"))
```

`Isolated` data can only be moved, not copied. It is implemented as a library without bloating Nim's core type system. The `isolate` proc is used to create an isolated subgraph from the expression `value`. The expression `value` is checked at compile time . The `extract` proc is used to get the internal value of `Isolated` data. 

```nim
import std/isolation

var data = isolate("string")
doAssert data.extract == "string"
doAssert data.extract == ""
```

By means of `Isolated` data, the channels become safe and convenient to use.


## Benchmark

Here is a simple benchmark. We create 10 threads for sending data to the channel and 5 threads for receiving data from the channel.

```nim
# benchmark the new channel implementation with 
# `nim c -r --threads:on --gc:orc -d:newChan -d:danger app.nim`
#
# benchmark the old channel implementation with
# `nim c -r --threads:on -d:oldChan -d:danger app.nim`

import std/[os, times, isolation]

var
  sender: array[0 .. 9, Thread[void]]
  receiver: array[0 .. 4, Thread[void]] 


when defined(newChan):
  import std/channels
  var chan = initChan[seq[string]](40)

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


| Implementation                    | Time                                 |
| --------------------------------- | ------------------------------------ |
| system/channels + refc(-d:danger) | 433 microseconds and 590 nanoseconds |
| std/channels + orc(-d:danger)     | 137 microseconds and 522 nanoseconds |



## Summary

The new channels implementation makes ORC suitable for sharing data between threads. Data races are detected at compile time.

If you use latest Nim version, you can run the example above and experiment `std/channels` with your own programs. Please try it out and give us your feedback!

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
