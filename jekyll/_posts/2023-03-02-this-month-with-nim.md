---
title: "This Month with Nim: Feburary 2023"
author: The Nim Community
excerpt: "A system monitor, internationalization macros, and a nimib update"
---


## [ttop](https://github.com/inv2004/ttop)

#### Author: [Inv2004](https://github.com/inv2004)

System monitoring tool with TUI, historical data service and triggers

<p style="text-align: center;">
  <img width="auto" height="600" src="{{ site.url }}{{ site.baseurl }}/assets/thismonthwithnim/2023-02/ttop.png">
</p>

- [x] Saving historical snapshots via systemd.timer or crontab
- [x] Scroll via historical data
- [x] TUI with critical values highlight
- [x] External triggers (for notifications or other needs)
- [x] Ascii graph of historical stats (via https://github.com/Yardanico/asciigraph)
- [x] Temperature via `sysfs`
- [x] User-space only, doesn't require root permissions
- [x] Static build
- [x] Threads tree




## [ni18n](https://github.com/heinthanth/ni18n)

#### Author: [Hein Thant](https://github.com/heinthanth)

`ni18n` is a super simple and fast Nim macro for internationalization and localization.
No runtime lookup for translation since all translations are compiled down to Nim functions except we still have a runtime `case` statement for `locale` to call correct generated locale specific function.

```nim
import ni18n

type
    Locale = enum
        English
        Chinese

i18nInit Locale, true:
    hello:
        English = "Hello, $name!"
        Chinese = "你好, $name!"
    ihaveCat:
        English = "I've cats"
        Chinese = "我有猫"
        withCount:
            English = proc(count: int): string =
                case count
                of 0: "I don't have a cat"
                of 1: "I have one cat"
                else: "I have " & $count & " cats"
            Chinese = proc(count: int): string =
                proc translateCount(count: int): string =
                    case count
                    of 2: "二"
                    of 3: "三"
                    of 4: "四"
                    of 5: "五"
                    else: $count
                return case count
                    of 0: "我没有猫"
                    of 1: "我有一只猫"
                    else: "我有" & translateCount(count) & "只猫"

# prints "你好, 黄小姐!". This function behave the same as `strutils.format`
echo hello(Chinese, "name", "黄小姐")

# prints 我有猫
echo ihaveCat(Chinese)

# prints 我有五只猫
echo ihaveCat_withCount(Chinese, 5)

# compiler error here since each function is generated with the same signature from lambda
echo ihaveCat_withCount(Chinese, "some str")
```


### Behind the Scenes

Imagine one writes this code:

```nim
type
    Locale = enum
        English
        Chinese

i18nInit Locale, true:
    hello:
        English = "Hello, $name!"
        Chinese = "你好, $name!"
```

The macro macro will convert that code into this:

```nim
type
    Locale = enum
        English
        Chinese

proc hello_English(args: varargs[string, `$`]): string =
    format("Hello, $name!", args)

proc hello_Chinese(args: varargs[string, `$`]): string =
    format("你好, $name!", args)

proc hello*(locale: Locale, args: varargs[string, `$`]): string =
    case locale
    of English: hello_English(args)
    of Chinese: hello_Chinese(args)
```

So, we have just locale runtime check, but since that's enum, we're still going fast!





## News from nimib-land

#### Authors: [@pietroppeter](https://github.com/pietroppeter) [@HugoGranstrom](https://github.com/HugoGranstrom)


In January we set our goals for 2023 and in February we started delivering progress on them.

We discuss goals, progress and next steps in 🎪*Nimib Speaking Hours*,
a loosely monthly appointment open to everyone from the curious person that has never used nimib,
to the aspiring contributor.
They are announced in [nimib forum](https://github.com/pietroppeter/nimib/discussions/178), join us!

So what are the goals for 2023?

- For nimib itself we have various improvements roughly split into the first and second half of the year,
see the [labels 2023H1 and 2023H2](https://github.com/pietroppeter/nimib/issues?q=is%3Aissue+label%3A2023H1%2C2023H2)
- Among the big goals for the first half of the year is a move to [nimib-org](https://github.com/nimib-org).
Indeed, we plan next month to actually move all our nimib-related repos there.
Please be patient if there are some turbulunces.
- The other big goal for the first half of the year is to finally create a general purpose Static Site Generator (SSG)
that works with nimib.
Currently to create a good looking website with nimib content there is only nimibook,
which is limited (on purpose, which makes it simple to pick up, and simple is good).
- For nimibook we have also lined up a [number of improvements](https://github.com/pietroppeter/nimibook/issues?q=is%3Aissue+label%3A2023H1%2C2023H2)
(basically covers most functionalities of mdbook, including delivering a binary on install and supporting SUMMARY.md).
- The second half of the year is planned to be reserved for some refactorings, changing some of the internals of nimib
(to be able to deliver more fancy features) and refactoring nimibook with the upcoming SSG.
- Among the other goals of is to start working on [nimibex](https://github.com/nimib-org/nimibex),
a repo for extensions,
extras and experiments for the nimib ecosystem.
- Most of the planned extensions are currently blogposts in [nblog](https://github.com/pietroppeter/nblog),
which we are also working on turning into a proper blog.

What is the current progress?
- We had [4 releases in nimib](https://github.com/pietroppeter/nimib/releases), mostly maintenance and minor stuff,
the big news is that nimib is now nim v2.0 ready!
- We had [2 releases in nimibook](https://github.com/pietroppeter/nimibook/releases), in particular 0.3 release
finally catches up the documentation on a lot of work done last year (including work from new contributor @beef331).
Ah, nimibook is also v2.0 ready!

What are next steps?

- Complete the [ongoing work on making nblog a proper blog](https://github.com/pietroppeter/nblog/pull/16), while a the same time progressing
on one of the key ingredients of the future SSG: a nimib document will be rendered to json and the json later converted to html
- Start working on nimibex
- Move repos to nimib-org

For more details you can look at the meeting notes from
[January](https://github.com/pietroppeter/nimib/discussions/162#discussioncomment-4811966) and
[February](https://github.com/pietroppeter/nimib/discussions/178#discussioncomment-5139070) speaking hours,
you can ask stuff in nimib discussion forum (hopefully soon that will become nimib-org discussion forum),
or elsewhere.

*Disclaimer*:  
Note that all these plans on doing stuff come with a very loose open source commitment:
we work on these projects on our free time, we do it because we enjoy it, we will not get stressed
if we do not manage to complete our plans, whatever happens in life means we might need to redirect our energy elsewhere.



----


## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
