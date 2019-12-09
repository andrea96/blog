
From Brainfuck to Python bytecode
=================================

.. post:: Aug 27, 2019
   :tags: python, compiler, bytecode, brainfuck
   :category:

.. role:: py(code)
   :language: python


.. note::
   When I wrote this post (and the script) the last Python version was 3.7, due
   of its low-level nature, the program no longer works with newer versions.
   However it should be simple to update it (starting from, for example,
   changing the magic number) or even better, using `this library
   <https://pypi.org/project/bytecode/>`_.

   
About one month ago I wrote this_ simple transpiler from Brainfuck_ to Python
bytecode. I'm going to assume you already can "program" in Brainfuck, otherwise
I advise you to read the `dedicated page on Esolang`_, in my opinion the best
place to learn about the language. I'm also assuming that you have a minimal
knowledge about `stack machines`_, personally I only used them as a theorical
objects during some proofs. I learned to use them as a real software only during
the creation of this transpiler.

Understanding how to do all of this was not easy because the Python virtual
machine is a moving target, I worked with Python 3.7 and I think my program
should work with Python 3.6+. The best places to understand how the things work
under the hood is the official `dis module documentation`_. and `this source`_
directly from the Python source code. I recommend to take a look at the first
link and to use the second one only for consultation.

I suggest to keep an eye on the source of the program while reading this post.

In the first part of the program there are some imports and the initialization
of the `cli parser`_, the interesting part starts with the :py:`parse` function.

.. _this: https://gist.github.com/andrea96/913aa9667d89af8e2ab45e99e557c2aa
.. _Brainfuck: https://en.wikipedia.org/wiki/Brainfuck
.. _`dedicated page on Esolang`: https://esolangs.org/wiki/Brainfuck
.. _`stack machines`: https://en.wikipedia.org/wiki/Stack_machine
.. _`dis module documentation`: https://docs.python.org/3.7/library/dis.html
.. _`this source`: https://github.com/python/cpython/blob/master/Python/ceval.c
.. _`cli parser`: https://docs.python.org/3.7/library/argparse.html

.. gistlines:: 913aa9667d89af8e2ab45e99e557c2aa
   :footer: false
   :lines: 50-88

That function creates the abstract syntax tree, which is a bit overkill as word
because it simply returns a list of lists where the elements can be "[", "]",
",", ".", "<", ">" or an integer in the interval 0-255. This procedure ignores
any character that isn't one of the standard 8 brainfuck commands and
automatically simplify the successions of "+" and "-" in a number modulo 256. It
would be possible to simplify also "<" and ">" but I was too lazy.

The :py:`visit` function simply depth visits the abstract syntax tree applying
the visitor function for every element of the tree.

.. gistlines:: 913aa9667d89af8e2ab45e99e557c2aa
   :footer: false
   :lines: 90-95

Then it's created a :py:`bytearray` object called :py:`instructions` containing
some instructions for the stack machine (every instruction is 2 bytes long),
that part is mandatory for every programs that the compiler generates, basically
it contains some imports.

Instead the global variable :py:`addresses` is a stack where the top element is
the address (as index of :py:`instructions`) of the last '[' met during the
compilation.

The real compilation occurs inside :py:`visitor`, the function itself is
basically a big switch statement where different things happen depending on the
element of the abstract syntax tree. The only noteworthy branches are "[" and
"]", inside the first one is annotated the address at the top of :py:`addresses`
and then 6 :py:`NOP` instructions are added to the program so that when the in
the second branch "]" is met, it's possible to change the :py:`NOP` instructions
to manage the :py:`JUMP` instruction.

.. gistlines:: 913aa9667d89af8e2ab45e99e557c2aa
   :footer: false
   :lines: 195-232

Here the parsing and the visiting (i.e. the :py:`instructions` creation) are
done, then two last instructions are added, they basically let the program
return :py:`None`. Then a :py:`CodeType` "object" is created, it was not easy to
find some documentations about this. At the end the :py:`bytearray` is
serialized and wrote to a file using the `marshal module`_. This is how the pyc
files are structured inside.

Let's note that before writing the instructions in the file a magic number of 16
bytes is written, it depends on the Python version, so this transpiler should
generate bytecode working only with the same Python version used for the
interpiler execution.

The complete source code of the program is `here on Gist`_.

Here you can see an usage example where I compile a Brainfuck program which
prints an ascii version of a famous fractal.

.. asciinema:: eQxRo9gNILmH0RnT6paAPgQib

For this I have to thanks `Daniel Cristofani`_, an insanely good Brainfuck
developer who wrote programs such as the (maybe) shortest possible quine, a
Brainfuck interpreter (a.k.a. `Meta-circular evaluator`_) and a Brainfuck to C
transpiler.

This project has a lot of possible improvements...

.. _`marshal module`: https://docs.python.org/3.7/library/marshal.html
.. _`here on Gist`: https://gist.github.com/andrea96/913aa9667d89af8e2ab45e99e557c2aa
.. _`Daniel Cristofani`: http://www.hevanet.com/cristofd/brainfuck/
.. _`Meta-circular evaluator`: https://en.wikipedia.org/wiki/Meta-circular_evaluator
