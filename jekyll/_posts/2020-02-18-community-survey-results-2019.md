---
title: "Nim Community Survey 2019 Results"
author: The Nim Team
---

Nim community survey 2019 has been open for 50 days, and we have received 908 responses, which is our record-high number (771 in 2018, 603 in 2017).
Before we go into details, we would like to thank all the people who took the time to respond.
We really appreciate the feedback!

The goal of this survey was primarily to determine how our community is using Nim, in order to better understand how we should be improving it.
The main difference from the previous years is that in 2019 we finally did [release version 1.0](https://nim-lang.org/blog/2019/09/23/version-100-released.html), and we wanted to see how accepted v1.0 is in our community.
We have also asked our respondents about how well the Nim tools worked, the challenges of adopting Nim, the resources that they used to learn Nim and more.



## Do you use Nim?

Based on the answer to this question, the respondents were divided in two groups and they've received separate set of questions.

<img src="{{site.baseurl}}/assets/news/images/survey2019/01.png" alt="Do you use Nim?" style="width:100%"/>

Approximately 2/3 of the respondents use Nim (23% frequently, 41% occasionally), while the remaining 1/3 is divided between people who never used Nim and people who stopped using Nim.

Of those people who *don't* use Nim, the most frequent reasons are: "Nim doesn't have libraries I need" (30%), "Nim seems immature, not ready for production" (26%), "Nim seems too risky for production" (20%), and "Nim doesn't have enough learning materials" (19%).

For people who have used Nim previously but stopped the most frequent reasons were (free-form question): lack of libraries (small and not mature ecosystem), incomplete documentation, bad editor support, coworkers don't use it, etc.



## Users

<img src="{{site.baseurl}}/assets/news/images/survey2019/02.png" alt="How long have you been using Nim?" style="width:100%"/>

About a half (47%) respondents are new Nim users - they've started using Nim in the last 6 months.
We have 35% of experienced users (between 6 months and 2 years), and 18% of Nim veterans (more than 2 years of Nim experience).


<img src="{{site.baseurl}}/assets/news/images/survey2019/03.png" alt="Where are you from?" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/04.png" alt="What is your occupation?" style="width:100%"/>

An average Nim user would be a software developer from Europe.

Besides Europe, our users mostly come from North America, Asia, and South America, with couple of users from Australia and Africa.
Three quarter of our users are either software developers, students or scientists.


<img src="{{site.baseurl}}/assets/news/images/survey2019/05.png" alt="In what age group are you?" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/06.png" alt="How many years of programming experience do you have?" style="width:100%"/>

We have users from all age groups and with programming experience varying between 1 and 40 years, proving that Nim can be used both by beginners and the experienced programmers.


<img src="{{site.baseurl}}/assets/news/images/survey2019/07.png" alt="What are the technical aspects or features of Nim you like the most?" style="width:100%"/>

Things that people like about Nim the most are: performance/speed (88%), ease of use (76%), syntax (75%), self-contained binaries (69%), open source code (53%), macros and meta-programming (45%).


<img src="{{site.baseurl}}/assets/news/images/survey2019/08.png" alt="What editor(s) do you use when writing Nim?" style="width:100%"/>

The most used editor, expectedly, is VS Code, which is used by 61% of Nim users.
In the second place is Vim/Neovim, followed by Emacs and Sublime Text.
(Note that this is a multiple answer question, and some respondends use more than one editor)



## Nim versions

With version 1.0 released only three months before this survey, we were afraid that we might not get the realistic picture about what Nim version is used the most, because people might have not yet caught up with the latest version.

<img src="{{site.baseurl}}/assets/news/images/survey2019/09.png" alt="Which version(s) of Nim do you use?" style="width:100%"/>

In the end it seems we didn't have to worry: the large majority of users are using the latest stable version (1.0.x).
There are people who use multiple Nim version, but at least one of them is either 1.0.x or the latest devel version.

We can partially attribute this to the mostly painless upgrade process:

<img src="{{site.baseurl}}/assets/news/images/survey2019/10.png" alt="Has upgrading to a new version of the Nim compiler broken your code? How much work did it take to fix it?" style="width:100%"/>



## Using Nim

<img src="{{site.baseurl}}/assets/news/images/survey2019/11.png" alt="Roughly, what percentage of the programming work you do is in Nim?" style="width:100%"/>

This is one of the areas where we should improve.
The majority of users use Nim only sporadically, and only 1/4 of them use Nim for at least half of their programming work.


<img src="{{site.baseurl}}/assets/news/images/survey2019/12.png" alt="What types of software are you developing using Nim?" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/13.png" alt="What platforms are you targeting?" style="width:100%"/>

Nim is mostly used for writing command-line programs and automation/scripts, followed by data processing, libraries, web services, and GUI.
Also, some people use it for game development. (Unfortunately, it wasn't offered as a choice in the survey, people wrote it down in the 'other' field)

The large majority of Nim users are targeting Linux, followed by Windows and macOS.
Most frequent "smaller" targets are JavaScript, Android, web assembly, embedded, and iOS.


<img src="{{site.baseurl}}/assets/news/images/survey2019/14.png" alt="Do you use Nim at work?" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/15.png" alt="If you are not using it at work yet, do you plan to in 2020?" style="width:100%"/>

About 1/3 of Nim users use it at work, either exclusively (6.6%) or from time to time (30.1%).

Of people who don't use Nim at work, 1/3 can't use it because their company doesn't allow it.
Of the remaining 2/3 people who are allowed to use Nim at work, the large majority plan to use it in 2020.

People mention stability, better tooling, more 3rd party libraries, having to mature, and better documentation as the main fields where Nim has to improve to be more accepted in their companies.



## Learning Nim

<img src="{{site.baseurl}}/assets/news/images/survey2019/16.png" alt="How difficult did you find learning Nim?" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/17.png" alt="What learning resources, if any, did you use to learn Nim?" style="width:100%"/>

People find Nim easy to learn, with only 3% of respondents feeling that learning Nim is hard or very hard.
Almost all of them have read the official tutorials, about half of them have read "Nim by Example" and/or "Nim in Action" book.
Rosetta code examples are also a popular choice as a learning resource, followed by "Nim Basics", "Nim Notes", and "Nim Days".


<img src="{{site.baseurl}}/assets/news/images/survey2019/18.png" alt="What kind of learning materials does Nim need?" style="width:100%"/>

If anyone would like to create some more learning materials for Nim (which is very high on the community priority list, see below under "Nim in 2020 and beyond" section), the most wanted fields are code examples and written tutorials.



## Nim community and contributions

<img src="{{site.baseurl}}/assets/news/images/survey2019/19.png" alt="Have you made code contributions to the Nim project in the past?" style="width:100%"/>

There is an equal amount of people who are regular contributors (they contributed in the past and will continue to do so in the future) and people who have no plans of contributing.
The most interesting stat is that, compared to the current contributors, there are three times more people who haven't contributed to Nim so far but plan to do that in the future.
We're looking forward to this :)

The most frequent reasons given for not contributing (yet) are: lack of time and lack of skill/experience.



## Nim tools

We've asked you how satisfied you are with the Nim tooling:

<img src="{{site.baseurl}}/assets/news/images/survey2019/29.png" alt="What is your experience with the following tools? [nimble]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/30.png" alt="What is your experience with the following tools? [choosenim]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/32.png" alt="What is your experience with the following tools? [nimsuggest]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/31.png" alt="What is your experience with the following tools? [c2nim]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/33.png" alt="What is your experience with the following tools? [nimpretty]" style="width:100%"/>

Most of our users use Nimble package manager and they are very satisfied by it.
A smaller amount of users picked Choosenim as their way of installing and updating Nim versions, but those who did are quite satisfied with what it has to offer.
People generally like Nimsuggest, even though not as much as the first two tools mentioned.

Nimpretty and C2nim are used less often than other tools, and feelings about them are also positive.



## Nim in 2020 and beyond

### Existing features

How should we prioritise improving the existing situation?

<img src="{{site.baseurl}}/assets/news/images/survey2019/24.png" alt="What should be our priorities in improving Nim, that would bring the largest quality-of-life improvements? [fixing compiler bugs]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/20.png" alt="What should be our priorities in improving Nim, that would bring the largest quality-of-life improvements? [documentation]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/28.png" alt="What should be our priorities in improving Nim, that would bring the largest quality-of-life improvements? [more learning materials (tutorials, videos, books, ...)]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/23.png" alt="What should be our priorities in improving Nim, that would bring the largest quality-of-life improvements? [fixing stdlib bugs]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/21.png" alt="What should be our priorities in improving Nim, that would bring the largest quality-of-life improvements? [larger standard library]" style="width:100%"/>

* fixing compiler bugs: According to the votes, this should be our first priority; 55% find it very important, with only 19% of votes for ok or low priority.

* more learning materials and documentation improvements: Although in 2019 we improved the documentation of the most used standard library modules, the users not only think there is room for more improvement, but they also think that this should be one of our top priorities. Similar results are seen for learning materials, where we mostly lean on the community content --- for this to improve we need your involvement --- people want to see more written tutorials and code examples.

* fixing standard library bugs and larger standard library: Fixing bugs in the existing standard library modules is a higher priority than expanding the standard library.



### New features

When it comes to the proposed new features, it is expected to see less enthusiasm than for improving the existing situation (fixing bugs, improving documentation) as most people, except few regulars on our community channels, are not properly informed about them and/or they might not know that they could also benefit from them.

<img src="{{site.baseurl}}/assets/news/images/survey2019/25.png" alt="What should be our priorities in improving Nim, that would bring the largest quality-of-life improvements? [incremental compilation]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/26.png" alt="What should be our priorities in improving Nim, that would bring the largest quality-of-life improvements? [non-nilable types]" style="width:100%"/>
<img src="{{site.baseurl}}/assets/news/images/survey2019/27.png" alt="What should be our priorities in improving Nim, that would bring the largest quality-of-life improvements? [atomic ref-counting]" style="width:100%"/>

We also take the blame for not communicating properly what each of these features would bring to Nim world.
For example, we're currently working on `--gc:arc` which, in our opinion, should make Nim both faster and more memory efficient, and as such it might become "one memory management to rule them all".
But at the time the survey was created, the work on it has just started and the benefits of it were unknown to the most of our users.



## Last words

Thank you to each and every one of you who took the time to answer this survey. Your time is precious and we are deeply thankful that you used it to share your feedback.

Please remember that you do not need to wait for a survey in order to give us feedback, of course you’re more than welcome to wait if you wish, but ideally share your feedback with us immediately. We can be found in various different places, see [the community page](https://nim-lang.org/community.html) for links and instructions on how to get in touch.
