Extract packages
================

This article demonstrates how to extract the contents of debian packages.

See also the article :doc:`/explanation/package-model` for a deeper 
understanding of package formats.

.. _ExtractSourcePackage:

Extract a source package 
------------------------

This section demonstrates how to extract the content of a source package.

.. note::

    A source package archive has the file ending `.dsc`.
    See also the man page :manpage:`dsc(5)` for further information.

.. important::

    Make sure that you have the `dpkg-dev` package installed. 
    To install it run the following commands in a terminal:

    .. code-block:: bash

        sudo apt update && sudo apt install dpkg-dev

Run the follwong command in a terminal:

.. code-block:: bash

    dpkg-source --extract SOURCE-PACKAGE.dsc [OUTPUT-DIRECTORY]

``SOURCE-PACKAGE.dsc``
    The path to the source package control file.

``OUTPUT-DIRECTORY`` (optional)
    The path to the directory where to extract the content of the source
    package to. This directory **must not** exist. If no output directory is 
    specified the content will be extracted into a directory named 
    ``NAME-VERSION`` (where ``NAME`` is the name of the source package and 
    ``VERSION`` its version) under the current working directory.

See the man page :manpage:`dpkg-source(1)` for further informations.

.. _ExtractBinaryPackage:

Extract a binary package
------------------------

This section demonstrates how to extract the content a binary packages.

.. note::

    A binary package archive has the file ending `.deb`.
    See also the man page :manpage:`deb(5)` for further information.

Run the follwong command in a terminal:

.. code-block:: bash

    dpkg-deb --extract BINARY-PACKAGE.dsc OUTPUT-DIRECTORY

``BINARY-PACKAGE.dsc``
    The path to the binary package control file.

``OUTPUT-DIRECTORY``
    The path to the directory where to extract the content of the binary
    package to. In comparison to :ref:`ExtractSourcePackage` this directory
    can already exist and even contain files.

See the man page :manpage:`dpkg-deb(1)` for further informations.

.. tip::

    Using ``--vextract`` instead of ``--extract`` will also display
    the extracted files to :term:`standard output <Standard Output>`.

    To just list the contained files use the ``--contents`` option:

    .. code-block:: bash

        dpkg-deb --contents BINARY-PACKAGE.dsc

.. tip::

    You can also replace ``dpkg-deb`` with ``dpkg`` for the examples 
    demonstarted here. ``dpkg`` will forward the options to ``dpkg-deb``. 
    See the man page :manpage:`dpkg(1)` for further informations.
