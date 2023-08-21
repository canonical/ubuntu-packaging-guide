..  _download-new-upstream-version:

===============================
Download a new Upstream Version
===============================

.. caution::

    Work in progress!

Once in a while you need to download a new upstream release or check if a newer 
upstream release exists.

Most of the source packages contain a ``watch`` file in the ``debian`` folder.
This is a configuration file for the :manpage:`uscan(1)` utility which allows
you to automatically scan ``http`` or ``ftp`` sites or :manpage:`git(1)`
repositories for newly available updates of the upstream project.

.. note::
    If the source package does not contain a ``watch`` file, there may be
    an explanation and instructions in the ``README.source`` or 
    ``README.debian`` file (if available) that tell you how to proceed.

.. caution::
    You should only download any upstream file(s) manually if there is no automatic download mechanism and you can't find any download instructions. 

    Remember that a package may get distributed to hundreds of thousands of users.
    Humans are the weakest link in this distribution chain, because we may
    accidentally miss or skip a verification step, misspell a URL, copy the 
    wrong URL or copy a URL only partially, etc.

If you just want to check if a new update is available, but you don't want to 
download anything, you can run the following command from the root of the 
source tree::

    uscan --safe

.. note::
    If :manpage:`uscan(1)` could not find a newer upstream version it will 
    return with the exit code `1` and print nothing to the standard output.

You can add the ``--verbose`` flag to see more information (e.g., which version 
:manpage:`uscan(1)` found)::

    uscan --safe --verbose 

You can use the ``--force-download`` flag to download the new upstream release
even if it is up-to-date with the source package::

    uscan --force-download

.. note::
    :manpage:`uscan(1)` reads the first entry in ``debian/changelog`` to 
    determine the name and the lastest upstream version of the source package.

.. note::
    If the upstream project has a signing key it should be stored in the source
    package as ``debian/upstream/signing-key.asc``. :manpage:`uscan(1)` does 
    attempt to verify a download against this key (if available).



Further Information
-------------------

- man page -- :manpage:`uscan(1)`
- Debian wiki -- `debian/watch <https://wiki.debian.org/debian/watch>`_
- Debian policy ``4.6.2.0`` -- `Upstream source location: debian/watch <https://www.debian.org/doc/debian-policy/ch-source.html#upstream-source-location-debian-watch>`_
