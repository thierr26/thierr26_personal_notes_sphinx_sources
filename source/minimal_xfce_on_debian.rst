Minimal installation of Xfce on Debian
======================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

I'm using `Openbox <https://en.wikipedia.org/wiki/Openbox>`_ (see my
:doc:`Openbox installation notes <openbox_on_debian>`, but it may be desirable
to also have a "heavier" desktop environment installed, as some users are not
comfortable with a minimalist environment. `Xfce <https://xfce.org>`_ is a good
compromise, closer to a full desktop environment but still lightweight.


Installation
------------

.. index::
  single: Xfce
  single: LightDM
  single: X.org
  single: tasksel

When I installed Xfce, I had already Openbox and X.org installed.

I followed `Craig Coonrad's recommendation <https://github.com/coonrad/Debian-Xfce4-Minimal-Install>`_ to install Xfce manually instead of
using the Debian package selection (``tasksel``). I just installed the
``xfce4`` package::

  apt-get install xfce4

This triggered the installation of the `LightDM display manager
<https://en.wikipedia.org/wiki/LightDM>`_, which is fine.


Theming
-------

.. index::
  single: Debian theme
  single: desktop-base
  triple: Debian alternatives; update-alternatives options; --config
  single: update-grub

The installation of ``xfce4`` also triggered the installation of the
``desktop-base`` package which provides the Debian themes.

Browse the ``/usr/share/desktop-base`` for an overview of the available themes,
with for example::

  xzgv /usr/share/desktop-base

Select your preferred theme (**as root**) with the Debian alternatives system::

  update-alternatives --config desktop-theme # As root.

Similarly, you can select the `Grub <https://en.wikipedia.org/wiki/GNU_GRUB>`_
theme with::

  update-alternatives --config desktop-grub # As root.

Then run ``update-grub``.
