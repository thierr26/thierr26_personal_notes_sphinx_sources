Debian applications installation
================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

This page gives the packages I install on my `Debian GNU/Linux
<https://www.debian.org>`_ machines just after the :doc:`base installation
<debian_base_install>` and in my first :doc:`Openbox <openbox_on_debian>`
session.

Some packages I install are not mentioned here because I have written dedicated
pages for them. Please see the :doc:`home page <index>`.


Installation
------------

.. index::
  single: xfreerdp

**As root**::

  apt-get install \
      firefox-esr midori \
      grip \
      webext-ublock-origin \
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
      sox \
      wkhtmltopdf \
      default-jre default-jdk \
      taskwarrior \
      gcal \
      gftp \
      dlume \
      xpdf \
      evince \
      catdoc \
      octave \
      gnat libaunit18-dev gnat-gps \
      ada-reference-manual-2012 \
      libxmlada-dom8-dev libxmlada-input8-dev libxmlada-sax8-dev \
      libxmlada-schema8-dev libxmlada-unicode8-dev \
      libgtkada-bin libgtkada-doc libgtkada18 libgtkada18-dev \
      valgrind \
      lcov \
      libncurses5 \
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
      ifp-line-libifp \
      unaccent \
      psmisc \
      sudo \
      pwgen \
      time \
      tree \
      openconnect \
      freerdp2-x11 \
      wireshark \
      tcpdump \
      nmap \
      openssh-server \
      colortest \
      mesa-utils \
      lm-sensors \
      zbar-tools \
      hexedit \
      sakura # As root.

.. list-table::

  * - firefox-esr, midori
    - Graphical Web browsers
  * - grip
    - Server application to render local markdown files
  * - webext-ublock-origin
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
  * - sox
    - Audio files manipulation programs
  * - wkhtmltopdf
    - HTML to PDF conversion tool
  * - default-jre, default-jdk
    - Java runtime, Java development kit
  * - taskwarrior
    - Console based todo list manager
  * - gcal
    - Calendar program
  * - gftp
    - FTP client
  * - dlume
    - Address book
  * - xpdf
    - PDF reader
  * - evince
    - Document viewer (can fill in forms in PDF files)
  * - catdoc
    - Text extractor for MS-Office files
  * - octave
    - GNU Octave language (similar to Matlab)
  * - gnat, libaunit18-dev, gnat-gps
    - Ada programming tools
  * - ada-reference-manual-2012
    - Ada 2012 reference manual
  * - libxmlada-dom8-dev libxmlada-input8-dev libxmlada-sax8-dev
      libxmlada-schema8-dev libxmlada-unicode8-dev libgtkada-bin libgtkada-doc
      libgtkada18 libgtkada18-dev
    - Ada libraries (XML/Ada and GtkAda)
  * - valgrind
    - Program profiling tools
  * - lcov
    - Test coverage report generation tools
  * - libncurses5
    - Libraries for terminal handling (legacy version), needed to run `GNAT
      Programming Studio
      <https://en.wikipedia.org/wiki/GNAT_Programming_Studio>`_ as provided
      with `GNAT Community <https://www.adacore.com/community>`_ 2018 and 2019.
  * - libb-lint-perl
    - Perl code checker
  * - gimp, jhead, imagemagick
    - Image manipulation programs
  * - libimage-exiftool-perl
    - Includes exiftool (image metadata extraction)
  * - xsane
    - Frontend for SANE (Scanner Access Now Easy), includes Gimp plugin
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
  * - ifp-line-libifp
    - Tool to access iRiver iFP audio players
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
  * - openconnect
    - Client for GlobalProtect VPN (among others)
  * - freerdp2-x11
    - X11 based Remote Desktop Protocol client (On Debian Buster, I have to
      append options ``/relax-order-checks`` and ``+glyph-cache`` to the
      ``xfreerdp`` command line. See
      https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=954203#10. My command
      line is like: ``xfreerdp +glyph-cache /relax-order-checks /u:my_user_name
      /v:my.server /kbd:0x40c /f``)
  * - wireshark
    - Graphical network traffic analyzer
  * - tcpdump
    - Command-line network traffic analyzer
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
  * - zbar-tools
    - Bar code / QR-code related utilities
  * - hexedit
    - Hexadecimal editor
  * - sakura
    - Terminal emulator


Flash player plugin installation
--------------------------------

.. index::
  single: Flash player plugin

See instructions here: https://wiki.debian.org/FlashPlayer


Configuration, preferences
--------------------------

Firefox ESR
~~~~~~~~~~~

.. index::
  pair: Firefox ESR; confirm on exit
  pair: Firefox ESR; default search engine
  single: DuckDuckGo

At about:config, set the following options to true:

* browser.sessionstore.warnOnQuit
* browser.tabs.warnOnClose
* browser.tabs.warnOnCloseOtherTabs
* browser.warnOnQuit

At about:preferences#search, set DuckDuckGo as default search engine.

At about:preferences#privacy, uncheck "Ask to save logins and passwords for
websites".


.. _chromium_config:

Chromium
~~~~~~~~

.. index::
  pair: Chromium; default search engine
  single: DuckDuckGo

In Settings | Search engines, set DuckDuckGo as the search engine used in the
adress bar.

In Settings | Autofill | Passwords, disable "Offer to save passwords" and "Auto
sign-in".


Irssi
~~~~~

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
~~~~~~~~~~

.. index::
  pair: Claws Mail; confirm on exit
  pair: Claws Mail; theme
  single: ~/.claws-mail/accountrc
  single: ~/.signature

Setup MH directory properly, restore files ``~/.claws-mail/accountrc`` and
``.signature``, and directory ``~/.claws-mail/addrbook``.

In Preferences, Themes: orbit-claws.

In Preferences, Other, Miscellaneous: Confirm on exit.

In Preferences, Message View, External Programs: Uncheck "Use system defaults
when possible". Enter external programs as follows:

* Web browser: firefox '%s'

* Text editor: gvim '%s'

* Command for 'Display as text': gvim '%s'


Pan
~~~

.. index::
  pair: Pan; custom browser
  single: ~/.pan2/preferences.xml

In Edit News Servers, add a news server. I use news.free.fr, with my Free
E-Mail login. This works even when connecting through an ISP other than `Free
<https://www.free.fr>`_.

In Edit Preferences, Applications, Web browser: Custom Command: firefox

The two settings are saved in ``~/.pan2/servers.xml`` and
``~/.pan2/preferences.xml`` respectively.


GIMP
~~~~

.. index::
  pair: Gimp; theme
  pair: Gimp; icon theme
  pair: Gimp; Keyboard Shortcuts

In Preferences, Interface, Theme: System.

In Preferences, Interface, Icon Theme: Color.

In Keyboard Shortcuts, View: Set Zoom in shortcut to '='.


Music On Console
~~~~~~~~~~~~~~~~

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
~~~~~~~~~~~

.. index::
  single: Taskwarrior
  single: task
  single: ~/.taskrc
  single: ~/.task

By default, Taskwarrior stores the data in ``~/.task``, but it is possible to
set another directory. See `my ~/.taskrc file
<https://github.com/thierr26/thierr26_config_files/blob/master/.taskrc>`_.


xzgv
~~~~

.. index::
  single: xzgv
  single: ~/.xzgvrc

`Such a ~/.xzgvrc file
<https://github.com/thierr26/thierr26_config_files/blob/master/.xzgvrc>`_
ensure that the program starts in "fit to window" mode for high resolution
images or in 100% mode for images smaller than the window. For high resolution
images, switching between "fit to window" mode and 100% mode is possible with
the Z key.


Vim
~~~

.. index::
  pair: Vim; backup files
  pair: Vim; swap files
  pair: Vim; undo files
  single: ~/.vimrc
  triple: Debian alternatives; update-alternatives options; --display
  triple: Debian alternatives; update-alternatives options; --config

Check that ``/usr/bin/vim.gtk`` is the selected editor in the `Debian
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
<base16_color_schemes_xterm_and_vim>`.


Sakura
~~~~~~

.. index::
  single: Sakura

Set font to Inconsolata Medium 12.


Privilege escalation for use of ifp-line-libifp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: sudo
  single: visudo
  single: iRiver iFP audio player
  single: ifp-line
  single: ifp-line-libifp
  single: /etc/sudoers
  single: alias
  single: ~/.bash_aliases

Use ``visudo`` to add a line in ``/etc/sudoers``. This line allows any user to
execute ``/usr/bin/ifp`` without password. See `my /etc/sudoers file
<https://github.com/thierr26/thierr26_config_files/blob/master/system_config/etc/sudoers>`_.

Run ``ifp`` with ``sudo``::

  sudo ifp ls

An alias can come in handy (see `my ~/.bash_aliases file
<https://github.com/thierr26/thierr26_config_files/blob/master/.bash_aliases>`_)::

  alias ifp='sudo ifp'


Google Chrome installation
--------------------------

.. index::
  single: Google Chrome
  single: apt install -f
  triple: Debian alternatives; update-alternatives options; --config

I downloaded the 64 bit .deb Debian package from https://www.google.com/chrome
and installed it **as root** with::

  dpkg -i google-chrome-stable_current_amd64.deb # As root.

The installation was not successful. I had to issue the following command to
fix the system::

  apt install -f # As root.

This caused the following packages to be installed:

* libappindicator3-1
* libdbusmenu-glib4
* libdbusmenu-gtk3-4
* libindicator3-7

I didn't want Google Chrome to be the default browser, so I reselected Firefox
ESR in the `Debian alternatives system
<https://wiki.debian.org/DebianAlternatives>`_ with ``update-alternatives
--config x-www-browser`` (**as root**).

I then tweaked Google Chrome's settings as for
:ref:`Chromium <chromium_config>`.


signal-desktop installation and linking to a "dumb phone"
---------------------------------------------------------

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

The rest of this section is largely taken from the `"How to install and use
Signal messenger without a smartphone" ctrl.alt.coop page
<https://ctrl.alt.coop/en/post/signal-without-a-smartphone>`_.

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
* Type "data:image/png" in the filter text box.
* Hit Ctrl-R if you don't see any "data:image/png" entry appear.
* Click the "data:image/png" entry.
* Save the image (right click on it, save to ~/qr.png).

Finally, use zbarimg to extract the tsdevice link and link your computer with
your phone::

  zbarimg ~/qr.png 2>/dev/null|head -1|sed "s/^[^:]\+://"

  /opt/signal-cli-0.7.4/bin/signal-cli -u +336xxxxxxxx \
    addDevice --uri "<tsdevice_link>"


Wireshark installation
----------------------

.. index::
  single: Wireshark
  single usermod

When installing Wireshark (Debian package wireshark), I choose to allow
"normal" users that are members of the ``wireshark`` group to capture packets.

You can add a user to group ``wireshark`` with a command like (**as root**)::

  usermod -aG wireshark user_name # As root.


Session for desktop installation
--------------------------------

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
