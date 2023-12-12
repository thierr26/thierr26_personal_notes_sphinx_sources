When things go wrong...
=======================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

This page is where I've noted the commands I used when things went wrong or
when I needed to be reassured about the integrity of the data on my `Debian
GNU/Linux <https://www.debian.org>`_ systems.


Reconfiguring GRUB to boot an older kernel by default
-----------------------------------------------------

.. index::
  single: GRUB
  single: /etc/default/grub
  single: /boot/grub/grub.cfg
  single: update-grub

The kernel GRUB boots by default is determined by the "GRUB_DEFAULT" line in
file ``/etc/default/grub``. By default, it is "GRUB_DEFAULT=0" which designates
the first entry in the GRUB menu, and this is probably the last installed
kernel.

You can designate a specific entry by using the entry name as it appears in the
menu. If the entry is in a submenu, use ``>`` to separate the submenu name and
the entry name. For example, the following line designates the "Debian
GNU/Linux, with Linux 6.1.0-13-amd64" entry in the "Advanced options for Debian
GNU/Linux" submenu::

  GRUB_DEFAULT="Advanced options for Debian GNU/Linux>Debian GNU/Linux, with Linux 6.1.0-13-amd64"

The entry and submenu names can be found in file ``/boot/grub/grub.cfg``.

After modifying (**as root** of course) the ``/etc/default/grub`` file, run
``update-grub`` (still **as root**) and reboot.


Checking file systems with fsck
-------------------------------

.. index::
  single: fdisk
  single: lsblk
  single: fsck
  single: extended file system
  single: ext

When using ``fsck``, it is important to provide the right file system on the
command line, and to make sure the file system is not mounted.

``lsblk`` lists the file systems with their mount points when applicable.

``fdisk -l`` (**as root**) shows information about the file systems, in
particular the device name (like ``/dev/sda2``).

For an `ext file system <https://en.wikipedia.org/wiki/Extended_file_system>`_
at least, invoke (**as root**) ``fsck`` with the ``-f`` option to force the
file system checking::

  fsck -f /dev/sda2


Checking a Git repository
-------------------------

.. index::
  pair: Git; fsck

Use ``git fsck`` to check a Git repository. Run ``git help fsck`` for more
details.


Checking Taskwarrior data files
-------------------------------

.. index::
  single: Taskwarrior

``task diagnostics`` performs a diagnostic scan of the Taskwarrior data files.


rsync checksum and trial run options
------------------------------------

.. index::
  single: rsync

If you use rsync to maintain a backup copy of some files, and you have a doubt
about the integrity of one of the sources, you may want to use the following
rsync options:

  * ``--checksum`` to force rsync to do a real comparison of the files using a
    checksum instead of just doing a quick check based on files date and size.
  * ``--dry-run`` (or ``-n``) to perform a trial run and not change any file.


Other resources
---------------

* `GRUB Manual - Simple configuration
  <https://www.gnu.org/software/grub/manual/grub/html_node/Simple-configuration.html#Simple-configuration>`_
* `What is the difference between fsck and e2fsck?
  <https://superuser.com/questions/19982/what-is-the-difference-between-fsck-and-e2fsck>`_
