.. ubuntu-packaging-guide documentation master file, created by
   sphinx-quickstart on Wed Nov 17 14:59:57 2010.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Ubuntu Packaging Guide
==================================================

The guide is split up into two sections:

* A list of articles based on tasks, things you want to get done.
* A set of knowledge-base articles that dig deeper 
  into specific bits of our tools and workflows.

This guide focuses on the Ubuntu Distributed Development packaging method. 
This is a new way of packaging which uses Distributed Revision Control
branches.  It currently has some limitations which mean many teams in Ubuntu
use :doc:`traditional packaging</traditional-packaging>` methods.  See the
:doc:`UDD Introduction</udd-intro>` page for an introduction to the differences.

Articles
--------

.. toctree::
   :maxdepth: 1

   introduction-to-ubuntu-development
   getting-set-up
   udd-intro
   packaging-from-scratch
   fixing-a-bug
   security-and-stable-release-updates
   patches-to-packages

Knowledge Base
--------------

.. toctree::
   :maxdepth: 1

   debian-dir-overview
   testing
   udd-getting-the-source
   udd-working
   udd-sponsorship
   udd-uploading
   udd-latest
   udd-merging
   udd-patchsys
   udd-newpackage
   chroots
   traditional-packaging


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
