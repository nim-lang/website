
---
title: "Create a simple macro"
author: Antonis Geralis
---

Hello, as you might know Nim is a powerful programming language that supports
metaprogramming using macros. Though a lot of Nim programmers are unaware about
the merits of them due to lack of learning resources. In the first part of
this series we will discuss the use of macros to simplify the creation of
boilerplate code in Nim.

Suppose we have code which builds a directed graph.

```nim
  proc buildCityGraph(): Digraph =
    result = initGraph()
    result.addEdge(initEdge(initNode("Boston"), initNode("Providence")))
    result.addEdge(initEdge(initNode("Boston"), initNode("New York")))
    result.addEdge(initEdge(initNode("Providence"), initNode("Boston")))
    result.addEdge(initEdge(initNode("Providence"), initNode("New York")))
    ...
```

A template could be used to reduce the amount of typing. For example:

```nim
   template adder(graph, src, dest): untyped =
      graph.addEdge(initEdge(initNode(src), initNode(dest)))
```

However it needs to be called each time with all three arguments. This excludes
the possibility of using an operator with a nice syntax. Although operators can
have more than two parameters, we are limited into calling them like
this: `` `->`(result, "Boston", "Providence") ``. A macro, however can be used
to create a simpler and more appealling syntax.

> Macros can be used to implement domain specific languages.
[*From the Nim manual.*](https://nim-lang.org/docs/manual.html#macros)

To begin, this is how calling our macro will look like:

```nim
  proc buildCityGraph(): Digraph =
    result = initGraph()
    edges(result):
      "Boston" -> "Providence"
      "Boston" -> "New York"
      "Providence" -> "Boston"
      "Providence" -> "New York"
      ...
```

We can pass the body of this unfinished macro to ``dumpTree`` to better
understand how it will work.

```
StmtList
  Infix
    Ident "->"
    StrLit "Boston"
    StrLit "Providence"
  Infix
    Ident "->"
    StrLit "Boston"
    StrLit "New York"
  ...
```

A working first version looks like this:

```nim
macro edges(head, body: untyped): untyped =
  template adder(graph, src, dest): untyped =
    graph.addEdge(initEdge(initNode(src), initNode(dest)))

  # Create a NimNode of kind nnkStmtList for the result
  result = newStmtList()
  for n in body:
    # Check if it is an Infix NimNode with the operator
    # we look to implement.
    if n.kind == nnkInfix and $n[0] == "->":
      # we pass the template to getAst to avoid constructing
      # the AST manualy
      result.add getAst(adder(head, n[1], n[2]))
```

What is important to understand now is that, while we are done, procedurally
modifying an AST is not the correct solution. It is a tree after all. Also it
will fail if we come up with more complicated syntax. Instead we implement
recursion with the help of an anonymous procedure.

```nim
  proc graphDslImpl(head, body: NimNode): NimNode =
    template adder(graph, src, dest): untyped =
      graph.addEdge(initEdge(initNode(src), initNode(dest)))

    if body.kind == nnkInfix and $body[0] == "->":
      result = getAst(adder(head, body[1], body[2]))
    else:
      # copyNimNode instead of newStmtList to makes sure
      # a parent node is created with the correct kind.
      result = copyNimNode(body)
      for n in body:
        result.add graphDslImpl(head, n)
```

Finally our macro is declared:

```nim
  macro edges(head, body: untyped): untyped =
    result = graphDslImpl(head, body)
    echo result.treeRepr # let us inspect the result
```

From making this simple macro we can take away how to structure procs that
transform the Nim AST.

> **Bonus excersise** In the ``buildCityGraph`` proc we see there is an undirected edge.
> Can you add another operator (i.e. ``"Boston" -- "Providence"``) that takes care of it?
