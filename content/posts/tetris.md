---
title: "Vintage tetris written in Guile Scheme"
date: 2017-09-02T15:15:02+02:00
draft: false
---

This isn't really recent but it worths to be mentionated on this site, about one month ago I started reading the [Wizard book](https://mitpress.mit.edu/sicp/) and I became obsessed with this fantastic language.
The first *real* project I tried was this Tetris implementation using [Guile](https://www.gnu.org/software/guile/) (yep, his sanctity Stallman should be proud of me), the code ~~was~~ is orrible but it allowed me to discover how to make things working pratically.
The SICP is a great book but it doesn't offer any **real world** example. 

![XKCD is always the best](/img/xkcd-lisp.jpg)

So, I realized the first working version in only one night but then I added a lot of features, e.g.:

* Coloured blocks and a nice interface
* I made a block lie on 2 characters so that it looks more squared
* Levels that make the game faster
* Points system inspired by the classical Nintendo game

Obviously I used the good old [NCurses library](http://www.tldp.org/HOWTO/NCURSES-Programming-HOWTO/intro.html#WHATIS), luckily Guile provides an [official wrapper](https://www.gnu.org/software/guile-ncurses/) that is [well documented](https://www.gnu.org/software/guile-ncurses/manual/guile-ncurses.html).

When I reached a decent version I was so excited that I uploaded a video on YouTube:


{{< youtube 7FWsP1iKPCY >}}


I know I shouldn't upload code so bad but I really enjoyed writing it and I'm afraid of losing it in the future, so...

<code data-gist-id="e8c6a7281b9144fae308db2324dbc519"></code>
