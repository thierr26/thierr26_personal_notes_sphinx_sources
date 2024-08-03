Listing a Linux process's threads
=================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: threads


Introduction
------------

This page presents the commands I've used to "see" the threads of a Linux
process. They're invocations of programs ps, top or chrt.


With ps
-------

.. index::
  single: ps

The following ``ps`` commands provide information about the threads of a
process with a given PID::

  ps -T -p <PID>
  ps -L -p <PID>
  ps -mo pid,tid,%cpu,psr,comm -p <PID>


With top
--------

.. index::
  single: top

The following command provides a dynamic real-time view of the threads of a
process with a given PID::

  top -H -p <PID>

Add a ``-n 1`` option to have just a non dynamic listing::

  top -H -n 1 -p <PID>

With the ``-b`` switch (Batch mode), there is no highlighting in the output,
which is preferable when you redirect the output to another program or to a
file::

  top -H -bn 1 -p <PID>

You can control the top output width with the ``-w`` switch::

  top -w 50 -H -bn 1 -p <PID>


With chrt
---------

.. index::
  single: chrt

Using ``chrt`` you can see the scheduling policy and the priority of the
threads of a process with a given PID::

  chrt -a -p <PID>
