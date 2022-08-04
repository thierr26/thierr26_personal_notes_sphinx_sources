Sed
===

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: sed


Introduction
------------

This page is where I note the `GNU sed <https://www.gnu.org/software/sed/>`_
commands I found difficult to elaborate.


Left-padding numbers with zeros
-------------------------------

.. index::
  pair: sed commands; loop
  pair: sed commands; s
  pair: sed commands; t

Let's say we have a file called ``numbers`` containing integer numbers (without
any sign):

| 123
| 4
| 5678
| 99999

The following Bash command line outputs the same numbers, but with leading
zeros (for the numbers having less than 4 digits)::

  sed -e ":redo;s/^\([0-9]\{1,3\}\)$/0\1/; t redo" numbers

| 0123
| 0004
| 5678
| 99999

The ``t`` command causes sed to restart at the ``:redo`` label as long as the
``s`` command performs a substitution. The ``s`` command here substitutes a
line with a number made of one to three digits with the same number with a zero
prepended.

Here is the same command with the parameter (number of digits) set as a bash
variable::

  N=4; sed -e ":redo; s/^\([0-9]\{1,$(($N-1))\}\)$/0\1/; t redo" numbers


Substituting starting at a specific line number
-----------------------------------------------

.. index::
  pair: sed commands; addresses specifications

Taking the same example file as in the previous section, if you need to add a
leading minus sign starting at line 3, you can use the following command::

  sed "3,/\d0/s/^/-/" numbers

Here "3" is the first line where the substitution should be done and "/\d0/" is
a regular expression used to match the last line where the substitution should
be done (starting on the line following line 2 in this case). "/\d0/" does not
match any line (well, unless you have null characters in your input), so the
substitution is done on every remaining line.

See `the "addresses" section of the GNU sed manual
<https://www.gnu.org/software/sed/manual/html_node/sed-addresses.html#sed-addresses>`_
for all the details about line selection.


