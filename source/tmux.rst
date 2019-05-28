tmux
====

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

I appreciate `tmux (a terminal multiplexer)
<https://en.wikipedia.org/wiki/Tmux>`_ for its window management features. For
terminal based activities, it can be an alternative to using a `tiling window
manager <https://en.wikipedia.org/wiki/Tiling_window_manager>`_.


Installation
------------

.. index::
  pair: tmux; installation
  pair: tmux-resurrect; installation

On a `Debian GNU/Linux <https://www.debian.org>`_ system, install tmux (**as
root**) with::

  apt-get install tmux # As root.

You may need the tmux-resurrect plugin. You can install it that way (as an
unprivileged user)::

  mkdir -p ~/.tmux/plugins
  cd ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tmux-resurrect resurrect

The default key bindings for tmux-resurrect are ``prefix Ctrl-s`` (save
session) and ``prefix Ctrl-r`` (restore session).


Configuration
-------------

.. index::
  pair: tmux; configuration
  single: ~/.tmux.conf


My .tmux.conf
~~~~~~~~~~~~~

You can download :download:`my ~/.tmux.conf <download/.tmux.conf>`.


Disabling control flow
~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: control flow

You should probably disable control flow by adding this line to your
``~/.bashrc``::

  stty -ixon

You can find more details about that in Tom Ryder's `"Terminal annoyances" blog
post <https://sanctum.geek.nz/arabesque/terminal-annoyances>`_.


Colors
~~~~~~

.. index::
  pair: tmux; colors

The following command shows the colors that can be used in a tmux
configuration (source: https://superuser.com/a/1104214)::

  for i in {0..255}; \
    do printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i; \
    if ! (( ($i + 1 ) % 8 )); then echo; fi; \
  done


Vim configuration
~~~~~~~~~~~~~~~~~

.. index::
  triple: tmux; Vim; configuration
  pair: Vim; mouse
  single: ~/.vimrc

.. highlight:: vim

Enable the use of the mouse in terminal Vim by adding this line to your
``~/.vimrc``::

  set mouse=a

.. highlight:: shell


Listing / killing tmux sessions
-------------------------------

.. index::
  pair: tmux commands; list sessions
  pair: tmux commands; ls
  pair: tmux commands; kill all sessions
  pair: tmux commands; kill-server
  pair: tmux commands; kill session
  pair: tmux commands; kill all other sessions
  pair: tmux commands; kill-session

List your opened tmux sessions with::

  tmux ls

Kill all the opened tmux sessions and the tmux server with::

  tmux kill-server
  tmux confirm-before kill-server # Prompts the user for confirmation in
                                  # tmux status bar.

If you're in a tmux session and want to kill all the other sessions, use::

  tmux kill-session -a

To kill a specific session, read session ID from ``tmux ls`` and do::

  tmux kill-session -t <session_id>


Detaching client / attaching session
------------------------------------

.. index::
  pair: tmux commands; attach
  pair: tmux commands; detach

Detach the current client with ``prefix d`` or::

  tmux detach

Reattach with one off::

  tmux attach
  tmux a
  tmux attach -d -t <session_id> # To attach to a specific session.
                                 # -d causes any other clients attached to the
                                 # session to be detached.


Managing windows and panes
--------------------------

.. index::
  pair: tmux; windows
  pair: tmux; panes

Create a new window with ``prefix c``.

Rename the current window with ``prefix ,``.

Close the current window with ``prefix &``.

Split pane vertically with ``prefix %``.

Split pane horizontally with ``prefix "``.

Resize pane with ``prefix + left/down/up/right arrow``. See also `this article
by Michael Lee <https://michaelsoolee.com/resize-tmux-panes/>`_.


Other resources
---------------

* `tmux cheatsheet <https://tmuxcheatsheet.com/>`_

