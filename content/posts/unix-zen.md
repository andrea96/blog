---
title: "The Zen and the art of the Unix hacking"
date: 2017-11-27T22:27:25+01:00
draft: false
---


More than two months are passed since my last post, I had some good ideas I would have liked to transform into posts but I'm afraid to be too lazy (in my defence I have to say that I've been really busy).
However, maybe because I bought a new mechanical keyboard, maybe because I'm going to assemble a new pc for Christmas; this is a new post.

As I preannunced, since I'm building a new pc, I don't want to switch on my new computer for the first time without knowing which software to install, so the purpose of this post is to provide a *recipe* with my favorite softwares (and their configurations).

Obviously the operating system is [ArchLinux](https://www.archlinux.org/), I've been using it for 3-4 years and I still love it (and this says a lot).
I will not give information about the installation process nor the basic needed configurations, I want to focus on the specific programs and to do that I will split the article into different sections.
Besides, there are many important tools that I will omit in my *recipe*, but this is voluntary, if there isn't something it's simply because I like its default configuration.
Indeed I want to enfatize that this post shows a personal point of view, so let's start:

This is a draft of the programs I'm going to install:

* i3wm
* finch
* glances
* ranger (with img2txt support)
* vim
* zsh
* chromium (with vimium)


This is a work in progess post! There isn't (and probably there will not be) a definitive version!

### i3 configuration
I've used [i3-gaps](https://github.com/Airblader/i3) (i.e. i3 with more features) because I wanted to add a spacing between windows.
All the configurations are inside `~/.config/i3/`, precisely there are:

* `config` which is the standard i3 configuration file
* `i3pystatus-conf.py` which is the configuration file of [i3pystatus](https://github.com/enkore/i3pystatus), a cooler replacement of i3status
* `wallpaper.png` (or any other format that `feh` is able to read), this is the image that `feh` try to load as background when i3 is started


<code data-gist-id="d108b7660bf8def5265239a3e6156d9b"></code>
