---
title: "Version 1.0 released"
author: The Nim Team
excerpt: "The Nim Team is very proud and happy to announce the much-anticipated version 1.0 of the language."
---


Today is the day. The Nim Team is very proud
and happy to announce the much-anticipated version 1.0 of the language.

Nim has always been focused on providing a compiled statically typed language
focusing on efficiency, readability and flexibility.

Version 1.0 marks the beginning of a stable base which
can be used in the coming years, knowing that the future versions of Nim won't
break the code you have written with the current version.

Nim has built a warm and welcoming [community](https://nim-lang.org/community.html)
which is ready to help newcomers to the language.

If you are one of the new users, check out our
[learning resources](https://nim-lang.org/learn.html) and try Nim in
[our playground](https://play.nim-lang.org/).



# The stability guarantee

Version 1.0 is now a long-term supported stable release that will only
receive bug fixes and new features in the future, as long as they don't
break backwards compatibility.

The 1.0.x branch will receive bug fixes for as long as there is demand for them.
New features (which do not break backwards compatibility) will continue in
steadily advancing 1.x branches.

Our goal is to make sure that code which compiled under Nim 1.0 continues to
compile under any stable Nim 1.x version in the future.


## What is included under the stability guarantee?

Backwards compatibility covers only the stable fragment of the language,
as defined by the [manual](https://nim-lang.org/docs/manual.html).

The compiler still implements experimental features which are documented in the
["experimental manual"](https://nim-lang.org/docs/manual_experimental.html).
These features are subject to changes which may be backwards incompatible;
some of the features included under this umbrella are concepts,
the `do` notation and a few others. There are also modules in the stdlib
which are still considered unstable - these have been marked with an
"Unstable API" in their docs.

You can use experimental features, even in production, but be aware that
these are not as fleshed out as we would like them to be.

The standard library is also covered, as long as the module in question
is clearly marked with a v1.0 tag in its documentation.


## Exceptions to the rule

We of course have to concede that there are exceptions.
In certain serious cases, for example if a security vulnerability is
discovered in the standard library, we reserve the right to break code which
uses it.



# Installing Nim 1.0

## New users

Check out if the package manager of your OS already ships version 1.0 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.0 is as easy as:

```bash
$ choosenim update stable
```



# Contributors

Over the years, more than 500 people contributed to the Nim codebase,
implementing new features, fixing bugs and issues, writing documentation, and
so on.
The Nim team would like to thank all of you who helped us build Nim to become
what it is today.

We would also want to thank all people who have created Nimble packages,
extending what is possible to do with Nim.
The number of Nimble packages has been steadily growing, and in August 2019 we
broke the 1000 package milestone!
We are optimistic that with this release we will see even bigger growth of
new and exciting packages.
