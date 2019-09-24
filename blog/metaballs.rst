
Metaballs and marching cubes
============================

.. post:: Dec 19, 2018
   :tags: atag
   :category:

In the last days I started playing with three.js_,
basically it's a *JavaScript* library that manages animated 3d objects and
permits to render them.
I was interested in computer graphics and I found this library a wonderful
sandbox capable of running in my browser as a simple *Canvas* (thanks to
WebGL_).

In this post I'm going to explain how I implemented the famous
`Marching cubes`_ algorithm.
I want to underline the fact that I'm not an expert, I discovered this algorithm
some days ago because I wanted display two Metaballs, so this post is for fun,
simply don't expect a super-efficient implementation.

.. _three.js: https://threejs.org/
.. _WebGL: https://www.khronos.org/webgl/
.. _`Marching cubes`: https://en.wikipedia.org/wiki/Marching_cubes

This is my final result, I hope you like it.


.. raw:: html
   :file: _static/metaballs/demo.html

Let's try to move around the metaballs using the mouse!

What is a metaball?
-------------------

Let :math:`metaball_i(x, y, z)` be the function associated with the :math:`i`-th
metaball, a typical example of such a function is the reciprocal of the euclidean
distance from the center of the metaball;

.. math::
   metaball_i(x, y, z) =  \frac{1}{(x_i - x)^2 + (y_i - y)^2 + (z_i - z)^2}

where :math:`(x_i, y_i, z_i)` is the center of the :math:`i`-th metaball.

Then the implicit surface defined by the metaballs (which could be disconnected)
is simply the set of the points :math:`(x, y, z)` that satisfy

.. math::
   \sum_{i=1}^{n} metaball_i(x, y, z) < t

where :math:`t` is a constant threshold. Changing the value of :math:`t` allows to
modify how much the metaballs attract each other.

Marching cubes
--------------

Soon there will be the explaination of the algorithm!
Meanwhile this is the code:

.. gist:: https://gist.github.com/andrea96/8a5a9a5ce761d4a8f7fd28d9aad4614f
