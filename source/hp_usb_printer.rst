HP USB printer
==============

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

.. index::
  pair: HP LaserJet P4014n; printer

This page describes the steps I had to take be able to print on a
`HP LaserJet P4014n monochrome printer
<https://support.hp.com/us-en/product/hp-laserjet-p4014-printer-series/3558788/model/3558799/manuals>`_
from my `Debian GNU/Linux <https://www.debian.org>`_ computer.

It was pretty easy because the HP LaserJet P4014n printer is supported by the
`HPLIP driver <https://developers.hp.com/hp-linux-imaging-and-printing>`_,
which is available in Debian (package ``hplip``). And
`CUPS <https://www.cups.org/>`_ (package ``cups`` in Debian) provides a
browser-based interface to install the printer. The hardest part was moving
the printer, because it's quite heavy (26.5kg)!

I used the USB connection only. I did not use the network connection.


Installing HPLIP and CUPS
-------------------------

.. index::
  single: HPLIP (HP Linux Imaging and Printing)
  single: CUPS
  single: lpadmin user group
  single: usermod
  single: task-print-server

Chances are that HPLIP and CUPS are already installed on your Debian system, as
the Debian installer proposes to install packages related to printing:

.. image:: image/debian_install_screenshot_tasksel_first_0.png

Selecting "print server" in this Debian installer screen would result in
package ``task-printer-server`` being installed and ``cups`` and ``hplip`` are
dependencies for ``task-printer-server`` (well, ``hplip`` is a recommended
dependency).

If HPLIP and CUPS are not already installed, you can install them with (note
that ``cups`` is a dependency of ``hplip``)::

  apt-get install hplip # As root.

If you want to be able to install a printer as an unprivilged user, you need to
add yourself to group ``lpadmin`` with a command like::

  usermod -a -G lpadmin my_user_name # As root.

After logging out and in again, check that you are a member of group
``lpadmin`` with::

  groups my_user_name


Installing the printer
----------------------

.. index::
  pairs: CUPS; Browser-based interface

Connect the printer to the computer using the USB cable and point your browser
to the CUPS interface at http://localhost:631/admin.

Click the "Add Printer" button and login with a user name and password. (It can
be your normal user name if you're a member of group ``lpadmin``, see above.)

The printer is listed twice:

* HP LaserJet P4014 USB CNFX408861 HPLIP (HP LaserJet P4014)

* HP LaserJet P4014 (HP LaserJet P4014)

I selected the first item (the one containing "HPLIP").

A few other screens require information. Here is what I provided:

.. list-table::

  * - Name
    - HP_LaserJet_P4014
  * - Description
    - HP LaserJet P4014n
  * - Location
    - Home
  * - Model
    - HP LaserJet p4014n, hpcups 3.18.12 (en)

The final screen is to set the default options. I took the default values
except for paper size (I chose A4).


Printing PDF documents
----------------------

.. index::
  pair: printing; PDF
  single: Gimp

You can use the command line program ``lp`` to print a PDF document with a
commande like::

  lp -d HP_LaserJet_P4014 my_pdf_file.pdf

But accented characters may not be rendered properly.

Importing the PDF file in Gimp (package ``gimp`` in Debian) and printing from
Gimp seems to be a better option (although I haven't tried yet with documents
of more than one page...).


Other resources
---------------

* `SystemPrinting Debian Wiki page <https://wiki.debian.org/SystemPrinting>`_
* `HPLIP supported printer models <https://developers.hp.com/hp-linux-imaging-and-printing/supported_devices/index>`_
* `Open Printing printer listing <http://www.openprinting.org/printers/>`_
* `Open Printing printer driver listings <http://www.openprinting.org/drivers/>`_
