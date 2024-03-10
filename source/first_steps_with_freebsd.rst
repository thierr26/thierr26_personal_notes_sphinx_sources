My first steps with FreeBSD
===========================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

This page describes the few things I've done with `FreeBSD
<https://www.freebsd.org>`_ after :doc:`installing a FreeBSD 12.1 virtual
machine <freebsd_vm>`.


Shutting down FreeBSD
---------------------

.. index::
  single: halt

You can trigger the FreeBSD shut down and power down with the following command
(**as root**)::

  halt -p # As root.


Tweaking SSH server configuration
---------------------------------

.. index::
  single: /etc/ssh/sshd_config
  single: service restart

You may need to tweak the SSH server configuration, for example to allow root
password login (although it's not recommended in the general case).
Edit ``/etc/ssh/sshd_config`` as instructed in the :ref:`SSH page
<sshd_configuration>` and restart the ``sshd`` service (**as root**) with::

  service sshd restart    # If sshd_enable is set to YES in /etc.rc.conf.

or::

  service sshd onerestart # If sshd_enable is not set to YES in /etc.rc.conf.


Fixing a slow boot issue ("unqualified host name; sleeping for retry")
----------------------------------------------------------------------

.. index::
  single: /etc/rc.conf
  single: hostname

If you have provided an unqualified host name during the installation, you
probably have the `FreeBSD slow boot issue described here
<http://tuttlem.github.io/2014/07/19/unqualified-host-name-sleeping-for-retry.html>`_.

Just edit ``/etc/rc.conf`` and make sure the hostname value is fully qualified
(i.e. contains a dot).

You can output the host name with::

  hostname


Having root's shell history stored to file
------------------------------------------

.. index::
  single: ~/.cshrc
  single: history
  single: histfile
  single: savehist
  single: precmd
  single: alias

On FreeBSD, root's shell is `tcsh
<https://www.tutorialspoint.com/unix_commands/tcsh.htm>`_. The command history
is not stored to file by default. The following two commands add lines to the
``~/.cshrc`` file which should cause the command history to be stored to file
``~/.shell_history``::

  echo "set histfile = ~/.shell_history" >> ~/.cshrc       # As root.
  echo "alias precmd 'history -S; history -M'" >> ~/.cshrc # As root.

(It is assumed that variables ``history`` and ``savehist`` were already set by
``.cshrc``.)


Installing Bash
---------------

.. index::
  single: bash (on FreeBSD)
  pair: FreeBSD package management commands; pkg search
  pair: FreeBSD package management commands; pkg install

For non root users, the default shell on FreeBSD is ``/bin/sh``. Linux users
may feel more comfortable with `Bash
<https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ instead.

The following command shows that Bash is available on FreeBSD::

  pkg search bash

(If you're running a ``pkg`` command for the first time, make sure to run it
**as root** because it will fetch and install the package management tool and
this will fail if you are not root.)

Install Bash **as root** with::

  pkg install bash bash-completion # As root.


Changing user's shell to Bash
-----------------------------

.. index::
  single: chsh
  single: ~/.bashrc

As a "normal" (non root) user, you can change your shell to Bash with::

  chsh -s /usr/local/bin/bash

Create a ``~/.bashrc`` file with the following content to enable the Bash
completion library:

| [[ $PS1 && -f /usr/local/share/bash-completion/bash-completion.sh ]] \
|     source /usr/local/share/bash-completion/bash-completion.sh


Making it possible for a "normal" user to change user to root (with ``su -``)
-----------------------------------------------------------------------------

.. index::
  single: su
  single: pw
  single: wheel user group

On FreeBSD, only users who are in the ``wheel`` are allowed to change user to
root. You can add (**as root**) a user in the ``wheel`` group with::

  pw usermod <username> -G wheel # As root


Searching / installing binary packages
--------------------------------------

.. index::
  pair: FreeBSD package management commands; pkg install
  pair: FreeBSD package management commands; pkg info
  pair: FreeBSD package management commands; pkg search
  single: gmake (on FreeBSD)
  single: Git (on FreeBSD)

You can install binary packages (for example GNU make and Git) with commands
like (**as root**)::

  pkg install gmake git # As root.

After the installation of a package, a message is sometimes displayed. You can
view this message later with a command like::

  pkg info -D git

You can search the package repository catalogues with commands like::

  pkg search vim
