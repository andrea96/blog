
SCMRL (SCheMeRogueLike)
=======================

.. post:: Sep 11, 2017
   :tags: scheme, roguelike, ncurses, dijkstra, procedural generation
   :category:

Welcome to *SCMRL* (SCheMeRogueLike, yes I've to choose a more imaginative
name), in this page I will collect the information about this my project.

**2017/09/11** *SCMRL* is `here on GitHub`_. This is the first commit, I worked
on it at the end of July and I decided to upload it only now. The game is not
playable but I feared that it could be accidentally deleted so here it is.

**May 2019** After nearly 2 years of nothing I started working again on this
project, I'm trying to create an object oriented interface (using coops_) for
the already existing structures. I'm also making it compatible with `Chicken
5`_. I gave up about the idea of using the bugged `nCurses egg`_ and chose to
directly do the C calls to the library. At the moment I'm working on a new
branch of the repository.


Features implemented:

- Random dungeon generation inspired by this_
- Field of vision based on `this method`_
- Pathfinding via Dijkstra maps

I hope, sooner or later, to reach a playable version.


.. _`here on GitHub`: https://github.com/andrea96/scmrl
.. _coops: http://wiki.call-cc.org/eggref/5/coops
.. _`Chicken 5`: http://wiki.call-cc.org/man/5/
.. _`nCurses egg`: http://wiki.call-cc.org/eggref/5/ncurses
.. _`this`: http://journal.stuffwithstuff.com/2014/12/21/rooms-and-mazes/
.. _`this method`: http://www.roguebasin.com/index.php?title=Precise_Shadowcasting_in_JavaScript
