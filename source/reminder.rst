Reminder
========

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

This page provides commands that can be used to produce a graphical popup and
to broadcast a message to opened terminals.

It also indicates how to setup reminders by having these commands called
periodically by `cron <https://en.wikipedia.org/wiki/Cron>`_.


Graphical popup (using xmessage)
--------------------------------

.. index::
  single: xmessage
  single: graphical popup

The ``xmessage`` command (provided by package ``x11-utils`` on a Debian
GNU/Linux system) causes a popup message box to appear::

  xmessage 'My message'

  xmessage -display :0.0 'My message'            # A cron job launching
                                                 # xmessage with the display
                                                 # option fails.

  xmessage -center -geometry 130x68 'My message' # Specifies position (center
                                                 # of the screen) and size.
                                                 # In Xmonad at least, message
                                                 # is not readable if size is
                                                 # not specified.

Follow the `link for more information about X applications command line
options <https://www.oreilly.com/library/view/x-window-system/9780937175149/Chapter08.html>`_.


Broadcasted message (using wall)
---------------------------------

.. index::
  single: wall
  single: broadcasted message

The ``wall`` command (provided by package ``bsdutils`` on a Debian GNU/Linux
system) causes a message to be broadcasted to every terminal::

  wall 'My message'


Using cron to display or broadcast a message
--------------------------------------------

.. index::
  single: crontab
  single: cron

Add a job to your crontab with::

  crontab -e

List the content of your crontab with::

  crontab -l

An :download:`example output of "crontab -l" (with a xmessage job)
<download/crontab_l>` is downloadable.
