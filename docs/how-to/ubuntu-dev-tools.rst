.. _ubuntu-dev-tools:

=============================================
ubuntu-dev-tools: Tools for Ubuntu developers
=============================================

``ubuntu-dev-tools`` package is a collection of 30 tools created for making
packaging work much easier for Ubuntu developers. It’s similar in scope to
Debian ``devscripts`` package.

Setting up packaging environment
================================

``setup-packaging-environment`` command allows to interactively set up packaging
environment, including setting environment variables, installing required packages
and ensuring that required repositories are enabled.

Environment variables
=====================

Introducing yourself
--------------------

``ubuntu-dev-tools`` configurations can be set using environment variables. It’s
used for example in changelogs. For example, to set e-mail address (and full
name), use ``UBUMAIL`` variable. It overrides the ``DEBEMAIL`` and ``DEBFULLNAME``
variables used by ``devscripts``. To learn ``ubuntu-dev-tools`` about you, open
`~/.bashrc` in text editor and add something like this::

    export UBUMAIL="Marcin Mikołajczak <marcin@example.org>"

Now, save this file and restart your terminal or use ``source ~/.bashrc``.

Changing preferred builder
--------------------------

Default builder is specified by ``UBUNTUTOOLS_BUILDER`` variable. To set
between *pbuilder* (default), *pbuilder-dist*, and *sbuild*, change this variable.
Example::

    export UBUNTUTOOLS_BUILDER=sbuild

Save file and restart terminal.

You can also check whether to update the builder every time before building, by
changing ``UBUNTUTOOLS_UPDATE_BUILDER`` from ``no`` (default) to ``yes``.

Downloading source packages
===========================

``ubuntu-dev-tools`` comes with ``pull-lp-source`` command, allowing to download
source packages from Launchpad. Its usage is simple. To download latest source
package for ubuntu-settings, use::

    $ pull-lp-source ubuntu-settings

You can also specify release from which you want to download source or specify
version of source package. ``-d`` option allows to download source package without
extracting. A slightly more complex example would look like this::

    $ pull-lp-source brisk-menu 0.5.0-1 -d

``pull-debian-source`` package allows to do the same for Debian source packages.
It has similar syntax.

Backporting packages
====================

``ubuntu-dev-tools`` provides ``backportpackage`` allowing us to backport a
package from specified release of Ubuntu or Debian. For example, to backport
``bzr`` package from latest development release for your installed Ubuntu version,
simply::

    $ backportpackage -w . bzr

This command allows to use more options. To specify Ubuntu release for which you
are going to backport a package, use ``-d  dest`` or ``--destination=DEST``
parameter, where ``DEST`` is Ubuntu release, for example ``xenial``. You can
specify more than one destination. In turn, ``-s SOURCE`` and ``--source=SOURCE``
specifies the Ubuntu or Debian release from which you are going to backport
a package. ``-w DIR`` and ``--workdir=DIR`` specifies directory, where package
files will be downloaded, unpacked and built. By default, it will create temporary
directory that will be automatically deleted. ``-U`` or ``--update`` allows to
update build environment before building package. ``-u`` or ``--upload`` allows to
upload package after building (for example to PPAs) using ``dput``.

Requesting backports
====================

``requestbackport`` command makes creating backports through Launchpad bugs much
easier. It creates testing checklist that will be included in the bug. For
example, to request backporting libqt5webkit5 from latest development branch to
current stable release (without optional parameters)::

    $ requestbackport libqt5webkit5

You should fulfill the checklist if you have already tested the backport.

Additional options allows to specify destination of backport and its source, by
using ``-d DEST`` or ``--destination=DEST`` and ``s SRC`` or ``--source=SRC``.

Other simple commands
=====================

``ubuntu-dev-tools`` also includes small utilities allowing to do simple tasks
like checking whether .iso file is an Ubuntu installation media.

``ubuntu-iso``
--------------

To do this, use ``ubuntu-iso <pathtoiso>``, for example::

    $ ubuntu-iso ~/Downloads/ubuntu.iso

``bitesize``
------------

“Bitesize” tag is used on Launchpad to describe tasks that are suitable for
begineers who want to contribute to one of the projects. ``bitesize`` command
allows to add “bitesize” tag to Launchpad bug with just simple command, by
providing its number, like::

    $ bitesize 1735410

``404main``
-----------

``404main`` allows to check whether all of package build dependencies are included
in main repository of specified Ubuntu distribution. Example::

    $ 404main libqt5webkit5 xenial

If any of the required packages isn’t part of Ubuntu main repository, you can
check whether the package fulfill `Ubuntu main inclusion requirements <Requirements_>`_ and request
it.

Further reading
---------------

``ubuntu-dev-tools`` manpages are covering more about usage of this package.

.. _Requirements: https://wiki.ubuntu.com/UbuntuMainInclusionRequirements
