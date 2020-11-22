The GNU Privacy Guard (GPG)
===========================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

You can find on this page a few notes about the configuration of `the GNU
Privacy Guard <https://gnupg.org/>`_ (the ``gpg`` command). My main use of this
software is for encryption of a part of my data on my `Debian GNU/Linux
<https://www.debian.org>`_ box. I also happen to use it to verify the
authenticity of a downloaded Debian installer image, as described in my Debian
base installation notes (":ref:`Getting an installation CD
<getting_debian_iso_image>`").

There is nothing here about the use the GNU Privacy Guard. You may want to read
the :ref:`good Tutonics guide <tutonics_gpg_encryption_guide_links>`.


Selecting the pinentry version
------------------------------

.. index::
  single: pinentry
  triple: Debian alternatives; update-alternatives options; --config
  pair: apt-cache commands; search

`Pinentry <https://www.gnupg.org/software/pinentry/index.html>`_ is the dialog
program invoked by GPG to read a passphrase. It exists in multiple versions. On
my system, two versions are installed: ``pinentry-curses`` and
``pinentry-gnome3``. On a Debian system, you can select the pinentry version
using the `Debian alternatives system
<https://wiki.debian.org/DebianAlternatives>`_ (**as root**)::

  update-alternatives --config pinentry # As root.

List the pinentry versions available on a Debian system with::

  apt-cache search pinentry|grep ^pinentry


Configuring the passphrase caching time
---------------------------------------

.. index::
  pair: gpg; passphrase caching time
  single: ~/.gnupg/gpg-agent.conf
  single: gpg-agent

Depending on the configuration, GPG does not ask again for a passphrase if you
have already given it a short (configurable) time ago. This is very practical
in my use case and I even have increased the time by specifying the
``default-cache-ttl`` and ``max-cache-ttl`` parameters in the
``~/.gnupg/gpg-agent.conf`` file:

| default-cache-ttl 14400
| max-cache-ttl 28800

Note that you have to stop ``gpg-agent`` after editing
``~/.gnupg/gpg-agent.conf``, otherwise your changes are not taken into
account::

  gpgconf --kill gpg-agent

``gpg-agent`` is restarted automatically by GPG when needed.


Deleting a key without confirmation prompt
------------------------------------------

.. index::
  pair: gpg; batch mode

I have once mistakenly imported a whole keyring. The ``--delete-key`` option of
GPG makes it possible to delete a key::

  gpg --delete-key <key_id>

But this prompts you for confirmation. If you want to run a big number of such
commands (in a script), you may not want to be prompted for confirmation. Use
the ``--batch --yes`` options for that::

  gpg --batch --yes --delete-key <key_id>


.. _tutonics_gpg_encryption_guide_links:

Other resources
---------------

* `Tutonics GPG Encryption Guide - Part 1 <https://tutonics.com/2012/11/gpg-encryption-guide-part-1.html>`_
* `Tutonics GPG Encryption Guide - Part 2 <https://tutonics.com/2012/11/gpg-encryption-guide-part-2-asymmetric.html>`_
* `Tutonics GPG Encryption Guide - Part 3 <https://tutonics.com/2012/11/gpg-encryption-guide-part-3-digital.html>`_
* `Tutonics GPG Encryption Guide - Part 4 <https://tutonics.com/2012/11/gpg-encryption-guide-part-4-symmetric.html>`_
