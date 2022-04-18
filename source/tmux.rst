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
  single: xterm
  pair: tmux; installation
  pair: tmux-resurrect; installation

On a `Debian GNU/Linux <https://www.debian.org>`_ system, install tmux (**as
root**) with::

  apt-get install tmux # As root.

You can launch tmux with command ``tmux``. I always use tmux in an `xterm
<https://en.wikipedia.org/wiki/Xterm>`_ and launch both with a single ``xterm
tmux`` command.

You may need the tmux-resurrect plugin. You can install it that way (as an
unprivileged user)::

  mkdir -p ~/.tmux/plugins
  cd ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tmux-resurrect resurrect

At the time of this writing (2022-04-17), current version of tmux-resurrect is
4.0.0. I have experienced som issues with session restoration with version
4.0.0 so **I'm sticking with version 3.0.0 for now**::

  git checkout v3.0.0

The default key bindings for tmux-resurrect are ``prefix Ctrl-s`` (save
session) and ``prefix Ctrl-r`` (restore session).


Configuration
-------------

.. index::
  pair: tmux; configuration


My .tmux.conf
~~~~~~~~~~~~~

.. index::
  single: ~/.tmux.conf
  pair: tmux commands; source-file
  pair: tmux; status line
  single: strftime (C library function)
  single: Caps lock mode
  single: Num lock mode
  single: head
  single: grep
  single: cat
  pair: laptop; power supply
  pair: laptop; battery

You can download :download:`my ~/.tmux.conf <download/.tmux.conf>`.

I had a little bit of a hard time defining the ``status-right`` option (the
right hand side of the status line). It causes the right hand side of the
status line to show:

* A Caps lock mode indicator (a yellow "Caps lock on" when Caps lock is **on**,
  nothing visible otherwise).

* A Num lock mode indicator (a yellow "Num lock off" when Caps lock is **off**,
  nothing visible otherwise).

* A power supply indicator ("CHG" if the machine is plugged in, "BAT" if the
  machine is running on the battery, nothing visible if the information is not
  found).

* The remaining capacity of charge in the battery in percent (yellow if lower
  than 20% and machine not plugged in, nothing visible if the information is
  not found).

* Time and date, with the day of the week.

The time / date part was easy enough, the format specification is passed
through `strftime(3) <https://linux.die.net/man/3/strftime>`_. The sole time /
date part could be obtained with ``set -g status-right "%H:%M %Y-%m-%d(%a)"``.

I could obtain the other parts using shell commands. The shell commands must be
enclosed in a ``#()`` construct. So my ``status-right`` option "line" now is
something like
``set -g status-right "#(<shell commands>) %H:%M %Y-%m-%d(%a)"``.

When multiple and/or long shell commands are needed, one solution is to write
them in a separate script file and just call the script file in the ``#()``
construct. Another solution is to use line continuation. Lines can be
continuated by adding ``\`` at the end. That's the route I went, and my
``status-right`` option "line" now is more like::

  set -g status-right "#(\
  <shell \
  commands>\
  ) %H:%M %Y-%m-%d(%a)"

The shell commands actually ended up being a sequence of calls to ``printf``
in ``if ... else ... fi;`` constructs. Text coloring in the tmux status line is
controlled using strings like ``#[fg=colour184]``. Example::

  set -g status-right "#(printf '#[fg=colour184]yellow#[fg=colour0] black') %a"

The Caps lock mode indicator is build from the content of a file like
``/sys/class/leds/input5::capslock/brightness``. But there might be multiple
files like this one (if you have multiple keyboards plugged in to your
machine). You can ``cat`` only one of them with a command like (from my
experience, they all have the same content at a given time)::

  cat $(find /sys/class/leds -name "*capslock"|head -1)/brightness

Similarly, for Num lock mode::

  cat $(find /sys/class/leds -name "*numlock"|head -1)/brightness

The power supply indicator is build from the content of the
``/sys/class/power_supply/AC/online`` if it exists (from my experience, and on
a Debian system, it exists on a laptop computer but not on a desktop computer).

Finally, the remaining capacity of charge in the battery is taken in file
``/sys/class/power_supply/BAT/capacity`` if it exists. It exists on my Debian
laptop. On other systems, the file may be
``/sys/class/power_supply/BAT0/capacity`` instead. And some laptop have two
batteries. My ``status-right`` option displays the remaining capacity for only
one battery.

Determining whether the remaining capacity is lower than 20% or not is achieved
by piping the remaining capacity to a ``grep '\(^\|[0-1]\).$'`` command. If the
output is non empty, then the remaining capacity is lower than 20%. Note that
in the ``~/.tmux.conf`` the backslashes must be escaped:
``grep '\\(^\\|[0-1]\\).$')``.

Note also the format string in the ``printf`` command for the remaining
capacity. The percent sign must be tripled
(``printf '% 3d%%%' $(cat /sys/class/power_supply/BAT/capacity);``).

I've set the refresh rate of the status line to 3 seconds::

  set -g status-interval 3

And I also had to specify the ``status-right-length`` option, without that the
status line is truncated::

  set -g status-right-length 56


Reloading configuration
~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  pair: tmux; source-file

After changing your ``~/.tmux.conf``, you can reload it with::

  tmux source-file ~/.tmux.conf


Disabling control flow
~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: control flow
  single: stty

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
    do printf "\x1b[38;5;${i}mcolour%-5i\x1b[0m" $i; \
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

I usually have only one tmux session and I close it with ``prefix s`` (which
brings you to a "session list" screen), and then ``x`` to require to stop the
current session and ``y`` to confirm.


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

To swap two windows, enter command mode with ``prefix :`` and type a command
like ``swap-window -s 3 -t 1``. This command swaps numbering of windows 3 and
1.


Zooming a window to fit it to full terminal size
------------------------------------------------

.. index::
  single: kill
  pair: signal; SIGCONT

Just use ``prefix z``. This does also unzoom the window.

Doing this I sometimes accidentally hit ``Ctrl-z``, which suspends the tmux
process. The solution in this case is to grab another terminal, to `find the
PID <https://www.configserverfirewall.com/linux-tutorials/how-to-get-pid-of-a-process/>`_
of the tmux process and to send a SIGCONT signal to it::

  kill -cont <PID>


Other resources
---------------

* `tmux cheatsheet <https://tmuxcheatsheet.com/>`_

