Using secondary hard disk drive to extend a specific user home directory
========================================================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

On a machine having two disks (one `SSD
<https://en.wikipedia.org/wiki/Solid-state_drive>`_ and one larger `traditional
spinning hard disk drive <https://en.wikipedia.org/wiki/Hard_disk_drive>`_), I
wanted to use the SSD as the "main" disk (i.e. the disk where all files are
installed, including ``/home``) and the spinning disk as an extension of the
home directory of a specific user (which is the only user of the machine).

I also wanted encryption on both disks.

After the run of the Debian installer, the system was entirely installed on the
SSD (device ``/dev/nvme0n1``), and the other drive (device ``/dev/sda``) had an
(empty) ext4 partition in a `LUKS <https://fr.wikipedia.org/wiki/LUKS>`_
container (``/dev/sda1``), unused (i.e. not mounted).


Finding the LUKS containers
---------------------------

.. index::
  single: LUKS
  single: lsblk
  single: cryptsetup
  single: blkid

Here are a few commands that make it possible to determine whether a partition
is a LUKS container or not.

``lsblk`` is usable by unprivileged users. Example output:

| NAME                    MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
| sda                       8:0    0 931.5G  0 disk  
| └─sda1                    8:1    0 931.5G  0 part  
| sr0                      11:0    1  1024M  0 rom   
| nvme0n1                 259:0    0 232.9G  0 disk  
| ├─nvme0n1p1             259:1    0   976M  0 part  /boot
| ├─nvme0n1p2             259:2    0     1K  0 part  
| └─nvme0n1p5             259:3    0 231.9G  0 part  
|   └─nvme0n1p5_crypt     254:0    0 231.9G  0 crypt 
|     ├─debian--vg-root   254:1    0   224G  0 lvm   /
|     └─debian--vg-swap_1 254:2    0   7.9G  0 lvm   [SWAP]

``nvme0n1p5`` here is a LUKS container, and is opened (unlocked). ``sda1`` is
also a LUKS container but is not currently opened.

The following command (to be run **as root**)::

  cryptsetup isLuks -v /dev/sda1 # As root.

outputs "Command successful." which means that ``sda1`` is a LUKS container.

With the ``-f`` switch, ``lsblk`` gives more details and makes it easier to
find the LUKS container (but be aware that the output of ``lsblk`` **is
sensible to terminal width**, so you may not always get the same output):

| NAME                    FSTYPE      FSVER    LABEL UUID                                   FSAVAIL FSUSE% MOUNTPOINTS
| sda                                                                                                      
| └─sda1                  crypto_LUKS 2              93cecf1d-efa8-4f70-b811-b67cb996f040                  
| sr0                                                                                                      
| nvme0n1                                                                                                  
| ├─nvme0n1p1             ext4        1.0            b4ab51f0-75ff-4558-8b68-60e9558a5e41    737.7M    15% /boot
| ├─nvme0n1p2                                                                                              
| └─nvme0n1p5             crypto_LUKS 2              a1a95860-81f5-403c-80b0-b1611751029d                  
|   └─nvme0n1p5_crypt     LVM2_member LVM2 001       0pzMEU-UQ5A-OO2C-zGob-1k1f-WZ4E-jCRqVC                
|     ├─debian--vg-root   ext4        1.0            3231f3f8-cf5c-41e8-9cd6-20bde82debed    180.3G    13% /
|     └─debian--vg-swap_1 swap        1              fc0b8623-d7cd-45b8-8527-79084d6dcf39                  [SWAP]

Alternatively, you can use ``blkid`` (**as root**), which outputs something
like:

| /dev/mapper/debian--vg-root: UUID=\"3231f3f8-cf5c-41e8-9cd6-20bde82debed\" BLOCK_SIZE=\"4096\" TYPE=\"ext4\"
| /dev/nvme0n1p5: UUID=\"a1a95860-81f5-403c-80b0-b1611751029d\" TYPE=\"crypto_LUKS\" PARTUUID=\"13888c7b-05\"
| /dev/nvme0n1p1: UUID=\"b4ab51f0-75ff-4558-8b68-60e9558a5e41\" BLOCK_SIZE=\"4096\" TYPE=\"ext4\" PARTUUID=\"13888c7b-01\"
| /dev/mapper/debian--vg-swap_1: UUID=\"fc0b8623-d7cd-45b8-8527-79084d6dcf39\" TYPE=\"swap\"
| /dev/mapper/nvme0n1p5_crypt: UUID=\"0pzMEU-UQ5A-OO2C-zGob-1k1f-WZ4E-jCRqVC\" TYPE=\"LVM2_member\"
| /dev/sda1: UUID=\"93cecf1d-efa8-4f70-b811-b67cb996f040\" TYPE=\"crypto_LUKS\" PARTUUID=\"eb9eab94-01\"


Unlocking and mounting automatically at boot time
-------------------------------------------------

.. index::
  single: cryptsetup
  single: head
  single: chmod
  single: /etc/crypttab
  single: /etc/fstab
  single: /etc/mtab

This section describes a way to open (unlock) and mount ``sda1`` at boot time.

Obviously, you have to know the passphrase that was provided to the Debian
installer. If you want to change it, use (**as root**)::

  cryptsetup luksChangeKey /dev/sda1

This is fast and does not imply re-encrypting the whole drive, it just
re-encrypts the "master key".

The passphrase has to be stored somewhere, and the best option may be to store
it a hidden file on the (encrypted) "root" partition, in the home directory of
the root user (``/root``).

Some people have had difficulties with this (see for example `this answer on
superuser.com <https://superuser.com/a/1703892>`_) **due to a trailing new line
in the file**. I made sure to make a file without the trailing new line with a
command like::

  head -c -1 file_with_trailing_new_line >/root/.keyfile # As root.

Make sure also that the key file cannot be read by any one but the root user::

  chmod 600 /root/.keyfile # As root.

The automatic opening of the LUKS container at boot time is achieved by adding
a line (**as root**) to ``/etc/crypttab`` (which probably already exists and
contains a line to open the swap partition container). The line to add is like:

| extension_crypt UUID=93cecf1d-efa8-4f70-b811-b67cb996f040 /root/.keyfile luks

The automatic mounting of the partition that the container contains is achieved
by adding a line (**as root**) to ``/etc/fstab``. This line specifies the mount
point, make sure to create it (**as root**)::

  mkdir /media/extension # As root.

The line to add to ``/etc/fstab`` is like:

| /dev/mapper/extension_crypt /media/extension ext4 defaults 0 0

After a reboot, the spinning disk partition should be mounted on
``/media/extension`` (a ``cat /etc/mtab`` should show a line starting with
"/dev/mapper/extension_crypt").


Setting permissions and creating a symbolic link to the mount point
-------------------------------------------------------------------

.. index::
  single: mkdir
  single: chown
  single: chmod
  single: ln

The final steps consist in:

* Creating a directory in the mounted partition (the symbolic link we are going
  to create will point to this directory instead of directly to the mount
  point, this will make sure the ``lost+found`` directory (which exists at the
  top level of any ext2, ext3 and ext4 partitions) is not visible through the
  symbolic link).
* Changing the ownership and permissions of the mount point, to make sure that
  only the intended user can access the mounted partition (the effect of this
  is persistent).
* Creating a symbolic link in the home directory of the user.

You can do this with commands like::

  mkdir /media/extension/data             # As root.
  chown -R <user>:<user> /media/extension # As root.
  chmod -R 700 /media/extension           # As root.

  cd                                      # As <user>.
  ln -s /media/extension/data extension   # As <user>.

User <user> has now a home directory extended with the full space available on
the spinning disk. User <user> has access to this space through
``~/extension``.


Other resources
---------------

* `Verifying if a Disk Is Encrypted in Linux
  <https://www.baeldung.com/linux/check-disk-encryption>`_
* `Changing a LUKS Passphrase
  <https://www.baeldung.com/linux/luks-change-passphrase>`_
