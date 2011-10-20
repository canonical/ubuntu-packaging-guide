======================
Building a new package
======================

Let's say I have an upstream project that is not yet available for Ubuntu.  I
want to create a package from this project and make it available as a PPA_ so
that other people can more easily use the code.  This also makes a good first
step in contributing your package to universe_.


Example package
===============

I started with a Python library called `flufl.enum`_, which is a fairly
typical setuptools-based Python package.  Fortunately, it's also maintained in
Launchpad using Bazaar, so that makes bootstrapping much easier.  (TBD: add
instructions for using other upstream VCSs.)

Because we want to package the trunk branch, getting started is pretty
simple::

    $ bzr init-repo flufl.enum
    $ cd flufl.enum
    $ bzr branch lp:flufl.enum trunk
    $ bzr branch trunk debianize
    $ cd debianize

.. TODO explain what each of these commands does


Bootstrapping
=============

You need to create the initial ``debian`` directory, as well as the necessary 
files inside the ``debian`` directory.  Currently, there are many ways to set up 
this directory, but hopefully there will be `some convergence`_ in the methods,
especially if you're building standard Python setuptools-based libraries and
applications.

.. COMMENT  Is "Bootstrapping" the technical / commonly-used developer term? Also, please list the files needed in the debian directory.
  

The bzr-builddeb way
--------------------

.. This section seems a bit too casual, and assumes to much prior knowledge (re: use of "of course").

You could of course just use `dh_make(8)` to get things going, or you could
use `bzr dh-make`.  The latter might provide some benefits, and can be run
like so from inside your branch::

    $ bzr dh-make PKGNAME VERSION DOWNLOADURL
    $ bzr add debian

If you don't have a URL to download a tarball from, you'll need to create the
tarball locally first.  Use ``bzr dh-make --help`` for details on this command.

After you've created the ``debian`` directory template, be sure to ``bzr rm``
any ``debian`` files you don't need (e.g. the ``*.ex`` files), and edit files
such as ``debian/control``, ``debian/watch``, ``debian/copyright`` and
``debian/changelog``.  The following section may give you some hints about
that.


The stdeb way
-------------

Another way I've found useful for initializing the ``debian`` directory for
Python setuptools-based packages, is to use the stdeb_ package.  The full
documentation for this package is available on the `upstream home`_, but you
won't need all of the commands.  stdeb has a command that is *exactly* what
we're looking for!

In either case, start by putting this in your ``~/.pydistutils.cfg`` file::

    [global]
    command.packages:stdeb.command


Modern stdeb
~~~~~~~~~~~~

Here's how easy it is::

    $ python setup.py debianize
    $ bzr add debian
    $ bzr commit -m'Debianize'

We also need a ``debian/copyright`` file.  Normally, we'd use ``dh_make -c``
for that but again, that doesn't play nicely with UDD.  ``dh_make`` expects a
particular file system layout that we don't have.  No matter, we'll add the
copyright file manually::

    $ cp /usr/share/debhelper/dh_make/licenses/lgpl3 debian/copyright
    $ edit debian/copyright
    $ bzr add debian/copyright
    $ bzr commit -m'Added copyright file'


stdeb <= 0.5.1
~~~~~~~~~~~~~~

If you have an older version of stdeb, use this command to create the basic
``debian/`` directory layout::

    $ python setup.py sdist_dsc

This command leaves you with a ``deb_dist`` directory containing a
``flufl.enum_3.0.1`` directory.  Inside that is your ``debian/`` directory.
Because we're using UDD we don't care about anything else that ``sdist_dsc``
produces, so we can shuffle things around and remove the cruft.

    $ mv deb_dist/munepy-2.0.1/debian .
    $ rm -rf deb_dist
    $ bzr add debian
    $ bzr commit -m'Add debian directory'


pkgme
-----

pkgme_ is a new tool that makes it easy to Debianize a new package.  TBD:
describe how to use it.


debian/control file
===================

You probably want to edit the ``debian/control`` file at this point, adding
any information that's missing, or fixing incorrect default information.  For
example, I needed to modify the ``Maintainer`` and ``Description`` fields, and
add ``X-Python-Version`` and ``Homepage`` fields.

Now we want to build the source package.  The easiest way to do that is with
the ``bzr-builddeb`` plugin, however this requires a valid ``debian/watch``
file so that builddeb can find the upstream tarball.  This really should match
the version of the checkout you've made.


debian/watch file
=================

Here for example is the ``debian/watch`` file I'm using::

    version=3
    http://pypi.python.org/packages/source/f/flufl.enum/flufl.enum-(.*).tar.gz

If your tarballs live on Launchpad, the ``debian/watch`` file is a little more
complicated (see `Question 21146`_ and `Bug 231797`_ for why this is).  In
that case, use something like::

    version=3
    https://launchpad.net/flufl.enum/+download http://launchpad.net/flufl.enum/.*/flufl.enum-(.+).tar.gz

So, then it's a matter of...::

    $ bzr add debian/watch
    $ bzr commit -m'added debian/watch file'


Building the source package
===========================

Now we can build the source package and publish the package as we normally
would, with ``bzr builddeb -S`` and ``dput``.


.. _PPA: https://help.launchpad.net/Packaging/PPA
.. _universe: https://wiki.ubuntu.com/MOTU/GettingStarted
.. _`flufl.enum`: http://launchpad.net/flufl.enum
.. _`some convergence`: http://launchpad.net/bugs/545361
.. _stdeb: http://packages.ubuntu.com/lucid/python-stdeb
.. _`upstream home`: http://github.com/astraw/stdeb#the-commands
.. _pkgme: https://launchpad.net/pkgme
.. _`Question 21146`: https://answers.launchpad.net/launchpad/+question/21146
.. _`Bug 231797`: https://launchpad.net/bugs/231797
