
---
title: "Advanced macro technics"
author: Antonis Geralis
---

<div class="sidebarblock">
  <div class="content">
    <div class="title">Guest post</div>
    <div class="paragraph">
      This is a guest post by Antonis Geralis. If you would like to publish 
      articles as a guest author on nim-lang.org then get in touch with us via
      <a href="https://twitter.com/nim_lang">Twitter</a> or
      <a href="https://nim-lang.org/community.html">otherwise</a>.
    </div>
  </div>
</div>

# Advanced macro technics

Hello there, in this part we explore more useful paradigms for programming
Nim macros. For this purpose we will take the already established
[OOP macro](https://nim-by-example.github.io/oop_macro/) and adapt it to
our requirements.

The OOP macro provides some convenience when writing classes in Nim.

```nim
class Animal of RootObj:
  var age: int # variables get turned into fields of the type.
  method vocalize {.base.} = echo "..." # `self: T` injected into the arguments
  proc `$`: string = "animal:" & $self.age

class Person of Animal:
  var name: string
  proc newPerson(name: string, age: int) = # overwrite the return type of the constructor
    result = Person(name: name, age: age)
  method vocalize = echo "Hey"
  proc `$`: string = "person:" & self.name & ":" & $self.age
```

Lets apply the same recursive algorithm to transform the passed body. You can
side-by-side compare the two implementations to see what's changed.

```nim
proc transform(node: NimNode, b: ClassBuilder): NimNode =
   case node.kind
   of nnkMethodDef, nnkProcDef:
      if node.name.kind != nnkAccQuoted and eqIdent(node.name.basename, b.ctorName):
         node.params[0] = typeName
      else:
         node.params.insert(1, newIdentDefs(ident("self"), b.typeName))
      # return the transformed node
      result = node
   of nnkVarSection:
      node.copyChildrenTo(b.recList)
      # since nothing is returned, result is a None node
      result = newNimNode(nnkNone)
   else:
      result = copyNimNode(node)
      for n in node:
         let x = transform(n, b)
         # filter out nodes of None kind
         if x.kind != nnkNone: result.add(x)
```

But first, we have introduced a new type that holds the context of the class.
It is passed to the recursive helper and, in the case of field ``recList``,
acts as an out parameter or passes down necessary variables.

```nim
type
   ClassBuilder = ref object
      typeName, baseName, recList: NimNode
      ctorName: string
```

Lastly rest of the class macro. Not much to explain here, except that ``NimNode``
is a reference type, so altering the alias, also affects the original.

```nim
macro class(head, body): untyped =
  let b = ClassBuilder()

  var isExported = false
  if head.kind == nnkInfix and head[0].ident == !"of":
    b.typeName = head[1]
    b.baseName = head[2]
  elif head.kind == nnkInfix and $head[0] == "*" and
      head[2].kind == nnkPrefix and $head[2][0] == "of":
    b.typeName = head[1]
    b.baseName = head[2][1]
    isExported = true
  else:
    error "Invalid node: " & head.lispRepr

  template declare(a, b): untyped =
    type a = ref object of b

  template declarePub(a, b): untyped =
    type a* = ref object of b

  let typeDecl =
    if isExported:
      getAst(declarePub(b.typeName, b.baseName))
    else:
      getAst(declare(b.typeName, b.baseName))

  # this alias is modified later by the ``transform`` helper
  b.recList = newNimNode(nnkRecList)
  typeDecl[0][2][0][2] = b.recList

  b.ctorName = "new" & $b.typeName

  result = newStmtList(typeDecl, transform(body, b))
  # echo result.treeRepr
```

And that's it. In the second article we learned how to use a simple
``ref object`` to retain information in the recursion.
