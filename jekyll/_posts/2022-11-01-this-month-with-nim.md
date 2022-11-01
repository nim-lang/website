---
title: "This Month with Nim: October 2022"
author: The Nim Community
excerpt: "Nim's Website Analytics, HTTP RPC, and TileEngine Bindings"
---


## Public Analytics for Nim

#### Author: [pietroppeter](https://github.com/pietroppeter)

This month (October 2022) has been the first month where Nim website analytics have been available publicly
for everyone to consult, here is a snapshot of the dashboard on October 31st:

<p style="text-align: center;">
  <img width="auto" height="300" src="{{ site.baseurl }}/assets/thismonthwithnim/2022-10/analytics.png">
</p>

Can you spot the day of NimConf? 😜

By **Public** Analytics I mean that anyone has access to the dashboard.
Indeed, you can explore the data yourself: [https://plausible.io/nim-lang.org](https://plausible.io/nim-lang.org).

- Can you guess what are the top three sources of traffic for the month?
- How many views did last edition of "This month with Nim" had?
- Is your country in the top ten list of visitors? How many Nim visitors from your city?
- More mobile or more desktop visitors? What if you filter for a specific blogpost?

The analytics in the dashboard are provided by [plausible analytics](https://plausible.io),
which is an analytics service that provides simple metrics which are privacy focused, and in particular,
they are **very easy to set up and to share the analytics publicly**!

I have been a happy user of plausible for a while,
at some point I had a subscription with space for many views and I decided that as part of my sponsorship efforts for Nim.
I would be happy to commit on keep funding this analytics for some time.
Plausible is open source and can be self hosted, which are nice benefits.

I see this is the beginning of a process of migrating away from Google Analytics (which is currently still used).
There will be other steps along the way before being able to drop google analytics (including migrating GA data into plausible),
I will keep working on this and my plan would be at some point to publish a blogpost dedicated to this activity with more explanations.
If you have questions, the forum thread where this blogpost will be shared could be a good place to start a discussion.

Other references:
- PR that adds plausible to nim website: [link](https://github.com/nim-lang/website/pull/339)
- Issue that tracks next steps: [link](https://github.com/nim-lang/website/issues/342)




## [pigeon](https://github.com/dizzyliam/pigeon)

#### Author: [Liam Scaife](https://github.com/dizzyliam)

[Pigeon](https://github.com/dizzyliam/pigeon) replaces HTTP boilerplate with simple Nim procedures.
When compiling to C (and friends), procedures defined within the `autoRoute` macro are automatically exposed as an API via Jester.
When compiling to JS, matching procedures are created that make requests to the API.
All arguments and return values are marshaled into JSON for the journey.

The result is procs you can define on the server, then call from a webapp, letting you develop them together.

Install with `nimble install pigeon`.



## [nim-tilengine](https://sr.ht/~exelotl/nim-tilengine/)

#### Author: [exelotl](https://exelo.tl/)

[nim-tilengine](https://sr.ht/~exelotl/nim-tilengine/) is a set of bindings for [Tilengine](https://www.tilengine.org/),
a free, cross-platform 2D rendering engine for creating retro-style games using tilemaps, sprites and palettes.
Many oldschool tricks are supported such as palette-based animation and per-scanline raster effects.
Rendering is all done in software. The implementation is efficient and can run well even on a Raspberry Pi.

The Nim bindings strip away all the cruft from the C API,
becoming shorter and more readable than even the official Python bindings, while keeping native performance!

Example:

<p style="text-align: center;">
  <img width="auto" height="300" src="{{ site.baseurl }}/assets/thismonthwithnim/2022-10/tileengine.png">
</p>

```nim
import tilengine

let engine = init(320, 180, numLayers = 4, numSprites = 128, numAnimations = 128)

let map = loadTilemap("assets/map.tmx")
Layer(0).setTilemap(map)

createWindow()
while processWindow():
  drawFrame()

map.delete()
deleteWindow()
deinit()
```

----




## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
