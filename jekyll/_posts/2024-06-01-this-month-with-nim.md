---
title: "This Month with Nim: October 2023 to June 2024 (It is a long month)"
author: The Nim Community
excerpt: "It has been a long time since one of these!"
---


## [Oolib Upgrade](https://github.com/Glasses-Neo/OOlib)

#### Author: [Neo](https://github.com/glassesneo)

New super cool features here!
### Multiple constructor
```nim
class Gun:
  var
    offence: int
    capacity = 6
    price: int

  proc `new`(offence: int) =
    self.offence = offence
    self.capacity = 8
    self.price = 300

  proc `new`(capacity: int) =
    self.offence = 14
    self.capacity = capacity
    self.price = 200

# This `new()` is made from the type definition
let _ = Gun.new(offence = 5, price = 6)

# 2nd one
let _ = Gun.new(offence = 12)

# 3rd one
let _ = Gun.new(capacity = 10)

class Sword:
  var
    offence: int
    price {.initial.} = 100

# made from the type definition
let _ = Sword.new(8)
```
### `{.construct.}`
a type definition with {.construct.} are made into a class. Now that we can define a class without using `class`!
```nim
type Shield {.construct.} = ref object
  defence*: int
  price {.initial.}: int = 100

# This new() was made by `{.construct.}` pragma
let _ = Shield.new(4)
```

### Multiple implementation
Now we can use multiple implementation!
```nim
protocol Readable:
  var text: string

protocol Writable:
  var text: string
  proc `text=`(value: string)

protocol Product:
  var price: int

type Writer* {.protocoled.} = tuple
  write: proc(text: string)

class Book impl (Readable, Product):
  var
    text: string = ""
    price: int

class Diary impl (Readable, Writable, Product):
  var text {.initial.}: string = ""
  var price: int
  proc `text=`(value: string) =
    self.text = value

class HTMLWriter impl Writer:
  var writable: Writable
  proc write(text: string) =
    self.writable.text = text

let book = Book.new(price = 500)

let _ = book.toProtocol()

let diary = Diary.new(price = 300)

let _ = diary.toProtocol()
```

Also, the features below were removed:
+ Class data constant
+ Inheritance class, super keyword and {.open.}
+ Alias class
+ {.pClass.}, {.pProtocol.}
+ {.noNewDef.} for class


## [Nim Blinky with Apache NuttX RTOS on Ox64 BL808 RISC-V SBC](https://lupyuen.codeberg.page/articles/nim.html)

#### Author: [Lup Yuan Lee](https://github.com/lupyuen)

Running Apache NuttX RTOS (Real-Time Operating System) on Single-Board Computers with plenty of RAM.
Like Pine64 Ox64 BL808 SBC with 64 MB RAM!

In this article, we create a Blinky LED app with Nim on NuttX.
Garbage-Collected Languages (like Nim) require a bit more RAM than Low-Level Languages (like C).
Perfect for our roomy (and vroomy) single board computer!
We test NuttX + Nim Blinky on QEMU Emulator for 64-bit RISC-V (minus the blinkenlight)
Then we run NuttX + Nim Blinky on the Ox64 BL808 RISC-V SBC (with a real LED)


## happyx-ui

#### Author: [Ethosa](https://github.com/Ethosa)

UI library for the HappyX web framework, inspired by Jetpack Compose.

A small code exmaple follows:
<p style="text-align: center;">
  <img width="auto" height="600" src="{{ site.url }}{{ site.baseurl }}/assets/thismonthwithnim/2024-06/happyx-ui-code.png">
</p>

<p style="text-align: center;">
  <img width="auto" height="600" src="{{ site.url }}{{ site.baseurl }}/assets/thismonthwithnim/2024-06/happyx-ui.png">
</p>
A live demo can be found [here](https://hapticx.github.io/happyx-ui/#/)

----


## Want to see your project here next month?

[Follow this](https://github.com/beef331/website#adding-your-project-to-month-with-nim)
to add your project to the next month's blog post.
