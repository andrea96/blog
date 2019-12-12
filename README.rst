.. image:: https://api.netlify.com/api/v1/badges/ef2c3ed3-7f3d-4210-b560-ee459367d608/deploy-status
   :target: https://app.netlify.com/sites/andreaciceri/deploys

My blog
=======
This is the repository of my blog, which collects different contents. The
website is actually visitable at `this address`_.

.. _`this address`: https://andreaciceri.netlify.com/

Requirements
------------

All the packages needed for the blog building and deployment are inside the
:code:`requirements.txt` file. There is a problem with
:code:`sphinxcontrib.youtube`, the `official one`_ downloadable with `pip`,
which is not working with Python 3, but as I wanted to use it I added the custom
extension inside `blog/_ext/youtube.py <blog/_ext/youtube.py>`_ taking the code
from `here`_.

I also added a custom extension wrote by me which adds the directive
:code:`::gistlines::`, it allows to include sources from `Gist`_ setting the
lines range, it works simply adding a :code:`<code>` element to the DOM and
including `gist-embed`_. However I'm also using the standard
`sphinxcontrib.gist` where this is not needed.

.. _`Official one`: https://pypi.org/project/sphinxcontrib.youtube/
.. _`here`: https://github.com/sphinx-contrib/youtube
.. _`gist-embed`: https://www.npmjs.com/package/gist-embed
.. _`Gist`: https://gist.github.com/

Creating contents and building
------------------------------

It's possible to add a post with the command :code:`ablog post <title>` and then
modifyng the created :code:`<title>.rst` file, the command :code:`ablog serve
-r` starts a web server at :code:`http://localhost:8000/` with the realtime
updated blog.

To publish the post it's enough to push the commit with the new file on the
:code:`master` branch, the building process will automatically start.
Substantially Netifly is triggered when the repository is updated and it
executes the command :code:`ablog build` which builds the site and put the
generated contents inside the folder `_website/ <website/>`_. Then it executes
the python script `compress.py <compress.py>`_ which try to minify the files in
:code:`_website`. At the end Netifly hosts the whole folder.

.. _`Netlify`: https://netlify.com/
