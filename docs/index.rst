.. _index:

Ubuntu Packaging Guide
######################

Welcome to the Ubuntu Packaging and Development Guide!

This is the official place for learning all about Ubuntu Development and
packaging. After reading this guide you will have:

* Heard about the most important players, processes and tools in
  Ubuntu development,
* Your development environment set up correctly,
* A better idea of how to join our community,
* Fixed an actual Ubuntu bug as part of the tutorials.

Ubuntu is not only a free and open source operating system, its platform is
also open and developed in a transparent fashion. The source code for every
single component can be obtained easily and every single change to the Ubuntu
platform can be reviewed.

This means you can actively get involved in improving it and the community of
Ubuntu platform developers is always interested in helping peers getting
started.

Ubuntu is also a community of great people who believe in free software and
that it should be accessible for everyone. Its members are welcoming and want
you to be involved as well. We want you to get involved, to ask questions, to
make Ubuntu better together with us.

-----

The guide is split up into two sections:


.. grid:: 1 1 2 2
   :gutter: 3

   .. grid-item-card:: **Tutorial**
       :link: tutorial
       :link-type: doc
      
       Get started - a hands-on introduction to the Ubuntu Packaging Guide for
       new users

   .. grid-item-card:: **How-to guides**
       :link: how-to
       :link-type: doc
      
       Step-by-step guides covering key operations and common tasks
    
   .. grid-item-card:: **Explanation**
       :link: explanation
       :link-type: doc
          
       Discussion and clarification of key topics
    
   .. grid-item-card:: **Reference**
       :link: reference
       :link-type: doc
      
       Technical information - specifications, APIs, architecture

Having trouble? We would like to help!
======================================

If you run into problems: don't panic! Check out the :ref:`communication
article<communication>` and you will find out how to most easily get in
touch with other developers.

- Links to other communication channels go here
- Use the "Give feedback" button at the top of any page to open a GitHub issue
  and let us know what problem you're having

Project and community
=====================

The Ubuntu Packaging Guide is an open source project that warmly welcomes
community projects, contributions, suggestions, fixes and constructive feedback.

* Read our `Code of Conduct`_
* IRC?
* Discourse?
* Mailing list?
* GitHub?

.. toctree::
   :hidden:
   :maxdepth: 2

   introduction-to-ubuntu-development.rst
   tutorial
   how-to
   explanation
   reference

Further reading
===============

You can read this guide offline in different formats, if you install one of
the `binary packages <BinPkgs_>`_.

If you want to learn more about building Debian packages, here are some Debian
resources you may find useful:

* `How to package for Debian <HowToPackage_>`_;
* `Debian Policy Manual <Policy_>`_;
* `Debian New Maintainers' Guide <NewMaintGuide_>`_ — available in many languages;
* `Packaging tutorial <PkgTutorial_>`_ (also available as a `package <PkgTutorialPkg_>`_);
* `Guide for Packaging Python Modules <PythonModules_>`_.

We are always looking to improve this guide. If you find any problems or have
some suggestions, please `report a bug on Launchpad <Bugs_>`_.
If you'd like to help work on the guide, `grab the source <Source_>`_ there as well.

.. Links:
.. _Code of Conduct: https://ubuntu.com/community/code-of-conduct

.. _BinPkgs: https://launchpad.net/ubuntu/+source/ubuntu-packaging-guide
.. _HowToPackage: https://wiki.debian.org/HowToPackageForDebian
.. _Policy: http://www.debian.org/doc/debian-policy/
.. _NewMaintGuide: http://www.debian.org/doc/manuals/maint-guide/
.. _PkgTutorial: http://www.debian.org/doc/manuals/packaging-tutorial/
.. _PkgTutorialPkg: https://launchpad.net/ubuntu/+source/packaging-tutorial
.. _Bugs: https://bugs.launchpad.net/ubuntu-packaging-guide
.. _Source: https://code.launchpad.net/~ubuntu-packaging-guide-team/ubuntu-packaging-guide/trunk
.. _PythonModules: https://wiki.debian.org/Python/LibraryStyleGuide
