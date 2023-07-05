.. _get-package-source:

===========================
Get the Source of a Package
===========================

.. caution::

    Work in progress!

Before you can work on a packge you need to get the source code of a given 
package. This article presents multiple ways how you can achive this.

``git-ubuntu``
--------------

.. note::

   ``git-ubuntu`` is the modern way of working with ubuntu source packages.

.. warning::

    ``git-ubuntu`` is still in active development. It is possible that you 
    run into rough edges or unsupported edge cases. You can ask for help
    in the #ubuntu-devel channel or open a bug report on launchpad.

Install::

    $ sudo snap install --classic --edge git-ubuntu 

Basic usage::

    # Clone a source package git repository to a directory
    $ git ubuntu clone PACKAGE [DIRECTORY]

    # Generate the orig tarballs for a given source package
    $ git-ubuntu export-orig

Example::

    $ git ubuntu clone hello 
    $ cd hello
    $ git ubuntu export-orig

You can find further information in these two blog articles (note that they are from 2017):

- `git ubuntu clone <GitUbuntuBlogArticle1_>`_
- `Git Ubuntu: More on the imported repositories <GitUbuntuBlogArticle2_>`_

``pull-pkg``
------------

The ``pull-pkg`` command is part of the ``ubuntu-dev-tools`` package and 
downloads a specified version of a package, or the latest version from a
specified release.

Install::

    $ sudo apt install ubuntu-dev-tools

Basic usage::

    $ pull-pkg [OPTIONS] <PACKAGE-NAME> <SERIES|VERSION>

You can find further information on the `man page <PullPkgManPage_>`_.

There are convenience scripts that follow a simmelar syntax and set 
the ``OPTIONS`` for pull type and distribution appropriately, these
are (among others):

``pull-lp-source``
^^^^^^^^^^^^^^^^^^

Examples
""""""""

download the latest version of the ``hello`` package from debian::

    $ pull-lp-source hello

download the latest version of the ``hello`` package for the ``mantic`` release from Launchpad sid::

    $ pull-lp-source hello mantic

download the version ``2.10-3`` of the ``hello`` package from Launchpad::

    $ pull-lp-source hello 2.10-3
    
``pull-ppa-source``
^^^^^^^^^^^^^^^^^^^

Examples
""""""""

download the latest version of the ``hello`` package from the Launchpad PPA with the name ``hello`` of the user ``dviererbe``::
    
    $ pull-ppa-source --ppa dviererbe/hello hello

download the latest version of the ``hello`` package for the ``mantic`` release from the Launchpad PPA with the name ``hello`` of the user ``dviererbe``::

    $ pull-ppa-source --ppa dviererbe/hello hello mantic

download the version ``2.10-3`` of the ``hello`` package for the ``mantic`` release from the Launchpad PPA with the name ``hello`` of the user ``dviererbe``::

    $ pull-ppa-source --ppa dviererbe/hello hello 2.10-3

``pull-debian-source``
^^^^^^^^^^^^^^^^^^^^^^

Examples
""""""""

download the latest version of the ``hello`` package from debian::

    $ pull-debian-source hello

download the latest version of the ``hello`` package for the ``sid`` release from debian::

    $ pull-debian-source hello sid

download the version ``2.10-3`` of the ``hello`` package from debian::

    $ pull-debian-source hello 2.10-3

``apt-get source``
------------------

The APT package manager can also fetch source packages via ``apt-get source``.

.. important::

   Source packages are tracked separately from binary packages via ``deb-src``
   lines in the ``sources.list(5)`` file. This means that you will need to add
   such a line for each repository you want to get sources from; otherwise
   you will probably get either the wrong (too old/too new) source versions
   or none at all.

Basic usage::

    $ apt-get source <PACKAGE>

Example::

    $ apt-get source hello

You can find further information on the `man page <AptGetManPage_>`_.

``dget``
--------

The ``dget`` command is part of the ``devscripts`` package. If you call it with 
the URL of a ``.dsc`` or ``.changes`` file it acts as a source package aware ``wget``.

Install::

    $ sudo apt install devscripts

Basic usage::

    $ dget <URL>

Example

1. Go to Launchpad and select the package you want to download (in this example; the latest version of the ``hello`` package):

.. image:: ../images/how-to/get-package-source/lp-hello-package.png
   :align: center
   :width: 35 em
   :alt: Illustration of the workflow between releases

2. Copy the link of the ``.dsc`` file:

.. image:: ../images/how-to/get-package-source/lp-hello-package-2.10-3.png
   :align: center
   :width: 35 em
   :alt: Illustration of the workflow between releases

3. Call ``dget`` with the copied URL:
::

    $ dget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/hello/2.10-3/hello_2.10-3.dsc

.. note::

    This works for links from debian and Launchpad PPAs too.

You can find further information on the `man page <DgetManPage_>`_.

.. _GitUbuntuBlogArticle1: https://ubuntu.com/blog/git-ubuntu-clone
.. _GitUbuntuBlogArticle2: https://ubuntu.com/blog/git-ubuntu-more-on-the-imported-repositories
.. _PullPkgManPage: https://manpages.ubuntu.com/manpages/lunar/en/man1/pull-pkg.1.html
.. _AptGetManPage: https://manpages.ubuntu.com/manpages/lunar/en/man8/apt-get.8.html
.. _SourcesListManPage: https://manpages.ubuntu.com/manpages/lunar/en/man5/sources.list.5.html
.. _DgetManPage: https://manpages.ubuntu.com/manpages/lunar/en/man1/dget.1.html
