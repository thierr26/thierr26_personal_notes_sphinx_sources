Installation of Openbox on Debian
=================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

These are my notes about the installation and configuration of `Openbox
<https://en.wikipedia.org/wiki/Openbox>`_ on `Debian GNU/Linux
<https://www.debian.org>`_. I'm doing this installation just after the
:doc:`Debian base installation <debian_base_install>`.


Installation
------------

.. index::
  pair: Debian; installer
  single: Openbox
  single: X.org
  single: X Window

I install `X.Org X Window System <https://www.x.org>`_ and Openbox with the
following command (**as root**)::

  apt-get install xorg openbox obmenu openbox-menu menu # As root.

Then an unprivileged user can start Openbox with::

  startx

A right mouse click opens the Openbox root-menu. From there you can launch a
terminal.

If the keyboard layout is wrong, try rebooting.

At this point, I :doc:`install and tweak the applications I want on the system
<debian_apps_install>`. Then I proceed with the configuration of
the Openbox environment and that's what is described in the rest of this page.


Thunar for file, archive and removable media management
-------------------------------------------------------

.. index::
  pair: Thunar; volume management
  pair: Thunar; archive management
  single: thunar-volman
  single: thunar-archive-plugin

By installing Thunar and its extension for volumes management (`thunar-volman
<https://goodies.xfce.org/projects/thunar-plugins/thunar-volman>`_), you get a
graphical file manager with the ability to mount removable medias. With
`thunar-archive-plugin
<https://goodies.xfce.org/projects/thunar-plugins/thunar-archive-plugin>`_ you
also get the ability to easily open and create archives. Do the installation
(**as root**) with::

  apt-get install thunar thunar-archive-plugin thunar-volman # As root.

`Follow the link for instructions about how to enable and configure the volume
management. <https://docs.xfce.org/xfce/thunar/using-removable-media#managing_removable_drives_and_media>`_


Requiring confirmation before exiting
-------------------------------------

.. index::
  pair: Openbox root-menu; prompting for confirmation
  single: ~/.config/openbox/menu.xml

I want to be prompted for confirmation when exiting Openbox via the root-menu.
The same when shuting down the system or rebooting. I could obtain that with
entries like the following in ``~/.config/openbox/menu.xml``:

|     <item label="Exit Openbox">
|       <action name="Execute">
|         <prompt>Are you sure you want to exit Openbox?</prompt>
|         <execute>openbox --exit</execute>
|       </action>
|     </item>
|     <item label="Reboot the system">
|       <action name="Execute">
|         <prompt>Are you sure you want to reboot the system?</prompt>
|         <execute>systemctl reboot</execute>
|       </action>
|     </item>
|     <item label="Shutdown the system">
|       <action name="Execute">
|         <prompt>Are you sure you want to shutdown the system?</prompt>
|         <execute>systemctl poweroff</execute>
|       </action>
|     </item>


Theme and wallpaper
-------------------

.. index::
  single: feh
  single: wallpaper
  pair: Openbox; theme

I launch obconf from a terminal window and choose the Syscrash theme::

  obconf &

for the wallpaper, I install ``feh`` **as root**::

  apt-get install feh # As root.

Then I "install" the wallpaper with commands like::

  feh --bg-fill path/to/image.jpg # See https://wiki.archlinux.org/index.php/feh
  echo "~/.fehbg &" >> ~/.config/openbox/autostart


Turning NumLock on on Openbox startup
-------------------------------------

.. index::
  single: numlockx
  single: NumLock
  single: ~/.config/openbox/autostart

You can install numlockx (**as root**) with::

  apt-get install numlockx # As root.

Adding the command ``numlockx on &`` to ``~/.config/openbox/autostart`` ensures
that numlockx turns on NumLock on Openbox startup::

  echo "numlockx on &" >> ~/.config/openbox/autostart


Binding menu key to root-menu
-----------------------------

.. index::
  single: menu key
  single: ~/.config/openbox/rc.xml

If your machine has a `menu key <https://en.wikipedia.org/wiki/Menu_key>`_, you
may want to bind it to the Openbox root-menu. Make sure your
``~/.config/openbox/rc.xml`` contains something like:

|   </keyboard>
|     ...
|     <keybind key="Menu">
|       <action name="ShowMenu">
|         <menu>root-menu</menu>
|       </action>
|     </keybind>
|     ...
|   </keyboard>


Binding Super-E to Thunar
-------------------------

.. index::
  single: Windows key
  single: Super key
  single: ~/.config/openbox/rc.xml

When working on Windows at the office, I usually open the file manager with the
Windows-E (a.k.a.
`Super <https://en.wikipedia.org/wiki/Super_key_(keyboard_button)>`_-E)
keyboard shortcut. I want the same on Openbox. I have added something like the
following in my ``~/.config/openbox/rc.xml``:

|   </keyboard>
|     ...
|     <keybind key="W-e">
|       <action name="Execute">
|         <command>thunar</command>
|       </action>
|     </keybind>
|     ...
|   </keyboard>


Undecorating and/or maximizing windows
--------------------------------------

.. index::
  single: xterm
  single: Firefox ESR
  single: Claws Mail
  pair: Openbox; window decoration
  pair: Openbox; window maximizing
  single: ~/.config/openbox/rc.xml

I want that `Firefox <https://www.mozilla.org/firefox>`_, `Claws Mail
<https://www.claws-mail.org>`_ and `xterm
<https://en.wikipedia.org/wiki/Xterm>`_ open with Window maximized. I also want
the xterm window to be undecorated (to get rid of the title bar).

I could achieve that by adding something like the following in my
``~/.config/openbox/rc.xml``:

|   </applications>
|     ...
|     <application class="XTerm">
|       <decor>no</decor>
|       <maximized>yes</maximized>
|     </application>
|     <application class="Firefox-esr">
|       <maximized>yes</maximized>
|     </application>
|     <application class="Claws-mail">
|       <maximized>yes</maximized>
|     </application>
|     <application type="dialog">
|       <maximized>no</maximized>
|     </application>
|     ...
|   </applications>

Note the ``<application type="dialog">`` markup for dialog boxes. It prevents
the dialog boxes from being maximized.


Benefiting from Vim clipboard feature
-------------------------------------

.. index::
  pair: Vim; clipboard
  single: vim-gtk

Even if using Vim only in a terminal and not as a graphical application, it is
useful to install the ``vim-gtk`` package instead of just the ``vim`` package,
to benefit from the clipboard feature::

  apt-get install vim-gtk # As root.

`Follow the link for an interesting discussion on that topic on
vi.stackexchange.com
<https://vi.stackexchange.com/questions/13564/why-is-vim-for-debian-compiled-without-clipboard>`_.


Other resources
---------------

* `Openbox default keyboard shortcuts <https://defkey.com/openbox-shortcuts>`_
