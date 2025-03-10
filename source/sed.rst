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

Let's say we have a text file called ``numbers`` containing integer numbers
(one per line, and without any sign):

| 123
| 4
| 5678
| 99999

The following command outputs the same numbers, but with leading zeros (for the
numbers having less than 4 digits)::

  sed -e ":redo;s/^\([0-9]\{1,3\}\)$/0\1/; t redo" numbers

| 0123
| 0004
| 5678
| 99999

The ``t`` command causes sed to restart at the ``:redo`` label as long as the
``s`` command performs a substitution. The ``s`` command here substitutes a
line with a number made of one to three digits with the same number with a zero
prepended.

Here is the same command with the parameter (number of digits) set as a shell
variable::

  N=4; sed -e ":redo; s/^\([0-9]\{1,$(($N-1))\}\)$/0\1/; t redo" numbers


Substituting starting at a specific line number
-----------------------------------------------

.. index::
  pair: sed commands; addresses specifications
  pair: sed commands; s

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


Deleting one out of N lines
---------------------------

.. index::
  pair: sed commands; addresses specifications
  pair: sed commands; d

To drop one out of three (for example) lines from file ``f``, starting at line
(for exemple) 2, use the following command::

  sed "2~3d" f

The ``d`` here is for "delete".

See `the "addresses" section of the GNU sed manual
<https://www.gnu.org/software/sed/manual/html_node/sed-addresses.html#sed-addresses>`_
for all the details about line selection.


Joining lines matching a pattern
--------------------------------

.. index::
  pair: sed commands; N
  pair: sed commands; t
  pair: sed commands; P
  pair: sed commands; D
  pair: sed commands; s

Still taking the same example file, the following command substitutes the
preceding end of line sequence with a space character if the line matches a
pattern (here pattern "67")::

  sed -e ':redo; N; s/\n\(.*67\)/ \1/; t redo; P; D' numbers

The ``N`` command adds the next input line into the pattern space. The ``s``
command substitutes the end of line sequence with a space if the added line
contains the searched pattern. The ``t`` command causes sed to restart at the
``:redo`` label as long as the ``s`` command performs a substitution. After
exiting the loop, the ``P`` command causes the pattern space to be output up to
the first end of line sequence and the ``D`` command deletes the pattern space
up to the first end of line sequence (only if the pattern space contains an end
of line sequence).


Keep end of line only for lines matching a pattern
--------------------------------------------------

.. index::
  pair: sed commands; N
  pair: sed commands; b

Let's say we have a text file called ``f`` with the following content:

| f
| o
| o
| b
| a
| r
| b
| a
| z
| .

The following command outputs the same content but with end of lines removed
except for lines matching "o", "r" or "z"::

  sed ":redo /[orz]/b; N; s/\n//; b redo" f

| fo
| o
| bar
| baz
| .

For lines matching ``[orz]``, nothing special is done which implies that all
the content accumulated in memory is output. (The ``b`` in ``/[orz]/b;`` means
"branch to end of script".)

Other lines are accumulated in memory (thanks to ``N;``), their end of line is
removed (``s/\n//;``) and they're not output immediately. (The ``b redo``
causes a jump to the ``:redo`` label.)


Filter by line numbers
----------------------

.. index::
  pair: sed commands; p
  pair: sed commands; d

The following pages show how to use sed to solve some line number-based output
problems:

* `Printing Specified Lines From a File
  <https://www.baeldung.com/linux/print-specified-lines-file>`_,
* `Read a Specific Line From a File in Linux
  <https://www.baeldung.com/linux/read-specific-line-from-file>`_.

Here are a few more examples.

To output lines number 2 to 4 and 7 to 9 of file ``f``, do::

  sed -n '2,4p; 7,9p;' f

To output all but lines number 2 to 4 of file ``f``, do::

  sed '2,4d;' f
