Email with nmh and other command-line programs
==============================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

.. index::
  single: email
  single: Claws Mail
  single: MH Message Handling System
  single: nmh
  single: POP3
  single: SMTP

I have a few email accounts that offer `POP3 access
<https://en.wikipedia.org/wiki/Post_Office_Protocol>`_ and I send my emails via
the `SMTP <https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol>`_
server of my Internet service Provider.

I'm a happy `Claws Mail <https://www.claws-mail.org>`_ (with the `Bogofilter
plugin <https://www.claws-mail.org/plugin.php?plugin=bogofilter>`_) user on my
`Debian GNU/Linux <https://www.debian.org>`_ box, but I'm interested in being
able to manage email via command-line programs. Claws Mail stores mails in the
so called MH mailbox format. This mailbox format is the one of the `MH Message
Handling System <https://en.wikipedia.org/wiki/MH_Message_Handling_System>`_, a
command-line based mail handling system.

`nmh <http://www.nongnu.org/nmh>`_ is the current implementation of the MH
system (provided by package nmh on a Debian GNU/Linux system). It is `possible
to use both Claws Mail and nmh
<http://lists.nongnu.org/archive/html/nmh-workers/2014-02/msg00049.html>`_.

This page gives the various actions I had to take to be able to receive and
send emails using the nmh command-line programs. Filtering the incoming
messages with `Bogofilter <http://bogofilter.sourceforge.net/>`_ (anti-spam
filter) is also covered.


Installation
------------

.. index::
  pair: exim4; installation
  pair: fetchmail; installation
  pair: nmh; installation
  single: path
  single: search path
  single: $PATH
  single: ~/.profile

On a `Debian GNU/Linux <https://www.debian.org>`_ system, install fetchmail and
nmh (**as root**) with::

  apt-get install fetchmail nmh mh-book # As root.

The nmh programs are installed in ``/usr/bin/mh``. This directory is not in the
search path by default. You can add it to the search path by adding this line
to your ``~/.profile`` file::

  PATH="$PATH:/usr/bin/mh"

This makes it possible to invoke the nmh programs by their base name (e.g.
``inc``) instead of their full path (e.g. ``/usr/bin/mh/inc``).

If exim4 is not already installed, install it (**as root**) with::

  apt-get install exim4 # As root.


Configuration
-------------


Exim4
~~~~~

.. index::
  pair: exim4; configuration
  single: sendmail

Configure Exim4 (**as root**) with::

  dpkg-reconfigure exim4-config # As root

I gave the following answers:

General type of mail configuration:
  mail sent by smarthost; received via SMTP or fetchmail

System mail name:
  Default value (<my_hostname>.<my_local_domain_name>)

IP-addresses to listen on for incoming SMTP connections:
  Default value (127.0.0.1 ; ::1)

Other destinations for which mail is accepted:
  Default value (<my_hostname>.<my_local_domain_name>)

Machine to relay mail for:
  Default value (empty)

IP address or host name of the outgoing smarthost:
  <smtp_server_host_name> (like "smtp.my_isp.xxx")

Hide local mail name in outgoing mail:
  Yes

Visible domain name for local users:
  <valid_mail_domain> (like "my_isp.xxx")

Keep number of DNS-queries minimal (Dial-on-demand):
  Default value (no) (note: I have a permanent internet connection)

Delivery method for local mail:
  mbox format in /var/mail/

Split configuration into small files:
  Default value (no)

As a test, I issued the following command which is supposed to send a mail
containing "Test" to a recipient (the -v switch is for verbosity)::

  /usr/sbin/sendmail -v recipient@example.com
  Test
  .

``/usr/sbin/sendmail`` is a symbolic link to exim4 executable.


fetchmail
~~~~~~~~~

.. index::
  pair: fetchmail; configuration
  single: .fetchmailrc

Create a ``~/.fetchmailrc`` file and change its permission so that only the
user can read and write it::

  chmod 600 ~/.fetchmailrc

You can :download:`download an example .fetchmailrc file with two POP3
connections defined <download/.fetchmailrc>`.


nmh user installation
~~~~~~~~~~~~~~~~~~~~~

.. index::
  pair: nmh; user installation
  single: .mh_profile

Perform nmh user installation with::

  install-mh

Here's the quote of my ``install-mh`` session:

| Do you want help? yes
|
| Prior to using nmh, it is necessary to have a file in your login
| directory (/home/my_user_name) named .mh_profile which contains information
| to direct certain nmh operations.  The only item which is required
| is the path to use for all nmh folder operations.  The suggested nmh
| path for you is /home/my_user_name/Mail...
|
| You already have the standard nmh directory "/home/my_user_name/Mail".
| Do you want to use it for nmh? yes
| [Using existing directory]
|
| Please see the nmh(7) man page for an introduction to nmh.
|
| Send bug reports, questions, suggestions, and patches to
| nmh-workers@nongnu.org.  That mailing list is relatively quiet, so user
| questions are encouraged.  Users are also encouraged to subscribe, and
| view the archives, at ``http://lists.gnu.org/mailman/listinfo/nmh-workers``
|
| If problems are encountered with an nmh program, they should be
| reported to the local maintainers of nmh, if any, or to the mailing
| list noted above.  When doing this, the name of the program should be
| reported, along with the version information for the program.
|
| To find out what version of an nmh program is being run, invoke the
| program with the -version switch.  This prints the version of nmh, the
| host it was compiled on, and the date the program was linked.
|
| New releases and other information of potential interest are announced
| at http://www.nongnu.org/nmh/ .


Retrieving mails
----------------

Without any filtering
~~~~~~~~~~~~~~~~~~~~~

.. index::
  pair: email; retrieval
  single: fetchmail
  pair: nmh; inc

Run the two following commands to retrieve mails::

  fetchmail       # Retrieves new mails.
  /usr/bin/mh/inc # Incorporates retrieved mails to the inbox folder of the nmh
                  # directory.

If the ``fetchmail`` command fails with a "upgrade to TLS failed" error message
as described in `one of messages of Debian bug #921450
<https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=921450#32>`_, use the
``--sslproto=""`` option::

  fetchmail --sslproto=""


With filtering by Bogofilter
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: procmail
  single: .procmailrc
  single: Bogofilter

Make sure procmail and bogofilter are installed::

  apt-get install procmail bogofilter # As root.

Create a ``~/.procmailrc`` like :download:`this example .procmailrc file
<download/.procmailrc>` and when invoking fetchmail, use the ``--mda``
option::

  fetchmail --mda "procmail -f %F"

This results in the messages classified as spam being moved automatically to
the "Spam" subdirectory of your nmh directory, and messages classified as
unsure to the "Unsure spam" subdirectory.

Note the "slash dot" after the subdirectory names in the ``~/.procmailrc``
file. That's how procmail knows that we're talking MH subdirectories. See here:
https://unix.stackexchange.com/a/336422

And also, don't forget to :ref:`train Bogofilter <training_bogofilter>`!


Sending a mail
--------------

.. index::
  pair: email; transmission
  single: /etc/nmh/components
  single: /etc/nmh/replcomps
  single: /etc/nmh/forwcomps
  single: components file
  pair: nmh; comp
  pair: nmh; send

Use ``/usr/bin/mh/comp``. This program opens the text editor (on my `Debian
GNU/Linux <https://www.debian.org>`_ system at least, on other system it may
just launch ``/usr/bin/mh/prompter``) so that you can edit the message draft.
Save and quit when you are done. You'll then get a prompt. Just hit "Enter" to
see the list of available commands. One of these commands is "send".

By default, ``/etc/nmh/components`` is used as message template. If your nmh
directory is ``/home/my_user_name/Mail``, you can put a custom ``components``
file there. It will be used automatically by ``/usr/bin/mh/comp``. You can
:download:`download an example components file with sender's name, address and
signature <download/nmh_custom_components/components>`.

To force ``/usr/bin/mh/comp`` to use a specific message template, use the
``-form`` switch::

  /usr/bin/mh/comp -form path/to/components/file

To send a message that has already been prepared and saved in a file, use
``/usr/bin/mh/send``::

  /usr/bin/mh/send path/to/message/file

nmh also offers other programs to send mails: ``repl`` (to reply to a message)
and ``forw`` (to forward a message) for example. They don't use the same
message templates as ``comp``. ``repl`` uses ``/etc/nmh/replcomps`` and
``forw`` uses ``/etc/nmh/forwcomps``.


Deleting mails
--------------

.. index::
  pair: email; deletion
  pair: nmh; rmm
  single: find

You can delete the mail with number 421 in the "Sent" folder with::

  rmm +Sent 421

This does not really delete the mail, but renames it to ",421". You may want to
periodically erase your deleted mails with a command like::

  find /home/my_user_name/Mail -name ,* -exec rm -f {} \;


.. _training_bogofilter:

Training Bogofilter (anti-spam filter)
--------------------------------------

.. index::
  pair: Bogofilter; training
  pair: find; -mindepth
  pair: find; -type
  pair: find; -not
  pair: find; -path
  pair: find; -exec

Assuming that your current working directory is your standard nmh directory and
your spam messages are in the "Spam" subfolder, you can (re)train Bogofilter
with the three following commands::

  rm -f ~/.bogofilter/wordlist.db # Don't do this if you don't want to entirely
                                  # reset the training.
  cat Spam/* | bogofilter -s
  find . -mindepth 1 -type f -not -path "./Spam/*" -exec cat {} \; \
      | bogofilter -n

You can check in which category (spam (S), ham (H), unsure (U)) Bogofilter
classifies a message with commands like::

  cat Spam/1 | bogofilter -t

Such commands output one line. The first character of the line is S, H or U.

Follow the `link for interesting details about how Bogofilter works (in
French) <http://bogofilter.sourceforge.net/>`_.


Other resources
---------------

* `nmh home page <http://www.nongnu.org/nmh>`_
* `MH & nmh (book by Jerry Peek) <https://rand-mh.sourceforge.io/book/>`_
* `Getting bogofilter to work with procmail, fetchmail, and mutt
  <http://www.exstrom.com/journal/comp/bogofilter.html>`_
