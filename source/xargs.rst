xargs
=====

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: xargs


Introduction
------------

This page contains a few examples of the xargs command that I want to keep at
hand. I'm not very familiar with xargs and often resort to a "cheatsheet" (e.g.
`Mastering Xargs: Your Guide to Linux Command Efficiency
<https://ioflood.com/blog/xargs-linux-command/>`_) when I have to use it.


Splitting null terminated input items
-------------------------------------

.. index::
  single: cat
  pair: proc filesystem; environ
  pair: proc filesystem; cmdline

Sometimes you need to list the environement variables of a running Linux
process. If you just do ``cat /proc/<PID>/environ``, you get a single long line
of output with all the environement variables of the process with PID <PID>.
This is because the environement variables are separated by the null character.

There are at least two solutions based on xargs to get the environement
variables on separate lines::

  cat /proc/<PID>/environ | xargs -0 printf '%s\n'
  cat /proc/<PID>/environ | xargs -0 -L1

You can avoid the pipe with the ``-a`` option which instructs xargs to read
items from the specified file instead of standard input::

  xargs -0 -L1 -a /proc/<PID>/environ

All this also works for ``/proc/<PID>/cmdline`` (command line arguments of a
process). If you want the arguments separated by blanks on a single line do::

  xargs -0 -a /proc/<PID>/cmdline


Executing a command for each item
---------------------------------

A command like::

  any_command | xargs -n 1 other_command

causes ``other_command`` to be executed once for each item output by
``any_command``.


Executing a command for each item (with item used anywhere in the command)
--------------------------------------------------------------------------

.. index::
  single: cleartool

This makes use of the ``-I`` option of xargs. The "{}" following ``-I`` means
that later occurrences of "{}" are substituted with the item.

Here is an example involving the ``cleartool`` command (primary command-line
interface to `ClearCase <https://www.ibm.com/products/devops-code-clearcase>`_
version-control and configuration management software)::

  cleartool lsco -all -me -short -cview \
      | xargs -I {} sh -c \
      'diff --unified $(cleartool describe -fmt '%En@@%PVn\\\\n' {}) {}'

Other resources
---------------

* `xargs man page <https://linux.die.net/man/1/taskset>`_
* `Mastering Xargs: Your Guide to Linux Command Efficiency
  <https://ioflood.com/blog/xargs-linux-command/>`_
