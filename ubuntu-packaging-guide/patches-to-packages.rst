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
fortunately we are standardizing on one system, `Quilt`_, which is now used by
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

    $ quilt new kubuntu_02_program_description.diff
    Patch kubuntu_02_program_description.diff is now on top
    $ quilt add src/main.cpp
    File src/main.cpp added to patch kubuntu_02_program_description.diff
    $ sed -i "s,Webcam picture retriever,Webcam snapshot program,"
    src/main.cpp
    $ quilt refresh
    Refreshed patch kubuntu_02_program_description.diff

The ``quilt add`` step is important, if you forget it the files will not end up
in the patch.

The change will now be in
``debian/patches/kubuntu_02_program_description.diff`` and the ``series``
file will have had the new patch added to it.  You should add the new file to
the packaging::

    $ bzr add debian/patches/kubuntu_02_program_description.diff
    $ bzr add .pc/*
    $ dch -i "Add patch kubuntu_02_program_description.diff to improve the program description"
    $ bzr commit

Quilt keeps its metadata in the ``.pc/`` directory, so currently you need to
add that to the packaging too.  This should be improved in future.

As a general rule you should be careful adding patches to programs unless
they come from upstream, there is often a good reason why that change has not
already been made.  The above example changes a user interface string for
example, so it would break all translations.  If in doubt, do ask the upstream
author before adding a patch.


Patch Headers
-------------

We recommend that you tag every patch with DEP-3_ headers by putting them at the top
of patch file. Here are some headers that you can use:

:Description: Description of what the patch does.
:Author:      Who wrote the patch (i.e. "Jane Doe <packager@example.com>").
:Origin:      Where this patch comes from (i.e. "upstream"), when *Author* is
              not present.
:Bug-Ubuntu:  A link to Launchpad bug, a short form is preferred (like
              *https://bugs.launchpad.net/bugs/XXXXXXX*). If there are also
              bugs in upstream or Debian bugtrackers, add *Bug* or *Bug-Debian*
              headers.
:Forwarded:   Whether the patch was forwarded upstream. Either "yes", "no" or
              "not-needed".
:Last-Update: Date of the last revision (in form "YYYY-MM-DD").


Upgrading to New Upstream Versions
-----------------------------------

To upgrade to the new version, you can use ``bzr merge-upstream`` command::

    $ bzr merge-upstream --version 2.0.2 https://launchpad.net/ubuntu/+archive/primary/+files/kamoso_2.0.2.orig.tar.bz2

When you run this command, all patches will be unapplied, because they can
become out of date. They might need to be refreshed to match the new upstream
source or they might need to be removed altogether. To check for problems,
apply the patches one at a time::

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
    Applied kubuntu_02_program_description.diff

It is a good idea to run refresh, this will update the patch relative to the
changed upstream source::

    $ quilt refresh
    Refreshed patch kubuntu_02_program_description.diff

Then commit as usual::

    $ bzr commit -m "new upstream version"


Making A Package Use Quilt
-----------------------------

Modern packages use Quilt by default, it is built into the packaging
format.  Check in ``debian/source/format`` to ensure it says ``3.0
(quilt)``.

Older packages using source format 1.0 will need to explicitly use
Quilt, usually by including a makefile into ``debian/rules``.


Configuring Quilt
-----------------

You can use ``~/.quiltrc`` file to configure quilt. Here are some options
that can be useful for using quilt with debian/packages:

.. code-block:: sh

   # Set the patches directory
   QUILT_PATCHES="debian/patches"
   # Remove all useless formatting from the patches
   QUILT_REFRESH_ARGS="-p ab --no-timestamps --no-index"
   # The same for quilt diff command, and use colored output
   QUILT_DIFF_ARGS="-p ab --no-timestamps --no-index --color=auto"


Other Patch Systems
--------------------

Other patch systems used by packages include ``dpatch`` and ``cdbs
simple-patchsys``, these work similarly to Quilt by keeping patches in
``debian/patches`` but have different commands to apply, un-apply or create
patches. You can find out which patch system is used by a package by using the
``what-patch`` command (from the ``ubuntu-dev-tools`` package). You can use
``edit-patch``, shown in :ref:`previous chapters <working-on-a-fix>`, as a
reliable way to work with all systems.

In even older packages changes will be included directly to sources and kept
in the ``diff.gz`` source file.  This makes it hard to upgrade to new upstream
versions or differentiate between patches and is best avoided.

Do not change a package's patch system without discussing it with the Debian
maintainer or relevant Ubuntu team.  If there is no existing patch system then
feel free to add Quilt.

.. _`Quilt`: http://wiki.debian.org/UsingQuilt
.. _DEP-3: http://dep.debian.net/deps/dep3/
