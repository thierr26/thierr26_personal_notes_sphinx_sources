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

**As root**::

  apt-get install \
      firefox-esr \
      webext-ublock-origin \
      w3m \
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
      genisoimage \
      vlc \
      ffmpeg \
      wkhtmltopdf \
      default-jre default-jdk \
      taskwarrior \
      gcal \
      gftp \
      dlume \
      xpdf \
      octave \
      gnat gnat-gps \
      ada-reference-manual-2012 \
      gimp jhead imagemagick \
      libimage-exiftool-perl \
      xzgv \
      rawtherapee \
      irssi \
      claws-mail \
      claws-mail-themes \
      vim vim-pathogen \
      ifp-line-libifp \
      sudo \
      sakura # As root.

.. list-table::

  * - firefox-esr
    - Graphical Web browser
  * - webext-ublock-origin
    - Ads, malware, trackers blocker
  * - w3m
    - Text-based Web browser
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
  * - cdrskin
    - CD writing tool
  * - genisoimage
    - ISO-9660 CD-ROM filesystem images creation
  * - vlc
    - Multimedia player
  * - ffmpeg
    - Multimedia files transcoding, playing, ...
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
  * - octave
    - GNU Octave language (Matlab clone)
  * - gnat, gnat-gps
    - Ada programming tools
  * - ada-reference-manual-2012
    - Ada 2012 reference manual
  * - gimp, jhead, imagemagick
    - GNU Manipulation Programs
  * - libimage-exiftool-perl
    - Inc. exiftool (image metadata extraction)
  * - xzgv
    - Image viewer
  * - rawtherapee
    - Raw image converter
  * - claws-mail
    - Mail client (MH mailbox format)
  * - claws-mail-themes
    - Claws Mail themes
  * - vim, vim-pathogen
    - Vim text editor and Pathogen plugin
  * - ifp-line-libifp
    - Tool to access iRiver iFP audio players
  * - sudo
    - Privilege escalation
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

At about:config, set browser.showQuitWarning to true.

At about:preferences#search, set DuckDuckGo as default search engine.

At about:preferences#privacy, uncheck "Remember logins and passwords for
websites.


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
``.signature``.

In Preferences, Themes: orbit-claws.

In Preferences, Other, Miscellaneous : Confirm on exit.


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
`~/.config/moc file
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
  pair: Vim; Pathogen
  pair: Vim; plugins
  pair: Vim; backup files
  pair: Vim; swap files
  pair: Vim; undo files
  single: ~/.vimrc
  single: ~/.vim/bundle
  triple: Debian alternatives; update-alternatives options; --display
  triple: Debian alternatives; update-alternatives options; --config

Clone favorite Vim plugins in Pathogen's bundle directory::

  mkdir -p ~/.vim/bundle
  cd ~/.vim/bundle
  git clone https://github.com/tomtom/tcomment_vim.git
  git clone https://github.com/kien/ctrlp.vim.git
  git clone https://github.com/vim-scripts/a.vim.git
  git clone https://github.com/dhruvasagar/vim-table-mode.git
  git clone https://github.com/docunext/closetag.vim.git
  git clone https://github.com/jlanzarotta/bufexplorer.git
  git clone https://github.com/easymotion/vim-easymotion.git
  git clone https://github.com/Yggdroot/indentLine.git
  git clone https://github.com/jvirtanen/vim-octave.git
  git clone https://github.com/chriskempson/base16-vim.git

Check that ``/usr/bin/vim.gtk`` is the selected editor in the Debian
alternatives system with ``update-alternatives --display editor`` (**as
root**). If not, use ``update-alternatives --config editor`` (**as root**).

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