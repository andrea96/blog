
.. Blog index file, created by `ablog start` on Mon Sep 23 23:58:06 2019.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome
=======

Welcome to my blog, let :math:`\Sigma` be the set of the Unicode symbols, then
this site is a finite subset :math:`\mathbb{B} \subset \Sigma^*`. Assuming that
your browser can parse and interpret :math:`\mathbb{B}`, and hoping that you
find it more interesting than a generic subset, I wish you a pleasant
navigation.

The content of this blog is heterogeneous and I think that a better introduction
than this would be difficult, so let's move on.


Who am I
--------

I'm a math student who likes programming problems, I think this is a
good and concise definition compared to what this blog looks like. However I'm
more than this, I also appreciate a variety of different things like cooking,
`really nerd videogames`_, free software, music (light or classical, as a
listener or `as a player`_), sci-fi books, old and boring movies, etc...

Moreover, I'm not an english native speaker, so I ask you to be clement if you
find some errors, this site is also an opportunity to improve my language
skills.

.. _`really nerd videogames`: https://www.nethack.org/
.. _`as a player`: midi-to-bach

Technologies behind this blog
-----------------------------

This blog is generated using ablog_, a Python tool based on Sphinx_, the
famous documentation generator. The theme is the simple and clear Alabaster_.

I completely automated the deployment using netlify_, which builds the blog at
every new commit on the main branch of the repository and hosts the generated
contents. The posts are written in a plain reStructuredText using Emacs, I
reserve the right to insert some extra Javascript or CSS in some posts, as I
already did. 

You can find the complete source code in my `Github repository`_.

.. _ablog: https://ablog.readthedocs.io/
.. _Sphinx: http://www.sphinx-doc.org
.. _Alabaster: https://alabaster.readthedocs.io/
.. _`Github repository`: http://www.github.com/andrea96/blog/
.. _netlify: https://www.netlify.com/


My last posts
-------------

Here is a list of my most recent posts with a brief excerpt.

.. postlist:: 5
   :date: %B %d, %Y
   :excerpts:
   :list-style: circle


.. `toctree` directive, below, contains list of non-post `.rst` files.
   This is how they appear in Navigation sidebar. Note that directive
   also contains `:hidden:` option so that it is not included inside the page.

   Posts are excluded from this directive so that they aren't double listed
   in the sidebar both under Navigation and Recent Posts.

.. toctree::
   :hidden:


