GPRbuild on OpenBSD
===================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: OpenBSD
  single: GPRBuild


Introduction
------------

.. index::
  single: GCC
  single: egcc

This page describes how I could build `GPRbuild (the project manager of the
GNAT toolchain)
<https://learn.adacore.com/courses/GNAT_Toolchain_Intro/chapters/gprbuild.html>`_.
from source on `OpenBSD <https://www.openbsd.org>`_ 6.6.

The process is documented in the `GPRbuild GitHub repository
<https://github.com/adacore/gprbuild>`_ (and in the `XML/Ada GitHub repository
<https://github.com/adacore/xmlada>`_ for the XML/Ada build) but I had a few
difficulties due to the specifics of OpenBSD. In particular, the `GCC
<https://gcc.gnu.org/>`_ version that comes with the OpenBSD base installation
is not the one that must be used to build GPRbuild. A newer one must be used
(version 8.3.0) and is not installed as ``gcc`` but as ``egcc``. ``egcc`` is
not recognised automatically by the building tool.

The GPRbuild and XML/Ada versions (commit hashes) I used are:

* ``f3d62455b02564a4bbdc1ec04f1da788f22702fe`` (2019-12-25) for GPRBuild.

* ``b50bc2659637695f3a4cf5f0568a537a3e033047`` (2019-11-18) for XML/Ada.


Prerequisites
-------------

.. index::
  single: GNU make (on OpenBSD)
  single: gmake (on OpenBSD)
  single: Git (on OpenBSD)
  single: XML/Ada

GCC and GNAT 8.3.0p4 must be installed. Please read the :doc:`"My first steps
with OpenBSD" page <first_steps_with_openbsd>` for more details.

`GNU make <https://www.gnu.org/software/make>`_ must also be installed::

  pkg_add gmake # As root.

Git should be installed as well. It makes cloning the GPRbuild and `XML/Ada
<https://docs.adacore.com/xmlada-docs/index.html>`_ repositories much easier::

  pkg_add git # As root.


Building and installing GPRbuild
--------------------------------


Cloning the repositories and creating a bootstrapped GPRbuild
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: install

As a "normal" (non root) user, create a working directory and clone the
GPRbuild and XML/Ada repositories::

  mkdir ~/bootstrapped_gprbuild
  cd ~/bootstrapped_gprbuild
  git clone https://github.com/AdaCore/gprbuild.git
  git clone https://github.com/AdaCore/xmlada.git

Then move to the ``gprbuild`` directory and edit the edit the ``bootstrap.sh``
script, to **remove** the ``-t`` option on the ``install`` commands (four
occurrences, near the end of the script). (Because the ``-t`` option is not
recognized (and not needed) by the OpenBSD ``install`` program.)

You can now create the bootsrapped GPRbuild::

  ./bootstrap.sh --with-xmlada=../xmlada --prefix=./bootstrap


Creating a ``gcc`` symbolic link to ``egcc``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: ln
  single: GPRconfig

As root, create a ``gcc`` symbolic link to ``egcc``::

  cd /usr/local/bin # As root.
  ln -s egcc gcc # As root.

This makes sure that GPRbuild detects the appropriate GCC version. To verify,
issue a ``gprconfig --config Ada --config C`` as a normal user (make sure you
add the ``gprbuild`` directory to the path
(``export PATH=~/bootstrapped_gprbuild/gprbuild:"$PATH"``).

The ``gprconfig --config Ada --config C`` command should output something like:

| --------------------------------------------------
| gprconfig has found the following compilers on your PATH.
| Only those matching the target and the selected compilers are displayed.
| *  1. GNAT for Ada in /usr/local/bin/ version 8.3 (default runtime)
|    2. GCC-ASM for Asm in /usr/local/bin/ version 8.3.0
|    3. GCC-ASM for Asm2 in /usr/local/bin/ version 8.3.0
|    4. GCC-ASM for Asm_Cpp in /usr/local/bin/ version 8.3.0
| *  5. GCC for C in /usr/local/bin/ version 8.3.0
| Select or unselect the following compiler (or "s" to save):

(Press Ctrl-c to exit without saving.)


Configuring, building and installing XML/Ada
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: GPRconfig
  single: default.cgpr
  single: gnatls
  single: which
  single: gmake

As a normal user, move to the ``gprbuild`` directory and create a GPRbuild
default configuration file (``default.cgpr``)::

  cd ~/bootstrapped_gprbuild/gprbuild
  gprconfig --batch --config Ada --config C # Creates the default.cgpr file.

Copy ``default.cgpr`` to the ``xmlada`` directory::

  cp default.cgpr ../xmlada

Move to the ``xmlada`` directory and configure the XML/Ada sources::

  cd ../xmlada
  ./configure --prefix=/usr/local

``/usr/local`` is the prefix used for the GNAT installation, as suggested by
``which gnat`` or ``gnatls -v``.

Then **as root**, add the ``gprbuild`` directory to the path and build and
install XML/Ada::

  export PATH=/home/<username>/bootstrapped_gprbuild/gprbuild:"$PATH" # As root.
  cd /home/<username>/bootstrapped_gprbuild/xmlada                    # As root.
  gmake all install                                                   # As root.


Configuring, building and installing GPRBuild
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: gmake
  pair: GCC; target machine

As a normal user, make sure that the ``gprbuild`` directory is in the path
(issue a ``export PATH=~/bootstrapped_gprbuild/gprbuild:"$PATH"`` command if
needed).

Move to the ``gprbuild`` directory and configure the GPRbuild sources::

  cd ~/bootstrapped_gprbuild/gprbuild
  gmake prefix=/usr/local setup

Edit the ``default.cgpr`` file: for the Ada binder driver, substitute
``libexec/gprbuild/gprbind`` with ``bootstrap/libexec/gprbuild/gprbind``.

Then build GPRbuild::

  gmake all

Finally as root, make sure that the ``gprbuild`` directory is in the path
(issue a ``export PATH=/home/<username>/bootstrapped_gprbuild/gprbuild:"$PATH"``
command if needed), move to the ``gprbuild`` directory and install GPRbuild::

  cd /home/<username>/bootstrapped_gprbuild/gprbuild
  gmake install TARGET=$(egcc -dumpmachine)

(The ``TARGET=$(egcc -dumpmachine)`` part is needed because by default the
Makefile obtains the target from a ``gcc -dumpmachine`` command (which invokes
``/usr/bin/gcc`` (GCC 4.2.1) and yields "amd64-unknown-openbsd6.6") whereas we
want the output of ``/usr/local/bin/egcc -dumpmachine``
("x86_64-unknown-openbsd6.6").)

GPRbuild and companion tools should now be installed in ``/usr/local/bin``::

  ls -1 /usr/local/bin/gpr*

should give:

| /usr/local/bin/gprbuild
| /usr/local/bin/gprclean
| /usr/local/bin/gprconfig
| /usr/local/bin/gprinstall
| /usr/local/bin/gprls
| /usr/local/bin/gprname
| /usr/local/bin/gprslave
