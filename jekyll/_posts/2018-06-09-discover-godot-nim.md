## Discovering Godot and Nim

In my ongoing quest to get better at programming and game development, I stumbled upon [Nim](https://nim-lang.org/) and it was love at first "Hello, World!". Meanwhile a little bird whispered news to me that a cool open-source game engine, called [Godot](https://godotengine.org/), is reaching 3.0 status with a lot of new features, among others a way to include scripting in languages that aren't builtin. Eventually Nim support landed for Godot and I thought it was the perfect time to get started. Here follows my experiences with Nim and learning Godot.

### Enter Nim

```nim
  echo("Hello, World!")
```

As a beginner and hobbyist programmer, Nim was easy to learn but hard to understand. The [main tutorial](https://nim-lang.org/0.18.0/tut1.html) and [book](https://www.manning.com/books/nim-in-action) are excellent starting resources and I could get productive without knowing the inner workings of Nim.
My biggest hurdle was thinking in the procedural programming realm as most beginner resources I read before were OOP-orientated. Once that and Nim's straightforward type system clicked I found myself doing coding challenges and starting up small projects(like an interpreter), instead of browsing StackOverflow to copy-and-paste my solution.
Programming in Nim is fun for me, because of the clear syntax, fast compile times and helpful community. I haven't even gotten to the juicy parts of Nim: metaprogramming!

```nim
# This is my solution for the first Rosalind problem
# also one of the first Nim snippets I wrote
import tables

const input = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGAT"
var symbolCount = initCountTable[char]()

for c in input:
    symbolCount.inc(c, 1)

for k, v in symbolCount:
    stdout.write v, " "
```

#####

### Experimenting with Godot

Now I don't have that much experience with Godot as I've recently started using it. The [current documentation](http://docs.godotengine.org/en/3.0/) the engine provides is great and it covers everything you need to get started making a game.
At first I found Godot quite intimidating(so many bells and whistles!), but browsing through the docs(and google) solved most of my questions. Godot also has an incredible helpful and awesome community, reachable through [multiple channels](https://godotengine.org/community). Open source at it's best.
Thinking in nodes is the first thing I had to learn. Everything in Godot is a node and a tree of nodes make up a scene. Your game could be one scene or multiple scenes, it depends on how you tackle the design of your game. Personally I find it a lot easier to make a project in Godot if I make a rough sketch on paper of all the important nodes in a game and how they work together.

### Godot + Nim = ???

Somewhere halfway I stopped using GDScript and started my journey on figuring out how the hell the [Nim bindings](https://github.com/pragmagic/godot-nim) work. This... wasn't the smartest of choices as there aren't many examples on how to work with the bindings. The [godotnim-stub](https://github.com/pragmagic/godot-nim-stub) is an excellent starting place if you have previous experience, but as a beginner I was continously searching for hints, even looking through other GDNative bindings trying to find a way to do something which is so simple in GDScript. Looking back I definitely would be more productive in GDScript and I'd understand Godot alot better.
_But!_ I did finish 2 small samples following the ["Your first game"](http://docs.godotengine.org/en/3.0/getting_started/step_by_step/your_first_game.html) tutorial and a [Conways Game of Life](http://www.brainjargames.com/game-of-life/) post using Nim instead of GDScript. Using types made things a lot clearer in code and I learned the awesome feeling of tackling a problem that might seem impossible to figure out at first, but to which the answer is so simple once solved.
For those who are also keen to try Nim with Godot, I'd say take a look at the stub project and the api the bindings generate. My experience following the GDScript focused tutorials with Nim was that it all translates pretty well. Nim compiles so fast that I didn't find myself growing tired of the compile script -> press f5 in godot cycle.

```nim
import godot
import animation_player, control

type
  CellKind* {.pure.} = enum # the asterisk means it's exported
    Living
    Dead

gdobj Cell of Control:
  var kind: CellKind
  var x*, y*: int
  var anim: AnimationPlayer

  method ready*() =
    anim = getNode("AnimationPlayer").as(AnimationPlayer)

  proc initTile*(x,y: int) =
    self.x = x
    self.y = y

  proc setKind*(kind: CellKind) =
    self.kind = kind
    case kind:
    of CellKind.Living:
      anim.play("Living")
    of CellKind.Dead:
      anim.play("Dead")

  proc getKind*(): CellKind =
    kind
```

##### A lot of thanks to @endragor, one of the maintainers of the plugin for answering my often stupid questions

`gdobj` is the macro goodness that makes extending a node so easy. Declaring fields, properties and methods all happen inside it. Once compiled slap it on as a `NativeScript` and add your `nimlib.gdnlib` . I wrote the game of life sample first and then worked on the Dodge the Creeps project, the second time my workflow was _a lot_ faster. Hurray learning and doing!
And everything you can do in GDScript you can do with Nim. Nim is also really fast.
One thing I really did struggle with was registering a signal and emitting signals. I found the concept confusing reading about it but in GDScript it's a simple `signal foo`. For those who care in Nim you register a signal and emit a signal like this:

```nim
gdobj Foo of Node2D:
   method init():
       addUserSignal("Nim Rocks!") #register a signal
       emitSignal("Godot Rocks!") #emit a signal
```

### Closing sentiments

If you want to look at my _ahem_ work of art you can check it out **[here](http://docs.godotengine.org/en/3.0/getting_started/step_by_step/your_first_game.html#finishing-up).**
Godot and Nim are both wonderful open source and community driven projects. I thoroughly enjoyed using them and using them together. As a beginner I didn't take the smartest route but I was more productive(and learned a heck more) in 2 weeks than I was following another Unity/Unreal course about how to make a ball bounce. So don't be afraid to jump in the pool!
