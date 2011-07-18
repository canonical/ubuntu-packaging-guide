======================
Packaging From Scratch
======================

You have found an exciting new piece of software, it needs exposure to the
wider world by getting it into Ubuntu or a PPA, so you have decided to package
it.

Checking the Programme
----------------------

The first stage in packaging is to get the released tar from upstream (we call
the authors of applications "upstream") and check that it compiles and runs.

This guide will take you through packaging a simple application called KQRCode
which has been `posted on KDE-apps.org`_.  Download `version 0.4 from
Sourceforge`_ and put it in a new directory.

Now uncompress it::

    $ tar xf kqrcode-0.4.tar.gz
    $ cd kqrcode-0.4

This application uses the CMake build system so we want to run cmake to prepare
for compilation::

    $ mkdir build
    $ cd build
    $ cmake ..

CMake will check for the required dependencies, in this case it tells us we
need Qt and KDE libraries.  We also need GCC, packagers can install
``build-essential`` which brings this in and is assumed to be installed for all
packages. If you do not have the development files for these libraries installed
it will fail, you can install them and run CMake again::

    $ sudo apt-get install build-essential libqt4-dev kdelibs5-dev
    $ cmake ..

Now you can compile the source::

    $ make

Running this gives some errors about missing headers.  This means there are
other libraries missing which were not checked by CMake.  Make a note to inform
upstream of this problem.  `packages.ubuntu.com`_ can be used to find which
packages these headers come from, install these packages and continue the
compile::

    $ sudo apt-get install libqrencode-dev libzbar-dev libzbarqt-dev
    $ make

If the compile completes successfully you can install and run the programme::

    $ sudo make install
    $ kqrcode

Starting a Package
------------------

``bzr-builddeb`` includes a plugin to create a new package from a template,
the plugin is a wrapper around the ``dh_make`` command::

    $ sudo apt-get install dh-make
    $ bzr dh-make kqrcode 0.4 kqrcode-0.4.tar.gz

When it asks what type of package type ``s`` for single binary.

This will import the code into a branch and add the ``debian/`` packaging
directory.  Have a look at the contents.  Most of the files it adds are only
needed for specialist packages (such as Emacs modules) so you can start by
removing the optional example files::

    $ cd kqrcode/debian
    $ rm *ex *EX

You should now customise each of the files.  

In ``debian/changelog`` change the
version number to an Ubuntu version: ``0.4-0ubuntu1`` (upstream version 0.4,
Debian version 0, Ubuntu version 1).  Also change ``unstable`` to the current
development Ubuntu release such as ``oneiric``.

Much of the package building work is done by a series of scripts
called ``debhelper``.  The exact behaviour of ``debhelper`` changes
with new major versions, the compat file instructs ``debhelper`` which
version to act as.  You will generally want to set this to the most
recent version which is ``8``.

``control`` contains all the metadata of the package.  The first paragraph
describes the source package.  The second and and following paragraphs describe
the binary packages to be built.  We will need to add the packages needed to
compile the application to ``Build-Depends:`` so set that to::

    Build-Depends: debhelper (>= 7.0.50~), cmake, libqt4-dev, kdelibs5-dev,
    libqrencode-dev, libzbar-dev, libzbarqt-dev

You will also need to fill in a description of the programme in the
``Description:`` field.

``copyright`` needs to be filled in to follow the licence of the upstream
source.  According to the kqrcode/COPYING file this is GNU GPL 3 or later.

``docs`` contains any upstream documentation files you think should be included
in the final package.

``README.source`` and ``README.Debian`` are only needed if your package has any
non-standard features, we don't so you can delete them.

``source/format`` can be left as is, this describes the version format of the
source package and should be ``3.0 (quilt)``.

``rules`` is the most complex file.  This is a Makefile which compiles the
code and turns it into a binary package.  Fortunately most of the work is
automatically done these days by ``debhelper 7`` so the universal ``%``
Makefile target just runs the ``dh`` script which will run everything needed.

Finally commit the code to your packaging branch::

    $ bzr commit

Building the package
--------------------

Now we need to check that our packaging successfully compiles the package and
builds the .deb binary package::

    $ bzr builddeb

This should compile the package and place the result in ``../build-area``.  You
can view the contents of the package with::

    $ lesspipe kqrcode_0.4-0ubuntu1_amd64.deb

Install the package and check it works::

    $ sudo dpkg --install kqrcode_0.4-0ubuntu1_amd64.deb

Next Steps
----------

Even if it builds the .deb binary package, your packaging will not yet be a work
of perfection, nothing is first time.  Many errors can be automatically
detected by our tool ``lintian`` which can be run on both the source .dsc
metadata file and the .deb binary package::

    $ lintian kqrcode_0.4-0ubuntu1.dsc
    $ lintian kqrcode_0.4-0ubuntu1_amd64.deb

A description of each of the problems can be found on the `lintian website`_.

After making a fix to the packaging you can rebuild without having to build
from scratch using::

    $ debuild -nc

FIXME is there a UDD equivalent?

Having checked that the package builds locally you should ensure it builds on a
clean system using ``pbuilder``::

    $ bzr builddeb -S
    $ cd ../build-area
    $ pbuilder-dist oneiric build kqrcode_0.4-0ubuntu1.dsc

When you are happy with your package you will want others to review it.  You
can upload the branch to Launchpad for review::

    $ bzr push lp:~<lp-username>/+junk/kqrcode-package

You could also upload the source package to REVU for review::

    $ bzr builddeb -S
    $ cd ..
    $ dput revu kqrcode_0.4-0ubuntu1.dsc

You will need to log in to REVU before you can upload to it.  The package
must also be correctly signed by the GPG key you have in Launchpad.  See the
`REVU wiki page` for full details.

.. _`posted on KDE-apps.org`: http://kde-apps.org/content/show.php/KQRCode?content=143544
.. _`version 0.4 from Sourceforge`: http://sourceforge.net/projects/kqrcode/files/kqrcode-0.4.tar.gz/download
.. _`packages.ubuntu.com`:  http://packages.ubuntu.com/
.. _`lintian website`: http://lintian.debian.org/tags.html
.. _`REVU wiki page`: https://wiki.kubuntu.org/MOTU/Packages/REVU
