SSH
===

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

These are quick notes about `SSH
<https://www.secureblackbox.com/kb/articles/SSH-Authentication-methods.rst>`_.
SSH is useful for me as a way to :ref:`connect to virtual machines
<finding_vm_ip>`.


Installation (on a Debian GNU/Linux system)
-------------------------------------------

.. index::
  single: openssh-client
  single: openssh-server

A SSH client (i.e. a program that you can use to connect to a SSH server) is
probably installed by default (package ``openssh-client``).

The SSH server (i.e. the program that must be running on a computer (or a
virtual machine) to make SSH connections to this computer possible) may not be
installed. You can install is **as root** with::

  apt-get install openssh-server # As root.


Usage
-----

Logging into the remote machine and executing commands
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Just issue a command like the following to log in to the remote::

  ssh username@192.168.122.250 # Use server IP address.

Then you can execute commands.


Copying files to and from the remote machine
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: scp

Use the ``scp`` command. Examples::

  scp file_on_local_machine username@192.168.122.250:/path/on/remote
  scp username@192.168.122.250:/path/on/remote/my_file path/on/local

**Make sure the shell initialization (.profile, .bashrc, etc...) doesn't
produce output for non-interactive sessions**, otherwise ``scp`` does not work
properly.


Synchronizing directories over SSH with rsync
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: rsync

I use a command like the following to synchronize my ``~/data`` directory on a
remote machine with my ``~/data`` directory on the local machine::

  rsync -aAXv --delete ~/data/ 192.168.122.250:data

For a dry run, use option ``-n``::

  rsync -n -aAXv --delete ~/data/ 192.168.122.250:data

Check the `rsync documentation
<https://download.samba.org/pub/rsync/rsync.1>`_. Rsync has a lot of options.
You may, for example, prefer to use ``--update`` rather than ``--delete``.


.. _sshd_configuration:

Server configuration
--------------------

.. index::
  pair: SSH; root password login
  pair: SSH; X11 forwarding
  single: /etc/ssh/sshd_config
  pair: systemctl commands; restart

You may not need to tweak anything in the server configuration.

If you want to allow root password login, make sure you have the following
lines in `/etc/ssh/sshd_config`.

| PasswordAuthentication yes
| PermitRootLogin yes

Note however that enabling root password login is not recommended in the
general case as it leaves the server root account as a possible target for a
`brute force attack <https://linuxhint.com/bruteforce_ssh_ftp>`_.

Let's mention also X11 forwarding. If you have the following line in
`/etc/ssh/sshd_config`, then X11 forwarding is enabled:

| X11Forwarding yes

This makes it possible to run graphical applications on the remote machine but
"see" them on the local display. But you have to use the ``-X`` option when
launching the client::

  ssh -X username@192.168.122.250 # Use server IP address.

After modifying file /etc/ssh/sshd_config, make sure you restart the server::

  systemctl restart ssh # As root, on the remote machine.


Using public key authentication
-------------------------------

.. index::
  pair: SSH; public key authentication
  single: ~/.ssh
  single: ssh-keygen
  single: ssh-copy-id

Instead of password authentication, you may use public key authentication. For
that you have to first generate your public/private key pair **on your local
machine** with for example::

  ssh-keygen -t rsa -b 2048

``ssh-keygen`` requires a passphrase. It is possible to leave it empty but in
this case the key is not encrypted and anyone obtaining your private key can
use it.

The generated key pair is stored in ``~/.ssh``.

The next step is to copy the public key to the server with a command like::

  ssh-copy-id username@192.168.122.250 # Use server IP address.


Other resources
---------------

.. index::
  single: ~/.ssh/authorized_keys
  single: ~/.ssh/known_hosts

* `The 4 most important files for SSH connections (on techrepublic.com)
  <https://www.techrepublic.com/article/the-4-most-important-files-for-ssh-connections/>`_
