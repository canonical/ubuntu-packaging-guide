===============================
Fixing a security bug in Ubuntu
===============================

Introduction
============

Fixing security bugs in Ubuntu is not really any different than :doc:`fixing a
regular bug in Ubuntu</fixing-a-bug>`, and it is assumed that you are familiar
with patching normal bugs. To demonstrate where things are different, we will
be updating the dbus package in Ubuntu 10.04 LTS (Lucid Lynx) for a security
update.

Since security updates are most often in stable releases of Ubuntu, you'll need
to add ``deb-src`` lines to your apt configuration for the stable releases you
want to fix. So after :doc:`you are set up for Ubuntu
Development</getting-set-up>`, you'll want to add something like this to
``/etc/apt/sources.list.d/security-sources.list``::

    # lucid
    deb-src http://archive.ubuntu.com/ubuntu/ lucid main restricted universe multiverse
    deb-src http://archive.ubuntu.com/ubuntu/ lucid-updates main restricted universe multiverse
    deb-src http://security.ubuntu.com/ubuntu/ lucid-security main restricted universe multiverse

Then run the following command to put your changes into effect::

    $ sudo apt-get update


Obtaining the source
====================
In this example, we already know we want to fix the dbus package in Ubuntu
10.04 LTS (Lucid Lynx). So first you need to determine the version of the
package you want to download. We can use the ``rmadison`` to help with this::

    $ rmadison dbus
    dbus | 1.1.20-1ubuntu1 |         hardy | source, amd64, i386
    dbus | 1.1.20-1ubuntu3.4 | hardy-security | source, amd64, i386
    dbus | 1.1.20-1ubuntu3.4 | hardy-updates | source, amd64, i386
    dbus | 1.2.16-2ubuntu4 |         lucid | source, amd64, i386
    dbus | 1.2.16-2ubuntu4.1 | lucid-security | source, amd64, i386
    dbus | 1.2.16-2ubuntu4.2 | lucid-updates | source, amd64, i386
    dbus | 1.4.0-0ubuntu1 |      maverick | source, amd64, i386
    dbus | 1.4.0-0ubuntu1.1 | maverick-security | source, amd64, i386
    dbus | 1.4.0-0ubuntu1.2 | maverick-updates | source, amd64, i386
    dbus | 1.4.6-1ubuntu6 |         natty | source, amd64, i386
    dbus | 1.4.12-4ubuntu2 |       oneiric | source, amd64, i386

Typically you will want to choose the highest version for the release you want
to patch that is not in -proposed or -backports. Since we are updating Lucid's
dbus, you'll download 1.2.16-2ubuntu4.2::

    daniel@bert:~$ LC_ALL=C apt-get source dbus=1.2.16-2ubuntu4.2
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    NOTICE: 'dbus' packaging is maintained in the 'Svn' version control system at:
    svn://svn.debian.org/svn/pkg-utopia/packages/unstable/dbus
    Need to get 1,613 kB of source archives.
    Get:1 http://archive.ubuntu.com/ubuntu/ lucid-updates/main dbus 1.2.16-2ubuntu4.2 (dsc) [2,360 B]
    Get:2 http://archive.ubuntu.com/ubuntu/ lucid-updates/main dbus 1.2.16-2ubuntu4.2 (tar) [1,576 kB]
    Get:3 http://archive.ubuntu.com/ubuntu/ lucid-updates/main dbus 1.2.16-2ubuntu4.2 (diff) [34.6 kB]
    Fetched 1,613 kB in 0s (9,222 kB/s)
    dpkg-source: info: extracting dbus in dbus-1.2.16
    dpkg-source: info: unpacking dbus_1.2.16.orig.tar.gz
    dpkg-source: info: applying dbus_1.2.16-2ubuntu4.2.diff.gz
    daniel@bert:~$


Patching the source
===================
Now that we have the source package, we need to patch it to fix the
vulnerability. You may use whatever patch method that is appropriate for the
package, including :doc:`UDD techniques</udd-intro.rst>`, but this example will
use ``edit-patch`` (from the ubuntu-dev-tools package). ``edit-patch`` is the
easiest way to patch packages and it is basically a wrapper around every other
patch system you can imagine.

To create your patch using ``edit-patch``::

    daniel@bert:~$ cd dbus-1.2.16
    daniel@bert:~/dbus-1.2.16$ edit-patch 99-fix-a-vulnerability
    Normalizing patch path to 99-fix-a-vulnerability
    Normalizing patch name to 99-fix-a-vulnerability.patch
    Applying patch 00_dbus-quiesce-startup-errors.patch
    patching file bus/config-parser.c

    Applying patch 01_no-fatal-warnings.patch
    patching file dbus/dbus-internals.c

    Applying patch 02_dbus_monitor_no_sigint_handler.patch
    patching file tools/dbus-monitor.c

    Applying patch 10_dbus-1.0.1-generate-xml-docs.patch
    patching file Doxyfile.in

    Applying patch 20_kbsd_cmsgcred.patch
    patching file dbus/dbus-sysdeps-unix.c

    Applying patch 30_rt-as-needed.patch
    patching file bus/Makefile.am
    patching file bus/Makefile.in

    Applying patch 11_timeout_handling.patch
    patching file dbus/dbus-connection.c

    Applying patch 20_system_conf_limit.patch
    patching file bus/system.conf.in

    Applying patch 81-session.conf-timeout.patch
    patching file bus/session.conf.in

    Applying patch 99-CVE-2010-4352.patch
    patching file dbus/dbus-marshal-validate.c
    patching file dbus/dbus-marshal-validate.h
    patching file dbus/dbus-message-factory.c
    patching file doc/dbus-specification.xml

    Now at patch 99-CVE-2010-4352.patch
    Patch 99-fix-a-vulnerability.patch is now on top
    daniel@bert:/tmp/quilt-2oLXmw$ ls dbus/dbus-marshal-validate.c
    dbus/dbus-marshal-validate.c
    daniel@bert:/tmp/quilt-2oLXmw$ vi dbus/dbus-marshal-validate.c

Aftering making the necessary changes, you just hit Ctrl-D or type exit to
leave the subshell. E.g.::

    daniel@bert:/tmp/quilt-2oLXmw$ exit
    exit
    File ./dbus/dbus-marshal-validate.c added to patch 99-fix-a-vulnerability.patch
    Refreshed patch 99-fix-a-vulnerability.patch
    Removing patch 99-fix-a-vulnerability.patch
    Restoring dbus/dbus-marshal-validate.c

    Removing patch 99-CVE-2010-4352.patch
    Restoring doc/dbus-specification.xml
    Restoring dbus/dbus-marshal-validate.h
    Restoring dbus/dbus-marshal-validate.c
    Restoring dbus/dbus-message-factory.c

    Removing patch 81-session.conf-timeout.patch
    Restoring bus/session.conf.in

    Removing patch 20_system_conf_limit.patch
    Restoring bus/system.conf.in

    Removing patch 11_timeout_handling.patch
    Restoring dbus/dbus-connection.c

    Removing patch 30_rt-as-needed.patch
    Restoring bus/Makefile.am
    Restoring bus/Makefile.in

    Removing patch 20_kbsd_cmsgcred.patch
    Restoring dbus/dbus-sysdeps-unix.c

    Removing patch 10_dbus-1.0.1-generate-xml-docs.patch
    Restoring Doxyfile.in

    Removing patch 02_dbus_monitor_no_sigint_handler.patch
    Restoring tools/dbus-monitor.c

    Removing patch 01_no-fatal-warnings.patch
    Restoring dbus/dbus-internals.c

    Removing patch 00_dbus-quiesce-startup-errors.patch
    Restoring bus/config-parser.c

    No patches applied
    Remember to add debian/patches/99-fix-a-vulnerability.patch debian/patches/series to
    a VCS if you use one


Formatting the changelog and patches
====================================

After applying your patches you will want to update the changelog. The ``dch``
command is used to edit the ``debian/changelog`` file and ``edit-patch`` will
launch ``dch`` automatically after unapplying all the patches. If you are not
using ``edit-patch``, you can launch ``dch -i`` manually. Unlike with regular
patches, you should use the following format (note the distribution name uses
lucid-security since this is a security update for Lucid) for security
updates::

    dbus (1.2.16-2ubuntu4.3) lucid-security; urgency=low

      * SECURITY UPDATE: [DESCRIBE VULNERABILITY HERE]
        - debian/patches/99-fix-a-vulnerability.patch: [DESCRIBE CHANGES HERE]
        - [CVE IDENTIFIER]
        - LP: #[BUG NUMBER]
    ...

Update your patch to use the appropriate patch tags. Your patch should have at
a minimum the Origin, Description and Bug-Ubuntu tags. For example, edit
debian/patches/99-fix-a-vulnerability.patch to have something like::
    ## Description: [DESCRIBE VULNERABILITY HERE]
    ## Origin/Author: [COMMIT ID, URL OR EMAIL ADDRESS OF AUTHOR]
    ## Bug: [UPSTREAM BUG URL]
    ## Bug-Ubuntu: https://launchpad.net/bugs/[BUG NUMBER]
    Index: dbus-1.2.16/dbus/dbus-marshal-validate.c
    ...

Multiple vulnerabilities can be fixed in the same security upload; just be sure
to use different patches for different vulnerabilities.

Test and Submit your work
=========================

At this point the process is the same as for :doc:`fixing a regular bug in
Ubuntu</fixing-a-bug>`. Specifically, you will want to:

 #. Build your package and verify that it compiles without error and without
    any added compiler warnings
 #. Upgrade to the new version of the package from the previous version
 #. Test that the new package fixes the vulnerability and does not introduce
    any regressions
 #. Submit your work via a Launchpad bug being sure to mark the bug as a
    security bug and to subscribe ``ubuntu-security-sponsors``
