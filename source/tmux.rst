tmux
====

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


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


Configuration
-------------

.. index::
  pair: tmux; configuration
  pair: .tmux.conf


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
