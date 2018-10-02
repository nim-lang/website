
---
title: "Creating a simple macro 2nd part"
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

## Creating a macro for a state machine

This time we will be building a state machine. Macros can be useful here in
order to write cleaner code that is easier to understand. At first we will
develop a macro that creates a state transition table. Then we will expand on
this to generate states machines that also run faster.

When designing a macro you will be frequently stopped because `dumpTree`
can't parse the syntax you hoped for.
The [manual](https://nim-lang.org/docs/manual.html#macros) explains what types
of macros are possible. In this example you could be tempted to go for an
expression-based style like: `let stateTransitions = sparse: ...`. The
following results in an easier to write macro and maybe more efficient
generated code:

```nim
  var stateTransitions: StateTransitionsArray

  sparse(stateTransitions): [
    Idle: [CardInsert: insertCardHandler],
    CardInserted: [PinEnter: enterPinHandler],
    PinEntered: [OptionSelection: optionSelectionHandler],
    OptionSelected: [AmountEnter: enterAmountHandler],
    AmountEntered: [AmountDispatch: amountDispatchHandler]]
```

The `expect-` procs are handy to check that the code passed, follows our
specification. Which needs to be strict, or else we would have to write checks
for all the different cases.

```nim
macro sparse(table, data: untyped): untyped =
  template insert(table, state, event, handler): untyped =
    table[state][event] = handler
  result = newStmtlist()
  expectKind(data[0], nnkBracket)
  for n in data[0]:
    expectKind(n, nnkExprColonExpr)
    expectKind(n[1], nnkBracket)
    for m in n[1]:
      expectKind(m, nnkExprColonExpr)
      result.add getAst(insert(table, n[0], m[0], m[1]))
```

## A more complex senario

Next we will modify this to produce nested case clauses, instead of the proc pointers
array. For this we need to know, how the case statement is represented in AST.
The documentation in the
[macros module](https://nim-lang.org/docs/macros.html#the-ast-in-nim) can help us.

Our new macro will look like this:

```nim
  var eNextState = Idle
  while true:
    # Read system Events
    let eNewEvent = readEvent()
    cases(eNextState, eNewEvent): [
      Idle: [CardInsert: insertCardHandler],
      CardInserted: [PinEnter: enterPinHandler],
      PinEntered: [OptionSelection: optionSelectionHandler],
      OptionSelected: [AmountEnter: enterAmountHandler],
      AmountEntered: [AmountDispatch: amountDispatchHandler]]
```

A common struggle when writing macros is producing the correct tree.
Here we need to be carefull to append at the last case statement that was
created, else we will produce the wrong AST. Thus inspecting what is done
so far is very important and can be done with `repr`, `treeRepr` and
`lispRepr` procs from the `macros` module.

```nim
macro cases(state, event, table: untyped): untyped =
  result = newStmtlist()
  expectKind(table[0], nnkBracket)
  # top level case state
  result.add nnkCaseStmt.newTree(state)
  for n in table[0]:
    expectKind(n, nnkExprColonExpr)
    expectKind(n[1], nnkBracket)
    expectMinLen(n[1], 1)
    # of state kind with sublevel case event
    result[0].add nnkOfBranch.newTree(n[0], nnkCaseStmt.newTree(event))
    for m in n[1]:
      expectKind(m, nnkExprColonExpr)
      # of event kind with next state assignment
      result[0][^1][1].add nnkOfBranch.newTree(m[0],
        nnkAsgn.newTree(state, nnkCall.newTree(m[1])))
    # sublevel else discard
    result[0][^1][1].add nnkElse.newTree(
      nnkDiscardStmt.newTree(newEmptyNode()))
```

Finally, we confirm with `echo result.repr` that the result is created as expected:

```nim
case eNextState
of Idle:
  case eNewEvent
  of CardInsert:
    eNextState = insertCardHandler()
  else:
    discard
of CardInserted:
  case eNewEvent
  of PinEnter:
    eNextState = enterPinHandler()
  ...
```

# The future of macros

From what we have seen so far macros can become quite complex. Could the creation process
become easier and less error-prone? One idea that is being developed, is writing declarative
code that builds the macro. The nimble library [breeze](https://github.com/alehander42/breeze)
does that. Same code will look like this:

```nim
macro cases(state, event, table: untyped): untyped =
  expectKind(table[0], nnkBracket)
  result = buildMacro:
    caseStmt(state):
      for n in table[0]:
        expectKind(n, nnkExprColonExpr)
        expectKind(n[1], nnkBracket)
        expectMinLen(n[1], 1)
        ofBranch(n[0]):
          ifStmt:
            for m in n[1]:
              expectKind(m, nnkExprColonExpr)
              elifBranch(call(ident"==", m[0], event)):
                asgn(state, call(m[1]))
            `else`:
              discardStmt(empty)
```
Unfortunately the `breeze` module doesn't compile at the time of writing.

Last but not least the
[matchAst](https://github.com/krux02/ast-pattern-matching "Ast Pattern Matching")
macro does AST pattern matching of the passed `NimNode`. 
The beginning of the popular [OOP macro](https://nim-by-example.github.io/macros/)
can be rewritten as:

```nim
macro class(head, body): untyped =
  head.matchAst:
  of nnkInfix(ident"of", `classType`, `baseType`):
    # declare a type here
  of nnkInfix(ident"*", `classType`, nnkPrefix(ident"of", `baseType`)):
    # declare a public type here
  else:
    error("Invalid node: " & head.lispRepr)
  ...
```
