Wi-Fi
=====

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

.. index::
  single: Livebox

This page describes how I could connect my `Debian GNU/Linux
<https://www.debian.org>`_ desktop computer (which originally had no Wi-Fi
capability) to various `Livebox
<https://en.wikipedia.org/wiki/Orange_Livebox>`_ Wi-Fi networks (more precisely
to one Livebox Play Wi-Fi network and one Livebox 4 Wi-Fi network).


Wi-Fi network adapter and driver
--------------------------------

.. index::
  pair: Wi-Fi network adapter; TP-Link TL-WN821N
  pair: Linux kernel; Header files package
  triple: Wi-Fi network adapter driver; rtl8192eu-linux-driver; 8192eu

For the Wi-Fi network adapter I followed the recommendation of the `Debian Wiki
<https://wiki.debian.org/WiFi>`_ and bought a `TP-Link TL-WN821N wireless N USB
adapter <https://www.tp-link.com/ae/home-networking/adapter/tl-wn821n>`_. This
device is easily available on various online stores.

The same `Debian Wiki page <https://wiki.debian.org/WiFi>`_ also provides the
method to download, compile and install the driver.

First, install (**as root**) some packages needed to be able to compile the
driver::

  apt-get install gcc git build-essential # As root.

Then, install (**as root**) the header files for your Linux kernel::

  apt-get install linux-headers-`uname -r` # As root.

As a normal user, create a folder for the driver somewhere in your home
directory tree, clone  `the driver repository
<https://github.com/jeremyb31/rtl8192eu-linux-driver>`_ and change directory to
the cloned repository::

  mkdir -p ~/drivers
  cd ~/drivers
  git clone https://github.com/jeremyb31/rtl8192eu-linux-driver.git
  cd rtl8192eu-linux-driver

Change user to **root**, change directory to the directory you where in as a
normal user, and compile and install the driver::

  make         # As root.
  make install # As root.

Plug in the Wi-Fi network adapter and restart the computer. After reboot, you
should see 8192eu in the list of loaded modules::

  lsmod|grep 8192eu


Configuration
-------------

.. index::
  single: wireless-tools
  single: iwconfig
  single: wpa_passphrase
  single: /etc/network/interfaces
  single: chmod

Install wireless-tools (**as root**) with::

  apt-get install wireless-tools # As root.

The following command gives the name of the wireless network interface
(probably a name starting with "wlx503")::

  /sbin/iwconfig 2>/dev/null|grep -v "^\(\s\|$\)"|sed "s/\s.\+$//"

The wireless network interface name is referred to as <interface_name> in the
rest of the page.

Get the name of the Wi-Fi network. For a `Livebox
<https://en.wikipedia.org/wiki/Orange_Livebox>`_, the default Wi-Fi network
name is printed on a sticker on the bottom of the box. The default network name
is "Livebox-" followed by four hexadecimal digits. The network name can also
probably be shown on the Livebox display.

The Wi-Fi network name is referred to as <wifi_net> in the rest of the page.

It's now time to get the WPA PSK (pre-shared key). In the case of the Livebox
4, it can be shown on the Livebox display (unless the Livebox has been
configured to not show it). In the case of the Livebox Play, the key shown on
the display is not the WPA PSK but an hexadecimal key. **You have to use the
wpa_passphrase program to get the WPA PSK**::

  wpa_passphrase <wifi_net> <hexadecimal_key>|grep "^\s*psk="|sed "s/^.\+=//"

The WPA PSK is referred to as <psk> in the rest of the page.

Finally, add (**as root**) the following lines in your /etc/network/interfaces
file:

| auto <interface_name>
| iface <interface_name> inet dhcp
| wpa-ssid <wifi_net>
| wpa-psk <psk>

As the WPA PSK is confidential, only root should be able to access
/etc/network/interfaces. Change the file permission (**as root**) with this
command::

  chmod 600 /etc/network/interfaces # As root.

Unplug the Ethernet connection (if any) from the computer and restart it. It
should now be connected to the wireless network.
