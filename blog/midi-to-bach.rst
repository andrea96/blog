
Midi To Bach
============

.. post:: Sep 23, 2019
   :tags: python, bach, music, midi, moviepy, mido
   :category:

You know these videos on YouTube where someone has recorded himself playing
every single notes and then, after days of editing, has created a smooth video
where he plays an entire song? They are usually titled like *1% music skills,
99% editing skills*.

Now I present my new video, which is *1% music skills, 1% editing skills, 98%
coding skills*, lo and behold:


.. youtube:: 2ohxGVv6ngY
   :width: 100%


This video is generated by a Python script which mainly use two libraries;
MoviePy_ for the video editing (based on ffmpeg) and mido_ for the midi file
reading.

You can find the source `here on Github`_, I created a repository only for this,
it also contains the source videos I used, so it's easier if someone want to try
playing with it without recording new videos (that was the more boring part).

The source code is messy and full of hardcoded things which depends on the
specific midis, maybe one day I will create a specific Python library for this.


Happy hacking

.. _`here on GitHub`: https://github.com/andrea96/midiToVideo
.. _mido: https://github.com/mido/mido
.. _MoviePy: https://github.com/Zulko/moviepy/
