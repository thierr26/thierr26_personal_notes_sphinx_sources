hexdump
=======

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: hexdump


Introduction
------------

This short page contains the hexdump commands I want to keep at hand.


Byte-by-byte output, with input offset and ASCII representation
---------------------------------------------------------------

This is what the ``-C`` option is for::

  hexdump -v -C input_file


Byte-by-byte output only
------------------------

I use a format string for that (16 is the number of bytes per line)::

  hexdump -v -e '16/1 "%02x " "\n"' input_file


Other resources
---------------

* `hexdump man page <https://linux.die.net/man/1/hexdump>`_
