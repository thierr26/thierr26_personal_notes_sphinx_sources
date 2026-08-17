AWK
===

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: awk


Introduction
------------

I don't use `AWK <https://en.wikipedia.org/wiki/AWK>`_ very often and so am not
very comfortable with it. I wrote on this page a few AWK commands I used. They
may be helpful as a starting point next time I need AWK.

Note that the commands on this page have been tested with `GNU AWK
<https://www.gnu.org/software/gawk>`_.


Extracting one or more columns from a CSV file
----------------------------------------------

.. index::
  single: Comma-separated values
  single: CSV file

A command like the following prints the input file (a `comma-separated value
<https://en.wikipedia.org/wiki/Comma-separated_values>`_ file), but keeping
only columns 1 and 3::

  awk -F',' '{printf "%s,%s\n", $1, $3}' my_table.csv

The ``-F`` option specifies the delimiter. When omitted, the delimiter defaults
to blank character (space or tabulation).

If you need to extract only one column (say column 2), you can just do::

  awk -F',' '{print $2}' my_table.csv


Filtering, but keeping the first line (headers)
-----------------------------------------------

There is a AWK command on my :doc:`Linux firewalling <linux_firewalling>`
page::

  awk "NR == 1 || /[0-9a-zA-Z\]]:(22 |68 |3142 |5353 )/"

The ``||`` symbol is a logical or, the ``NR == 1`` condition is true when AWK
is processing the first "record" (i.e. the first input line) and the rest
specifies a `regular expression
<https://www.math.utah.edu/docs/info/gawk_5.html>`_.

The regular expression matches strings containing successively:

* A digit, letter or closing square bracket,
* A colon (:),
* One of the following strings: "22 ", "68 ", "3142 ", "5353 ".

The whole command leads AWK to print the first input line and all lines
matching the regular expression.


Removing leading and trailing blank lines
-----------------------------------------

The following AWK command comes directly from `this Stack Overflow discussion
about the removal of leading / trailing blank lines
<https://stackoverflow.com/questions/7359527/removing-trailing-starting-newlines-with-sed-awk-tr-and-friends>`_::

  awk '/[[:graph:]]/ {
           p=1;
           for (i=0; i<n; i++) {
               print "";
           }
           n=0;
           print;
       }
       p && /^[[:space:]]*$/ {
           n++;
       };'

In the command, there are two instruction sequences.

The first one is executed for input lines that contain at least one character
in the "graphical" class (i.e. at least one printable and visible character).
Note that executing this instruction sequence causes ``p`` to be set to 1.
(Before that, ``p`` is 0 due to implicit initialization to 0.)

The second one is executed for input lines that contain only characters in the
"space" class (which most notably contains space and tabulation), and (due to
the ``p &&`` part) only if p is non zero (i.e. if at least one non blank line
has already been seen). The instruction sequence just counts the successive
blank lines.

The ``for`` loop in the first instruction sequence output the blank lines
before printing a non blank line.

All in all, the whole command ignores any blank line as long a non blank line
has not been seen (thus "removing leading blank lines"), and does not output
blank lines if no non blank line is coming after (thus "removing trailing blank
lines").

You can find the full list of character classes in `"Effective AWK Programming
(section "Using Bracket Expressions")"
<https://docs.jade.fyi/gnu/gawk/gawk.html#Using-Bracket-Expressions>`_.

If you consider only strictly empty lines as blank lines, you can remove
``[[:space:]]*`` in the command and keep only ``^$`` in the regular expression.
