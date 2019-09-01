External (USB) drives
=====================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

I'm using `Debian GNU/Linux <https://www.debian.org>`_ and I backup my data to
external (USB) drives. This page describes how I've setup those drives, that is
how I've recreated a partition table (with a single Linux type partition) and
how I've formatted and labeled the partition with the ext4 filesystem. This of
course erases all the data on the drive, so **don't do that if your external
drive contains precious data that you must preserve and retain!**

Indications about how to format to FAT32 are also provided.


Recreating the partition table
------------------------------

.. index::
  single: dmesg
  single: fdisk
  single: partition table


Device identification
~~~~~~~~~~~~~~~~~~~~~

I've plugged in the USB drive and have identified the associated device by
checking the output of the ``dmesg`` command (**as root**). The last lines
should contain the name of the device (probably something like ``/dev/sdb`` or
``/dev/sdc``) for the just mounted drive.

Alternatively, a ``fdisk -l`` command (**as root**) can be used, as it shows
all the disk devices on the system.


Deletion of existing partitions and creation of the new partition
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Launch fdisk **as root** with the device as argument::

  fdisk /dev/sdb # As root.

Check current partition table with command ``p``.

Delete first partition with command ``d``. If there are more than one
partition, repeat command ``d`` as many times as needed.

Create a new partition with command ``n``. fdisk now asks for a few questions.
Answer ``p`` (primary), ``1`` (partition number) and just press enter when
asked for the first and last sectors. fdisk may propose to remove the
signature, accept.

Then use command ``t`` to select the partition type. Choose type 83 (Linux).
Use ``L`` to see the list of possible codes.

Finally, write the new partition table to the disk with command ``w``.

A ``fdisk -l /dev/sdb`` command (**as root**) should show the newly created
partition.


Formatting the new partition
----------------------------

.. index::
  single: mkfs.ext4
  single: e2label
  single: partition label

Use ``mkfs.ext4`` (**as root**) to format the newly created partition with the
ext4 filesystem. Note the ``-L`` option used to provide the label::

  mkfs.ext4 -L <label> /dev/sdb1 # As root.

If you omit the label or want to change it, you can run later::

  e2label /dev/sdb1 <label> # As root.

To show the label, just do::

  e2label /dev/sdb1 # As root.


.. _fat32_formatting:

FAT32 formatting
-----------------

.. index::
  single: mkfs.vfat
  single: dosfstools
  single: mlabel
  single: mtools
  single: partition label

For a FAT32 formatting instead of a ext4 formatting, the procedure is similar.
The differences are:

* In fdisk, choose partition type 0c;
* Format with ``mkfs.vfat -F 32 -n <label> /dev/sdb1``;
* Change label with ``mlabel -i /dev/sdb1 ::<label>`` (``mlabel -i /dev/sdb1
  -s`` to show the label).

On Debian GNU/Linux, ``mkfs.vfat`` is in package ``dosfstools`` and ``mlabel``
is in package ``mtools``. You can install them with::

  apt-get install dosfstools mtools # As root.

Chances are that ``dosfstools`` is already installed.
