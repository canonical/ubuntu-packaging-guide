======================
Packaging New Software
======================

While there are thousands of packages in the Ubuntu archive, there are still 
a lot nobody has gotten to yet. If there is an exciting new piece of software 
that you feel needs wider exposure, maybe you want to try your hand at 
creating a package for Ubuntu or a PPA. This guide will take you through the 
steps of packaging new software.

Checking the Program
----------------------

The first stage in packaging is to get the released tar from upstream (we call
the authors of applications "upstream") and check that it compiles and runs.

This guide will take you through packaging a simple application called KQRCode
which has been `posted on KDE-apps.org`_.

If you don't have the build tools lets make sure we have them first.  Also if you don't have the
required dependencies lets install those as well.





Install build tools::

    $ sudo apt-get install build-essential cmake libqt4-dev kdelibs5-dev \
    $ libqrencode-dev libzbar-dev libzbarqt-dev bzr


Download main & dev package::

    $ wget -O kqrcode-0.6.0.tar.gz \
    $ "https://downloads.sourceforge.net/project/kqrcode/KQRCode/kqrcode-0.6.0.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fkqrcode%2F&ts=1328730716&use_mirror=iweb" 
    $ wget -O kqrcode-dev-0.6.0.tar.gz \
    $ "https://downloads.sourceforge.net/project/kqrcode/KQRCode-dev/kqrcode-dev-0.6.0.tar.gz?r=&ts=1328731847&use_mirror=iweb"


Now uncompress and install dev package::

    $ tar xf tar xf kqrcode-dev-0.6.0.tar.gz
    $ cd cd kqrcode-dev-0.6.0
    $ mkdir build
    $ cmake ..
    $ make
    $ sudo make install
    $ cd ../../

Now uncompress main package::

    $ tar xf kqrcode-0.6.0.tar.gz
    $ cd kqrcode-0.6.0

This application uses the CMake build system so we want to run cmake to prepare
for compilation::

    $ mkdir build
    $ cd build
    $ cmake ..

Now you can compile the source::

    $ make

If the compile completes successfully you can install and run the program::

    $ sudo make install
    $ kqrcode

Starting a Package
------------------

``bzr-builddeb`` includes a plugin to create a new package from a template,
the plugin is a wrapper around the ``dh_make`` additionally make sure your
in the directory where you have your kqrcode tar file. command::

    $ sudo apt-get install dh-make
    $ bzr dh-make kqrcode 0.6.0 kqrcode-0.6.0.tar.gz

When it asks what type of package type ``s`` for single binary.

This will import the code into a branch and add the ``debian/`` packaging
directory.  Have a look at the contents.  Most of the files it adds are only
needed for specialist packages (such as Emacs modules) so you can start by
removing the optional example files::

    $ cd kqrcode/debian
    $ rm *ex *EX

You should now customise each of the files.  

In ``debian/changelog`` change the
version number to an Ubuntu version: ``0.6.0-0ubuntu1`` (upstream version 0.6.0,
Debian version 0, Ubuntu version 1).  Also change ``unstable`` to the current
development Ubuntu release such as ``oneiric``.

Much of the package building work is done by a series of scripts
called ``debhelper``.  The exact behaviour of ``debhelper`` changes
with new major versions, the compat file instructs ``debhelper`` which
version to act as.  You will generally want to set this to the most
recent version which is ``8``.

``control`` contains all the metadata of the package.  The first paragraph
describes the source package. The second and and following paragraphs describe
the binary packages to be built.  We will need to add the packages needed to
compile the application to ``Build-Depends:`` so set that to::

    Build-Depends: debhelper (>= 7.0.50~), cmake, libqt4-dev, kdelibs5-dev,
    libqrencode-dev, libzbar-dev, libzbarqt-dev

You will also need to fill in a description of the program in the
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

    $ debuild -us -uc

``debuild`` is a command to build the package in its current location.  The
``-us -uc`` tell it there is not need to GPG sign the compile.  The result will
be placed in ``..``.  

You can view the contents of the package with::

    $ lesspipe kqrcode_0.6.0-0ubuntu1_amd64.deb

Install the package and check it works::

    $ sudo dpkg --install kqrcode_0.6.0-0ubuntu1_amd64.deb

Next Steps
----------

Even if it builds the .deb binary package, your packaging may have
bugs.  Many errors can be automatically detected by our tool
``lintian`` which can be run on both the source .dsc metadata file and
the .deb binary package::

    $ lintian kqrcode_0.6.0-0ubuntu1.dsc
    $ lintian kqrcode_0.6.0-0ubuntu1_amd64.deb

A description of each of the problems it reports can be found on the
`lintian website`_.

After making a fix to the packaging you can rebuild using ``-nc`` "no clean"
without having to build from scratch::

    $ debuild -nc

Having checked that the package builds locally you should ensure it builds on a
clean system using ``pbuilder``::

    $ bzr builddeb -S
    $ cd ../build-area
    $ pbuilder-dist oneiric build kqrcode_0.6.0-0ubuntu1.dsc

When you are happy with your package you will want others to review it.  You
can upload the branch to Launchpad for review::

    $ bzr push lp:~<lp-username>/+junk/kqrcode-package

Uploading it to a PPA (Personal Package Archive) will ensure it builds
and give an easy way for you and others to test the binary packages.
You will need to set up a PPA in Launchad then upload with ``dput``::

    $ dput ppa:<lp-username> kqrcode_0.6.0-0ubuntu1.dsc

See :doc:`uploading</udd-uploading>` for more information.

You can ask for reviews in ``#ubuntu-motu`` IRC channel, or on the
`MOTU mailing list`_.  There might also be a more specific team you
could ask such as the Kubuntu team for KDE packages.

Submitting for inclusion
------------------------

There are a number of paths that a package can take to enter Ubuntu.
In most cases, going through Debian first can be the best path. This
way ensures that your package will reach the largest number of users
as it will be available in not just Debian and Ubuntu but all of their
derivatives as well. Here are some useful links for submitting new
packages to Debian:

  - `Debian Mentors FAQ`_ - debian-mentors is for the mentoring of new and
    prospective Debian Developers. It is where you can find a sponsor
    to upload your package to the archive.

  - `Work-Needing and Prospective Packages`_ - Information on how to file
    "Intent to Package" and "Request for Package" bugs as well as list
    of open ITPs and RFPs.

  - `Debian Developer's Reference, 5.1. New packages`_ - The entire 
    document is invaluable for both Ubuntu and Debian packagers. This
    section documents processes for sumbitting new packages.

In some cases, it might make sense to go directly into Ubuntu first. For
instance, Debian might be in a freeze making it unlikely that you're
package will make it into Ubuntu in time for the next release. This
process is documented on the `"New Packages" section of the Ubuntu wiki`_.

.. _`posted on KDE-apps.org`: http://kde-apps.org/content/show.php/KQRCode?content=143544
.. _`packages.ubuntu.com`:  http://packages.ubuntu.com/
.. _`lintian website`: http://lintian.debian.org/tags.html
.. _`MOTU mailing list`: https://lists.ubuntu.com/mailman/listinfo/ubuntu-motu
.. _`Debian Mentors FAQ`: http://wiki.debian.org/DebianMentorsFaq
.. _`Work-Needing and Prospective Packages`: http://www.debian.org/devel/wnpp/
.. _`Debian Developer's Reference, 5.1. New packages`: http://www.debian.org/doc/developers-reference/pkgs.html#newpackage
.. _`"New Packages" section of the Ubuntu wiki`: https://wiki.ubuntu.com/UbuntuDevelopment/NewPackages
