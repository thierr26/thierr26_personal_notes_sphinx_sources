PDF files manipulation with command-line programs
=================================================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

.. index::
  single: Ghostscript
  single: Poppler
  single: PDFtk
  single: PDF

This short page is where I keep track of the commands I use to manipulate `PDF
<https://en.wikipedia.org/wiki/PDF>`_ files with my `Debian GNU/Linux
<https://www.debian.org>`_ box.

Those commands are actually invocations of ``gs``, ``ps2pdf`` (both provided by
package ``ghostscript``) and ``pdf2text`` (provided by package
``poppler-utils``).

`PDFtk <https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit>`_ might be a
solution as well, but I haven't used it yet.


Merging ("concatenating") PDF files
-----------------------------------

.. index::
  single: gs

Merge files doc_1.pdf, doc_2.pdf and doc_3.pdf to file output.pdf with::

  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=output.pdf \
      doc_1.pdf doc_2.pdf doc_3.pdf


Extracting specified pages from a PDF file
------------------------------------------

.. index::
  single: gs

Extract pages 2 to 4 from file input.pdf to file output.pdf with::

  gs -sDEVICE=pdfwrite -q -dNOPAUSE -dBATCH -sOutputFile=output.pdf \
      -dFirstPage=2 -dLastPage=4 input.pdf


Removing a password from a PDF file
-----------------------------------

.. index::
  single: gs

Assuming the file input.pdf is password-protected and that you know the
password, create file output.pdf as a copy of file input.pdf, but with no
protection with::

  gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sPDFPassword="the password"
  -sOutputFile=output.pdf input.pdf

(Provide the password via the ``-sPDFPassword`` option.)


Reducing PDF file size
----------------------

.. index::
  single: ps2pdf

I observe that a command like::

  ps2pdf input.pdf output.pdf

duplicates input.pdf to output.pdf, but with a smaller size. Not sure what's
going on here. It might a matter of default settings (`-dPDFSETTINGS option
<https://ghostscript.readthedocs.io/en/gs10.0.0/VectorDevices.html#controls-and-features-specific-to-postscript-and-pdf-input>`_)


Converting PDF file to plain text file
--------------------------------------

.. index::
  single: pdftotext

Convert PDF file input.pdf to plain text file output.txt with::

  pdftotext input.pdf output.txt

With the ``-layout`` option, the original physical layout of the text is
preserved as best as possible::

  pdftotext -layout input.pdf output.txt


Other resources
---------------

* `Ghostscript user documentation
  <https://ghostscript.readthedocs.io/en/latest/Use.html>`_

