---
title: "From Brainfuck to Python bytecode"
date: 2019-08-27T19:16:27+02:00
draft: false
---

About one month ago I wrote
[this](https://gist.github.com/andrea96/913aa9667d89af8e2ab45e99e557c2aa) simple
transpiler from [Brainfuck](https://en.wikipedia.org/wiki/Brainfuck) to Python
bytecode.
I'm going to assume you already can "program" in Brainfuck, otherwise I advise
you to read the [dedicated page on
Esolang](https://esolangs.org/wiki/Brainfuck), in my opinion the best place to
learn about the language.
I'm also assuming that you have a minimal knowledge about [stack
machines](https://en.wikipedia.org/wiki/Stack_machine),
personally I only used them as a theorical objects during some proofs. I learned
to use them as a real software only during the creation of this transpiler.

Understanding how to do all of this was not easy because the Python virtual
machine is a moving target, I worked with Python 3.7 and I think my program
should work with Python 3.6+. The best places to understand how the things work
under the hood is the official [dis module
documentation](https://docs.python.org/3.7/library/dis.html)
and [this source](https://github.com/python/cpython/blob/master/Python/ceval.c)
directly from the Python source code.
I recommend to take a look at the first link and to use the second one only for
consultation.

I suggest to keep an eye on the source of the program while reading this post.

In the first part of the program there are some imports and the initialization
of the [cli parser](https://docs.python.org/3.7/library/argparse.html), the
interesting part starts with the `parse` function.

<code data-gist-id="913aa9667d89af8e2ab45e99e557c2aa"
data-gist-hide-footer="true" data-gist-line="50-88"></code>

That function creates the abstract syntax tree, which is a bit overkill as word
because it simply returns a list of lists where the elements can be "[", "]",
",", ".", "<", ">" or an integer in the interval 0-255.
This procedure ignores any character that isn't one of the standard 8 brainfuck
commands and automatically simplify the successions of "+" and "-" in a number
modulo 256.
It would be possible to simplify also "<" and ">" but I was too lazy.

The `visit` function simply depth visits the abstract syntax tree applying the
visitor function for every element of the tree.

<code data-gist-id="913aa9667d89af8e2ab45e99e557c2aa"
data-gist-hide-footer="true" data-gist-line="90-95"></code>

Then it's created a `bytearray` object called `instructions` containing some
instructions for the stack machine (every instruction is 2 bytes long), that
part is mandatory for every programs that the compiler generates, basically it
contains some imports.

Instead the global variable `addresses` is a stack where the top element is the
address (as index of `instructions`) of the last '[' met during the compilation.

The real compilation occurs inside `visitor`, the function itself is basically a
big switch statement where different things happen depending on the element of
the abstract syntax tree.
The only noteworthy branches are "[" and "]", inside the first one is annotated
the address at the top of `addresses` and then 6 `NOP` instructions are added
to the program so that when the in the second branch "]" is met, it's possible
to change the `NOP` instructions to manage the `JUMP` instruction.


<code data-gist-id="913aa9667d89af8e2ab45e99e557c2aa"
data-gist-hide-footer="true" data-gist-line="195-232"></code>

Here the parsing and the visiting (i.e. the `instructions` creation) are done,
then two last instructions are added, they basically let the program return
`None`.
Then a `CodeType` "object" is created, it was not easy to find some
documentations about this. At the end the `bytearray` is serialized and wrote to
a file using the [marshal
module](https://docs.python.org/3.7/library/marshal.html). This is how the pyc
files are structured inside.

Let's note that before writing the instructions in the file a magic number of 16
bytes is written, it depends on the Python version, so this transpiler should
generate bytecode working only with the same Python version used for the
interpiler execution.

The complete source code of the program is [here on
Gist](https://gist.github.com/andrea96/913aa9667d89af8e2ab45e99e557c2aa).

Here you can see an usage example where I compile a Brainfuck program which
prints an ascii version of a famous fractal.

<div align=center><script id="asciicast-eQxRo9gNILmH0RnT6paAPgQib"
src="https://asciinema.org/a/eQxRo9gNILmH0RnT6paAPgQib.js" async></script></div>

For this I have to thanks [Daniel
Cristofani](http://www.hevanet.com/cristofd/brainfuck/), an insanely good
Brainfuck developer who wrote programs such as the (maybe) shortest possible quine,
a Brainfuck interpreter (a.k.a. [Meta-circular
evaluator](https://en.wikipedia.org/wiki/Meta-circular_evaluator)) and a
Brainfuck to C transpiler.

This project has a lot of possible improvements...
