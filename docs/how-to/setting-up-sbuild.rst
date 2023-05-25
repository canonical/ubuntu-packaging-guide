.. _setting-up-sbuild:

=================
Setting up sbuild
=================

``sbuild`` simplifies building Debian/Ubuntu binary package from source
in clean environment. It allows to try debugging packages in environment
similar (as opposed to ``pbuild``) to builders used by Launchpad.

It works on different architectures and allows to build packages for
other releases. It needs kernel supporting overlayfs.

Installing sbuild
=================

To use sbuild, you need to install sbuild and other required packages
and add yourself to the ``sbuild`` group::

    $ sudo apt install debhelper sbuild schroot ubuntu-dev-tools
    $ sudo adduser $USER sbuild

Create ``.sbuildrc`` in your home directory with following content::

    # Name to use as override in .changes files for the Maintainer: field
    # (mandatory, no default!).
    $maintainer_name='Your Name <user@example.org>';

    # Default distribution to build.
    $distribution = "jammy";
    # Build arch-all by default.
    $build_arch_all = 1;

    # When to purge the build directory afterwards; possible values are "never",
    # "successful", and "always".  "always" is the default. It can be helpful
    # to preserve failing builds for debugging purposes.  Switch these comments
    # if you want to preserve even successful builds, and then use
    # "schroot -e --all-sessions" to clean them up manually.
    $purge_build_directory = 'successful';
    $purge_session = 'successful';
    $purge_build_deps = 'successful';
    # $purge_build_directory = 'never';
    # $purge_session = 'never';
    # $purge_build_deps = 'never';

    # Directory for writing build logs to
    $log_dir=$ENV{HOME}."/ubuntu/logs";

    # don't remove this, Perl needs it:
    1;

Replace “Your Name <user@example.org>” with your name and e-mail address.
Change default distribution if you want, but remember that you can
specify target distribution when executing command.

If you haven’t restarted your session after adding yourself to the
``sbuild`` group, enter::

    $ sg sbuild

Generate GPG keypair for sbuild and create chroot for specified release::

    $ sbuild-update --keygen
    $ mk-sbuild jammy

This will create chroot for your current architecture. You might want to
specify another architecture. For this, you can use ``--arch`` option.
Example::

    $ mk-sbuild jammy --arch=i386

Using schroot
=============

Entering schroot
----------------

You can use ``schroot -c <release>-<architecture> [-u <USER>]`` to enter
newly created chroot, but that’s not exactly the reason why you are
using sbuild::

    $ schroot -c jammy-amd64 -u root

Using schroot for package building
----------------------------------

To build package using sbuild chroot, we use (surprisingly) the
``sbuild`` command. For example, to build ``hello`` package from x86_64
chroot, after applying some changes::

    apt source hello
    cd hello-*
    sed -i -- 's/Hello/Goodbye/g' src/hello.c   # some
    sed -i -- 's/Hello/Goodbye/g' tests/hello-1 #
    dpkg-source --commit
    dch -i                                      #
    update-maintainer                           # changes
    sbuild -d jammy-amd64

To build package from source package (``.dsc``), use location of the
source package as second parameter::

    sbuild -d jammy-amd64 ~/packages/goodbye_*.dsc

To make use of all power of your CPU, you can specify number of threads
used for building using standard ``-j<threads>``::

    sbuild -d jammy-amd64 -j8

Maintaining schroots
====================

Listing chroots
---------------

To get list of all your sbuild chroots, use ``schroot -l``. The
``source:`` chroots are used as base of new schroots. Changes here aren’t
recommended, but if you have specific reason, you can open it using
something like::

    $ schroot -c source:jammy-amd64

Updating schroots
-----------------

To upgrade the whole schroot::

    $ sudo sbuild-update -udcar jammy-amd64

Expiring active schroots
------------------------

If because of any reason, you haven’t stopped your schroot, you can
expire all active schroots using::

    $ schroot -e --all-sessions

Further reading
===============

There is `Debian wiki page <DebianWiki_>`_ covering sbuild usage.

`Ubuntu Wiki <UbuntuWiki_>`_ also has article about basics of sbuild.

``sbuild`` manpages are covering details about sbuild usage and
available features.

.. _DebianWiki: https://wiki.debian.org/sbuild

.. _UbuntuWiki: https://wiki.ubuntu.com/SimpleSbuild
