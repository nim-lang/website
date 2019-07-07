---
title: "Nim Community Survey 2017 Results"
author: Dominik Picheta
---

We have recently closed the 2017 Nim Community Survey. I am happy to
say that we have received exactly 603 responses, huge thanks go to the people
that took the time to respond. We're incredibly thankful for this very valuable
feedback.

For the results of the previous year's survey, take a look at the
[2016 results analysis](https://nim-lang.org/blog/2016/09/03/community-survey-results-2016.html).

Our survey ran from the 23rd of June 2017 until the 14th of August 2017.
The goal of this survey was to primarily determine how our community is using
Nim, in order to better understand how we should be improving it. In particular,
we wanted to know what people feel is missing from Nim in the lead up to
version 1.0. We have also asked our respondents about how well the Nim tools
worked, the challenges of adopting Nim, the resources that they used to learn
Nim and more. We repeated the survey with the same questions this year to
see how we did over the past year.

Unlike in the last year, this analysis will not go over all the results. Instead
it will only go over the most interesting answers.

# A word on the response count

In comparison to last year we unfortunately received 187 less responses.
I suspect the reason for this decrease was the fact that we were not
able to advertise the survey as well as the previous year, I got lucky last year
by sharing a link to our survey in the Rust community survey results Hacker
News thread. This year Rust's results were late and so I didn't get the
same opportunity.

But with that in mind I think the number of responses is still good.


# Do you use Nim?

Like last year we split up our respondents into three groups:

* Current users of Nim
* Ex-Nim users
* Those that never used Nim

This allowed us to ask each group specific questions. For example, we
asked ex-Nim users why they've stopped using Nim.

<a href="{{site.baseurl}}/assets/news/images/survey2017/do_you_use_nim.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2017/do_you_use_nim.png" alt="Do you use Nim?" style="width:100%"/>
</a>

This year the proportion of responses from current Nim users has grown
from 39% to 44%, and as a result of this there is less responses from those
that never used Nim (decrease from 37% to 30%). This is likely due to
a higher proportion of responses from the Nim community.

But this isn't the whole story, the number of ex-Nim users went up from 24% to
26%.

# Nim users

This section includes answers from current Nim users only (44% of respondents).

## How long have you been using Nim?

<a href="{{site.baseurl}}/assets/news/images/survey2017/nim_time.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2017/nim_time.png" alt="How long have you been using Nim?" style="width:100%"/>
</a>

Just like last year, a large proportion of our Nim users are new. This suggests
that our community is growing and is a good sign. On the other end of the
spectrum we can see that there is a significantly higher number of Nim users
that have been using Nim for more than 24 months.

## Nim at work and project size

The questions related to these topics got very similar results to last year:

* 57.1% of Nim users' projects are less than 1,000 lines of code.
* 24.6% of Nim users' work with Nim either full-time or part-time.
* 52.5% of Nim users plan to use Nim at work.

### How is Nim being used at work?

This was a free-form question so I will just pick out some of the common and
interesting answers. According to the respondents, Nim is used at work for:

* Command-line applications
* Server-side analytics
* DevOps
* Scientific computing
* Speeding up Python

### How could we help make Nim more accepted at your company?

Another free-form question, I will pick out some of the things that respondents
have identified:

* **Release of version 1.0 (_a common theme_)**
* **Mature libraries and stability (_a common theme_)**
* **Up to date documentation of every feature, with examples (_a common theme_)**
  * More tutorials and videos
* Enhance the stdlib, it needs to be more complete
* Corporate sponsor
* Visual Studio plugin
* Lowering the barrier to entry for working with cross-compilers and interop
  with C
* Free book
* Compelling use cases
* Porting to ARM cortex M (_already done?_)
* "change cocky logo"
* More informative errors
* Lockfile support
* Interfaces
* More data processing tools
* GUI creator for Windows
* "idk lol"

## Nim and its tools

In this section of the survey, we wanted to find out the tools that Nim users are utilising when developing Nim applications.

### What editor(s) do you use when writing Nim?

Programmers swear by their editors. What does the Nim community prefer?

<a href="{{site.baseurl}}/assets/news/images/survey2017/editors_used.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2017/editors_used.png" alt="Editors used by Nim users" style="width:60%"/>
</a>

There is still a large number of Vim users, but now they are overwhelmed by
the Visual Studio Code users. VS Code has gone from 16.5% to 35.5%!

### Operating systems, Nim version and Nim code breakage

Again, the results for these questions are very similar to last year. I will
simply provide a summary:

* Linux is still the most popular development platform, with Windows second and
  macOS third.
* The same is true for the target platform. But in addition to this, a large
  19% of respondents are targeting Android, 16.7% are targeting JavaScript,
  10.5% are targeting iOS and 10.1% are targeting embedded platforms.
* The current release of Nim (0.17.0) is the most used at 68.8%, with Git HEAD
  second at 33.1%.
* 52.2% of respondent's code was never broken by a Nim upgrade.
* Of those whose code was broken, for 29.3% of the respondent's it was little
  work to fix.

### Install method

We wanted to find out how users are installing Nim. In particular I wanted to
find out whether ``choosenim`` was getting adopted.

<a href="{{site.baseurl}}/assets/news/images/survey2017/install_method.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2017/install_method.png" alt="Installation method" style="width:100%"/>
</a>

It seems that the majority are still in fact installing Nim by cloning the
Nim repo manually. This makes sense as Nim is still evolving quickly, for
most people it makes sense to stay on the bleeding edge.


### What critical libraries are missing in the Nim ecosystem?

This is a good list of projects for the Nim community to take up. The respondent's
were asked to freely give libraries that they need, here are their (mostly raw)
answers (duplicates left in to show popularity):

* High-level HTTP library (like "requests" in Python)
* First-class libraries rather than C wrappers.
* Bass audio library
* Distributed computing libraries
* REPL
* Stabilsing async libraries
* Rails-like framework, ORM, webdriver, Electron-like thing
* KD-Tree, Blas/Lapack
* Qt GUI bindings
* Excel XLSX Read/Write
* Pandas-like, more statistical libraries
* Linear algebra, plotting, science
* UI
* Simple gui, like tkinter or wxwidgets.
* Db/queues high level connectors
* Pandas like dataframes, a well documented web framework, ORM
* Gui
* html5 parser
* excel reader, dataframe. numpy/scipy-like scientific calculation lib.
* python2nim converter
* OpenPGP
* Easier way to add a language backend
* parsing
* multithreaded web framework
* embedded I/O
  * I think the libraries are there but the documentation is abit lacking.
* oracle oci
* Kerberos auth library (c wrapping), pandas like lib (there is one more features will be nice)
* native support for big numbers
* iterutils, date (native nim excluding time, usable at compile time in const), asyncdb
* a wysiwyg for guis
* cancelable async timers, gui, random, collections (unified), and would be nice to redesign the whole stdlib
* Android support
* OpenGL, Vulkan (all API for game development)
* Maybe theese exists already but for network equipment SSH, Expect tooling I'd love, and also parsing of config    files libraries.
* Interfaces
* Lib to make working with dates and times more easy, like pytz for Python.
* I'm always amazed at how complete the standard lib for such a (still) small
  project; more libs for data   processing would be great (Neo seems to be a very good start)
* GUI, I would like Qt
* orm
* Machine Learning, Pandas-like
* More object oriented paradigms, especially interfaces, that is a language
construct informing you that you forgot to implement a function required to
conform to an interface, it doesn't really need to be a "classic" example,
 because i know Nim developers think out of the box (I love the vtable
 system, which is not tied to a particular class ;) )
* Machine learning and scientific computing libraries
* Qt bindings
* Thrift, Cassandra drivers, Scientific computing
* scientific plotting
* GUI, Matrix works
* I like the libs, but I wish there was a wrapper for the steamsdk from Valve.
* The only thing that i've been missing so far as a good ORM for working with
  relational data in an Object Oriented manner. I always want to help improve the MongoDb driver.
* Numerical/scientific computing (features like Numpy/Scipy)
* CGAL, Boost, Qt
* simple cross-platform UI
* fltk (for me personally), pandas like lib
* wrapper of Microsoft RPC (rpc4), easy to use Windows GUI
* concurrent data structures
* more trees: tries, quad/octrees, more macro utilities
* Maybe something more related to scientific computing (linalg libraries, etc.)
* Self aligned SIMD vector types.
* A database driver for Cassandra
* Better redis client
* It would be good to have some sort of GUI support
* Built in efficient vec2/3/4 types, everyone duplicates that
* compile time reflection
* websockets
* I'd like to see a Nim implementation of multiformats and other IPFS technologies
* Although there are libraries, better support for linear algebra/scientific
  computing/data plotting would be very nice. Similarly, a standardized game
  library would be wonderful.
* Numerical computing/Data Science tools
* Standard and production-ready async support
* More GUI and networking suppport
* multithreading
* GUI
* web framework
* charting/plotting libraries, numerical libraries, graphics libraries...some
  of these exist or can easily be created by binding to C or C++, but that
  is hard for a noobie, so perhaps better doc in that area with frequent
  examples would help
* A good cross platform graphics library and a UI library built on top of it,
  but I'm intending to start working on these in the future as open source projects (based on OpenGL).
* Fast low level socket library (epool, kqueue)
* modern GUI library
* opengl
* gui library
* a scientific math and plotting library
* numerics. Gui wrapper (ngtk is nice). for me personally, geospatial and image processing libraries
* a matplotlib equivalent
* Pure Nim database libraries; Libraries for common HTTP I/O (files, chunked transfers, etc.)

### What development tools can make you more productive when working with Nim?

Summarising again:

* Debugger (_very common theme_)
* Documentation
* Various IDE plugins (IntelliJ, Visual Studio)
* Better cross-compiler support

# Previous Nim users

## How long did you use Nim before you stopped?

<a href="{{site.baseurl}}/assets/news/images/survey2017/ex_length.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2017/ex_length.png" alt="How long did you use Nim before you stopped?" style="width:100%"/>
</a>

This question is new. It shows that ex-Nim users are fairly equally distributed
based on the amount of time they used Nim before deciding to stop.

## Reasons why respondents stopped using Nim

This was a free-form question. Some of the common answers were as follows:

* Lack of time (_this is actually a very common reason_)
* No good editor support
* Lack of stability/maturity
* No killer use case
* Nim is a running target
* Metaprogramming too unstable

Here are some other interesting reasons:

* Compiler doesn't conform to Unix traditions and outputs HUGE binaries.
* Lack of ``GOTO``.
* Nim generated broken C code.
* "I found myself working on the compiler instead of using the language."
* "proc and echo are weird, I think that def and print are better"
* "really dislike the fact that if you do import foo you get a lot of new
  names in your namespace and sometimes have to exclude; find Python's explicit
  approach much more robust and clear."
* "Compiler doesn't conform to Unix traditions and outputs HUGE binaries."
* "Changes to the core libraries to rely too much on exceptions. I don't like exceptions."

# Non-users of Nim

## Reasons for not using Nim

As with the previous year, the most popular answer to this question was
once again to do with maturity of Nim as well as lack of libraries and good
IDE support.

There were also a number of free-form answers to this question:

* GC
* Small user base
* Dislikes significant whitespace
* No corporate backing
* Waiting for 1.0
* Unpredictable performance (according to the respondent Go has predictable
  performance behaviours whereas Nim doesn't)
* Language appears overcomplicated
* Uncertainty about future
* Just waiting for free time

# Nim's future

## What improvements are needed before v1.0 can be released?

This received a number of free-form answers which I will outline here:

* **Documentation**
* **It's ready now!**
* Getting rid of warts that HN/Reddit comments about
* Get rid of forward declarations
* Improve error messages
* Concepts
* Improve stdlib

## Which direction should Nim's GC/Memory management take?

<a href="{{site.baseurl}}/assets/news/images/survey2017/gc_direction.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2017/gc_direction.png" alt="Which direction should Nim's GC/Memory management take?" style="width:100%"/>
</a>


There was a number of free-form answers as well. Most of them spoke about
providing all approaches, i.e. the "have the cake and eat it too" approach.
Many are conscious of the fact that a GC makes programming
smoother so they don't want the Rust model, but for use cases where it's
necessary they do want it.

## Last words

Like last year, at the end of the survey we gave our respondents a chance to
speak their mind
about anything they wish, with a simple question: "Anything else you'd like
to tell us?"

There was a lot of great feedback given in this question from people who
obviously really care deeply about Nim. There is too much to outline here,
but rest assurred that we will take it all into account and do our best to
act on it.

In addition to feedback, we were also overwhelmed by the amount of positive
comments in the answers to this
question. There was a lot of support from the community thanking us for our
work and determination.

I'll let some quotes speak for themselves:

<blockquote>Keep up the good job. I love Nim!</blockquote>
<blockquote>Great work so far, keep it going!</blockquote>
<blockquote>Please just keep up the excelent work. Nim is awesome!</blockquote>
<blockquote>Awesome language, and great community!</blockquote>

Our community is truly brilliant. We thank each and every one of you for
filling out this survey and hope that you will help us tackle some of the
challenges that face Nim.

This survey was a good place to give us feedback, but please don't wait for
the next one. We are always looking to hear more from you and we hope that you
will participate in discussions relating to this survey as well the future
of Nim.

Thanks for reading, and have a good day!
