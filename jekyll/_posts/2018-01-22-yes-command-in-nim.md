---
title: "yes command in Nim"
author: Valts Liepiņš
excerpt: "Recently I stumbled upon a post which takes a closer look at the `yes` command line tool. The main purpose of it is to write endless stream of a single letter `y` at a ridiculous speed."
---

<div class="sidebarblock">
  <div class="content">
    <div class="title">Guest post</div>
    <div class="paragraph">
      This is a guest post by Valts Liepiņš. If you would like to publish articles as a guest author on nim-lang.org then get in touch with us via
      <a href="https://twitter.com/nim_lang">Twitter</a> or <a href="https://nim-lang.org/community.html">otherwise</a>.
    </div>
  </div>
</div>

Recently I stumbled upon a [post](https://www.reddit.com/r/unix/comments/6gxduc/how_is_gnu_yes_so_fast/) which takes a closer look at the `yes` command line tool. The main purpose of it is to write endless stream of a single letter `y` at a ridiculous speed.

On the first glance this seems like a really simple problem, just two lines of Nim and you're done, right?

```nim
while true:
  echo "y"
```

And indeed, this gives us plenty of `y`'s. But when we take a look at the write speed..

```
$ ./yes | pv > /dev/null
... [2.84MiB/s] ...
$ yes | pv > /dev/null
... [7.13GiB/s] ...
```

..that is a mind-blowing difference!

This curious detail is thoroughly researched in the original post, so I'll get straight to the key difference. The original `yes` writes a page aligned buffer, which is filled with the desired message, where page size typically is 4096 bytes.

Now to apply the newfound knowledge in Nim:

```nim
const
  pageSize = 4096
  yes = "y\n"
var buffer = ""

for i in 1..pageSize:
  buffer &= yes

while true:
  discard stdout.writeChars(buffer, 0, buffer.len)
```

And check the write speed..

```
$ ./yes | pv > /dev/null
... [5.11GiB/s] ...
```

..Well, this looks way better, but I'm not quite pleased with the missing `2 GB/s`. After checking out Nim source code it seem that the `fwrite` function is the bottleneck.

Luckily, we can easily import any other C function, so why not try using the same one used in the original post..

```nim
# Use POSIX write
proc write(fd: cint, buffer: pointer, count: cint) {.header: "<unistd.h>", importc: "write".}

const
  pageSize = 4096
  yes = "y\n"
var buffer = ""

for i in 1..pageSize:
  buffer &= yes

while true:
  write(1, addr buffer[0], cint(buffer.len))
```

And the result..

```
$ ./yes | pv > /dev/null
... [7.16GiB/s] ...
```

That's it! Nim has successfully achieved the same efficiency as the `yes` written in native C.

Although we managed to match the write speed, we also made our code less expressive. Luckily this is Nim, so a simple template will help cleaning this up while keeping the performance unimpacted!

```nim
# Use POSIX write
proc write(fd: cint, buffer: pointer, count: cint) {.header: "<unistd.h>", importc: "write".}

template fastWrite(str: string) =
  write(1, addr str[0], cint(str.len))

const
  pageSize = 4096
  yes = "y\n"

var buffer = ""

for i in 1..pageSize:
  buffer &= yes

while true:
  fastWrite(buffer)
```

And there we go! A seemingly simple problem that manages to highlight the beauty of Nim.
