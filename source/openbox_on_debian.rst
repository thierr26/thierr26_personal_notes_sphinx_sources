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
<https://www.debian.org>`_. Openbox is a window manager which provides a
minimalist environment, that is a configurable "root menu" you open with a
right click on the background and configurable key bindings.

I'm doing this installation just after the :doc:`Debian base installation
<debian_base_install>`.


Installation
------------

.. index::
  single: Openbox
  single: X.org
  single: X Window
  single: startx
  single: /etc/X11/Xwrapper.config

I install `X.Org X Window System <https://www.x.org>`_ and Openbox with the
following command (**as root**)::

  apt-get install xorg openbox menu # As root.

Then (and assuming that the ``/etc/X11/Xwrapper.config`` file contains the line
``allowed_users=console`` or ``allowed_users=anybody``) an unprivileged user
can start Openbox from the console with::

  startx

A right mouse click opens the Openbox root-menu. From there you can launch a
terminal.

If the keyboard layout is wrong, try rebooting.

At this point, I :doc:`install and tweak the applications I want on the system
<debian_apps_install>`. Then I proceed with the configuration of
the Openbox environment and that's what is described in the rest of this page.


Addition of a RDP server (for a remote machine)
-----------------------------------------------

.. index::
  single: Remote Desktop Protocol (RDP)
  single: RDP
  pair: xrdp; RDP server
  pair: xfreerdp; RDP client
  single: ssl-cert
  pair: Display manager; lightdm
  single: /etc/X11/Xwrapper.config
  single: ~/.profile
  single: ~/.xsessionrc
  single: logname
  single: openssl
  pair: certificate; snake oil

On a remote machine with no physical access, I use the `Remote Desktop Protocol
(RDP) <https://en.wikipedia.org/wiki/Remote_Desktop_Protocol>`_ to work in
Openbox. I did the installation just like I would have done for a desktop
machine (same ``apt-get install`` command as in the previous section), and
installed a display manager (`LightDM
<https://en.wikipedia.org/wiki/LightDM>`_) as well as a RDP server (`xrdp
<http://xrdp.org>`_)::

  apt-get install lightdm xrdp # As root.

Package ``ssl-cert`` gets installed as well (it's a dependency of ``xrdp``) and
the installation of ``ssl-cert`` causes the creation of a self-signed
certificate stored at ``/etc/ssl/certs/ssl-cert-snakeoil.pem``
(``/etc/ssl/private/ssl-cert-snakeoil.key`` for the private key). It is
necessary to add user ``xrdp`` to group ``ssl-cert``. Without that, xrdp is not
able to read the certificate, using the following command (**as root**)::

  adduser xrdp ssl-cert # As root.

When you need to regenerate the certificate, use a command like the follwing
one (**as root**)::

  openssl req -x509 -newkey rsa:4096 \
      -keyout /etc/ssl/private/ssl-cert-snakeoil.key \
      -out /etc/ssl/certs/ssl-cert-snakeoil.pem \
      -sha256 -days 365 -nodes                         # As root.

Then I restarted the server and was able to open an Openbox session on the
remote machine from my local desktop machine using a ``xfreerdp`` command like
the following one::

  xfreerdp +glyph-cache /relax-order-checks \
      /u:<my_user_name_on_the_remote_machine> \
      /v:<remote_machine_address> \
      /kbd:0x40c /f

I use the ``/kbd:0x40c`` option becasue I have a french keyboard on my local
machine and the ``/f`` option to start ``xfreerdp`` full screen. Toggling the
full screen state is possible with ``Ctrl+Alt+Enter``.

On a Debian GNU/Linux system, the ``xfreerdp`` executable is provided by the
``freerdp2-x11`` package.

Note that on the remote machine, the ``/etc/X11/Xwrapper.config`` file contains
the line ``allowed_users=rootonly``.

Let's also mention that there is no login shell involved when opening a session
with ``xfreerdp``. It implies that the ``logname`` command does not output your
user name but outputs "logname: no login name" instead, and your ``~/.profile``
file is not sourced. But ``~/.xsessionrc`` is sourced.


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
management <https://docs.xfce.org/xfce/thunar/using-removable-media#managing_removable_drives_and_media>`_.


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
  single: vim-gtk3

Even if using Vim only in a terminal and not as a graphical application, it is
useful to install the ``vim-gtk3`` package instead of just the ``vim`` package,
to benefit from the clipboard feature::

  apt-get install vim-gtk3 # As root.

`Follow the link for an interesting discussion on that topic on
vi.stackexchange.com
<https://vi.stackexchange.com/questions/13564/why-is-vim-for-debian-compiled-without-clipboard>`_.


Other resources
---------------

* `Openbox default keyboard shortcuts <https://defkey.com/openbox-shortcuts>`_
