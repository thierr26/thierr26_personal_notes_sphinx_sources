bc
==

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: bc


Introduction
------------

This short page contains the `bc
<https://en.wikipedia.org/wiki/Bc_(programming_language)>`_ commands I want to
keep at hand. I'm a very very occasional user of bc, and the commands provided
on this page may not be the best solutions to the problems.


Convert a list of hexadecimal numbers to decimal
------------------------------------------------

.. index::
  single: tr

Let's say we have a text file called ``hexnum`` containing hexadecimal numbers
(one per line, uppercase or lower case):

| 1
| 10
| f
| FF

The following `Bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ command
line outputs the same numbers converted to decimal::

  while IFS= read -r LINE; \
     do echo "ibase=16; $(echo $LINE|tr '[:lower:]' '[:upper:]')" | bc; \
  done < hexnum


Convert a list of hexadecimal numbers to decimal and multiply by a constant
---------------------------------------------------------------------------

The following Bash command line does the same as the one except that the output
is multiplied by 0.00005::

  while IFS= read -r LINE; \
     do echo n="$(echo "ibase=16; \
         $(echo $LINE|tr '[:lower:]' '[:upper:]')" | bc); \
         n * 0.00005" | bc; \
  done < hexnum


Other resources
---------------

* `bc man page <https://linux.die.net/man/1/bc>`_
