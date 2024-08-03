taskset
=======

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: taskset


Introduction
------------

This short page contains the taskset commands I want to keep at hand.


Retrieving a running process's CPU affinity
-------------------------------------------

Retrieve the CPU affinity of prpocess with a given PID with a command like::

  taskset -c -p <PID>

CPUs are identified by a zero-based number.


Setting CPU affinity for a process (when launching it)
------------------------------------------------------

To set the CPU affinity of a process when you launch it prepend the command you
would normally use (like ``<COMMAND> <FIRST_ARGUMENT> <SECOND_ARGUMENT> ...``)
with ``taskset -c <CPU_LIST>``. Examples::

  taskset -c 0 <COMMAND> <FIRST_ARGUMENT> <SECOND_ARGUMENT> ...
  taskset -c 0,3,6-8 <COMMAND> <FIRST_ARGUMENT> <SECOND_ARGUMENT> ...


Other resources
---------------

* `taskset man page <https://linux.die.net/man/1/taskset>`_
