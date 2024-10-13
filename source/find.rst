find
====

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

.. index::
  single: find
  single: locate

This page presents some of the commands I've used to find files or to print
information about files on some GNU/Linux systems. They all invoke the ``find``
program. Keep in mind that in some cases (searching by file name substring),
:ref:`locate <installing_locate_updatedb>` is a faster alternative.


Searching with depth limitation
-------------------------------

The following command finds subdirectories (due to the ``-type d`` option) of
directory ``my/directory`` at depth 1 only. So it outputs the paths to the
immediate subdirectories of ``my/directory``::

  find my/directory -mindepth 1 -maxdepth 1 -type d


Searching by file permission
----------------------------

The following command finds regular files (due to the ``-type f`` option) under
directory ``my/directory`` with execution permission set for the owner::

  find my/directory -type f -perm -u+x


Printing dates
--------------

.. index::
  single: stat
  single: sort

The following command prints the date of the latest content change (equivalent
to the "Modify" date of ``stat``) for files under the current directory.
``%T@`` instructs find to print the date as seconds since Jan. 1, 1970, 00:00
GMT, with fractional part. ``%Tc`` instructs find to print the date as a local
date in human readable format. ``%p`` instructs find to print the file name::

  find . -printf "%T@ %Tc %p\n"

Using ``%T+``, you get a date format closer to `ISO 8601
<https://en.wikipedia.org/wiki/ISO_8601>`_::

  find -type f -printf "%T+ %p\n"


Executing one or more commands for each found file
--------------------------------------------------

.. index::
  single: sh
  single: stat

The ``-exec`` option of ``find`` makes it possible to execute a shell command
for each found file. For example, the following command runs ``stat`` for each
found file::

  find . -type f -exec stat {} \;

In the executed command, ``{}`` is a placeholder for the name of the file.

You can use the ``-exec`` option multiple times to execute multiple commands
for each found file::

  find . -type f -exec stat {} \; -exec md5sum {} \;

To execute sophisticated shell commands, you need to wrap them in a child shell
using for example ``sh -c``.

Here's a simple example::

  find . -type f -exec sh -c 'stat {} && md5sum {}' \;

And here is a more sophisticated example, which prints the output of multiple
commands on the same line::

  find . -type f \
    -printf '%p ' \
    -exec sh -c \
    'echo $(stat --format=%s "$1") $(md5sum "$1" | sed "s/ .\+$//")' \
    sh {} \;

For each found file, the command prints on the same line and separated by
spaces:

* the file name (due to the ``-printf '%p '`` part),

* the file byte size (due to the ``stat --format=%s "$1"`` part),

* the MD5 digest value (due to the ``md5sum "$1"`` part, the piping to ``sed``
  is used to remove the file name from the ``md5sum`` output).


Combining (logical "or") search criteria
----------------------------------------

You can use the ``-or`` option of ``find`` to combine search criteria. For
example, to find files with a name that contains "foo" or "bar", use (note the
escaped parentheses)::

  find . -type f \( -name "*foo*" -or -name "*bar*" \)


Counting found files
--------------------

.. index::
  single: wc

When you need to count the found files (and not print their name), you can use
a command like::

  find . type f -exec printf %c {} + | wc -c

The ``printf %c`` part causes the name of each found files to be printed as a
single character (a dot). The ``+`` causes the whole output to be on a single
line (without end of line sequence) and ``wc -c`` counts the number of
character in the output line.


Printing full paths
-------------------

.. index::
  pair: Bash; ~+
  single: pwd

The ``find`` command prints the found files names as relative or absolute paths
depending on how the searched directories were specified.

Of course, a common case is searching in the current directory with a command
starting with ``find .``. ``.`` designates the current directory **relative
to** the current directory. This causes ``find`` to print the found files names
as relative.

If you want to get the full files names instead, and **assuming your shell is
Bash**, the easiest way is to use ``~+`` instead of ``.``. Bash expands ``~+``
to the current directory.

A much more portable alternative is to use ``pwd``::

  find "$(pwd)" ...


Other resources
---------------

* `find man page <https://linux.die.net/man/1/find>`_
