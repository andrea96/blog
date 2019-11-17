Classificazione lineare degli equilibri di un sistema dinamico piano
====================================================================

.. post:: Nov 12, 2019
   :tags:
   :category:

.. toctree::
   :hidden:


Si consideri il sistema dinamico piano governato da

.. math::
   \bf{\dot{x}}
   \coloneqq
   \begin{bmatrix}
   \dot{x} \\
   \dot{y}
   \end{bmatrix}
   \coloneqq
   \begin{bmatrix}
   f_1(x, y) \\
   f_2(x, y)
   \end{bmatrix}
   \coloneqq
   \bf{f}(\bf{x})

Si osservi come si stia assumendo che l'evoluzione temporale del sistema dipenda esclusivamente dalla
posizione del punto e non dal tempo o dalla sua velocità. Gli zeri del campo :math:`\mathbf{f}`, ovvero
i punti :math:`\mathbf{x_0} = (x_0, y_0)` per cui le velocità :math:`(\dot{x}, \dot{y})` sono nulle
verranno chiamati equilibri.
A patto di assumere :math:`\mathbf{f}(x, y)` sufficientemente regolare è lecito considerare il sistema
linearizzato nell'intorno di un equilibrio, ossia la serie di Taylor associata alla funzione :math:`f`
centrata in un equilibrio :math:`x_0` e arresta al primo ordine.

.. math::
   \bm{f}(x, y)
   =
   J_f(x_0, y_0) \cdot \begin{pmatrix} x - x_0 \\ y - y_0 \end{pmatrix}
   +
   \mathbf{o}(\sqrt{(x - x_0)^2 + (y - y_0)^2})

Considerando il determinante e la traccia della matrice Jacobiana é possibile ottenere una
classificazione qualitativamente completa del flusso nell'intorno dell'equilibrio, inoltre si vedrà
che in alcuni casi particolari si può mostrare come tale andamento sia lo stesso anche nel sistema
non linearizzato.


   
.. plot::
				
   import matplotlib.pyplot as plt
   import numpy as np
   x = np.random.randn(1000)
   plt.hist( x, 20)
   plt.grid()
   plt.title(r'Normal: $\mu=%.2f, \sigma=%.2f$'%(x.mean(), x.std()))
   plt.show()

