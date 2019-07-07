---
title: "Creating a simple macro"
author: Antonis Geralis
excerpt: "Nim is a powerful programming language that supports
metaprogramming using macros. Though a lot of Nim programmers are unaware of
their merits due to lack of learning resources. The first part of
this series will discuss the use of macros to simplify the creation of
boilerplate code in Nim."
---

<div class="sidebarblock">
  <div class="content">
    <div class="title">Guest post</div>
    <div class="paragraph">
      This is a guest post by Antonis Geralis. If you would like to publish 
      articles as a guest author on nim-lang.org then get in touch with us via
      <a href="https://twitter.com/nim_lang">Twitter</a> or
      <a href="https://nim-lang.org/community.html">otherwise</a>.
      You can also just create a PR like
      <a href="https://github.com/nim-lang/website/pull/90">this author did</a>.
    </div>
  </div>
</div>

Hello, as you might know Nim is a powerful programming language that supports
metaprogramming using macros. Though a lot of Nim programmers are unaware of
their merits due to lack of learning resources. The first part of
this series will discuss the use of macros to simplify the creation of
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

However I would like to use an operator with a nice syntax, like: ``"Boston" -> "Providence"``
A template could do so too here, but I want to show how macros work.

<div class="sidebarblock">
  <div class="content">
    <div class="paragraph">
      <q>Macros can be used to implement domain specific languages.</q><br>
      <i>&mdash;From the Nim <a href="http://nim-lang.org/docs/manual.html">manual</a>.</i>
    </div>
  </div>
</div>

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
      # the AST manually
      result.add getAst(adder(head, n[1], n[2]))
```

This macro is incomplete however, it doesn't replace nested usages of ``->``. 
We would like to replace -> anywhere in the passed body, so let's use recursion
with the help of a helper called ``graphDslImpl``.

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

That's it for now. This first article shows how to structure procedures
that transform the Nim AST and how to then use them in a macro. Later posts
will look at more advanced macro usage.

<div class="sidebarblock">
  <table>
  <tr>
  <td class="icon">
    <i class="fa fa-book-open" title="Exercise"></i>
  </td>
  <td class="content">
    <div class="title">Exercise</div>
    <div class="paragraph">
      There is an undirected edge in the <code>buildCityGraph</code> proc. Can you
      add another operator (i.e. <code>"Boston" -- "Providence"</code>) that takes care of it?
    </div>
  </td>
  </tr>
  </table>
</div>
