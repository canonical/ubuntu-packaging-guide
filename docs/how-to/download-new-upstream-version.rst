Download a new upstream version
===============================

Once in a while you may need to download a new :term:`Upstream` release or check if a newer
:term:`Upstream` release exists; for example:

- When fixing a bug, to rule out that a more recent version may have already fixed the bug.
- As a :term:`Source Packages <Source Package>` :term:`Maintainer`, to check for, download,
  and package a newer :term:`Upstream` release.

Most of the :term:`Source Packages <Source Package>` contain a ``watch`` file in the ``debian``
folder. This is a configuration file for the :manpage:`uscan(1)` utility which allows you to
automatically search :term:`HTTP` or :term:`FTP` sites or :manpage:`git(1)` repositories
for newly available updates of the :term:`Upstream` project.

.. note::
    If the :term:`Source Package` does not contain a :file:`debian/watch` file, there may be
    an explanation and instructions in the :file:`debain/README.source` or
    :file:`debian/README.debian` file (if available) that tell you how to proceed.

Best practices
--------------

You should download :term:`Upstream` file(s) manually only if there is no automatic
download mechanism and you can't find any download instructions.

Remember that a package may get distributed to hundreds of thousands of users.
Humans are the weakest link in this distribution chain, because we may
accidentally miss or skip a verification step, misspell a :term:`URL`, copy the
wrong :term:`URL` or copy a :term:`URL` only partially, etc.

If you still have to download :term:`Upstream` file(s) manually make sure to
verify :term:`Cryptographic Signatures` (if available). The :term:`Signing Key`
of the :term:`Upstream` project should be stored in the :term:`Source Package`
as :file:`debian/upstream/signing-key.asc` (if the :term:`Upstream` project
has a :term:`Signing Key`).

:manpage:`uscan(1)` verifies downloads against this :term:`Signing Key`
automatically (if available).

Download new upstream version (if available)
--------------------------------------------

Running :manpage:`uscan(1)` from the :term:`Root` of the :term:`Source Tree` will
check if a newer :term:`Upstream` version exists and downloads it:

.. code-block:: bash

    uscan

If :manpage:`uscan(1)` could not find a newer :term:`Upstream` version it will
return with the exit code `1` and print nothing to the :term:`Standard Output`.

:manpage:`uscan(1)` reads the first entry in :file:`debian/changelog` to determine
the name and version of the :term:`Source Package`.

You can allways add the ``--verbose`` flag to see more information (e.g., which version
:manpage:`uscan(1)` found):

.. code-block:: bash

    uscan --verbose

Check for new upstream version (no download)
--------------------------------------------

If you just want to check if a new update is available, but you don't want to download
anything, you can run the :manpage:`uscan(1)` :term:`Command` with the ``--safe`` flag
from the :term:`Root` of the :term:`Source Tree`:

.. code-block:: bash

    uscan --safe

Force the download of the latest upstream version
-------------------------------------------------

You can use the ``--force-download`` flag to download the latest :term:`Upstream` release
from the :term:`Upstream` project, even if the :term:`Upstream` Release is up-to-date
with the :term:`Source Package`:

.. code-block:: bash

    uscan --force-download

.. note::

    In most cases you actually want to download the :term:`Source` from the :term:`Archive`
    and not re-download the :term:`Source` from the :term:`Upstream` project.
    
    :ref:`How to get the Source from the Archive? <get-package-source>`

Download the source of older versions from the upstream project
---------------------------------------------------------------

If you want to download the :term:`Source` of a specific version from the
:term:`Upstream` project you can use the ``--download-version`` flag.

Basic syntax:

.. code-block:: none

    uscan --download-version VERSION

For example:

.. code-block:: bash

    uscan --download-version '1.0'

In the special case that you want to download the :term:`Source` for the
current version of the :term:`Source Package` from the :term:`Upstream` project
you can use the ``--download-current-version`` flag instead, which parses the
version to download from the first entry in :file:`debian/changelog` file:

.. code:: bash

    uscan --download-current-version

.. note::

    The ``--download-version`` and ``--download-current-version`` flags are
    both a :term:`best-effort` features of :manpage:`uscan(1)`.
    
    There are special cases where they do not work for technical reasons.

.. note::

    In most cases you actually want to download the :term:`Source` from the :term:`Archive`
    and not re-download the :term:`Source` from the :term:`Upstream` project.
    
    :ref:`How to get the Source from the Archive? <get-package-source>`

Further Information
-------------------

- Manual page -- :manpage:`uscan(1)`
- Debian wiki -- `debian/watch <https://wiki.debian.org/debian/watch>`_
- Debian policy ``4.6.2.0`` -- `Upstream source location: debian/watch <https://www.debian.org/doc/debian-policy/ch-source.html#upstream-source-location-debian-watch>`_
