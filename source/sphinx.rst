Sphinx
======

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

`Sphinx <http://www.sphinx-doc.org/en/master>`_ is the tool I settled on to
create this static website. Sphinx is primarily designed to create
documentation for `Python
<https://en.wikipedia.org/wiki/Python_(programming_language)>`_ projects, but
it is also appropriate as a `static website generator
<https://www.fullstackpython.com/static-site-generator.html>`_ (as others `have
<https://nudgedelastic.band/2017/07/why-use-restructuredtext-and-sphinx-static-site-generator-for-maintaining-teaching-materials/>`_
`pointed <http://echorand.me/site/notes/articles/sphinx/static_html.html>`_
`out <http://www.numericalexpert.com/blog/sphinx2website/>`_).


Installation
------------

.. index::
  pair: Sphinx; installation

On a `Debian GNU/Linux <https://www.debian.org>`_ system, install Sphinx (**as
root**) with::

  apt-get install python-sphinx # As root.


Starting a project
------------------

.. index::
  pair: Sphinx; sphinx-quickstart

To create a new Sphinx project, create a directory, move to that directory and
run ``sphinx-quickstart``::

  mkdir my_sphinx_project
  cd my_sphinx_project
  sphinx-quickstart

``sphinx-quickstart`` is an interactive command. Here's the quote of the
``sphinx-quickstart`` session run to start this "Personal Notes" project
you are currently reading:

| Welcome to the Sphinx 1.7.9 quickstart utility.
|
| Please enter values for the following settings (just press Enter to
| accept a default value, if one is given in brackets).
|
| Selected root path: .
|
| You have two options for placing the build directory for Sphinx output.
| Either, you use a directory "_build" within the root path, or you separate
| "source" and "build" directories within the root path.
| > Separate source and build directories (y/n) [n]: y
|
| Inside the root directory, two more directories will be created; "_templates"
| for custom HTML templates and "_static" for custom stylesheets and other static
| files. You can enter another prefix (such as ".") to replace the underscore.
| > Name prefix for templates and static dir [_]: 
|
| The project name will occur in several places in the built documentation.
| > Project name: Personal Notes
| > Author name(s): My Name
| > Project release []: 
|
| If the documents are to be written in a language other than English,
| you can select a language here by its language code. Sphinx will then
| translate text that it generates into that language.
|
| For a list of supported codes, see
| http://sphinx-doc.org/config.html#confval-language.
| > Project language [en]: 
|
| The file name suffix for source files. Commonly, this is either ".txt"
| or ".rst".  Only files with this suffix are considered documents.
| > Source file suffix [.rst]: 
|
| One document is special in that it is considered the top node of the
| "contents tree", that is, it is the root of the hierarchical structure
| of the documents. Normally, this is "index", but if your "index"
| document is a custom template, you can also set this to another filename.
| > Name of your master document (without suffix) [index]: 
|
| Sphinx can also add configuration for epub output:
| > Do you want to use the epub builder (y/n) [n]: 
| Indicate which of the following Sphinx extensions should be enabled:
| > autodoc: automatically insert docstrings from modules (y/n) [n]: 
| > doctest: automatically test code snippets in doctest blocks (y/n) [n]: 
| > intersphinx: link between Sphinx documentation of different projects (y/n) [n]: 
| > todo: write "todo" entries that can be shown or hidden on build (y/n) [n]: 
| > coverage: checks for documentation coverage (y/n) [n]: 
| > imgmath: include math, rendered as PNG or SVG images (y/n) [n]: 
| > mathjax: include math, rendered in the browser by MathJax (y/n) [n]: 
| > ifconfig: conditional inclusion of content based on config values (y/n) [n]: 
| > viewcode: include links to the source code of documented Python objects (y/n) [n]: 
| > githubpages: create .nojekyll file to publish the document on GitHub pages (y/n) [n]: y
|
| A Makefile and a Windows command file can be generated for you so that you
| only have to run e.g. 'make html' instead of invoking sphinx-build
| directly.
| > Create Makefile? (y/n) [y]: 
| > Create Windows command file? (y/n) [y]: n
|
| Creating file ./source/conf.py.
| Creating file ./source/index.rst.
| Creating file ./Makefile.
|
| Finished: An initial directory structure has been created.
|
| You should now populate your master file ./source/index.rst and create other documentation
| source files. Use the Makefile to build the docs, like so:
|    make builder
| where "builder" is one of the supported builders, e.g. html, latex or linkcheck.

Generating HTML output
----------------------

.. index::
  triple: Sphinx; build; HTML output
  pair: Sphinx; clean
  pair: Sphinx; linkcheck

Assuming ``sphinx-quickstart`` has created a Makefile,  you can build the HTML
output with::

  make html

This will write the output in the ``build/html`` subdirectory.

If you want the ``build/html`` subdirectory to be cleaned up before writing the
output, do::

  make clean html

If you also want to find the broken links in your project, add ``linkcheck``::

  make clean html linkcheck


Having make produce HTML output by default
------------------------------------------

.. index::
  triple: Sphinx; Makefile; default target

The ``make`` (without argument) command outputs a help message. Substituting
the Makefile created by ``sphinx-quickstart`` with :download:`this one
<download/sphinx_makefile_with_html_as_default/Makefile>` causes ``make``
(without argument) to produce the HTML output.

If you use Git and don't want this Makefile change to be committed, see
:ref:`git_maintain_work_commit_diff`.


Other resources
---------------

* `Sphinx documentation <http://www.sphinx-doc.org/en/master>`_
