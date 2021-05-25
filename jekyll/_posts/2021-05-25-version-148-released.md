---
title: "Version 1.4.8 released"
author: The Nim Team
---

The Nim team is happy to announce version 1.4.8, our fourth patch release for
Nim 1.4.

Version 1.4.8 is a result of one month of hard work, and it contains
[23 commits](https://github.com/nim-lang/Nim/compare/v1.4.6...v1.4.8),
fixing the most important bugs and bringing additional improvements to our
ORC memory management.

We would recommend to all of our users to upgrade and use version 1.4.8.


## Release highlights

* Just like our `devel` branch, v1.4.8 is built using `csources_v1`, which means
  you can use it on **Apple M1** chips.
* Version 1.4.6 triggered some false positives with several antivirus softwares.
  Based on our testing, this shouldn't happen with v1.4.8.
* Now you can use `-d:release` and `-d:danger` in your config files,
  no need to manually write these flags on the command line anymore.
* Additional improvements to our ORC memory management.
  Use `--gc:orc` to compile your projects with it.




# Installing Nim 1.4


## New users

Check out if the package manager of your OS already ships version 1.4.8 or
install it as described [here](https://nim-lang.org/install.html).


## Existing users

If you have installed a previous version of Nim using `choosenim`,
getting Nim 1.4.8 is as easy as:

```bash
$ choosenim update stable
```

Alternatively, you can download Nim 1.4.8 from
[our nightlies builds](https://github.com/nim-lang/nightlies/releases/tag/2021-05-25-version-1-4-44e653a9314e1b8503f0fa4a8a34c3380b26fff3).




# Donating to Nim

We would like to encourage you to donate to Nim.

The donated money will be used to further improve Nim:
- Bugs need to be fixed, the documentation can be improved, compiler error
  messages can always be better.
- The most exciting upcoming feature, that has the greatest impact to all
  of our users, is [incremental compilation](https://github.com/nim-lang/RFCs/issues/46).
- Incremental compilation will also be the foundation for further tooling
  improvements like `nimsuggest` (autocompletion, find usages).


You can donate via:

* [Open Collective](https://opencollective.com/nim)
* [Patreon](https://www.patreon.com/araq)
* [PayPal](https://www.paypal.com/donate/?cmd=_s-xclick&hosted_button_id=FLWX5V2PMAXAU)

If you are a company, we also offer commercial support.
Please get in touch with us via `support@nim-lang.org`.
As a commercial backer, you can decide what features and bugfixes should
be prioritized.



# Bugfixes

- Fixed "Asynchttpserver example doesn't work"
  ([#16506](https://github.com/nim-lang/Nim/issues/16506))
- Fixed "AsyncHttpClient doesn't handle errors"
  ([#16436](https://github.com/nim-lang/Nim/issues/16436))
- Fixed "OpenSSL 1.0.x library naming issue on windows "
  ([#17755](https://github.com/nim-lang/Nim/issues/17755))
- Fixed "Compiler warning on mismatching case/spelling"
  ([#15848](https://github.com/nim-lang/Nim/issues/15848))
- Fixed "`db_postgres` does not sanitize `%00` resulting in crash"
  ([#17925](https://github.com/nim-lang/Nim/issues/17925))

Full changelog since v1.4.6 contains [23 commits](https://github.com/nim-lang/Nim/compare/v1.4.6...v1.4.8).
