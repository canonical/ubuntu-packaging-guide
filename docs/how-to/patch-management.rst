Patch management
================

This article demonstrates how to manage the :term:`patches <Patch>` of a
:term:`source package <Source package>` in the ``3.0 (quilt)`` format. See the
:doc:`/explanation/package-model` article for more information about package
formats.

All changes from the :term:`Debian` version of a package (with the exception of
files inside the ``debian/`` directory) must be applied in the form of a patch.

The source package stores the patches in the ``debian/patches/`` directory.
The ``debian/patches/series`` contains the order in which the patches get
applied.

As the source package format implies, we will use the :manpage:`quilt(1)` tool
to manage the patches of a source package.

Quilt manages patches like a :term:`Stack`. It maintains a list of patches that
get applied one after another. You can 

.. important::

    Quilt will create a ``.pc/`` directory at the source package root
    directory. This is the location where Quilt will store control files
    similar to the ``.git/`` folder of a :term:`Git` repository.

    Before you commit any changes or attempt to build the source package, **do
    not forget to unapply all patches and delete the directory.**

Prerequisites
-------------

If you haven't already, install :manpage:`quilt(1)`:

.. include:: /reuse/snippets/quilt/setup.rst

List patches
------------

List all available patches:

.. code-block:: bash

    quilt series

This will also color code which patches are applied (green), which patch is the
latest applied patch (yellow) and which patches are unapplied (white).

List applied patches:

.. code-block:: bash

    quilt applied

Display the topmost applied patch:

.. code-block:: bash

    quilt top

List unapplied patches:

.. code-block:: bash

    quilt unapplied

Appply patches
--------------

Apply the next patch:

.. code-block:: bash

    quilt push

Apply all patches:

.. code-block:: bash

    quilt push -a

Apply the next ``N`` patches

.. code-block:: bash

    quilt push N

Apply all patches until (including) a specific patch:

.. code-block:: bash

    quilt push PATCH-NAME

This can also be the path of the patch (allowing for autocompletion):

.. code-block:: bash

    quilt push debian/series/PATCH-NAME

Unapply patches
---------------

This works similar to applying patches.

Unapply the patch on top:

.. code-block:: bash

    quilt pop

Unapply all patches:

.. code-block:: bash

    quilt pop -a

Unapply the ``N`` topmost applied patches

.. code-block:: bash

    quilt pop N

Unapply all patches until (excluding) a specific patch:

.. code-block:: bash

    quilt pop PATCH-NAME

This can also be the path of the patch (allowing for autocompletion):

.. code-block:: bash

    quilt pop debian/series/PATCH-NAME

Show details about a patchfile
------------------------------

.. code-block:: bash

    quilt files

.. code-block:: bash

    quilt diff [--combine patch] [-P PATCH-NAME] [file ...]


.. code-block:: bash

    quilt header


.. _VerifyPatches:

Verify patches
--------------

Now that we know how to apply and unapply patches we can verify if all patches
apply and unapply cleanly. This can be usefull when you merge changes from
Debian into an Ubuntu package and want to check if everything is still in
order.

1. We verify that all patches apply cleanly:
    .. code-block:: bash
    
        quilt push -a

2. We verify that all patches unapply cleanly:
    .. code-block:: bash
        
        quilt pop -a

3. (optional) We remove the Quilt control file folder:
    .. code-block:: bash
        
        rm -r .pc

Rename a patchfile
------------------

.. code-block:: bash

    quilt delete


Remove a patchfile
------------------

1. 
2. 


Edit a patchfile
----------------

1. Apply all patches until the patch we want to edit:
    .. code-block:: bash

        quilt push PATCH-NAME

2. If you edit file(s) that the patch does not modify so far, add the files you want to edit with: 
    .. code-block:: bash

        quilt add FILE-NAME

3. "Refresh" the patch:
    .. code-block:: bash
    
        quilt Refresh

4. Verify that all patches 

Generate a patchfile
--------------------

Import a patchfile
------------------

Resources
---------

- manual page :manpage:`quilt(1)`
- https://wiki.debian.org/UsingQuilt

