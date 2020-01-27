Free Software on Windows (without any privilege)
================================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: text


Introduction
------------

This page indicates which free softwares I've been able to install on Windows
10 Enterprises 64 bits machine, as an unprivileged user (no administration
rights) and how I did the installations.


.. _unxutils_win:

UnxUtils
--------

.. index::
  single: UnxUtils
  single: Path variable (Windows)

`UnxUtils <https://en.wikipedia.org/wiki/UnxUtils>`_ provides ports of some GNU
commands (ls, grep, sed, find, ...). It makes possible to use those commands,
in the windows command line (cmd).

Download UnxUtils.zip from https://sourceforge.net/projects/unxutils. Create a
UnxUtils directory somewhere and unzip the downloaded file to that directory.
The executable files for the GNU commands are in the ``usr\local\wbin``
subdirectory.

You now have to update your ``Path`` variable. Open the system setting dialog
(press Win+I). Type "environment" in the search box and choose "Edit
Environment variables for your account". Add the path to ``usr\local\wbin`` to
the ``Path`` variable.

Open a cmd window. The GNU commands should be usable.

There is a problem with the ``find`` command which conficts with the windows
command with the same name. To invoke the GNU ``find`` command and not the
windows command, you have to prepend the exact path to the command::

  ...\UnxUtils\usr\local\wbin\find ...

To make live a little bit easier, I've substituted a drive letter ('U', but is
doesn't have to be 'U') for the path. So I can invoke the GNU ``find`` command
with::

  U:\find ...

I've defined the substitution in a ``startup.bat`` batch file:

| @echo off
|
| subst U: ...\UnxUtils\usr\local\wbin 1>nul

And I've changed the target property of the shortcut I use to launch cmd, by
adding the ``/k`` option:
``%windir%\system32\cmd.exe /k C:\users\p006245\Documents\cmd_startup\startup.bat``
This ensures that ``startup.bat`` is run when I launch cmd.


ccrypt
------

.. index::
  single: ccrypt (on Windows)

`ccrypt <https://en.wikipedia.org/wiki/Ccrypt>`_ is a program to encrypt and
decrypt file. The same key is used on encryption and decryption.

Download ccrypt archive from http://ccrypt.sourceforge.net. Unzip the archive
and update your ``Path`` variable by adding the directory containing
``ccrypt.exe``.


Vim text editor (and Pathogen plugin)
-------------------------------------

.. index::
  single: Vim (on Windows)

Download Vim from https://www.vim.org/download.php and run the installation
program. Here again, you have to update your ``Path`` variable.

Launch Vim (or gVim) and get your home directory with command ``:echo $HOME``.
That's where you have to put your ``_vimrc`` file.

Issue the command ``:set runtimepath?``. It gives a list of directory. The
first one is where you have to create the ``bundle`` subdirectory for the
plugins.

Download the Pathogen plugin from the GitHub repository:
https://github.com/tpope/vim-pathogen. It contains essentially an ``autoload``
directory. Place this directory in the same directory as the ``bundle``
directory.

Download your favorite Vim plugins and place them all in the ``bundle``
directory (each plugin in its own subdirectory).


Git
---

.. index::
  single: Git (on Windows)

Git is a `distributed version control system
<https://en.wikipedia.org/wiki/Distributed_version_control>`_.

Download Git from https://git-scm.com/download.

I always use it from Git Bash. I've used a `~/.bashrc file
<https://github.com/thierr26/thierr26_config_files/blob/master/.bashrc>`_
originating from `Debian GNU/Linux <https://www.debian.org>`_ with no issue.

You might be interested by my :doc:`general page about Git <git>`.


GNAT Community Edition
----------------------

.. index::
  single: GNAT Community Edition (on Windows)

GNAT Community Edition is Adacore's programming tools (most notably the `Ada
<https://en.wikipedia.org/wiki/Ada_%28programming_language%29>`_ Compiler and
the `GNAT Programming Studio
<https://en.wikipedia.org/wiki/GNAT_Programming_Studio>`_ integrated
development environment) for free software developers.

Download GNAT Community Edition from https://www.adacore.com/download and run
the installation program.

Again, update your ``Path`` variable (add the ``bin`` subdirectory of the GNAT
Community Edition installation).


GNU Octave
----------

.. index::
  single: GNAT Community Edition (on Windows)
  single: MSYS2

`GNU Octave <https://wiki.octave.org/GNU_Octave_Wiki>`_ is an interpreted
language, similar to `Matlab <https://en.wikipedia.org/wiki/MATLAB>`_.

Download the Zip archive for the latest version (octave-5.1.0-w64-64.zip at the
time of this writing) from https://ftp.gnu.org/gnu/octave/windows, unzip it and
run the ``post-install.bat`` file.

Once more, update your ``Path`` variable (add the directory containing the
``octave.vbs`` file).

If you see a warning about a failure to set locale, you need to add the Perl
executable directory to your path (Perl comes with Octave for Windows in
subdirectory usr/bin) and set environment variable LC_ALL to a valid value ("C"
for example). If you launch Octave from the command line, you can do (assuming
your current directory is the one containing the ``octave.vbs`` file)::

  set PATH=%PATH%;%CD%\usr\bin & set "LC_ALL=C" & octave.vbs

GNU Octave for Windows comes with `MSYS2 <https://www.msys2.org>`_, and that is
another solution (beside :ref:`UnxUtils <unxutils_win>`) to use the GNU
commands on Windows. Launch ``msys2_shell.cmd``.


GNU Privacy Guard
-----------------

.. index::
  single: GNU Privacy Guard (on Windows)

Download the Windows version of `GNU Privacy Guard
<https://en.wikipedia.org/wiki/GNU_Privacy_Guard>`_ from
https://gpg4win.org/download.html and run the installation program. Right after
install you can use ``gpg`` commands in the Windows command line.
