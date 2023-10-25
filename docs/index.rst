Ubuntu Packaging Guide
======================

.. important::

   The Packaging and Development guide has not been updated for some time, and
   is currently undergoing a major overhaul to bring it up to date. It does not
   currently reflect the state of Packaging in Ubuntu and should not be used by
   beginners to Ubuntu packaging.

   As part of this overhaul we have moved the source code to a GitHub
   repository to make contributing easier. If you are an experienced packager
   and would like to contribute, we would love for you to be involved! See
   :doc:`our contribution page </contribute>` for details of how to join in.

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

In this documentation
---------------------

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

Project and community
---------------------

The Ubuntu Packaging Guide is an open source project that warmly welcomes
community projects, contributions, suggestions, fixes and constructive feedback. 
In a project where thousands of lines of code are changed, lots of decisions
are made and hundreds of people interact every day, it is important to 
communicate effectively.

Read our `Code of Conduct`_ to get started. If you run into problems, don't panic!
The following communication channels are there to help you.

.. tip::
  It is encouraged for you to use the same nickname (a known identity or your 
  real name) accross all the following communication channels, so that your 
  Ubuntu developer colleagues will be able to get to know you better. 

Launchpad:
~~~~~~~~~~

`Launchpad`_ is the general development platform where Ubuntu itself and most of 
Ubuntu related software projects live. It is the place where bugs are tracked,
source code is stored, tracked, get built, tested and much more.

We will go into more detail in the following articles. For now, you can think of
Launchpad as a platforms like GitHub, GitLab or BitBucket.

IRC channels:
~~~~~~~~~~~~~
For real-time discussions, please connect to ``irc.libera.chat`` and join one or
any of the `IRC channels`_. You may find especially these channels useful in the beginning:

* ``#ubuntu-devel``, for general development discussion
* ``#ubuntu-motu``, for :term:`Masters of the Universe` (:term:`MOTU`) team discussion and
  generally getting help.
* ``#ubuntu-meeting``, meetings are held here by various Ubuntu teams and everyone
  is welcome to participate.

You can follow these `instructions`_ on how to connect to ``irc.libera.chat``.
Also, when you join ``irc.libera.chat`` for the first time, you should follow the
`instructions to register a nickname`_ and register a nickname. If you don't register it,
someone else may end up registering the nickname you want/used.

.. note::
  Certain channels even require you to register before you can write in them.

Discourse:
~~~~~~~~~~
The `Ubuntu Discourse <UbuntuDiscourse_>`_ instance is a meeting 
point for the Ubuntu community and a forum about general Ubuntu development 
where you can find discussions, announcements, team updates, documentation and
much more.

Feel free to introduce yourself `here <https://discourse.ubuntu.com/c/intro/101>`_.

Mailing lists:
~~~~~~~~~~~~~~
For long-lived discussions or announcements you can subscribe/write to any of 
the `Ubuntu mailing lists <https://lists.ubuntu.com/>`_. You may find especially 
these :term:`Mailing Lists <Mailing List>` useful in the beginning:

* https://lists.ubuntu.com/mailman/listinfo/ubuntu-devel-announce 
  (announce-only, the most important development announcements go here)
* https://lists.ubuntu.com/mailman/listinfo/ubuntu-devel
  (general Ubuntu development discussion)
* https://lists.ubuntu.com/mailman/listinfo/ubuntu-motu
  (MOTU Team discussion, get help with packaging)

.. note::
  When you subscribe to :term:`Mailing Lists <Mailing List>`, expect to receive a lot of emails.
  A good way to manage these is to create email filters. For example,
  the `bug mailing lists <https://lists.ubuntu.com/#Bug+Lists>`_ generate a high
  volume of emails and using the `custom email headers <https://wiki.ubuntu.com/Bugs/HowToFilter>`_
  to filter them can help.

-----

We are always looking to improve this guide. If you find any problems or have
some suggestions, use the **Give feedback** button at the top of any page to 
open a GitHub issue or directly contribute by submitting a pull request to the 
`source`_ repository.

.. toctree::
   :hidden:
   :maxdepth: 2

   tutorial.rst
   how-to.rst
   explanation.rst
   reference.rst
   contribute.rst

Further reading
---------------

You can read this guide offline in different formats, if you install one of
the `binary packages <BinPkgs_>`_.

If you want to learn more about building Debian packages, here are some Debian
resources you may find useful:

* `How to package for Debian <HowToPackage_>`_
* `Debian Policy Manual <Policy_>`_
* `Debian New Maintainers' Guide <NewMaintGuide_>`_ — available in many languages
* `Packaging tutorial <PkgTutorial_>`_ (also available as a `package <PkgTutorialPkg_>`_)
* `Guide for Packaging Python Modules <PythonModules_>`_

.. Links:
.. _Code of Conduct: https://ubuntu.com/community/code-of-conduct
.. _IRC channels: https://wiki.ubuntu.com/IRC/ChannelList
.. _BinPkgs: https://launchpad.net/ubuntu/+source/ubuntu-packaging-guide
.. _HowToPackage: https://wiki.debian.org/HowToPackageForDebian
.. _Policy: http://www.debian.org/doc/debian-policy/
.. _NewMaintGuide: http://www.debian.org/doc/manuals/maint-guide/
.. _PkgTutorial: http://www.debian.org/doc/manuals/packaging-tutorial/
.. _PkgTutorialPkg: https://launchpad.net/ubuntu/+source/packaging-tutorial
.. _PythonModules: https://wiki.debian.org/Python/LibraryStyleGuide
.. _source: https://github.com/canonical/ubuntu-packaging-guide
.. _Masters of the Universe: https://wiki.ubuntu.com/MOTU
.. _instructions: https://libera.chat/guides/connect
.. _instructions to register a nickname: https://libera.chat/guides/registration
