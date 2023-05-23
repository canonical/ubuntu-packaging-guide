===================================
Security and Stable Release Updates
===================================

Fixing a Security Bug in Ubuntu
-------------------------------

Introduction
============

Fixing security bugs in Ubuntu is not really any different than :doc:`fixing a
regular bug in Ubuntu<./fixing-a-bug>`, and it is assumed that you are familiar
with patching normal bugs. To demonstrate where things are different, we will
be updating the dbus package in Ubuntu 12.04 LTS (Precise Pangolin) for a security
update.


Obtaining the source
====================

In this example, we already know we want to fix the dbus package in Ubuntu
12.04 LTS (Precise Pangolin). So first you need to determine the version of the
package you want to download. We can use the ``rmadison`` to help with this::

    $ rmadison dbus | grep precise
    dbus | 1.4.18-1ubuntu1   | precise          | source, amd64, armel, armhf, i386, powerpc
    dbus | 1.4.18-1ubuntu1.4 | precise-security | source, amd64, armel, armhf, i386, powerpc
    dbus | 1.4.18-1ubuntu1.4 | precise-updates  | source, amd64, armel, armhf, i386, powerpc

Typically you will want to choose the highest version for the release you want
to patch that is not in -proposed or -backports. Since we are updating Precise's
dbus, you'll download 1.4.18-1ubuntu1.4 from precise-updates::

    $ bzr branch ubuntu:precise-updates/dbus


Patching the source
===================
Now that we have the source package, we need to patch it to fix the
vulnerability. You may use whatever patch method that is appropriate for the
package, but this example will use ``edit-patch`` (from the ubuntu-dev-tools
package). ``edit-patch`` is the easiest way to patch packages and it is
basically a wrapper around every other patch system you can imagine.

To create your patch using ``edit-patch``::

    $ cd dbus
    $ edit-patch 99-fix-a-vulnerability

This will apply the existing patches and put the packaging in a temporary
directory. Now edit the files needed to fix the vulnerability.  Often upstream
will have provided a patch so you can apply that patch::

    $ patch -p1 < /home/user/dbus-vulnerability.diff

After making the necessary changes, you just hit Ctrl-D or type exit to
leave the temporary shell.

Formatting the changelog and patches
====================================

After applying your patches you will want to update the changelog. The ``dch``
command is used to edit the ``debian/changelog`` file and ``edit-patch`` will
launch ``dch`` automatically after un-applying all the patches. If you are not
using ``edit-patch``, you can launch ``dch -i`` manually. Unlike with regular
patches, you should use the following format (note the distribution name uses
precise-security since this is a security update for Precise) for security
updates::

    dbus (1.4.18-2ubuntu1.5) precise-security; urgency=low

      * SECURITY UPDATE: [DESCRIBE VULNERABILITY HERE]
        - debian/patches/99-fix-a-vulnerability.patch: [DESCRIBE CHANGES HERE]
        - [CVE IDENTIFIER]
        - [LINK TO UPSTREAM BUG OR SECURITY NOTICE]
        - LP: #[BUG NUMBER]
    ...

Update your patch to use the appropriate patch tags. Your patch should have at
a minimum the Origin, Description and Bug-Ubuntu tags. For example, edit
debian/patches/99-fix-a-vulnerability.patch to have something like::

    ## Description: [DESCRIBE VULNERABILITY HERE]
    ## Origin/Author: [COMMIT ID, URL OR EMAIL ADDRESS OF AUTHOR]
    ## Bug: [UPSTREAM BUG URL]
    ## Bug-Ubuntu: https://launchpad.net/bugs/[BUG NUMBER]
    Index: dbus-1.4.18/dbus/dbus-marshal-validate.c
    ...

Multiple vulnerabilities can be fixed in the same security upload; just be sure
to use different patches for different vulnerabilities.

Test and Submit your work
=========================

At this point the process is the same as for :doc:`fixing a regular bug in
Ubuntu<./fixing-a-bug>`. Specifically, you will want to:

 #. Build your package and verify that it compiles without error and without
    any added compiler warnings
 #. Upgrade to the new version of the package from the previous version
 #. Test that the new package fixes the vulnerability and does not introduce
    any regressions
 #. Submit your work via a Launchpad merge proposal and file a Launchpad bug
    being sure to mark the bug as a security bug and to subscribe
    ``ubuntu-security-sponsors``

If the security vulnerability is not yet public then do not file a merge
proposal and ensure you mark the bug as private.

The filed bug should include a Test Case, i.e. a comment which clearly shows how
to recreate the bug by running the old version then how to ensure the bug no
longer exists in the new version.

The bug report should also confirm that the issue is fixed in Ubuntu versions
newer than the one with the proposed fix (in the above example newer than
Precise).  If the issue is not fixed in newer Ubuntu versions you should prepare
updates for those versions too.


Stable Release Updates
-------------------------------

We also allow updates to releases where a package has a high impact bug such as
a severe regression from a previous release or a bug which could cause data
loss.  Due to the potential for such updates to themselves introduce bugs we
only allow this where the change can be easily understood and verified.

The process for Stable Release Updates is just the same as the process for
security bugs except you should subscribe ``ubuntu-sru`` to the bug.

The update will go into the ``proposed`` archive (for example
``precise-proposed``) where it will need to be checked that it fixes the problem
and does not introduce new problems.  After a week without reported problems it
can be moved to ``updates``.

See the `Stable Release Updates wiki page <SRUWiki_>`_ for more information.

.. _SRUWiki: https://wiki.ubuntu.com/StableReleaseUpdates
