Debian applications installation
================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

This page describes most of the installations I do on my `Debian GNU/Linux
<https://www.debian.org>`_ machines just after the :doc:`base installation
<debian_base_install>` and in my first :doc:`Openbox <openbox_on_debian>`
session.

The first section is about Debian GNU/Linux packages installations, the second
one is about third party applications installations.

Some of the applications I install have a dedicated page on this site (please
see the :doc:`home page <index>`) and are not mentionned here.


Debian GNU/Linux packages installation
--------------------------------------


Installation command
~~~~~~~~~~~~~~~~~~~~

The command to be run (**as root**) to perform the Debian GNU/Linux packages
installation is::

  apt-get install \
      rsyslog \
      apt-rdepends \
      curl \
      firefox-esr \
      webext-ublock-origin-firefox webext-ublock-origin-chromium \
      w3m \
      chromium \
      smartmontools \
      fonts-inconsolata \
      ccrypt \
      rsync \
      zip unzip \
      vorbis-tools \
      alsa-utils \
      moc \
      cdtool \
      cdparanoia \
      cdrskin \
      wodim \
      genisoimage \
      vlc \
      ffmpeg \
      libdvdcss2 \
      sox \
      default-jre default-jdk \
      taskwarrior \
      gcal \
      gftp filezilla \
      ghostwriter \
      xpdf \
      evince \
      librsvg2-bin \
      lyx texlive-lang-* \
      pandoc \
      catdoc \
      octave \
      shellcheck \
      reuse \
      lintian \
      exuberant-ctags \
      gnat gprbuild libaunit-dev libaunit-doc \
      ada-reference-manual-2012 \
      libxmlada-dom-dev libxmlada-input-dev libxmlada-sax-dev \
      libxmlada-schema-dev libxmlada-unicode-dev libxmlada-doc \
      libgtkada-dev libgtkada-doc libgtkada-bin \
      gdb gdb-doc gdbserver \
      valgrind \
      strace \
      lcov \
      libb-lint-perl \
      gimp jhead imagemagick \
      libimage-exiftool-perl \
      xsane \
      xzgv \
      rawtherapee \
      irssi \
      pan \
      claws-mail \
      claws-mail-themes \
      vim \
      unaccent \
      psmisc \
      sudo \
      pwgen \
      time \
      tree \
      mmv \
      bc \
      network-manager \
      openconnect \
      freerdp3-x11 \
      whois \
      wireshark \
      tcpdump \
      ncat \
      nmap \
      openssh-server \
      colortest \
      mesa-utils \
      lm-sensors \
      hwloc \
      zbar-tools \
      meld \
      hexedit \
      gawk \
      python3-sphinx \
      ruby-nokogiri \
      sakura \
      foobillardplus # As root.


Short description
~~~~~~~~~~~~~~~~~

.. index::
  single: xfreerdp

Here's a short description of the packages:

.. list-table::

  * - rsyslog
    - System and kernel logging daemon
  * - apt-rdepends
    - Package dependencies listing tool
  * - curl
    - Data transfer tool
  * - firefox-esr
    - Graphical Web browser
  * - webext-ublock-origin-firefox, webext-ublock-origin-chromium
    - Ads, malware, trackers blocker
  * - w3m
    - Text-based Web browser
  * - chromium
    - Graphical Web browser
  * - smartmontools
    - Storage systems control and monitoring tools using `S.M.A.R.T.
      <https://en.wikipedia.org/wiki/S.M.A.R.T.>`_ (see this `good
      smartmontools tutorial by Random Bits <https://blog.shadypixel.com/monitoring-hard-drive-health-on-linux-with-smartmontools>`_)
  * - fonts-inconsolata
    - Monospace font
  * - ccrypt
    - Encryption and decryption tool
  * - rsync
    - File-copying tool
  * - zip, unzip
    - Archiver and de-archiver for .zip files
  * - vorbis-tools
    - ogg123, vorbiscomment, ...
  * - alsa-utils
    - amixer, alsamixer, ...
  * - moc
    - Music On Console
  * - cdtool
    - Includes cdown (CD tracks info extraction)
  * - cdparanoia
    - CD ripper
  * - cdrskin, wodim
    - CD writing tools
  * - genisoimage
    - ISO-9660 CD-ROM filesystem images creation
  * - vlc
    - Multimedia player
  * - ffmpeg
    - Multimedia files transcoding, playing, ...
  * - libdvdcss2
    - Useful for reading DVDs
  * - sox
    - Audio files manipulation programs
  * - default-jre, default-jdk
    - Java runtime, Java development kit
  * - taskwarrior
    - Console based todo list manager
  * - gcal
    - Calendar program
  * - gftp, filezilla
    - FTP clients (text mode only for gftp in Debian 13 (Trixie))
  * - ghostwriter
    - Markdown editor
  * - xpdf
    - PDF reader
  * - evince
    - Document viewer (can fill in forms in PDF files)
  * - librsvg2-bin
    - Command-line utility to convert Scalable Vector Graphics (SVG) file
  * - lyx, texlive-lang-*
    - Document processor (almost WYSIWYG-frontend for LaTeX)
  * - pandoc
    - General markup converter
  * - catdoc
    - Text extractor for MS-Office files
  * - octave
    - GNU Octave language (similar to Matlab)
  * - shellcheck
    - Shell script analysis tool
  * - reuse
    - Tool for REUSE copyright and license recommendations
  * - lintian
    - Debian package checker
  * - exuberant-ctags
    - Generator of source code definitions indexes
  * - gnat, gprbuild, libaunit-dev, libaunit-doc
    - Ada programming tools
  * - ada-reference-manual-2012
    - Ada 2012 reference manual
  * - libxmlada-dom-dev, libxmlada-input-dev, libxmlada-sax-dev,
      libxmlada-schema-dev, libxmlada-unicode-dev, libxmlada-doc,
      libgtkada-dev, libgtkada-doc, libgtkada-bin
    - Ada libraries (XML/Ada and GtkAda)
  * - gdb, gdb-doc, gdbserver
    - GNU debugger (including remote server)
  * - valgrind
    - Program profiling tools
  * - strace
    - System call tracer
  * - lcov
    - Test coverage report generation tools
  * - libb-lint-perl
    - Perl code checker
  * - gimp, jhead, imagemagick
    - Image manipulation programs
  * - libimage-exiftool-perl
    - Includes exiftool (image metadata extraction)
  * - xsane
    - Frontend for SANE (Scanner Access Now Easy), includes Gimp plugin
      (the Gimp plugin may not work, on Debian Bookworm at least, but `there is
      a fix
      <https://askubuntu.com/questions/1427978/lubuntu-22-04-1-xsane-gimp-plugin-doesnt-work>`_)
  * - xzgv
    - Image viewer
  * - rawtherapee
    - Raw image converter
  * - irssi
    - IRC client
  * - pan
    - Usenet newsreader
  * - claws-mail
    - Mail client (MH mailbox format)
  * - claws-mail-themes
    - Claws Mail themes
  * - vim
    - Vim text editor
  * - unaccent
    - Tool to replace accented letters by unaccented equivalent
  * - psmisc
    - killall, ...
  * - sudo
    - Privilege escalation
  * - pwgen
    - Password generator
  * - time
    - CPU resource usage measurement
  * - tree
    - Indented directory listing tool
  * - mmv
    - Tool to move/copy/append/link multiple files by wildcard patterns
  * - bc
    - Calculator language, to be used in scripts or interactively
  * - network-manager
    - Network management framework
  * - openconnect
    - Client for GlobalProtect VPN (among others)
  * - freerdp3-x11
    - X11 based Remote Desktop Protocol client (On Debian Buster, I have to
      append options ``/relax-order-checks`` and ``+glyph-cache`` to the
      ``xfreerdp`` command line. See
      https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=954203#10. My command
      line is like: ``xfreerdp +glyph-cache /relax-order-checks /u:my_user_name
      /v:my.server /kbd:0x40c /f``)
  * - whois
    - Command-line WHOIS client
  * - wireshark
    - Graphical network traffic analyzer
  * - tcpdump
    - Command-line network traffic analyzer
  * - ncat
    - Utility to read / write data across networks from the command line
  * - nmap
    - Network mapper
  * - openssh-server
    - Secure shell (SSH) server
  * - colortest
    - Terminal color test graphs
  * - mesa-utils
    - glxgears and other programs
  * - lm-sensors
    - Utilities to read temperature/voltage/fan sensors (Run ``sensors-detect``
      as root to configure and ``sensors`` to view a readout of the sensors.)
  * - hwloc
    - Hardware Locality tool suite
  * - zbar-tools
    - Bar code / QR-code related utilities
  * - meld
    - Graphical tool to show differences between text files
  * - hexedit
    - Hexadecimal editor
  * - gawk
    - GNU awk, a pattern scanning and processing language
  * - python3-sphinx
    - Documentation generator
  * - ruby-nokogiri
    - HTML, XML, SAX, and Reader parser for Ruby
  * - sakura
    - Terminal emulator
  * - foobillardplus
    - 3D OpenGL billiard game


Configuration, preferences
~~~~~~~~~~~~~~~~~~~~~~~~~~

Firefox ESR
___________

.. index::
  pair: Firefox ESR; confirm on exit
  pair: Firefox ESR; default search engine
  single: DuckDuckGo

At about:config, set the following options to true:

* browser.quitShortcut.disabled
* browser.tabs.warnOnClose
* browser.tabs.warnOnCloseOtherTabs
* browser.warnOnQuit

At about:preferences#search, set DuckDuckGo as default search engine.

At about:preferences#privacy, uncheck "Ask to save logins and passwords for
websites".


.. _chromium_config:

Chromium
________

.. index::
  single: GNOME Keyring

In Settings | Autofill and passwords | Password Manager | Settings, disable
"Offer to save passwords and passkeys" and "Sign in automatically".

Chromium may issue a warning on every startup, asking the password to unlock
the default GNOME Keyring. To get rid of the warning, I clear my GNOME Keyring
files::

  rm -rf ~/.local/share/keyrings/*


Irssi
_____

.. index::
  pair: Irssi; theme
  single: ~/.irssi/config

Set personal information (real name, user name, nickname) in
``~/.irssi/config``.

`Many Irssi themes are available <https://irssi-import.github.io/themes>`_. I
chose the `rolle theme <https://irssi-import.github.io/themes/rolle.theme>`_.

To install and use the theme, just copy the theme file to ``~/.irssi`` and
issue a ``/SET theme <theme_name>`` command in Irssi.


Claws Mail
__________

.. index::
  pair: Claws Mail; confirm on exit
  pair: Claws Mail; theme
  single: ~/.claws-mail/accountrc
  single: ~/.signature

When starting Claws Mail for the first time, you're welcomed with the setup
wizard which helps you setting up an E-Mail account asks you in which folder
the messages should be stored. This is the "Mailbox name" which defaults to
"Mail" which means that the messages are stored in directory ``~/Mail``.

The "Mailbox name" ends up in configuration file
``~/.claws-mail/folderlist.xml``.

The E-Mail account parameters ends up in configuration file
``~/.claws-mail/accountrc``.

Claws Mail stores the address book related files in directory
``~/.claws-mail/addrbook``.

I keep my signature in ``~/.signature``. (You can provide the signature file in
the "Compose" tab of the "Account preferences" dialog box.)

Other settings:

* In Preferences, Themes: orbit-claws.

* In Preferences, Other, Miscellaneous: Confirm on exit.

* In Preferences, Message View, External Programs: Uncheck "Use system defaults
  when possible". Enter external programs as follows:

  - Web browser: firefox '%s'

  - Text editor: gvim '%s'

  - Command for 'Display as text': gvim '%s'


Pan
___

.. index::
  pair: Pan; custom browser
  single: ~/.pan2/preferences.xml

In Edit News Servers, add a news server. I use news.free.fr, with my Free
E-Mail login. This works even when connecting through an ISP other than `Free
<https://www.free.fr>`_.

In Edit Preferences, Applications:

* Web browser: Custom Command: firefox
* Text editor: gvim

The two settings are saved in ``~/.pan2/servers.xml`` and
``~/.pan2/preferences.xml`` respectively.


GIMP
____

.. index::
  pair: Gimp; theme
  pair: Gimp; icon theme
  pair: Gimp; Keyboard Shortcuts

In Preferences, Interface, Theme: System, Light Colors.

In Preferences, Interface, Icon Theme: Legacy.

In Keyboard Shortcuts, View: Set Zoom in shortcut to '=' (if you use a French
keyboard).


Music On Console
________________

.. index::
  single: Music On Console
  single: moc
  single: mocp
  single: ~/.moc/config

I use Music On Console in shuffle mode. I've set the shuffle mode in the
`~/.moc/config file
<https://github.com/thierr26/thierr26_config_files/blob/master/.moc/config>`_.

Note also in the same file the ``ShowTime`` setting. It avoids a huge delay
when quitting ``mocp`` (due to the program reading the tags in the files).


Taskwarrior
___________

.. index::
  single: Taskwarrior
  single: task
  single: ~/.taskrc
  single: ~/.task

By default, Taskwarrior stores the data in ``~/.task``, but it is possible to
set another directory. See `my ~/.taskrc file
<https://github.com/thierr26/thierr26_config_files/blob/master/.taskrc>`_.


xzgv
____

.. index::
  single: xzgv
  single: ~/.xzgvrc

`Such a ~/.xzgvrc file
<https://github.com/thierr26/thierr26_config_files/blob/master/.xzgvrc>`_
ensures that the program starts in "fit to window" mode for high resolution
images or in 100% mode for images smaller than the window. For high resolution
images, switching between "fit to window" mode and 100% mode is possible with
the Z key.


Vim
___

.. index::
  pair: Vim; backup files
  pair: Vim; swap files
  pair: Vim; undo files
  single: ~/.vimrc
  triple: Debian alternatives; update-alternatives options; --display
  triple: Debian alternatives; update-alternatives options; --config

Check that ``/usr/bin/vim.gtk3`` is the selected editor in the `Debian
alternatives system <https://wiki.debian.org/DebianAlternatives>`_ with
``update-alternatives --display editor`` (**as root**). If not, use
``update-alternatives --config editor`` (**as root**).

Restore file ``~/.vimrc``.

`my ~/.vimrc file
<https://github.com/thierr26/thierr26_config_files/blob/master/.vimrc>`_ is
heavily commented. The most "interesting" thing may be the affectation of the
``backupdir`` and ``directory`` options (the directories where the backup files
and the swap files are written respectively). They are affected to
``~/.vim/backup`` and ``~/.vim/swap`` respectively (assuming ``~/.vim`` is the
first entry of the ``runtimepath`` option and ``~/.vim/backup`` and
``~/.vim/swap`` are writable directories or can be created as writable
directories).

The point of this is to avoid having backup and swap files in the working
directories and having them in dedicated directories ``~/.vim/backup`` and
``~/.vim/swap`` instead. You may be interested by `this page by Xilin Sun
(which also covers the undo files)
<https://medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f>`_.

.. highlight:: text

Here is the code (with comments removed) of my ``~/.vimrc`` that makes the
affectation of the ``backupdir`` and ``directory`` options::


  function s:CanWriteToDir(path_to_dir)

      if !isdirectory(a:path_to_dir) && exists("*mkdir")
          silent! call mkdir(a:path_to_dir, "p", 0700)
      endif
      return (filewritable(a:path_to_dir) == 2)

  endfunction

  let s:DotVimPath = split(&runtimepath,",")[0]

  let s:BackupDir = s:DotVimPath . "/backup"
  if s:CanWriteToDir(s:BackupDir)
      set backup
      let &backupdir = s:BackupDir . "," . &backupdir
  endif

  let s:SwapDir = s:DotVimPath . "/swap"
  if s:CanWriteToDir(s:SwapDir)
      let &directory = s:SwapDir . "//" . "," . &directory
  endif

.. highlight:: shell

You may also be interested in :doc:`using the Base16 color schemes
<base16_color_schemes>`.


Sakura
______

.. index::
  single: Sakura

Set font to Inconsolata Medium 12.


Wireshark
_________

.. index::
  single: Wireshark
  single: wireshark-common
  single: usermod
  single: dpkg-reconfigure

When installing Wireshark (Debian package wireshark), you're prompted to choose
whether non-superusers should be able to capture packets. I answer "Yes". It
causes the ``wireshark`` group to be created. Then you just have to add a user
to the ``wireshark`` group to grant this user the right to capture packets with
Wireshark. Use a command like the one below (**as root**) to add a user a user
to the ``wireshark`` group::

  usermod -aG wireshark user_name # As root.

If you have answered "No" and have changed your mind, run ``dpkg-reconfigure
wireshark-common``.


Lyx
___

.. index::
  single: Lyx
  single: rsvg-convert
  single: librsvg2-bin
  single: Gimp
  single: Evince


The ``lyx`` package should preferably be installed along with the
``librsvg2-bin`` package, otherwise Lyx could fail to compile the
``welcome.lyx`` file (located in ``/usr/share/lyx/examples``). This is due to a
missing converter (the "SVG (compressed)" to "PDF (graphics)" converter).

You can also install ``librsvg2-bin`` later and then add the "SVG (compressed)"
to "PDF (graphics)" converter manually via the Tools | Preferences menu dialog
box, File Handling | Converters section. The converter command line must be::

  rsvg-convert -f pdf -o $$o $$i

(See `this Stackoverflow answer <https://tex.stackexchange.com/a/698032>`_.)

If you want to change the configured PDF viewer, you can do it via the Tools |
Preferences menu dialog box, File Handling | File formats section. I choose
"evince" as the viewer for the "PDF (pdflatex)" file format.


Third party applications installation
-------------------------------------


Google Chrome installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: Google Chrome
  single: apt install -f
  triple: Debian alternatives; update-alternatives options; --config

I downloaded the 64 bit .deb Debian package from https://www.google.com/chrome
and installed it **as root** with::

  dpkg -i google-chrome-stable_current_amd64.deb # As root.

I didn't want Google Chrome to be the default browser, so I reselected Firefox
ESR in the `Debian alternatives system
<https://wiki.debian.org/DebianAlternatives>`_ with ``update-alternatives
--config x-www-browser`` (**as root**).

I then tweaked Google Chrome's settings as for
:ref:`Chromium <chromium_config>`.


GNAT Studio
~~~~~~~~~~~

.. index::
  single: GNAT Studio

Follow the instructions at https://github.com/AdaCore/gnatstudio/releases.

I installed the Continuous Release 20250417, running the ``do_install.sh``
script as root.


Alire (Ada LIbrary REpository) installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: Alire (Ada LIbrary REpository)
  single: ~/.profile

The `Alire <https://alire.ada.dev/>`_ distribution is available as a Zip
archive on Github. I download it using ``wget`` (example for version 2.1.0)::

  cd Downloads
  wget https://github.com/alire-project/alire/releases/download/v2.1.0/alr-2.1.0-bin-x86_64-linux.zip

Then I extract it using ``unzip`` **as root**::

  cd <directory_containing_the_archive> # As root.
  mkdir -p /opt/alire # As root.
  unzip alr-2.1.0-bin-x86_64-linux.zip -d /opt/alire # As root.

Finally I add ``/opt/alire/bin`` to my path, via a line in my ``~/.profile``
file:

| PATH=\"$PATH\":/opt/alire/bin


signal-desktop installation and linking to a "dumb phone"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: signal-desktop
  single: signal-cli
  single: zbarimg
  single: wget
  single: apt-key
  single: /etc/apt/sources.list.d

Here are the commands I issued (**as root**) to install signal-desktop (you may
want to check the `Signal official site <https://signal.org/download>`_)::

  wget https://updates.signal.org/desktop/apt/keys.asc -O - | apt-key add
  echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" \
      > /etc/apt/sources.list.d/signal-xenial.list
  apt-get update
  apt-get install signal-desktop
  chmod 4755 /opt/Signal/chrome-sandbox

If your phone is not able to read `QR codes
<https://en.wikipedia.org/wiki/QR_code>`_ (like my "dumb phone"), you can link
it using `signal-cli <https://github.com/AsamK/signal-cli>`_. You will also
need a QR code decoder program. zbarimg (provided by Debian package zbar-tools)
is an example of such a program.

First, download signal-cli (as a normal user, and check the latest version
number on `<https://github.com/AsamK/signal-cli/releases>`_)::

  cd ~/Downloads
  wget https://github.com/AsamK/signal-cli/releases/download/v0.7.4/signal-cli-0.7.4.tar.gz

Then install it **as root**::

  cd /opt
  tar -xvf /home/<username>/Downloads/signal-cli-0.7.4.tar.gz

Then, as a normal user (substitute +336xxxxxxxx with your real phone number)::

  # Request a verification code (you'll receive it in an SMS).
  /opt/signal-cli-0.7.4/bin/signal-cli -u +336xxxxxxxx register

  # Verify your account.
  /opt/signal-cli-0.7.4/bin/signal-cli \
      -u +336xxxxxxxx verify <verification_code_received_by_sms>

  # Launch signal-desktop.
  signal-desktop &

You're presented with a QR code. You need to save the QR code image to a file
(say, ~/qr.png):

* Open developer tools (menu View | Toggle Developer Tools).
* Go to Network tab.
* Click All.
* Type ``data:image/png`` in the filter text box.
* Hit Ctrl-R if you don't see any ``data:image/png`` entry appear.
* Click the ``data:image/png`` entry.
* Save the image (right click on it, save to ~/qr.png).

Finally, use zbarimg to extract the tsdevice link and link your computer with
your phone::

  zbarimg ~/qr.png 2>/dev/null|head -1|sed "s/^[^:]\+://"

  /opt/signal-cli-0.7.4/bin/signal-cli -u +336xxxxxxxx \
    addDevice --uri "<tsdevice_link>"


Session for desktop installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: Session

Here is how I currently install and use Session for desktop. I download the
Appimage file for Linux from https://www.getsession.org/linux and place it
in my home directory. Then I give the file executable permission with a command
like::

  chmod +x session-desktop-linux-x86_64-1.5.2.AppImage

I launch Session for desktop with a command like::

  session-desktop-linux-x86_64-1.5.2.AppImage --no-sandbox &

(See https://github.com/oxen-io/session-desktop/issues/1418 for a discussion
about the use of the ``--no-sandbox`` flag).
