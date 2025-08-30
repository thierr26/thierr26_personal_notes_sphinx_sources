GNOME 3
=======

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: GNOME 3


Introduction
------------

Although `GNOME 3 <https://en.wikipedia.org/wiki/GNOME#GNOME_3>`_ is not my
favorite desktop and I'm happier with the sleek :doc:`Openbox desktop I have on
my Debian box <openbox_on_debian>` (along with :doc:`tmux <tmux>`), I have to
use a machine with GNOME 3.28.2 for some kind of work. I actually use the
`GNOME Classic
<https://help.gnome.org/users/gnome-help/stable/gnome-classic.html.en>`_
flavor.

I haven't done much tweaking in this environment and haven't much to say here,
but I felt the need to keep track of the `dconf
<https://en.wikipedia.org/wiki/Dconf>`_ commands I learned. GNOME uses a binary
database to store the settings and the ``dconf`` command is a way of
manipulating the settings. `This link made me aware of dconf
<https://bgstack15.wordpress.com/2017/10/04/dconf-save-and-load-from-file/>`_.


List the keys related to the GNOME terminal profiles
----------------------------------------------------

.. index::
  single: gnome-terminal
  pair: GNOME terminal; profiles
  pair: dconf commands; list

The following command lists the keys related to the GNOME terminal profiles::

  dconf list /org/gnome/terminal/legacy/profiles:/

In my case, the output of the command is:

| list
| :b1dcc9dd-5262-4d8d-a863-c897e6d979b9/
| :424cb317-4a79-4a77-be53-86b59ee1e321/
| default


Dump / load the keys related to the GNOME terminal profiles
-----------------------------------------------------------

.. index::
  single: gnome-terminal
  pair: GNOME terminal; profiles
  pair: dconf commands; dump
  pair: dconf commands; load

Use commands like the following ones to dump the keys to a file and load them::

  dconf dump /org/gnome/terminal/legacy/profiles:/ > output_file
  dconf load /org/gnome/terminal/legacy/profiles:/ < output_file

In my case, the output file contains:

| [/]
| list=[\'b1dcc9dd-5262-4d8d-a863-c897e6d979b9\', \'424cb317-4a79-4a77-be53-86b59ee1e321\']
| default=\'424cb317-4a79-4a77-be53-86b59ee1e321\'
|
| [:b1dcc9dd-5262-4d8d-a863-c897e6d979b9]
| background-color=\'rgb(0,0,0)\'
| default-size-columns=161
| use-theme-colors=false
| default-size-rows=52
| use-system-font=false
| visible-name=\'Large\'
| font=\'Liberation Mono 11\'
|
| [:424cb317-4a79-4a77-be53-86b59ee1e321]
| visible-name=\'Narrow\'
| default-size-columns=74
| default-size-rows=70
| use-system-font=false
| use-theme-colors=false
| font=\'Liberation Mono 8\'
| background-color=\'rgb(0,0,0)\'


Dump / load the keys related to all GNOME terminal options
----------------------------------------------------------

.. index::
  single: gnome-terminal
  pair: GNOME terminal; options
  pair: dconf commands; dump
  pair: dconf commands; load

Use commands like the following ones to dump the keys to a file and load them::

  dconf dump /org/gnome/terminal/ > output_file
  dconf load /org/gnome/terminal/ < output_file

In my case, the output file contains:

| [legacy]
| menu-accelerator-enabled=false
| schema-version=uint32 3
| default-show-menubar=true
|
| [legacy/profiles:]
| list=[\'b1dcc9dd-5262-4d8d-a863-c897e6d979b9\', \'424cb317-4a79-4a77-be53-86b59ee1e321\']
| default=\'424cb317-4a79-4a77-be53-86b59ee1e321\'
|
| [legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9]
| background-color=\'rgb(0,0,0)\'
| default-size-columns=161
| use-theme-colors=false
| default-size-rows=52
| use-system-font=false
| visible-name=\'Large\'
| font=\'Liberation Mono 11\'
|
| [legacy/profiles:/:424cb317-4a79-4a77-be53-86b59ee1e321]
| foreground-color=\'rgb(211,215,207)\'
| visible-name=\'Narrow\'
| default-size-columns=74
| default-size-rows=70
| use-system-font=false
| use-theme-colors=false
| font=\'Liberation Mono 8\'
| background-color=\'rgb(0,0,0)\'


Reset (i.e. erase) a particular key
-----------------------------------

.. index::
  single: gnome-terminal
  pair: GNOME terminal; profiles
  pair: dconf commands; reset

If you want to erase a particular key (for example the ``foreground-color`` key
of a GNOME terminal profile), use a command like::

  dconf reset /org/gnome/terminal/legacy/profiles:/foreground-color


Finding the GNOME version
-------------------------

.. index::
  single: /usr/share/gnome/gnome-version.xml
  pair: GNOME 3; version

You can find the GNOME 3 version in file
``/usr/share/gnome/gnome-version.xml``.


Closing the GNOME session from the command line
-----------------------------------------------

.. index::
  single: gnome-session-quit

You can close the GNOME session from a terminal with::

  gnome-session-quit


Other resources
---------------

* `How GNOME 3.14 is winning back disillusioned Linux users <https://www.pcworld.com/article/2691192/how-gnome-3-14-is-winning-back-disillusioned-linux-users.html>`_
* `How to get GNOME version? <https://unix.stackexchange.com/a/73225>`_
