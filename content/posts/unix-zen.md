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

Prova

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

`config`
~~~bash
# Use Start key as $mod
set $mod Mod4

# Font for window titles. 
font pango:DejaVu Sans Mono 8

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# Set colors palette
set $black   #000000
set $azure   #49edff
set $orange  #ff7a49
set $yellow  #ffd549
set $purple  #ad49ff
set $grey    #444444

# Set windows colors
client.focused 			$azure $azure $azure $azure
client.focused_inactive $grey $grey $grey $grey
client.unfocused 		$grey $grey $grey $grey
client.urgent 			$azure $azure $azure $azure
client.background 		$grey

# Set borders
new_window pixel 2
new_float pixel 2

# Set windows padding, require i3-gaps!
gaps inner 8
gaps outer -8

# start a terminal
bindsym $mod+Return exec sakura

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
bindsym $mod+d exec dmenu_run

# change focus
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+semicolon focus right

bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+j move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+l move up
bindsym $mod+Shift+semicolon move right

bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# Change orientation
bindsym $mod+h split h  # horizontal
bindsym $mod+v split v  # vertical

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
    status_command    python ~/.config/i3/i3pystatus-conf.py
    position          top
    workspace_buttons yes
    font pango:Hack, FontAwesome 10
    tray_padding 0 
    strip_workspace_numbers yes
    colors {
        background $black
        separator  $grey
        focused_workspace  $black  $black $azure
        active_workspace   $black  $black $orange
        inactive_workspace $black  $black $grey 
        urgent_workspace   $black $black $purple
        binding_mode       $black $black $yellow
    }

}



exec --no-startup-id feh --bg-fill ~/.config/i3/wallpaper.png
exec /usr/bin/compton
~~~

`i3pystatus-conf.py`
~~~python
# -*- coding: utf-8 -*-


import subprocess
import os
import os.path

from i3pystatus import Status
from i3pystatus.updates import pacman, cower
from i3pystatus.weather import weathercom


black =  '#000000'
azure =  '#49edff'
orange = '#ff7a49'
yellow = '#ffd549'
purple = '#ad49ff'
grey =   '#444444'
white =  '#cccccc'

status = Status()



status.register("clock",
    format=" %a %d-%m-%Y  %H:%M:%S ",  # the last space prevents overlapping with the tray icons
    color=white,
    interval=1)

status.register(
    'weather',
    format='{condition} {current_temp}{temp_unit}[ {icon}][ Hi: {high_temp}][ Lo: {low_temp}][ {update_error}]',
    interval=900,
    colorize=True,
    backend=weathercom.Weathercom(
        location_code='ITXX0042',
        units='metric',
    ),
)


status.register("updates",
    format = "{count} updates",
    format_no_updates = "No updates",
    color = azure,
    color_no_updates = orange,
    on_leftclick = None,
    on_rightclick = None,
    backends = [pacman.Pacman(), cower.Cower()])

status.register("pulseaudio",
    color_unmuted=purple,
    color_muted=orange,
    format_muted=' [muted]',
    format=" {volume}%",
    step=1,
    on_leftclick = None)

status.register("network",
    interface="wlp2s0",
    color_up=white,
    color_down=orange,
    on_leftclick=None,
    on_rightclick=None,
    on_downscroll=None,
    on_upscroll=None,
    format_up=": {essid} - {quality:03.0f}%")

status.register("backlight",
    interval=5,
    color=white,
    format=" {percentage:.0f}%",
    backlight="intel_backlight",)

status.register("temp",
    color='#78EAF2',
                )

status.register("cpu_usage",
    on_leftclick="termite --title=htop -e 'htop'",
    format="  {usage}%",)

status.register("mem",
    color="#999999",
    warn_color="#E5E500",
    alert_color="#FF1919",
    format=" {avail_mem}/{total_mem} GB",
    divisor=1073741824,)

status.register("keyboard_locks",
    format='{caps} {num}',
    caps_on='Caps Lock',
    caps_off='',
    num_on='Num On',
    num_off='',
    color='#e60053',
    )

status.register("mpd",
    host='localhost',
    port='6600',
    format="{status}",
    on_leftclick="switch_playpause",
    on_rightclick=["mpd_command", "stop"],
    on_middleclick=["mpd_command", "shuffle"],
    on_upscroll=["mpd_command", "next_song"],
    on_downscroll=["mpd_command", "previous_song"],
    status={
        "pause": " ",
        "play": " ",
        "stop": " ",
    },)

status.run()
~~~
