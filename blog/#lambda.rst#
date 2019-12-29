
Lambda calculus in Javascript
=============================

.. post:: Mar 31, 2019
   :tags: javascript, lambda calculus, functional
   :category:


.. role:: js(code)
   :language: javascript

.. role:: lisp(code)
   :language: lisp

	      
This sunday I enjoyed creating some simple functions using only the `lambda
calculus`_, I chose to use Javascript because of the simple syntax for the
lambda functions. In substance in javscript it's simple to translate something
like :math:`\lambda x . x` into :js:`(x) => x`.

.. _`lambda calculus`: https://en.wikipedia.org/wiki/Lambda_calculus

I started defining the boolean values true and false:

.. math::
   T = \lambda x . \lambda y . x \qquad F = \lambda x . \lambda y . y

.. gistlines:: 2806686fbb7103927da61b2a4d90afed
   :footer: false
   :lines: 1-2

This explicit parenthesization is not necessary but I preferred to exaggerate
rather than making the code even more obfuscated. I'm going to follow this
choice in the whole source. The purpose of this definition is clarified by the
*if-then-else* statement:

.. math::
   \lambda cond . \lambda a . \lambda b . cond \; a \; b

.. gistlines:: 2806686fbb7103927da61b2a4d90afed
   :footer: false
   :lines: 3

The lists are created consing nodes recursively, a *node* is a *pair* (i.e. a
*cons* of two "things") where:

- if the first element of the pair is *T* then the node is *nil* (the empty
  list), at this point what is the second element of the pair is not relevant
- if the first element of the pair is *F* then the node is not *nil* and the
  content of the node is in its second element.

Using a lisp-like syntax what I'm saying is that the list :js:`[1, 2, 3]` is
something like :lisp:`(cons (node 1) (cons (node 2) (cons (node 3) nil)))` where
`(node a)` is `(cons F a)`. In code:

.. gistlines:: 2806686fbb7103927da61b2a4d90afed
   :footer: false
   :lines: 5-10

And now something a little more interesting; the natural numbers! This
construction remembers the inductive definition by Peano.

.. math::
   \begin{align*} 0 &= \lambda f . \lambda x . x\\ 1 &= \lambda f . \lambda x . f x\\ 2 &= \lambda f . \lambda x . f(f x)\\ \vdots \\ n &= \lambda f . \lambda x \; \underbrace{f(\dots f(f(}_{n} n) \end{align*}

.. gistlines:: 2806686fbb7103927da61b2a4d90afed
   :footer: false
   :lines: 12-18

A number :math:`n` is simply something that, when called passing a function
:math:`f` return the composition :math:`\underbrace{f \circ f \circ \dots \circ
f}_n`, with the convention that :math:`f^0 = id`.

.. math::
   succ(n) = \lambda n . \lambda f .\lambda x . f(n(f)(x))

Now should be obvious what the function :js:`succ` does. Conversely how the
arithmetic operators have been implemented may not appear such obvious.

.. gistlines:: 2806686fbb7103927da61b2a4d90afed
   :footer: false
   :lines: 20-26

I suggest to equip yourself with paper and pen, I personally had some difficult
untangling these lambdas. An really nice place where to learn how this functions
work is `this page on wikipedia`_. I urge you to notice that this isn't the only
possible implentation, even continuing to use the *Church numerals* (the
representation used here for the numbers). However, as the names say, these
functions implement the addition, the multiplication, the exponentiation and the
subtraction. :js:`isZero` is a boolean predicate which tells if a numeral is
:math:`0` and :js:`pred` returns the predecent. I enfatize how implementing the
subtraction without :js:`pred` wouldn't have benn easy.

.. _`this page on wikipedia`: https://en.wikipedia.org/wiki/Church_encoding

The next logic operators and the comparator of numbers are easy to understand,
it's sufficient the remember what a boolean value and a number really are.

.. gistlines:: 2806686fbb7103927da61b2a4d90afed
   :footer: false
   :lines: 28-35

Last but not least the the factorial function! Implemented without the infamous
`Y combinator`_, that should merit a whole post only for itself. (maybe in the
future)

.. _`Y combinator`: https://en.wikipedia.org/wiki/Fixed-point_combinator#Fixed_point_combinators_in_lambda_calculus 

.. gistlines:: 2806686fbb7103927da61b2a4d90afed
   :footer: false
   :lines: 37

And now feel free to play with this code directly in this page, for example you
can try to calcolate the factorial of :math:`7` whith
:js:`lambdaToInt(fac(intToLambda(7)))`, not bad if you consider how the function
has been defined. I suggest to use the functions :js:`boolToLambda`,
:js:`lambdaToBool`, :js:`intToLambda`, :js:`lambdaToInt`, :js:`listToLambda` and
:js:`lambdaToList` to create and get boolean values, integers and lists. How do
they works is auto-explanatory, however you can find the `whole source`_ at the
end of this page.

.. _`whole source`: https://gist.github.com/andrea96/2806686fbb7103927da61b2a4d90afed#file-lambda-js

.. raw:: html
   :file: _static/lambda/demo.html

The complete source:

.. gist:: https://gist.github.com/andrea96/2806686fbb7103927da61b2a4d90afed
