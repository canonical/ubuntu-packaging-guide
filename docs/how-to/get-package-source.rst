Get the Source of a Package
===========================

Before you can work on a :term:`Source Package` you need to get the :term:`Source Code`
of a given :term:`Source Package`. This article presents multiple ways how you can achive this.

:command:`git-ubuntu`
---------------------

.. note::

   :command:`git-ubuntu` is the modern way of working with :term:`Ubuntu`
   :term:`Source Packages <Source Package>`.

.. warning::

    :command:`git-ubuntu` is still in active development. It is possible that you 
    run into rough edges or unsupported edge cases. You can ask for help
    in the ``#ubuntu-devel`` channel or `open a bug report <GitUbuntuBugs_>`_
    on :term:`Launchpad`.

Install

.. code:: bash

    sudo snap install --classic --edge git-ubuntu 

Basic usage

.. code::

    # Clone a source package git repository to a directory
    git ubuntu clone PACKAGE [DIRECTORY]

    # Generate the orig tarballs for a given source package
    git-ubuntu export-orig

Example

.. code:: bash

    git ubuntu clone hello 
    cd hello
    git ubuntu export-orig

You can find further information in these two blog articles (note that they are from 2017):

- `git ubuntu clone <https://ubuntu.com/blog/git-ubuntu-clone>`_
- `Git Ubuntu: More on the imported repositories <https://ubuntu.com/blog/git-ubuntu-more-on-the-imported-repositories>`_

:command:`pull-pkg`
-------------------

The :command:`pull-pkg` command is part of the ``ubuntu-dev-tools`` :term:`Package`
and downloads a specified version of a :term:`Source Package`, or the latest version
from a specified release.

Install

.. code:: bash

    sudo apt install ubuntu-dev-tools

Basic usage

.. code:: text

    pull-pkg [OPTIONS] <PACKAGE-NAME> <SERIES|VERSION>

You can find further information on the manual page :manpage:`pull-pkg(1)`.

There are convenience scripts that follow a simmelar syntax and set 
the ``OPTIONS`` for pull type and :term:`Distribution` appropriately,
these are (among others):

:command:`pull-lp-source`
~~~~~~~~~~~~~~~~~~~~~~~~~

Examples
^^^^^^^^

download the latest version of the ``hello`` :term:`Source Package` for the
:term:`Current Release in Development` from :term:`Launchpad`

.. code:: bash

    pull-lp-source hello

download the latest version of the ``hello`` :term:`Source Package` for the 
:term:`Ubuntu` ``mantic`` release from :term:`Launchpad`

.. code:: bash

    pull-lp-source hello mantic

download the version ``2.10-3`` of the ``hello`` :term:`Source Package` from :term:`Launchpad`

.. code:: bash

    pull-lp-source hello 2.10-3
    
:command:`pull-ppa-source`
~~~~~~~~~~~~~~~~~~~~~~~~~~

Examples
^^^^^^^^

download the latest version of the ``hello`` :term:`Source Package` from a
:term:`Launchpad` :term:`Personal Package Archive` with the name ``hello``
of the user ``dviererbe``

.. code:: bash
    
    pull-ppa-source --ppa dviererbe/hello hello

download the latest version of the ``hello`` :term:`Source Package` for the
``mantic`` release from a :term:`Launchpad` :term:`Personal Package Archive` with
the name ``hello`` of the user ``dviererbe``

.. code:: bash

    pull-ppa-source --ppa dviererbe/hello hello mantic

download the version ``2.10-3`` of the ``hello`` :term:`Source Package` for the ``mantic``
release from the :term:`Launchpad` :term:`Personal Package Archive` with the name ``hello``
of the user ``dviererbe``

.. code:: bash

    pull-ppa-source --ppa dviererbe/hello hello 2.10-3

:command:`pull-debian-source`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Examples
^^^^^^^^

download the latest version of the ``hello`` :term:`Source Package` from :term:`Debian`

.. code:: bash

    pull-debian-source hello

download the latest version of the ``hello`` :term:`Source Package` for the ``sid``
release from :term:`Debian`

.. code:: bash

    pull-debian-source hello sid

download the version ``2.10-3`` of the ``hello`` :term:`Source Package` from :term:`Debian`

.. code:: bash

    pull-debian-source hello 2.10-3

:command:`apt-get source`
-------------------------

The :term:`APT` :term:`Package Manager` can also fetch :term:`Source Packages <Source Package>`.

.. important::

   :term:`Source Packages <Source Package>` are tracked separately from
   :term:`Binary Packages <Binary Package>` via ``deb-src`` lines in the
   :manpage:`sources.list(5)` file. This means that you will need to add
   such a line for each :term:`Repository` you want to get :term:`Sources <Source>` from; 
   otherwise you will probably get either the wrong (too old/too new) :term:`Source`
   versions or none at all.

Basic usage

.. code:: text

    apt-get source <PACKAGE>

Example

.. code:: bash

    apt-get source hello

You can find further information on the manual page :manpage:`apt-get(8)`.

``dget``
--------

The :command:`dget` command is part of the ``devscripts`` :term:`Package`. If you call it with 
the URL of a ``.dsc`` or ``.changes`` file it acts as a :term:`Source Package` aware :manpage:`wget(1)`.

Install

.. code:: bash

    sudo apt install devscripts

Basic usage

.. code:: text

    dget <URL>

Example

1. Go to :term:`Launchpad` and select the :term:`Package` you want to download (in this example; the latest version of the ``hello`` :term:`Source Package`):

.. image:: ../images/how-to/get-package-source/lp-hello-package.png
   :align: center
   :width: 35 em
   :alt: Screenshot of the Launchpad overview page for the hello source package with an arrow pointing to the Mantic Minotaur 2.10-3 release. 

2. Copy the link of the ``.dsc`` file:

.. image:: ../images/how-to/get-package-source/lp-hello-package-2.10-3.png
   :align: center
   :width: 35 em
   :alt: Screenshot of the Launchpad overview page for the 2.10-3 release of the hello source package with an arrow pointing to the .dsc file link. 

3. Call ``dget`` with the copied URL:
    
   .. code:: bash
   
       dget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/hello/2.10-3/hello_2.10-3.dsc

.. note::

    This works for links from :term:`Debian` and :term:`Launchpad` :term:`Personal Package Archives <Personal Package Archive>` too.

You can find further information on the manual page :manpage:`dget(1)`.
