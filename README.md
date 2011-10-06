Studio Player for RaBe
======================

Gentoo based DAW with live-assist and cartwall support for use in radio studios.

I recently started building the described system. Since we are planning on using
more puppet at RaBe anyways i decided to start by installing stuff using puppet
in a quick and dirty manner. Some parts of the system still get installed manually
but writing these puppet modules has served as a convenient way to document the
changes i made to the base install.

For now this project won't help you install the described DAW on your own. If I
get this running as intended it will still take some time for me to clean up the
whole act and to refactor the puppet part to a degree that they should work with
a puppetmasterd in a sane fashion.

For now the I plan on basing the system off the following components:

* gentoo/linux as operating system
* xorg/xfce4/xmonad as x11 stack that lets me control large parts of the experience
* mixxx for live-assist
* an arduino that bangs out osc commands from the studio mixer
* puredata as convenient osc 2 midi converter for interfacing mixxx with osc

I still need to find solutions for some problems:

* a simple cartwall solution (needs painless import/export though)
* a way to create cartwall configs from winxp workstations elsewhere
* some sort of caching filesystem so i can fill the local disk with as much sound 
  as possible

Remember, as of now this is all preliminary and I am dumping this here for backup 
purposes and since i know that publishing from the beginning make keeping stuff open
much easier on my side.

I will add a more complete writeup when this is done, however as it is part of our
ongoing efforts at radio rabe it will probably take some time, even years, for all
this to get even remotely close to what i would regard as production ready.

