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

I'm a happy `Claws Mail <https://www.claws-mail.org>`_ user on my `Debian
GNU/Linux <https://www.debian.org>`_ box, but I'm interested in being able to
manage email via command-line programs. Claws Mail stores mails in the so
called MH mailbox format. This mailbox format is the one of the `MH Message
Handling System <https://en.wikipedia.org/wiki/MH_Message_Handling_System>`_, a
command-line based mail handling system.

`nmh <http://www.nongnu.org/nmh>`_ is the current implementation of the MH
system (provided by package ``nmh`` on a Debian GNU/Linux system). It is
`possible to use both Claws Mail and nmh
<http://lists.nongnu.org/archive/html/nmh-workers/2014-02/msg00049.html>`_.

This page gives the various actions I had to take to be able to receive and
send emails using the nmh command-line programs. Filtering the incoming
messages with `Bogofilter <http://bogofilter.sourceforge.net/>`_ (anti-spam
filter) is also covered. Some basic commands for message management (deletion,
search) are also provided. Of course, nmh programs have many options that are
not covered here. Please refer to the `nmh man pages
<http://manpages.org/nmh/7>`_ for all the details.


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
  single: dpkg-reconfigure

Configure Exim4 (**as root**) with::

  dpkg-reconfigure exim4-config # As root.

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
containing "Test" to a recipient. The -v switch is for verbosity. I notice that
the mails that I send that way are not delivered to all recipients. So **there must be something wrong**. I don't know what exactly, probably something that
makes those mails appear as spam to certain filter programs::

  /usr/sbin/sendmail -v recipient@example.com
  Test
  .

``/usr/sbin/sendmail`` is a symbolic link to exim4 executable.

You can specify the "from" address using a -f switch on the command line and
specify the mail subject by starting the message with a ``subject:`` line::

  /usr/sbin/sendmail -f sender@example.com -v recipient@example.com
  subject:The subject
  The mail body.
  .


fetchmail
~~~~~~~~~

.. index::
  pair: fetchmail; configuration
  single: ~/.fetchmailrc
  single: chmod

Create a ``~/.fetchmailrc`` file and change its permission so that only the
user can read and write it::

  chmod 600 ~/.fetchmailrc

You can :download:`download an example .fetchmailrc file with two POP3
connections defined <download/.fetchmailrc>`.


nmh user installation
~~~~~~~~~~~~~~~~~~~~~

.. index::
  pair: nmh; user installation
  single: ~/.mh_profile

Perform nmh user installation with::

  /usr/bin/mh/install-mh

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
  single: ~/.procmailrc
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


Message management
------------------

.. index::
  pair: nmh; folder

This section provides a few examples of commands you can use to manage the
messages in your MH mailbox with nmh. Please keep in mind that nmh message
management programs operate by default on *the current folder*. You can set the
current folder with the ``folder`` program::

  /usr/bin/mh/folder +'any folder' # Selects folder "any folder" as the current
                                   # folder.

  /usr/bin/mh/folder +any/folder   # Selects folder "any/folder" subfolder as
                                   # the current folder.

  /usr/bin/mh/folder +./any/folder # Selects folder "any/folder" subfolder as
                                   # the current folder (valid if the current
                                   # working directory is the MH mailbox).

``folder`` without arguments simply indicates the current folder::

  /usr/bin/mh/folder

You can force an nmh program to operate on a specific folder by providing this
folder as argument (prepended with a plus sign). Note that with most nmh
programs, **this causes this folder to be selected as the current folder for
the subsequent commands**.

Note also that when no message (or `message sequence
<http://manpages.org/mh-sequence/5>`_) is provided on the command line, an nmh
program operates on the current message **or** on all messages in the current
folder. The `nmh man pages <http://manpages.org/nmh/7>`_ state clearly what the
default message (or message sequence) is for each program.


Deleting mails
~~~~~~~~~~~~~~

.. index::
  pair: email; deletion
  pair: nmh; rmm
  single: find

You can delete the mail with number 421 in the "Sent" folder with::

  /usr/bin/mh/rmm +Sent 421

This does not really delete the mail, but renames it to ",421". You may want to
periodically erase your deleted mails with a command like::

  find /home/my_user_name/Mail -name ,* -exec rm -f {} \;


Searching for recent messages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  pair: email; search
  pair: nmh; pick
  pair: find; -mindepth
  pair: find; -type
  pair: find; -exec
  single: echo

You can search for recent messages with commands like::

  /usr/bin/mh pick -after 5/15/2019 # Searches for messages dated May 5th, 2019
                                    # or later.

  /usr/bin/mh pick -after -8        # Searches for messages not older than 8
                                    # days.

I couldn't find a way of finding messages recursively (i.e. in all folders and
subfolders) with nmh programs, but the ``find`` command can help here (it is
assumed that the current working directory is the MH mailbox)::

  find . -mindepth 1 -type d -exec sh -c \
      '/usr/bin/mh/pick +"$1" -after -8 2>/dev/null \
      && echo "This was for $1"' - {} \;


.. _training_bogofilter:

Training Bogofilter (anti-spam filter)
--------------------------------------

.. index::
  pair: Bogofilter; training
  single: ~/.bogofilter
  single: spam
  single: ham
  pair: find; -mindepth
  pair: find; -type
  pair: find; -not
  pair: find; -path
  pair: nmh; refile

Assuming that:

* Your current working directory is your MH mailbox,
* Your spam messages are in the "Spam" folder,
* Your trash folder (if any) is empty,
* You also have an "Unsure spam" folder that contains only spam messages (which
  implies that you have moved any ham (non spam) message away from this folder
  with (for example) commands like
  ``/usr/bin/mh/refile 1 -src +'Unsure spam' +'Any ham folder'``),

you can move the messages in 'Unsure spam' to Spam and (re)train Bogofilter
with the following commands::

  rm -rf ~/.bogofilter                 # Don't do this if you don't want to
                                       # entirely reset the training.

  refile all -src +'Unsure spam' +Spam # Moves the messages in 'Unsure spam' to
                                       # Spam.

  rm 'Unsure spam'/*                   # Actually delete files in 'Unsure spam'

  bogofilter -vsB Spam                 # Registers spam messages.

  find . -mindepth 1 \
         -type d \
         -not -path "\./Spam" \
    | bogofilter -vnb                  # Registers ham messages.

You can check in which category (spam (S), ham (H), unsure (U)) Bogofilter
classifies a message with commands like::

  bogofilter -tB Spam/1

Such commands output one line. The first character of the line is S, H or U.

Follow the `link for interesting details about how Bogofilter works (in
French) <http://bogofilter.sourceforge.net/>`_.


Other resources
---------------

* `nmh home page <http://www.nongnu.org/nmh>`_
* `MH & nmh (book by Jerry Peek) <https://rand-mh.sourceforge.io/book/>`_
* `nmh man pages <http://manpages.org/nmh/7>`_
* `Getting bogofilter to work with procmail, fetchmail, and mutt
  <http://www.exstrom.com/journal/comp/bogofilter.html>`_
