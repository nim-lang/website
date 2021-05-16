---
title: "This Month with Nim: March 2021"
author: The Nim Community
excerpt: "Four interesting packages our users worked on in March"
---


## [nimCloudflareDynDns](https://github.com/enthus1ast/nimCloudflareDynDns)

#### Author: David Krause ([enthus1ast](https://github.com/enthus1ast/))

If you live in Germany you most likely have a dynamic IP address.
So every time your router restarts, or after a certain time, your router gets a
new IP address from your ISP.

When you want to host services from home, or just want to have SSH access,
you normally use one of the big dynamic DNS providers (dyn.com, no-ip.com, afraid.org, etc.).
To have a DNS entry that always points to your routers external IP address.

If your domain is managed by cloudflare's DNS servers, this tool is for you!

The idea:

- Acquire your public IP address by crawling several "what is my IP address" websites.

- Assume that the most often 'seen' IP address is your router's external IP address.

- Use the cloudflare API to change 'A' records of some of the configured subdomains
  to point to your router's IP address.

By running this tool periodically, you effectively use cloudflare as your dynamic
DNS provider!

We use this tool for years without major issues and I wanted to share this with you :)

"Go and host all the things!"

P.S. Even if you do not plan to use cloudflare as your dynDNS provider, this
project includes a "from (text) soup IPv4 parser" which can extract IPv4 addresses from any text.
Maybe this is helpful!



## nimib

#### Author: Pietro Peterlongo ([pietroppeter](https://github.com/pietroppeter/))

[nimib](https://github.com/pietroppeter/nimib) provides an API to convert your
Nim code and its outputs (text, images, ...) to html documents, similar to
the notebooks produced by tools like Jupyter or RMarkdown.

For example the following code:
```nim
import nimib

nbInit

nbText: "### A random 8-color palette with [pixie](https://github.com/treeform/pixie)"

nbCode:
  import std/random, pixie

  proc randomColor : ColorRGB =
    rgb(rand(255).uint8, rand(255).uint8, rand(255).uint8)

  const
    radius = 32
    space = 16
  let image = newImage(8*(radius*2 + space), radius*2)

  var
    center = vec2(radius, radius)
    color: ColorRGB
    palette: seq[ColorRGB]
  
  for i in 1 .. 8:
    color = randomColor()
    palette.add color
    image.fillCircle(center, radius, color)
    center += vec2(2*radius + space, 0)

  image.writeFile("palette.png")

nbImage("palette.png")

nbCode:
  for c in palette: echo $c

nbShow
```

Produces an [html document](https://pietroppeter.github.io/nblog/drafts/random_palette.html)
that looks like this:
<p style="text-align: center;">
  <img width="auto" height="400" src="{{ site.baseurl }}/assets/thismonthwithnim/2021-04/nimib.png">
</p>



## Raspberry Pi Pico-sdk

#### Author: Jason Beetham ([beef331](https://github.com/beef331/))

The Raspberry Pi Pico is a micro-controller which runs C code, and you know what
that means: throw Nim on it!

I've started making idiomatic bindings for the Pico which makes it rather simple
to get going with Nim on the Pico.
Currently supporting GPIO, ADC, and PWM.

Check out the [template repo](https://github.com/beef331/picotemplate) with
the examples and the explanation on how to make the project.

Check out the [Pico-SDK](https://github.com/beef331/picostdlib) for the bindings.



## Cosmonim: an example of using [Cosmopolitan Libc](https://justine.lol/cosmopolitan/index.html) with Nim

#### Author: Danil Yarantsev ([Yardanico](https://github.com/Yardanico))

Cosmopolitan is a project that allows one to compile C programs into
[portable binaries](https://justine.lol/ape.html) that can run on multiple OSes at the same time.
Cosmonim shows how to properly set up the Nim compiler to use Cosmopolitan;
provides a few example programs and stubs (empty headers) so that the C compiler
would not complain about missing headers.

With [Cosmonim](https://github.com/Yardanico/cosmonim) you can make CLI applications
with Nim and distribute them as a single binary for multiple platforms!



## [Blog post: Amalgamating Nim programs](https://zen.su/posts/amalgamating-nim-programs/)

#### Author: Danil Yarantsev ([Yardanico](https://github.com/Yardanico))

In this blog post I talk about amalgamating Nim programs with [CIL](https://github.com/cil-project/cil).
Amalgamation is a process (popularised and used by the widely known SQLite project)
of combining multiple source files into a single file.
We can use that to compile Nim programs into single-file C programs that can be
distributed more easily, or used in contexts where using Nim directly is not possible.


----

## Want to see your project here next month?

[Follow this](https://github.com/beef331/website) to add your project to the next month's blog post.
