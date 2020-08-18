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

This page is where I note the `sed <https://en.wikipedia.org/wiki/Sed>`_
commands I found difficult to elaborate.


Left-padding numbers with zeros
-------------------------------

.. index::
  pair: sed commands; loop
  pair: sed commands; s
  pair: sed commands; t

Let's say we have a file called "numbers" containing integer numbers (without
any sign):

| 123
| 4
| 5678
| 99999

The following Bash command line outputs the same numbers, but with leading
zeros (for the numbers having less than 4 digits)::

  N=4; cat numbers \
      | sed -e ":loop;s/^\([^:]\+\):\([0-9]\{1,$(($N-1))\}\):/\1:0\2:/;t loop"

| 0123
| 0004
| 5678
| 99999
