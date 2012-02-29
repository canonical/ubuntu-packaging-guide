===================
Patches to Packages
===================

Sometimes, Ubuntu package maintainers have to change the upstream source code
in order to make it work properly on Ubuntu.  Examples include, patches to
upstream that haven't yet made it into a released version, or changes to the
upstream's build system needed only for building it on Ubuntu.  We could
change the upstream source code directly, but doing this makes it more
difficult to remove the patches later when upstream has incorporated them, or
extract the change to submit to the upstream project.  Instead, we keep these
changes as separate patches, in the form of diff files.

There are a number of different ways of handling patches in Debian packages,
fortunately we are standardising on one system, `Quilt`_, which is now used by
most packages.

Let's look at an example package, ``kamoso`` in Natty::

    $ bzr branch ubuntu:natty/kamoso

The patches are kept in ``debian/patches``.  This package has one patch
``kubuntu_01_fix_qmax_on_armel.diff`` to fix a compile failure on ARM.  The
patch has been given a name to describe what it does, a number to keep the
patches in order (two patches can overlap if they change the same file) and in
this case the Kubuntu team adds their own prefix to show the patch comes from
them rather than from Debian.

The order of patches to apply is kept in ``debian/patches/series``.

Patches with Quilt
------------------

Before working with Quilt you need to tell it where to find the patches.  Add
this to your ``~/.bashrc``::

    export QUILT_PATCHES=debian/patches

And source the file to apply the new export::

    $ . ~/.bashrc

By default all patches are applied already to UDD checkouts or downloaded
packages.  You can check this with::

    $ quilt applied
    kubuntu_01_fix_qmax_on_armel.diff

If you wanted to remove the patch you would run ``pop``::

    $ quilt pop
    Removing patch kubuntu_01_fix_qmax_on_armel.diff
    Restoring src/kamoso.cpp

    No patches applied

And to apply a patch you use ``push``::

    $ quilt push
    Applying patch kubuntu_01_fix_qmax_on_armel.diff
    patching file src/kamoso.cpp

    Now at patch kubuntu_01_fix_qmax_on_armel.diff


Adding a New Patch
-------------------

To add a new patch you need to tell Quilt to create a new patch, tell it which
files that patch should change, edit the files then refresh the patch::

    $ quilt new kubuntu_02_programme_description.diff
    Patch kubuntu_02_programme_description.diff is now on top
    $ quilt add src/main.cpp
    File src/main.cpp added to patch kubuntu_02_programme_description.diff
    $ sed -i "s,Webcam picture retriever,Webcam snapshot programme,"
    src/main.cpp
    $ quilt refresh
    Refreshed patch kubuntu_02_programme_description.diff

The ``quilt add`` step is important, if you forget it the files will not end up
in the patch.

The change will now be in
``debian/patches/kubuntu_02_programme_description.diff`` and the ``series``
file will have had the new patch added to it.  You should add the new file to
the packaging::

    $ bzr add debian/patches/kubuntu_02_programme_description.diff
    $ bzr add .pc/*
    $ dch -i "Add patch kubuntu_02_programme_description.diff to improve the programme description"
    $ bzr commit

Quilt keeps its metadata in the ``.pc/`` directory, so currently you need to
add that to the packaging too.  This should be improved in future.

As a general rule you should be careful adding patches to programmes unless
they come from upstream, there is often a good reason why that change has not
already been made.  The above example changes a user interface string for
example, so it would break all translations.  If in doubt, do ask the upstream
author before adding a patch.

Upgrading to New Upstream Versions
-----------------------------------

When you upgrade to a new upstream version, patches will often become out of
date.  They might need to be refreshed to match the new upstream source or they
might need to be removed altogether.

You should start by ensuring no patches are applied.  Unfortunately a commit is
needed before you can merge in the new upstream (this is `bug 815854`_::

    $ quilt pop -a
    $ bzr commit -m "remove patches"

Then upgrade to the new version

    $ bzr merge-upstream --version 2.0.2 https://launchpad.net/ubuntu/+archive/primary/+files/kamoso_2.0.2.orig.tar.bz2

Then apply the patches one at a time to check for problems::

    $ quilt push
    Applying patch kubuntu_01_fix_qmax_on_armel.diff
    patching file src/kamoso.cpp
    Hunk #1 FAILED at 398.
    1 out of 1 hunk FAILED -- rejects in file src/kamoso.cpp
    Patch kubuntu_01_fix_qmax_on_armel.diff can be reverse-applied

If it can be reverse-applied this means the patch has been applied already by
upstream, so we can delete the patch::

    $ quilt delete kubuntu_01_fix_qmax_on_armel
    Removed patch kubuntu_01_fix_qmax_on_armel.diff

Then carry on::

    $ quilt push
    Applied kubuntu_02_programme_description.diff

It is a good idea to run refresh, this will update the patch relative to the
changed upstream source::

    $ quilt refresh
    Refreshed patch kubuntu_02_programme_description.diff

Then commit as usual::

    $ bzr commit -m "new upstream version"


Making A Package Use Quilt
-----------------------------

Modern packages use Quilt by default, it is built into the packaging
format.  Check in ``debian/source/format`` to ensure it says ``3.0
(quilt)``.

Older packages using source format 1.0 will need to explicitly use
Quilt, usually by including a makefile into ``debian/rules``.


Other Patch Systems
--------------------

Other patch systems used by packages include ``dpatch`` and ``cdbs
simple-patchsys``, these work similarly to Quilt by keeping patches in
debian/patches but have different commands to apply, unapply or create patches.
You can use ``edit-patch``, shown in previous chapters, as a reliable way to
work with all systems.

Even older packages will include changes directly to sources and kept in the
``diff.gz`` source file.  This makes it hard to upgrade to new upstream
versions or differentiate between patches and is best avoided.

Bazaar Loom is a way to keep patches as part of bzr trees, see :doc:`Working
with Patches via Loom<./udd-patchsys>` for more information.

Do not change a package's patch system without discussing it with the Debian
maintainer or relevant Ubuntu team.  If there is no existing patch system then
feel free to add Quilt.

.. _`Quilt`: http://wiki.debian.org/UsingQuilt
.. _`bug 815854`: https://bugs.launchpad.net/bzr-builddeb/+bug/815854
