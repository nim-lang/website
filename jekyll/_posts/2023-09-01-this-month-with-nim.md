---
title: "This Month with Nim: July and August 2023"
author: The Nim Community
excerpt: "Webdev, webdev, webdev, and a backup program!"
---


## [HappyX](https://github.com/HapticX/HappyX)

#### Author: [ethosa](https://github.com/Ethosa)

Happyx is a macro-oriented full-stack web framework that combines frontend and backend features.

With HappyX you can write single page applications (SPA),
static site generation (SSG),
and server side rendering (SSR) web applications.

It provides the same syntax for all of these solutions:

```nim
import happyx

serve("127.0.0.1", 5000):
  "/":
    "Hello, world!"
```

```nim
import happyx

appRoutes("app"):
  "/":
    "Hello, world!"
```

Included is a command line interface `hpx`.
This enables easy creation of projects for Nim and Python.

A non exhaustive list of features is as follows:
- Multiple server options (built-in asynchttpserver, microasynchttpserver, httpbeast and httpx)
- Hot code reloading (now only for SPA)
- Debug logging with -d:debug
- Powerful routing that includes path params with validation and mounting
- Request models (see pydantic with fastapi from Python)
- Components (fully supported only in SPA)
- Event handlers (supported only in SPA)
- buildHtml, buildStyle and buildJs macros
- Automatically generated RestAPI Documentation
- .hpx files to writing components imperative/declarative
- VS Code extension to write projects more effectively
- Python bindings


## [Sauer](https://github.com/moigagoo/sauer)

#### Author: [moigagoo](https://github.com/moigagoo)

Sauer is a command-line tool that helps set up Karax projects and add new pages and routes to them.
Sauer uses [Kraut](https://github.com/moigagoo/kraut) for routing and offers a sane default app structure where each page is a separate module.
The routes are defined in `routes.nim` and the global state is just a module name `state.nim`.
Simple as that.
It automatically adds the necessary dependencies and useful tasks to your nimble file and even ships with a simple static server to serve your app locally for development.
Install Sauer with `nimble install sauer` and run `sauer --help` to see the available commands.
Sauer is powered by [Climate](https://github.com/moigagoo/climate).

## [EZ Bkup](https://ezbkup.app)

#### Author: ITwrx

### The easiest backup program on earth!

EZ Bkup is a data backup program for the desktop, striving to be as quick and easy to use, as possible.
EZ Bkup is a graphical frontend for [Rsync](https://rsync.samba.org/),
built with [Owlkettle](https://github.com/can-lehmann/owlkettle) and [GTK](https://www.gtk.org/),
written in Nim.
EZ Bkup currently runs on Linux distributions,
and expects rsync (3.2.4+) and polkit to be installed.

### Respects Your Time
- Zero configuration/settings required.
- Zero Rsync knowledge required.
- Create Backup Routine(s) and run on-demand.
- Fast: Only copies what has changed since last time.

### Respects your Freedom
- EZ Bkup source code is released under the [GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html).
- No [DRM](https://www.gnu.org/proprietary/proprietary-drm.en.html).

### Respects your Privacy
- No [Telemetry](https://www.gnu.org/proprietary/proprietary-surveillance.en.html).
- Does not beam your data back to the mothership.

If you've been reluctant to backup your data on a regular basis, or at all,
because you didn't want to learn/configure a backup program,
read a man page and use a command line program, or deal with the slow and tedious process of copying and pasting disparate folders/directories,
we understand.
That's why we created EZ Bkup for ourselves,
and are happy to share it with you!
Thank You for supporting the development of ethical software! 

A special thanks to Nim for rekindling the fun of programming, and making it easier to create programs that are more correct and efficient!

## [Karkas](https://github.com/moigagoo/karkas)

#### Author: [moigagoo](https://github.com/moigagoo)

Karkas is a library that makes creating web sites with Karax a bit more pleasant.
It offers a bunch of styles to build layouts and some syntactic sugar to save you typing.

Karkas allows you to create complex layouts by combining basic primitives.
It also offers a clean syntax for style combination,
which lets you write clear code and be obvious about your intentions as a programmer.

For example,
you can write something like this: `tdiv(style = hStack() <- box(2) <- {border: "solid"})`.
Which means there's a vertical stack which is in turn a box of size 2 inside another container,
with a solid border.

Find the official tutorial at https://karkas.nim.town.

----


## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
