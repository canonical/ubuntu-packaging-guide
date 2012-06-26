.. ubuntu-packaging-guide documentation master file, created by
   sphinx-quickstart on Wed Nov 17 14:59:57 2010.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. title:: Overview

Ubuntu Packaging Guide
==================================================

Ubuntu is not only a free and open source operating system, its platform is 
also open and developed in a transparent fashion. The source code for every 
single component can be obtained easily and every single change to the Ubuntu 
platform can be reviewed. 

This means you can actively get involved in improving it and the community of 
Ubuntu platform developers is always interested in helping peers getting 
started.

The guide is split up into two sections:

* A list of articles based on tasks, things you want to get done.
* A set of knowledge-base articles that dig deeper 
  into specific bits of our tools and workflows.

This guide focuses on the Ubuntu Distributed Development packaging method. 
This is a new way of packaging which uses Distributed Revision Control
branches.  It currently has some limitations which mean many teams in Ubuntu
use :doc:`traditional packaging<./traditional-packaging>` methods.  See the
:doc:`UDD Introduction<./udd-intro>` page for an introduction to the differences.

Articles
--------

.. toctree::
   :maxdepth: 1

   introduction-to-ubuntu-development
   getting-set-up
   udd-intro
   packaging-new-software
   fixing-a-bug
   security-and-stable-release-updates
   patches-to-packages
   libraries
   backports

Knowledge Base
--------------

.. toctree::
   :maxdepth: 1

   communication
   debian-dir-overview
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
   kde
