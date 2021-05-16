---
title: "Nim in 2020: A short recap"
author: The Nim Team
---

A lot has happened in the Nim world in 2020: two new major releases, two new
memory managements strategies (ARC and ORC), the first Nim conference, and much more.

We'll try to cover the most important bits chronologically in the following
sections.



## Version 1.2

Nim version 1.2.0 was [released in April](https://nim-lang.org/blog/2020/04/03/version-120-released.html).
It contained around 600 new commits which had not already been backported to our
1.0.x versions and, among other things, introduced **ARC memory management** and
several useful macros in the [sugar module](https://nim-lang.org/docs/sugar.html):
- `collect` (for creating list/set/table-comprehensions)
- `dup` (turning an in-place function into one that returns a result without modifying its input)
- `capture` (capturing local loop variables)



## Nim Conf 2020

<p align="center">
<img width="300px" style="background: #232733;" src="/assets/img/nim-conf-2020.svg">
</p>

Due to the COVID-19 situation, we decided that the first ever Nim conference
should be held online and be available for free for everybody.

It was held on June 20th via YouTube streams, and contained **15 interesting talks**
where the authors showed a wide variety of things they are developing using Nim.
Every talk also had a live chat where the authors and the audience interacted,
which proved to be very useful to get answers to some specific questions and
go into more depth about the topic.

All the talks can still be viewed on
[the YouTube playlist](https://www.youtube.com/playlist?list=PLxLdEZg8DRwTIEzUpfaIcBqhsj09mLWHx)
and we recommend that you take a look if you haven't watched them already.

<p align="center">
<iframe width="560" height="315" src="https://www.youtube.com/embed/videoseries?list=PLxLdEZg8DRwTIEzUpfaIcBqhsj09mLWHx" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</p>

Following its great success, we can already announce **Nim Conf 2021**!
We don't have any concrete details yet, but the plan is to have it in the
summer of 2021 - mark your calendars and start preparing your talks :)



## Version 1.4

In October, we [released Nim 1.4.0](https://nim-lang.org/blog/2020/10/16/version-140-released.html),
which in our opinion is the largest release since 1.0.0, bringing 900 new commits
(not counting all the bugfixes backported to 1.0.x and 1.2.x) and a new
major version of [Nimble](https://github.com/nim-lang/nimble), v0.12.0.

The main feature of the 1.4 release is **ORC memory management**, together with
many bugfixes for `--gc:arc` introduced in version 1.2.

If you want to know more about ARC and ORC, we recommend reading
[this introductory article](https://nim-lang.org/blog/2020/10/15/introduction-to-arc-orc-in-nim.html)
which explains the benefits of ARC/ORC compared to Nim's current default
`refc` GC, and contains links to other useful resources.
[This article](https://nim-lang.org/blog/2020/12/08/introducing-orc.html) shows
some benchmark numbers and reasons to switch to ORC in your
projects.



## Version 1.0 LTS and backports

Releasing new versions of Nim, we didn't forget the promise we made when
[Nim 1.0.0 was released](https://nim-lang.org/blog/2019/09/23/version-100-released.html):
version 1.0 is our long-term supported release and it will continue
to receive bug fixes for as long as there is demand for them.

Currently we are at version 1.0.10, and even though less than 5% of our users are
still using 1.0.x, we plan to continue to support it by backporting the most
critical bugfixes in 2021.

Our main backporting effort will continue to be the latest stable version.
At the time of writing, that is Nim 1.4; we recommend switching to it
as it brings exciting new features, together with all the bugfixes included in
the previous versions.



## 1500 Nimble packages

In December, we hit a milestone number of
[Nimble packages](https://nimble.directory/): 1500 available packages!

It sparks joy to know that out of those 1500, 400 were new packages submitted
in the last year (**+35% growth**), and that our community is growing at such
high pace.



## How can I help Nim grow in 2021?

If you haven't already, please fill our
[2020 Community Survey](https://forms.gle/kEWvEeVyfxSHq9Uj8)
so we can better understand what our users really want and their main pain points.

Fixing [bugs](https://github.com/nim-lang/Nim/issues) is an always-appreciated
way of directly helping us make Nim better.
In 2020 we merged more than 1900 commits into  our `devel` branch (averaging more
than 5 per day) from 49 contributors.
Thank you very much for your contributions!

We would also like to encourage you to
[**donate**](https://nim-lang.org/donate.html) to the Nim project. This will
allow us to create more bounties in 2021 for tackling the most important and
the most difficult problems.

You can donate via:

- [Open Collective](https://opencollective.com/nim)
- [Patreon](https://www.patreon.com/araq)
- [PayPal](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=FLWX5V2PMAXAU)



Thank you all for your incredible support so far, and have a happy new year!
