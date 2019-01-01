---
title: "Nim Community Survey 2018 Results"
author: Dominik Picheta
---

We have recently closed the 2018 Nim Community Survey. I am happy to
say that we have received exactly 771 responses, huge thanks to all the people
that took the time to respond. We're incredibly thankful for this very valuable
feedback.

For the results of the previous year's survey, take a look at the
[2017 results analysis](https://nim-lang.org/blog/2017/10/01/community-survey-results-2017.html).

Our survey ran from the 23rd of June 2018 until the 31st of July 2018.
The goal of this survey was primarily to determine how our community is using
Nim, in order to better understand how we should be improving it. In particular,
we wanted to know what people feel is missing from Nim in the lead up to
version 1.0. We have also asked our respondents about how well the Nim tools
worked, the challenges of adopting Nim, the resources that they used to learn
Nim and more.

This article goes through some of the highlights in the results for the survey
and discusses them in the context of the previous year's results. The aim is to
understand our users and to figure out priorities for Nim's future.

This time around I have decided to publish the Google Survey results
page, for some this may be more interesting than reading the highlights.
It's available here: [https://i.imgur.com/g7slQ8w.png](https://i.imgur.com/g7slQ8w.png).

# Changes since the last survey

The questions in this survey were largely the same as last year's,
but there were some key changes. In particular, the following questions were
added:

* How do you learn about the new functionality added to Nim?
* Should Nim 1.0 have been released already?

The following questions were removed:

* Which direction should Nim’s GC/memory management take?
* What domain do you work in currently?
* What domain do you use Nim in?

The following questions were modified:

* "How did you install Nim?" was changed to "How did you most recently install Nim?"
* What improvements are needed before Nim v1.0 can be released?
  * This question was streamlined into a single long form question.

The "What critical libraries are missing in the Nim ecosystem?" and
"What development tools, if any, can make you more productive when working with Nim?"
questions were merged into
"What features, tools, or libraries would you like Nim to have?"

We wanted to gain deeper knowledge of our contributor's experiences, so
a brand new section titled "Contributor questions" was introduced.

# Do you use Nim?

<a href="{{site.baseurl}}/assets/news/images/survey2018/do_you_use_nim.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2018/do_you_use_nim.png" alt="Do you use Nim?" style="width:100%"/>
</a>

Like last year the respondents were split up into three groups:

* Current users of Nim
* Ex-Nim users
* Those that never used Nim

This enabled each group to be targeted with specific questions.
For example, ex-Nim users were asked why they've stopped using Nim.

This year the proportion of responses from current Nim users has grown
from 43% to 47%. This is a slight increase in the proportion of Nim users
answering the survey, but it's important to note that the absolute number
went up by over 100 users from last year.

# How could we help make Nim more accepted at your company?

This was a free-form question so there were many different answers, but a few
answers were very common. By far the most common request was "version 1.0."

Other honourable mentions include "more documentation", "more stability" and
"Free balloons". These mostly align well with the general wishes of our
community so you will see similar answers in later questions as well.

# What editor(s) do you use when writing Nim?

<a href="{{site.baseurl}}/assets/news/images/survey2018/editors_used.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2018/editors_used.png" alt="Editors used by Nim users" style="width:60%"/>
</a>

Visual Studio Code continues its dominance and has become even more dominant
since the last survey. 51% of respondents selected Visual Studio Code, whereas
only 35.5% selected it last year.

# What is your experience with the following tools?

This questions gives a good idea about how popular Nim tools are and whether
using them is enjoyable.

The most popular tool, as one might expect, is Nimble. The Nimble package
manager also boasts a high like rating, with over 75% of respondents answering
either "Like" or "Extreme Like" for Nimble.

The most unpopular tool is nimpretty, with 75% of respondents answering that
they haven't used it.

The most disliked tool is nimsuggest, although it is only disliked by 6% of the
respondents.

# How did you most recently install Nim?

<a href="{{site.baseurl}}/assets/news/images/survey2018/recent_install.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2018/recent_install.png" alt="How did you most recently install Nim?" style="width:60%"/>
</a>

Choosenim takes the crown as the most popular installation method, but only just
barely. Other installation methods are also very popular.

# Top reasons why programmers stopped using Nim

The reasons given vary widely which makes their analysis challenging. In order
to make it easier to see the reasons at a high level, I went through and grouped
them into generic categories.

<a href="{{site.baseurl}}/assets/news/images/survey2018/leave_reasons.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2018/leave_reasons.png" alt="Why did you stop using Nim?" style="width:80%"/>
</a>

This offers some good insight into why programmers have stopped using Nim.

The number one reason is Nim's relative lack of maturity, many
respondents have quoted this as the
reason why they have stopped using Nim. In most cases the respondents simply
want 1.0 to be released. Together with maturity, multiple respondents also
mentioned a general lack of libraries and Nim's small ecosystem. These respondents
were all counted under the "Maturity" category.
The "Missing library" category mostly counts respondents who
mentioned a specific library that was missing. This category could
have easily been merged into the "Maturity" category but wasn't for greater detail.

The second reason, categorised as "Not sufficiently better than other languages",
was mostly the respondent specifying that they are happy with another language,
or that their project is more suited to another language.

Stability was the third reason. For this category, the respondents mostly
talked about the stability of Nim as a whole. In many cases this meant tools
such as IDEs not working properly rather than the compiler being buggy, although
the latter was prevalent as well.

# Top reasons why programmers are not using Nim

This is similar to the previous section, but it focuses on respondents who
do not use Nim. As previously these vary widely so they have been put into
categories.

<a href="{{site.baseurl}}/assets/news/images/survey2018/not_using_reasons.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2018/not_using_reasons.png" alt="Why aren't you using Nim?" style="width:80%"/>
</a>

Note that this is based on the long-form question which was asked in
addition to the multiple choice question.

It seems that the number one reason why respondents are not using Nim is
because they do not see the value in it. Many of the respondents didn't see
a reason why learning Nim was worthwhile. This is reflected in the number 1
category: "Not sufficiently better than other languages".

Lack of time is of course a big factor too and in many cases it ties in
with respondents not seeing value in learning Nim.

Nim's relative immaturity was another strong theme among the responses.

An interesting number of respondents specified that they simply didn't have
a project, or couldn't come up with a project to write in Nim. It may be worth
exposing newcomers to some project ideas to alleviate this.

# Do you feel well informed in the direction that the Nim project is heading?

<a href="{{site.baseurl}}/assets/news/images/survey2018/nim_future_heading_informed_feeling.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2018/nim_future_heading_informed_feeling.png" alt="Do you feel well informed in the direction that the Nim project is heading?" style="width:60%"/>
</a>

This question was asked last year to gauge how well we are informing users
about where the Nim project is heading. In comparison to last year, the
proportion of respondents answering "Yes" has increased to 25.8% from 23.5%.
This is positive but we should do better, while it is an increase it is
relatively minor. We should look into further ways to inform our community of
our roadmap and other plans for the future.

# Should Nim 1.0 have been released already?

<a href="{{site.baseurl}}/assets/news/images/survey2018/release_nim_1_now.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2018/release_nim_1_now.png" alt="Should Nim 1.0 have been released already?" style="width:60%"/>
</a>

This is a new question, it's aim is to gauge the feeling in the community around
whether a stable 1.0 release of Nim should have been made already.

Right now, the results are fairly even and thus it's hard to know what to take
away from them.

# What improvements are needed before Nim v1.0 can be released?

<a href="{{site.baseurl}}/assets/news/images/survey2018/needed_for_1.png">
  <img src="{{site.baseurl}}/assets/news/images/survey2018/needed_for_1.png" alt="What improvements are needed before Nim v1.0 can be released??" style="width:80%"/>
</a>

The chart above shows the general trends of what respondents felt was needed
for Nim v1.0 to be released.

It was surprising to see so many respondents mentioning destructors, it
seems that many people are excited about this feature and want it to be
included in v1.0 of Nim.

The top three improvements though were, in order, "Better Docs", "Stabilization"
and finally "Better Stdlib".

For the first one, respondents generally asked for
more polished documentation but a significant portion of them also asked for
video tutorials. Many felt that video tutorials were a good way to learn a
programming language, we have already
[created some live streams](https://nim-lang.org/blog/2017/12/28/nim-in-2017-a-short-recap.html#nim-livestreams)
where we coded
Nim projects but it is obvious that we need to do more. In particular,
we should:

* Create more video tutorial material
* Ensure that our video tutorials are accessible to all and easy to find
* Improve the general written documentation, both in its presentation but also
  in the amount of content available

For the second one, respondents generally asked for a more reliable experience
with all language features. A reduction of compiler crashes and surprising
behaviour was among the top wishes.

Finally for the "Better Stdlib" responses, many of them asked for a cleanup
of the standard library. In particular the removal of deprecated functions but
also the migration of some modules to a separate repository available via
the Nimble package manager.

## Last words

Thank you to each and every one of you who took the time to answer this survey.
Your time is precious and we are deeply thankful that you used it to share your
feedback.

Please remember that you do not need to wait for a survey in order to give us
feedback, of course you're more than welcome to wait if you wish, but ideally
share your feedback with us immediately. We can be found in various different
places, see the community page for links and instructions on how to get in touch:
https://nim-lang.org/community.html.

If there are any questions about this survey I'm more than happy to answer them.
Feel free to reach out to me on the community channels linked above.

Thanks for reading, and have a good day!
