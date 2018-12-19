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

The default key bindings for tmux-resurrect are :code:`prefix + Ctrl-s` (save
session) and :code:`prefix + Ctrl-r` (restore session).


Configuration
-------------

.. index::
  pair: tmux; configuration
  single: .tmux.conf


My .tmux.conf
~~~~~~~~~~~~~

You can download :download:`my ~/.tmux.conf <download/.tmux.conf>`.


Disabling control flow
~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: control flow

You should probably disable control flow by adding this line to your
:code:`~/.bashrc`::

  stty -ixon

You can find more details about that in Tom Ryder's `Terminal annoyances blog
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
  single: .vimrc

.. highlight:: vim

Enable the use of the mouse in terminal Vim by adding this line to your
:code:`~/.vimrc`::

  set mouse=a

.. highlight:: shell


Listing / killing tmux sessions
-------------------------------

.. index::
  pair: tmux; list sessions
  pair: tmux; ls
  pair: tmux; kill all sessions
  pair: tmux; kill-server
  pair: tmux; kill session
  pair: tmux; kill all other sessions
  pair: tmux; kill-session

List your opened tmux sessions with::

  tmux ls

Kill all the opened tmux sessions and the tmux server with::

  tmux kill-server

If you're in a tmux session and want to kill all the other sessions, use::

  tmux kill-session -a

To kill a specific session, read session number from :code:`tmux ls` and do::

  tmux kill-session -t session_number
