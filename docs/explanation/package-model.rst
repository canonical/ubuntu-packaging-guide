Package Model
=============

Because :term:`Ubuntu` is based on the community-driven :term:`Debian` project,
:term:`Ubuntu` uses the :term:`Debian` packaging model/format.

There are :ref:`SourcePackages` and :ref:`BinaryPackages`.

.. _SourcePackages:

Source Packages
---------------

A *source package* contains the :term:`Source` material used to build one or
more :ref:`BinaryPackages`.

A *source package* is composed of

- a :file:`.dsc` (*Debian Source Control*) file,
- one or more compressed tar files, and 
- optionally additional files depending on the type and format of the *source package*.

The *Source Control* file contains metadata about the *source package*, for instance, 
a list of additional files, name and version, list of the binary packages it produces, 
dependencies, a digital signature and many more fields.

.. note::
  The article :doc:`/reference/debian-dir-overview` showcases the layout of 
  an unpacked *source package*.

Source Package Formats
~~~~~~~~~~~~~~~~~~~~~~

There exist multiple formats for how the :term:`Source` is packaged. The format of a 
*source package* is declared in the :file:`debian/source/format` file. This file should
always exist. If this file can not be found, the :ref:`format 1.0 <SourcePackageFormat_1.0>`
is assumed for backwards compatibility, but :manpage:`lintian(1)` will warn you about it.

.. tip::

    If you don't know what source format to use, you should probably pick either 
    :ref:`3.0 (quilt) <SourcePackageFormat_3.0quilt>` or
    :ref:`3.0 (native) <SourcePackageFormat_3.0native>`.


.. _NativeSourcePackages:

(Non-)Native Source Packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In most cases, a software project is packaged by external contributors
(:term:`Maintainers <Maintainer>`) only tangentially related to the software project. 
Often, the *source package* has to do modifications to solve specific problems for its target
:term:`Distribution`. The *source package* can, in these cases, be considered as its own
software project, like a fork.

Consequently, the :term:`Upstream` releases and *source package* releases do not always align.

Native packages almost always originate from software projects designed with :term:`Debian`
packaging in mind and have no independent existence outside its target :term:`Distribution`.
Native packages do not differentiate between :term:`Upstream` releases and *source package* releases.
Therefore, the version identifier of a native package does not have a 
:term:`Ubuntu` or :term:`Debian` specific component.

.. _SourcePackageFormat_3.0quilt:

Format: ``3.0 (quilt)``
^^^^^^^^^^^^^^^^^^^^^^^

A new-generation *source package* format that records modifications in a :manpage:`quilt(1)`
:term:`Patch` series within the :file:`debian/patches` folder. The :term:`Patches <Patch>` are
organized as a :term:`Stack`, and you can apply, un-apply, and update them easily by traversing 
the :term:`Stack` (push/pop). These changes are automatically applied during the extraction of
the *source package*.

A *source package* in this format contains at least an original tarball (``.orig.tar.ext`` where
``ext`` can be ``gz``, ``bz2``, ``lzma`` and ``xz``) and a debian tarball (``.debian.tar.ext``).
It can also contain additional original tarballs (``.orig-component.tar.ext``), where ``component``
can only contain alphanumeric (``a-z``, ``A-Z``, ``0-9``) characters and hyphens (``-``).
Optionally, each original tarball can be accompanied by a detached upstream signature
(``.orig.tar.ext.asc`` and ``.orig-component.tar.ext.asc``).

For example, take a look at the ``hello`` package:

.. code:: bash

    pull-lp-source --download-only 'hello' '2.10-3'

Now you should see the following files:

- :file:`hello_2.10-3.dsc`: The *Debian Source Control* file of the *source package*.
- :file:`hello_2.10.orig.tar.gz`: The tarball containing the original :term:`Source Code` of the :term:`Upstream` project.
- :file:`hello_2.10.orig.tar.gz.asc`: The detached :term:`Upstream` signature of :file:`hello_2.10.orig.tar.gz`.
- :file:`hello_2.10-3.debian.tar.xz`: The tarball containing the content of the debian directory.

.. _SourcePackageFormat_3.0native:

Format: ``3.0 (native)``
^^^^^^^^^^^^^^^^^^^^^^^^

A new-generation *source package* format extends the native package
format defined in the :ref:`format 1.0 <SourcePackageFormat_1.0>`.

A *source package* in this format is a tarball (``.tar.ext`` where ``ext``
can be ``gz``, ``bz2``, ``lzma`` and ``xz``).

For example, take a look at the ``subiquity`` package:

.. code:: bash

    pull-lp-source --download-only 'ubiquity' '23.10.2'

Now you should see the following files:

- ``ubiquity_23.10.2.dsc``:  The *Debian Source Control* file of the *source package*.
- ``ubiquity_23.10.2.tar.xz``: The tarball containing the :term:`Source Code` of the project.

.. _SourcePackageFormat_1.0:

Format: ``1.0``
^^^^^^^^^^^^^^^

The original *source package* format. Nowadays, this format is rarely used.

A native *source package* in this format consists of a single ``.tar.gz``
file containing the :term:`Source`.

A non-native *source package* in this format consists of a ``.orig.tar.gz`` file
(containing the :term:`Upstream` :term:`Source`) associated with a ``.diff.gz``
file (the :term:`Patch` containing :term:`Debian` packaging modifications).
Optionally, the original tarball can be accompanied by a detached :term:`Upstream`
signature ``.orig.tar.gz.asc``. 

.. note::
  
  This format does not specify a :term:`Patch` system, which makes it harder for
  :term:`Maintainers <Maintainer>` to track modifications. There were multiple approaches
  to how packages tracked :term:`Patches <Patch>`. Therefore, the *source packages* of this
  format often contained a :file:`debian/README.source` file explaining how to use the 
  :term:`Patch` system.

``3.0`` Formats Improvements
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Some of the improvements that apply to most ``3.0`` formats are:

- Support for additional compression formats: ``bzip2``, ``lzma`` and ``xz``
- Support for multiple :term:`Upstream` tarballs
- Supports inclusion of binary files
- :term:`Debian`-specific changes are no longer stored in a single ``.diff.gz``
- The :term:`Upstream` tarball does not need to be repacked to strip the :term:`Debian` directory.

Other Formats
^^^^^^^^^^^^^

The following formats are rarely used, experimental and/or historical.
You should only choose these if you know what you do.

- ``3.0 (custom)``: Doesn't represent an actual *source package* format but can
  be used to create *source packages* with arbitrary files.
- ``3.0 (git)``: An experimental format to package from a :term:`git` repository.
- ``3.0 (bzr)``: An experimental format to package from a :term:`Bazaar` repository.
- ``2.0``: The first specification of a new-generation *source package* format.
  It was never widely adopted and eventually replaced by
  :ref:`3.0 (quilt) <SourcePackageFormat_3.0quilt>`.

``.changes`` file
~~~~~~~~~~~~~~~~~

Although technically not part of a *source package* -- every time a *source package* is built,
a :file:`.changes` file will be created alongside. The :file:`.changes` file contains metadata
from the *Source Control* file and other information (e.g. the latest changelog entry) about the
*source package*. :term:`Archive` tools and :term:`Archive Administrators <Archive Admin>` use this
data to process changes to *source packages* and determine the appropriate action to upload the 
*source package* to the :term:`Ubuntu Archive`.

.. _BinaryPackages:

Binary Packages
---------------

A *binary package* is a standardized format that the :term:`Package Manager` (:manpage:`dpkg(1)` or
:manpage:`apt(8)`) can understand to install and uninstall software on a target machine to simplify
distributing software to a target machine and managing software on a target machine.

A :term:`Debian` *binary package* is a file with the :file:`.deb` file extension that
contains a set of files that will be installed on the host system and a set of files
that control how the files will be (un-)installed.

Resources
---------

- `Debian Policy Manual v4.6.2.0 -- Chapter 3. Binary packages <https://www.debian.org/doc/debian-policy/ch-binary.html>`_
- `Debian Policy Manual v4.6.2.0 -- Chapter 4. Source packages <https://www.debian.org/doc/debian-policy/ch-source.html>`_
- The manual page :manpage:`dpkg-source(1)`
- `Debian Wiki -- 3.0 Source Package Format <https://wiki.debian.org/Projects/DebSrc3.0>`_