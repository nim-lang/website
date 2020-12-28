---
title: "Nim in 2020: A short recap"
author: The Nim Team
---

A lot has happened in the Nim world in 2020 -- two new major releases, two new
memory managements (ARC and ORC), the first Nim conference, and much more.

We'll try to cover the most important bits chronologically in the following
sections.



## Version 1.2

Nim version 1.2.0 was [released in April](https://nim-lang.org/blog/2020/04/03/version-120-released.html).
It contained around 600 new commits which have not already been backported to our
1.0.x versions and, among other things, introduced the **ARC memory management** and
several useful macros in the [sugar module](https://nim-lang.org/docs/sugar.html):
- `collect` (for creating list/set/table-comprehensions)
- `dup` (turning an in-place function into one that returns a result without modifying its input)
- `capture` (capturing local loop variables)



## Nim Conf 2020

<p align="center">
<img width="300px" style="background: #232733;" src="/assets/img/nim-conf-2020.svg">
</p>

Due to COVID-19 situation, we have decided that the first ever Nim conference
should be held online and be available for free for everybody.

It was held on June 20th via Youtube streams, containing **15 interesting talks**
where the authors showed wide variety of things they are developing using Nim.
Every talk also had a live chat where the authors and the audience interacted,
which proved to be very useful to get answers to some specific questions and
go into more depth about the topic.

All talks can still be viewed on
[the Youtube playlist](https://www.youtube.com/playlist?list=PLxLdEZg8DRwTIEzUpfaIcBqhsj09mLWHx)
and we recommend you to take a look if you haven't watched the talks already.

<p align="center">
<iframe width="560" height="315" src="https://www.youtube.com/embed/videoseries?list=PLxLdEZg8DRwTIEzUpfaIcBqhsj09mLWHx" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</p>

Following its great success, we can already announce **Nim Conf 2021**!
We don't have any concrete details yet, but the plan is to have it in the
summer of 2021 - mark your calendars and start preparing your talks :)



## Version 1.4

In October, we have [released Nim 1.4.0](https://nim-lang.org/blog/2020/10/16/version-140-released.html),
which in our opinion is the largest release since 1.0.0, bringing 900 new commits
(not counting for all the bugfixes backported to 1.0.x and 1.2.x) and a new
major version of [Nimble](https://github.com/nim-lang/nimble), v0.12.0.

The main feature of the 1.4 release is the **ORC memory management**, together with
many bugfixes for `--gc:arc` introduced in version 1.2.

If you want to know more about ARC and ORC, we recommend reading
[this introductory article](https://nim-lang.org/blog/2020/10/15/introduction-to-arc-orc-in-nim.html)
which explains the benefits of ARC/ORC compared to the Nim's currently default
`refc` GC, and contains links to other useful resources.
[This article](https://nim-lang.org/blog/2020/12/08/introducing-orc.html) shows
some benchmark numbers and the reasons why you should switch to ORC in your
projects.



## Version 1.0 LTS and backports

Releasing new versions of Nim, we didn't forget our promise given when
[Nim 1.0.0 was released](https://nim-lang.org/blog/2019/09/23/version-100-released.html),
and that is: version 1.0 is our long-term supported release and it will continue
to receive bug fixes even after a new version of Nim is released.

Currently we are at version 1.0.10, and even though less than 5% of our users are
still using 1.0.x, we plan to continue to support it by backporting the most
critical bugfixes even in 2021.

Our main backporting effort will continue to be the latest stable version.
At the time of writing this that is Nim 1.4, and we recommend switching to it
as it brings exciting new features, together with all the bugfixes included in
the previous versions.



## 1500 Nimble packages

In December, we hit the milestone with number of
[Nimble packages](https://nimble.directory/): 1500 available packages!

It sparks joy to know that out of those 1500, 400 were new packages submitted
in the last year (**+35% growth**), and that our community is growing at such
high pace.



## How can I help Nim grow in 2021?

If you haven't already, please fill our
[2020 Community Survey](https://forms.gle/kEWvEeVyfxSHq9Uj8)
so we can get a better understanding what our users really want and what are
your main pain points.

Fixing [bugs](https://github.com/nim-lang/Nim/issues) is always appreciated
way of directly helping us make Nim better.
In 2020 we had 49 contributors whose more than 1930 commits and pull requests
got merged into our `devel` branch. (More than 5 per day)
Thank you very much for your contributions!

We would also like to encourage you to
[**donate**](https://nim-lang.org/donate.html) to the Nim project which will
allow us to create more bounties in 2021 for tackling the most important and
the most difficult problems.

You can donate via:

- [Open Collective](https://opencollective.com/nim)
- [Patreon](https://www.patreon.com/araq)
- [PayPal](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=FLWX5V2PMAXAU)
- Bitcoin: 1BXfuKM2uvoD6mbx4g5xM3eQhLzkCK77tJ



Thank you all for your incredible support so far, and have a happy new year!

