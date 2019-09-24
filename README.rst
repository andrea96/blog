My blog
=======

All the packages needed for the blog building and deployment are inside the :code:`requirements.txt` file.
The only exception is the `sphinxcontrib.youtube`, the `official one`_ downloadable with `pip` is not
working with Pytohn 3, so I'm using `this one`_.

.. _`official one`: https://pypi.org/project/sphinxcontrib.youtube/
.. _`this one`: https://github.com/sphinx-contrib/youtube


Moreover it's necessary the file :code:`credentials.py`, wich is in the :code:`.gitignore` for obvious reasons,
this file must match this format:

.. code:: python

  user = 'myUserName'
  password = 'myPassword'
  host = 'myFtpHost'
 
It's possible to add a post with the command :code:`ablog post <title>` and then modifyng the created
:code:`<title>.rst` file, the command :code:`ablog serve -r` starts a web server at
:code:`http://localhost:8000/` with the realtime updated blog.

To publish the post the command is simply :code:`push.py`, it creates and pushes a commit on this repo
and then mirrors the folder :code:`_website` with the ftp server.
