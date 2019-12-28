Installing an OpenBSD virtual machine
=====================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  pair: virtual machine; OpenBSD
  single: QEMU
  single: KVM


Introduction
------------

These are my notes about the installation of an `OpenBSD
<https://www.openbsd.org>`_ 6.6 virtual machine on my `Debian GNU/Linux
<https://www.debian.org>`_ stable system ("AMD64" architecture).

The process is very similar to :doc:`the installation of a Debian GNU/Linux
virtual machine <debian_unstable_vm>` and this page does not repeat all the
details and mentions only the specific actions.

This page does not deal at all with the post-install configuration and usage of
the OpenBSD system.


Installing the OpenBSD signing and verifying tool
-------------------------------------------------

.. index::
  single: signify-openbsd

On a `Debian GNU/Linux <https://www.debian.org>`_ system, you can install the
OpenBSD signing and verifying tool (**as root**) with::

  apt-get install signify-openbsd # As root.


Getting and verifying the OpenBSD installer ISO image
-----------------------------------------------------

.. index::
  single: mkdir
  single: wget
  single: SHA256
  single: signify-openbsd

OpenBSD installer images can be obtained from many servers. I use
``ftp.fr.openbsd.org``. I choose to download the small ISO image (cd66.iso) and
let the installer download the file sets from the Internet.

Here are the commands I use to download the installer image and the other files
needed for the verification::

  mkdir -p ~/vm/installer_iso/openbsd_6.6
  cd ~/vm/installer_iso/openbsd_6.6
  wget https://ftp.fr.openbsd.org/pub/OpenBSD/6.6/amd64/cd66.iso
  wget https://ftp.fr.openbsd.org/pub/OpenBSD/6.6/amd64/SHA256
  wget https://ftp.fr.openbsd.org/pub/OpenBSD/6.6/amd64/SHA256.sig
  wget https://ftp.fr.openbsd.org/pub/OpenBSD/6.6/openbsd-66-base.pub

Then I do the verification with::

  signify-openbsd -C -p openbsd-66-base.pub -x SHA256.sig cd66.iso


Creating the OpenBSD virtual machine
------------------------------------


Start the installation
~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: virt-install
  single: osinfo-query
  pair: virsh commands; domcapabilities

It consists in running a ``virt-install`` command, very much like for the
:ref:`Debian unstable virtual machine creation
<start_debian_unstable_vm_install>`.

Don't forget to :ref:`start the default virtual network and to run the needed
commands so that applications running as root can connect to the X server
<start_debian_unstable_vm_install>`.

Use ``osinfo-query os`` to find the most appropriate value for the
``--os-variant`` option (the closest value to the OS you're installing).

Here is the exact ``virt-install`` command I use::

  virt-install --name openbsd_6.6 \
    --memory 1024 \
    --vcpus=1 \
    --cdrom cd66.iso \
    --disk pool=default,size=10 \
    --os-variant openbsd6.3 \
    --graphics spice \
    --channel spicevmc & # As root.

One precision though: This doesn't work on one of my PC (one with a AMD Phenom
II X2 555 CPU). OpenBSD fails to boot (kernel panic). The console says "Fatal
protection fault in supervisor mode". It looks very much like the problem
discussed in this `OpenBSD guest in bhyve on AMD CPU
<http://freebsd.1045724.x6.nabble.com/OpenBSD-guest-in-bhyve-on-AMD-CPU-td5987830.html>`_
thread.

One solution is to expose a different CPU to the guest (using the ``--cpu``
opton of ``virt-install``). The output of ``virsh domcapabilities`` helped me
find possible values for the ``--cpu`` option. ``kvm64`` seems to be a working
value.

So on the PC with the AMD CPU, the exact ``virt-install`` command I use is::

  virt-install --name openbsd_6.6 \
    --cpu kvm64 \
    --memory 1024 \
    --vcpus=1 \
    --cdrom cd66.iso \
    --disk pool=default,size=10 \
    --os-variant openbsd6.3 \
    --graphics spice \
    --channel spicevmc & # As root.


OpenBSD base installation
~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: X Window

Not much to say here. I haven't had any major difficulty doing the base
installation.

Follow `this link if you are surprised to be asked by the installer whether you
expect to run the X Window system and wants to know why
<https://unix.stackexchange.com/questions/53238/what-does-do-you-expect-to-run-the-x-windows-system-do-when-installing-openbs>`_.
