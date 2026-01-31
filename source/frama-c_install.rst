Frama-C installation
====================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

.. index::
  pair: Frama-C; installation

These are the notes I took when I installed `Frama-C
<https://en.wikipedia.org/wiki/Frama-C>`_ (version 32.0, Germanium) on my
`Debian GNU/Linux <https://www.debian.org>`_ 13 (Trixie) box in January 2026.
This was my first contact with Frama-C.


Installing opam
---------------

.. index::
  single: OCaml
  pair: opam; installation
  pair: opam; switch

There is no ``frama-c`` package in Debian 13, so I had to install Frama-C via
opam, the `OCaml <https://fr.wikipedia.org/wiki/OCaml>`_ source-based package
manager. (And this seems to be the recommended installation procedure, see
`the "Get Frama-C" page <https://frama-c.com/html/get-frama-c.html>`_).

I installed opam (**as root**) with::

  apt-get install opam libgmp-dev libgtksourceview-3.0-dev # As root.

Then as "normal" user, I ran the opam initialization command::

  opam init

This proposes to edit or not the ``~/.profile`` file, to include lines that set
the opam environment up.

I chose to not edit ``~/.profile`` and this implies that I have to issue a
``eval $(opam env)`` command in my terminal before being able to use opam and
any package installed via opam.

Running just ``opam init`` was not the best thing to do, because it installs
the default (latest) version of the OCaml compiler, and that's not the one to
use when you want to install Frama-C. (Package lablgtk3 fails to compile with
error ``Unbound module "Genlex"``).

You have to use OCaml compiler version 4.14.2.

I created an `opam switch <https://ocaml.org/docs/opam-switch-introduction>`_::

  opam update
  opam switch create 4.14.2

With that, I can (as before) set up the opam environment with ``eval $(opam
env)`` to use the latest compiler, or with ``eval $(opam
env --switch=4.14.2)`` to use compiler version 4.14.2.


Installing Frama-C package
--------------------------

.. index::
  pair: Frama-C plugins; WP
  single: Alt-Ergo
  single: CVC4
  single: CVC5
  single: Z3

Just set up the opam environment and install the ``frama-c`` package::

  eval $(opam env --switch=4.14.2)
  opam install frama-c

At the end of the installation, you get messages indicating that provers must
be installed to use the `WP Frama-C plugin
<https://www.frama-c.com/fc-plugins/wp.html>`_, with a list of prover names:

* `Alt-Ergo <https://alt-ergo.ocamlpro.com>`_ (which exists as an opam package
  and should already be installed),
* `CVC4 <https://cvc4.github.io>`_ (not available as an opam package),
* `CVC5 <https://cvc5.github.io>`_ (CVC4 successor, not available as an opam
  package),
* `Z3 <https://github.com/Z3Prover/z3>`_ (not available as an opam package).


Building and installing CVC5 from source
----------------------------------------

.. index::
  single: CVC5

CVC5 current version was 1.3.2 at the time of this writing.

I had to install (**as root**) a few Debian packages to be able to successfully
build CVC5 from source::

  apt-get install autoconf libtool libedit-dev cmake python3.13-venv # As root.

Then, as "normal" user, I did::

  mkdir ~/cvc5_build
  cd ~/cvc5_build
  wget https://github.com/cvc5/cvc5/archive/refs/tags/cvc5-1.3.2.tar.gz
  tar xzvf cvc5-1.3.2.tar.gz
  cd cvc5-cvc5-1.3.2
  ./configure.sh --auto-download --best --gpl
  cd build
  make
  make check

And finally, **as root** and in the same directory::

  make install # As root.


Building and installing Z3 from source
--------------------------------------

.. index::
  single: Z3

Z3 current version was 4.15.4 at the time of this writing.

As "normal" user::

  mkdir ~/z3_build
  cd ~/z3_build
  wget https://github.com/Z3Prover/z3/archive/refs/tags/z3-4.15.4.tar.gz
  tar xzvf z3-4.15.4.tar.gz
  cd z3-z3-4.15.4
  python3 scripts/mk_make.py
  cd build
  make

**As root** and in the same directory::

  make install # As root.


Listing installed provers
-------------------------

.. index::
  single: Why3

A `Why3 <https://www.why3.org>`_ command shows the installed provers (you must
set up opam environment first)::

  eval $(opam env)
  why3 config detect


Installing Ivette
-----------------

.. index::
  single: Ivette
  single: frama-c-gui
  single: chmod
  single: ln

`Ivette <https://frama-c.com/html/ivette.html>`_ is a new graphical user
interface for Frama-C, still in development. (The older interface, `frama-c-gui
<https://frama-c.com/html/gui.html>`_, is still usable on Linux.)

I had to install (**as root**) the ``libfuse2t64`` Debian package to get Ivette
to work::

  apt-get install libfuse2t64 # As root.

Then, as "normal" user, I did::

  mkdir -p ~/.local/bin
  cd ~/.local/bin
  wget https://www.frama-c.com/download/frama-c-ivette-linux-x86-64-32.0-Germanium.AppImage
  chmod +x frama-c-ivette-linux-x86-64-32.0-Germanium.AppImage
  ln -s frama-c-ivette-linux-x86-64-32.0-Germanium.AppImage frama-c-ivette

You might need to log out and log in again for frama-c-ivette to be in the
search path.

Note: I tried to name the symbolic link ``ivette``, but this was not
satisfactory (the name ``ivette`` is shadowed by ``~/.opam/4.14.2/bin/ivette``
when in opam environment).

When running Ivette, make sure to be in opam environment::

  eval $(opam env)
  frama-c-ivette &


Running Frama-C
---------------

.. index::
  pair: Frama-C plugins; Eva
  pair: Frama-C plugins; WP


I didn't do much with Frama-C, just quick tests of the `Eva
<https://www.frama-c.com/fc-plugins/eva.html>`_ and `WP
<https://www.frama-c.com/fc-plugins/wp.html>`_ plugins::

  eval $(opam env)

  frama-c -eva src/* # Run Eva on the source files in src.

  frama-c -wp -wp-prover=altergo,cvc5,z3 src/* # Run WP with all provers.
  frama-c -wp -wp-prover=none -wp-rte src/*    # Run WP with RTE guards and no
                                               # prover run.


Frama-C help
------------

.. index::
  pair: Frama-C plugins; Eva
  pair: Frama-C plugins; WP

You can get help from the ``frama-c`` command::

  eval $(opam env)
  frama-c -help     # General help.
  frama-c -eva-help # Help for Eva plugin.
  frama-c -wp-help  # Help for WP plugin.


Resources to go further with Frama-C
------------------------------------

* `Introduction to Frama-C <https://frama-c.com/download/publications/2013-merce-m/introduction-to-frama-c_v2.pdf>`_
* `Frama-C documentation <https://frama-c.com/html/documentation.html>`_
* `ACSL Mini-Tutorial <https://frama-c.com/download/acsl-tutorial.pdf>`_
