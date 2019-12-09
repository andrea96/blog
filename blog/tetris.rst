
Vintage tetris written in Guile Scheme
======================================

.. post:: Sep 2, 2017
   :tags: scheme, tetris, guile, ncurses
   :category: 

.. role:: strike
    :class: strike

This isn't really recent but it worths to be mentionated on this site, about one
month ago I started reading the `Wizard book`_ and I became obsessed with this
fantastic language. The first *real* project I tried was this Tetris
implementation using Guile_ (yep, his sanctity Stallman should be proud of me),
the code :strike:`was` is orrible but it allowed me to discover how to make things
working pratically. The SICP is a great book but it doesn't offer any *real
world* example.

.. image:: _static/tetris/xkcd-224.jpg
   :alt: XKCD is always the best

So, I realized the first working version in only one night but then I added a
lot of features, e.g.:

- Coloured blocks and a nice interface
- I made a block lie on 2 characters so that it looks more squared
- Levels that make the game faster
- Points system inspired by the classical Nintendo game

Obviously I used the good old `NCurses library`_, luckily Guile provides an
`official wrapper`_ that is `well documented`_.

When I reached a decent version I was so excited that I uploaded a video on
YouTube:


.. youtube:: 7FWsP1iKPCY
   :width: 100%


I know I shouldn't upload code so bad but I really enjoyed writing it and I'm
afraid of losing it in the future, so...

.. gist:: https://gist.github.com/andrea96/e8c6a7281b9144fae308db2324dbc519

.. _`Wizard book`: https://mitpress.mit.edu/sicp/
.. _Guile: https://www.gnu.org/software/guile/
.. _`NCurses library`: http://www.tldp.org/HOWTO/NCURSES-Programming-HOWTO/intro.html#WHATIS
.. _`official wrapper`: https://www.gnu.org/software/guile-ncurses/
.. _`well documented`: https://www.gnu.org/software/guile-ncurses/manual/guile-ncurses.html
