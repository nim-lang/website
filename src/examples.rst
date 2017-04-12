Examples
========

.. container:: pure-g
  .. container:: pure-u-1 pure-u-md-13-24 example-text example-text-left

      Nim is simple, yet fast
      -----------------------

      Nim was designed from the ground up to be simple, yet powerful. Forget
      about pointers and manual memory management*, Nim's threaded garbage
      collector will automatically ensure that your code keeps its memory
      footprint low. Even though it has the benefits of an interpreted
      language, as a compiled language, Nim can achieve very high performance
      when optimized, sometimes on par with C or C++.

      `* Can still be done manually if needed.`:sub:

  .. container:: pure-u-1 pure-u-md-11-24

    .. code-block:: nim
      # Compute average line length
      var
        sum = 0
        count = 0

      for line in stdin.lines:
        sum += line.len
        count += 1

      echo("Average line length: ",
        if count > 0: sum / count else: 0)

--------------------------------------------------------------------------

.. container:: pure-g
  .. container:: pure-u-1 pure-u-md-11-24

    .. code-block:: nim

      # Create and greet someone
      type Person = object
        name: string
        age: int

      proc greet(p: Person) =
        echo "Hi, I'm ", p.name, "."
        echo "I am ", p.age, " years old."

      let p = Person(name: "Jon", age: 18)
      p.greet() # Or greet(p)

  .. container:: pure-u-1 pure-u-md-13-24 example-text example-text-right

    Nim is type safe
    ----------------

    There is growing empirical evidence that static type checking improves
    productivity and robustness at the same time. Nim goes one step further
    than static typing, also giving you an effect system which can be used
    to ensure the freedom of deadlocks at compile-time!

-----------------------------------------------------------------------

.. container:: pure-g
  .. container:: pure-u-1 pure-u-md-13-24 example-text example-text-left

    Nim plays well with others
    --------------------------

    Nim is interoperable with C and C++, which means you can not only call
    C or C++ code if needed, but also leverage the power of existing
    libraries such as GTK+, libui, SDL, SFML and many more.

  .. container:: pure-u-1 pure-u-md-11-24

    .. code-block:: nim
      # Declare a C procedure...
      proc unsafeScanf(f: File, s: cstring)
        {.varargs, importc: "fscanf",
          header: "<stdio.h>".}

      # ...and use it...
      var x: cint
      stdin.unsafeScanf("%d", addr x)


------------------------------------------------------------------------


.. container:: pure-g
  .. container:: pure-u-1 pure-u-md-11-24
    .. code-block:: nim
      # A simple html server
      import
        jester, asyncdispatch, htmlgen

      routes:
        get "/":
          resp h1("Hello world")

      runForever()

  .. container:: pure-u-1 pure-u-md-13-24 example-text example-text-right

    Nim for Web developers
    ----------------------

    Using the Sinatra-like `Jester <https://github.com/dom96/jester>`_
    Web framework, Nim makes it easy to quickly create Web applications.

.. raw:: html
  <section class="background-faded call-to-action">
    <section class="content text-centered">
      <h2>Ready to discover Nim?</h2>
      <a class="pure-button pure-button-primary" href="download.html">Download</a>
    </section>
  </section>
