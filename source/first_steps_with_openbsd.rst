My first steps with OpenBSD
===========================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

At the end of 2019, I wanted to check whether it was possible to compile `Ada
2012 <https://www.ada2012.org>`_ code on `OpenBSD <https://www.openbsd.org>`_
or not.

The very first action I took was to :doc:`install an OpenBSD 6.6 virtual
machine <openbsd_vm>`.

Then I played a little bit with the system and could get the `GNAT Ada 2012
compiler <https://en.wikipedia.org/wiki/GNAT>`_ installed. This is what is
described in this page.

The final step was to build `GPRbuild (the project manager of the GNAT
toolchain)
<https://learn.adacore.com/courses/GNAT_Toolchain_Intro/chapters/gprbuild.html>`_.
This is described on another page: :doc:`GPRbuild on OpenBSD
<gprbuild_on_openbsd>`.


Shutting down OpenBSD
---------------------

.. index::
  single: halt

You can trigger the OpenBSD shut down and power down with the following command
(**as root**)::

  halt -p # As root.


Setting the KSH history file
----------------------------

.. index::
  single: ~/.profile
  single: HISTFILE
  single: HISTSIZE


With OpenBSD, and if you use the default shell (``/bin/ksh``), the command
history is not stored to file by default. If you want your shell command
history to be stored to file, you have to set the HISTFILE environment
variable. The ``~/.profile`` file seems to be the right place::

  echo "HISTFILE=~/.shell_history" >> ~/.profile # As both root and "normal"
                                                 # user.

The HISTSIZE environment variable gives the maximum number of commands stored.
It defaults to 500.


Installing Vim (and creating an alias)
--------------------------------------

.. index::
  pair: OpenBSD package management commands; pkg_info
  pair: OpenBSD package management commands; pkg_add
  single: vim (on OpenBSD)
  single: alias
  single: /etc/installurl
  single: ~/.profile
  single: ~/.kshrc
  single: ENV

The vi editor is installed by default, but I have a preference for Vim. Let's
check whether a Vim package is available on OpenBSD::

  pkg_info -Q vim                     # Lists package names containing "vim".
  pkg_info -Q vim | grep "^vim-[0-9]" # limits output to names like "vim-8...".

As I don't intend to use the X Window system, I choose to install the "no X11"
Vim package version (**as root**)::

  pkg_add vim-8.1.2061-no_x11 # As root.

The system downloads the package from the location indicated in file
``/etc/installurl`` (this file has been created automatically by the OpenBSD
installer).

Now let's create an alias to the Vim command (the ``-O`` option causes Vim to
open one window (i.e. pane) for each file given on the command line)::

  echo "alias e='vim -O'" >> ~/.kshrc # As both root and "normal" user.

Make sure the ENV variable is set to ``.kshrc`` by ``~/.profile`` (without
that, the ``~/.kshrc`` file is not read on shell startup)::

  echo "ENV=.kshrc" >> ~/.profile # As both root and "normal" user.
  echo "export ENV" >> ~/.profile # As both root and "normal" user.


Installed compilers (just after base installation)
--------------------------------------------------

.. index::
  single: grep
  single: egrep
  pair: GCC; version
  single: Clang

I've written a :ref:`shell script that extracts the descriptions (as provided
by the man pages) of the installed programs <man_page_descr_extraction>`.

After piping the output to grep (actually ``egrep -i
"build|compil|link|bind|profil"``) and manually filtering again, here are the
compilers (and other related tools) I've found:

.. list-table::

  * - /usr/bin/c++
    - clang, clang++, clang-cpp - the Clang C, C++, and Objective-C compiler
  * - /usr/bin/cc
    - clang, clang++, clang-cpp - the Clang C, C++, and Objective-C compiler
  * - /usr/bin/clang
    - clang, clang++, clang-cpp - the Clang C, C++, and Objective-C compiler
  * - /usr/bin/clang++
    - clang, clang++, clang-cpp - the Clang C, C++, and Objective-C compiler
  * - /usr/bin/clang-cpp
    - clang, clang++, clang-cpp - the Clang C, C++, and Objective-C compiler
  * - /usr/bin/cpp
    - clang, clang++, clang-cpp - the Clang C, C++, and Objective-C compiler
  * - /usr/bin/g++
    - gcc, g++, cc, c++ - GNU project C and C++ compiler
  * - /usr/bin/gcc
    - gcc, g++, cc, c++ - GNU project C and C++ compiler
  * - /usr/bin/ld
    - ld.lld - ELF linker from the LLVM project
  * - /usr/bin/ld.bfd
    - ld - Using LD, the GNU linker
  * - /usr/bin/ld.lld
    - ld.lld - ELF linker from the LLVM project
  * - /usr/bin/libtool
    - libtool - compile and link complex libraries
  * - /usr/bin/llvm-config
    - llvm-config - Print LLVM compilation options

To see the version numbers of `GCC <https://gcc.gnu.org/>`_ and `Clang
<https://clang.llvm.org/>`_::

  gcc --version; clang --version;

which gives:

| gcc (GCC) 4.2.1 20070719 
| Copyright (C) 2007 Free Software Foundation, Inc.
| This is free software; see the source for copying conditions.  There is NO
| warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

| OpenBSD clang version 8.0.1 (tags/RELEASE_801/final) (based on LLVM 8.0.1)
| Target: amd64-unknown-openbsd6.6
| Thread model: posix
| InstalledDir: /usr/bin


C compilation test
~~~~~~~~~~~~~~~~~~

.. index::
  single: C language
  single: GCC
  single: Clang

The commands suggested on the `RIP Tutorial C Language Hello World page
<https://riptutorial.com/c/example/795/hello-world>`_ for GCC and Clang both
work::

  gcc hello.c -o hello
  clang -Wall -Wextra -Werror -o hello hello.c


Ada compilation test (failed)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: Ada
  single: GNAT
  single: gnatmake

At this point, an attempt to compile an `Hello World Ada program
<https://riptutorial.com/ada/example/15002/hello-world>`_ fails with both the
``gcc`` and ``clang`` commands. And ``gnatmake`` is not installed.


Installing the GCC 8.3.0p4 package
----------------------------------

.. index::
  single: GCC (on OpenBSD)
  single: egcc (on OpenBSD)
  pair: OpenBSD package management commands; pkg_info
  pair: OpenBSD package management commands; pkg_add

Command ``pkg_info -Q gcc`` shows the existence of a ``gcc-8.3.0p4`` package.

Let's install the package (**as root**)::

  pkg_add gcc-8.3.0p4 # As root.

The installation has added some programs in ``/usr/local/bin``:

.. list-table::

  * - /usr/local/bin/ecpp
    - cpp - The C Preprocessor
  * - /usr/local/bin/egcc
    - gcc - GNU project C and C++ compiler
  * - /usr/local/bin/egcov
    - gcov - coverage testing tool
  * - /usr/local/bin/egcov-dump
    - gcov-dump - offline gcda and gcno profile dump tool
  * - /usr/local/bin/egcov-tool
    - gcov-tool - offline gcda profile processing tool
  * - /usr/local/bin/envsubst
    - envsubst - substitutes environment variables in shell format strings
  * - /usr/local/bin/gettext
    - gettext - translate message
  * - /usr/local/bin/iconv
    - iconv - character set conversion
  * - /usr/local/bin/ngettext
    - ngettext - translate message and choose plural form
  * - /usr/local/bin/vim
    - vim - Vi IMproved, a programmer's text editor
  * - /usr/local/bin/vimtutor
    - vimtutor - the Vim tutor
  * - /usr/local/bin/xxd
    - xxd - make a hexdump or do the reverse.

Let's check the version of ``egcc``::

  egcc --version

| egcc (GCC) 8.3.0
| Copyright (C) 2018 Free Software Foundation, Inc.
| This is free software; see the source for copying conditions.  There is NO
| warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

It's worth noting that the target machine designation has changed between GCC
4.2.1 and GCC 8.3.0.

For 4.2.1::

  gcc -dumpmachine # GCC 4.2.1

| amd64-unknown-openbsd6.6

For 8.3.0::

  egcc -dumpmachine # GCC 8.3.0

| x86_64-unknown-openbsd6.6


Ada compilation test (failed)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: Ada
  single: egcc
  single: gnatmake

Compiling an Ada program is still not possible. No ``gnatmake`` is installed
and an ``egcc -c hello.adb`` command fails:

| egcc: error trying to exec 'gnat1': execvp: No such file or directory


Installing the GNAT 8.3.0p4 package
-----------------------------------

.. index::
  single: GNAT (on OpenBSD)
  pair: OpenBSD package management commands; pkg_info
  pair: OpenBSD package management commands; pkg_add

Command ``pkg_info -Q gnat`` shows the existence of a ``gnat-8.3.0p4`` package.

Let's install the package (**as root**)::

  pkg_add gnat-8.3.0p4 # As root.

There are now some GNAT tools in ``/usr/local/bin``::

  ls -1 /usr/local/bin/gnat*

gives:

| /usr/local/bin/gnat
| /usr/local/bin/gnatbind
| /usr/local/bin/gnatchop
| /usr/local/bin/gnatclean
| /usr/local/bin/gnatfind
| /usr/local/bin/gnatkr
| /usr/local/bin/gnatlink
| /usr/local/bin/gnatls
| /usr/local/bin/gnatmake
| /usr/local/bin/gnatname
| /usr/local/bin/gnatprep
| /usr/local/bin/gnatxref

Note that the tools needed to work with project files (``gprbuild``,
``gprconfig``, ``gprclean``, ...) are not installed. A way of obtaining those
tools on OpenBSD is described in another page :doc:`GPRbuild on OpenBSD
<gprbuild_on_openbsd>`.


Ada compilation test (passed)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: Ada
  single: egcc
  single: gnatmake

Compiling an Ada program is now possible::

  gnatmake hello.adb

| egcc -c hello.adb
| gnatbind -x hello.ali
| gnatlink hello.ali


.. _man_page_descr_extraction:

Extraction of program descriptions from the man pages (shell script)
--------------------------------------------------------------------

.. index::
  single: man pages

The code of the script is::

  #!/bin/sh

  # Extract the names (as provided by the man pages) of the installed programs.
  #
  # Called with no argument, the script explores /usr/bin (recursively). To
  # explore other directories, provide those directories as argument.

  arg_list_sorted_no_dup() {

      # Output the argument list, sorted and without duplicates.

      {
          for ARG in $@; do
              echo "$ARG";
          done;
      } | sort -u;

  }

  subdirs_added() {

      # Output argument list (file and/or directory names) with subdirectories of
      # directories added (no depth limit). The output list has no duplicates.
      # Standard error is redirected to /dev/null. Objects other than directories
      # and files (e.g. symbolic links) are ignored.

      {
          for ARG in $@; do
              if [ -d "$ARG" ]; then
                  find "$ARG" -type d 2>/dev/null;
              elif [ -f "$ARG" ]; then
                  echo "$ARG";
              fi;
          done;
      } | sort -u;

  }

  files_list() {

      # Output the list of all files (without duplicates) contained in
      # directories passed as the arguments. Individual file names can be passed
      # as well. Other kind of objects (e.g. symbolic links) are ignored.

      {
          for ARG in $@; do
              if [ -d "$ARG" ]; then
                  find "$ARG" -type f;
              elif [ -f "$ARG" ]; then
                  echo "$ARG";
              fi;
          done;
      } | sort -u;

  }

  executables_list() {

      # Output the list of arguments, with non-executable elements removed.

      for ARG in $@; do
          [ -x "$ARG" ] && echo "$ARG";
      done;

  }

  arg_max_char_length() {

      # Output the length of the longest string provided as argument.

      MX=0;

      for ARG in $@; do
          if [ ${#ARG} -gt $MX ]; then
              MX=${#ARG};
          fi;
      done;

      echo $MX;

  }

  main_function() {

      # Get list of executable files.
      PROG_LIST=$(executables_list \
          $(files_list \
          $(subdirs_added \
          $(arg_list_sorted_no_dup $@))));

      # Get longest path of all executable files.
      PROG_PATH_MAX_LEN=$(arg_max_char_length $PROG_LIST);

      # Traverse executable files list.
      for PROG in $PROG_LIST; do

          # Extract the content of the "NAME" section of the man page (if any) of
          # the executable.
          MAN_PAGE_NAME_SECTION=$(man "${PROG##*/}" 2>/dev/null \
              | col -b \
              | grep -A1 "^NAME$" \
              | tail -1 \
              | sed "s/^ *//");

          # Output one line containing the executable path and the content of the
          # "NAME" section of the man page (if non empty).
          if [ -n "$MAN_PAGE_NAME_SECTION" ]; then
              printf %${PROG_PATH_MAX_LEN}s "$PROG";
              echo " - $MAN_PAGE_NAME_SECTION";
          fi;

      done;

  }

  # Call main_function with argument "/usr/bin" if no argument has been provided,
  # otherwise call main_function with all arguments.
  if [ $# -eq 0 ]; then
      main_function /usr/bin;
  else
      main_function $@;
  fi;
