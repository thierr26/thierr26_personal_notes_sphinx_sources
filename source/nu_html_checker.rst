Nu HTML Checker
===============

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: Nu HTML Checker


Introduction
------------

This page gives the actions I had to take to install the Nu HTML Checker on a
Debian GNU/Linux 10 (Buster) machine and shows how to use it (command line use
only).

This page is **not valid for Debian GNU/Linux 11 (Bullseye)**.


Installation
------------

I ran (**as root**) the following commands to install and build the Nu HTML
checker::

  apt-get install default-jre default-jdk
  export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
  cd /usr/local
  git clone https://github.com/validator/validator.git nu_html_checker
  cd nu_html_checker
  python ./build/build.py update dldeps build test jar


Usage
~~~~~

Check all the HTML files in a folder with a command like::

  java -jar /usr/local/nu_html_checker/build/dist/vnu.jar path/to/files/*.html


Other resources
---------------

* `The Nu Html Checker (v.Nu) <https://validator.github.io/validator/>`_
