==================
Getting the Source
==================

Source package URLs
===================

Bazaar provides some very nice shortcuts for accessing Launchpad's source
branches of packages in both Ubuntu and Debian.

To refer to source branches use::

    ubuntu:package

where *package* refers to the package name you're interested in.  This URL
refers to the package in the current development version of Ubuntu.  To
refer to the branch of Tomboy in the development version, you would use::

    ubuntu:tomboy

To refer to the version of a source package in an older release of Ubuntu,
just prefix the package name with the release's code name.  E.g. to refer to
Tomboy's source package in Maverick_ use::

    ubuntu:maverick/tomboy

Since they are unique, you can also abbreviate the distro-series name::

    ubuntu:m/tomboy

You can use a similar scheme to access the source branches in Debian, although
there are no shortcuts for the Debian distro-series names.  To access the
Tomboy branch in the current development series for Debian use::

    debianlp:tomboy

and to access Tomboy in Debian Lenny_ use::

    debianlp:lenny/tomboy


.. _`Bazaar`: http://bazaar.canonical.com/en/
.. _Maverick: https://wiki.ubuntu.com/MaverickMeerkat
.. _Lenny: http://debian.org/releases/stable/


Getting the source
==================

Every source package in Ubuntu has an associated source branch on Launchpad.
These source branches are updated automatically by Launchpad, although the
process is not currently foolproof.

There are a couple of things that we do first in order to make the workflow
more efficient later.  Once you are used to the process you will learn when it
makes sense to skip these steps.


.. _branching:

Creating a shared repository
----------------------------

You want to work on the Tomboy package in Natty, and you've verified
that the source package is named ``tomboy``.  Before actually
branching the code for Tomboy, create a shared repository to hold the
branches for this package.  The shared repository will make future
work much more efficient.

Do this using the `bzr init-repo` command, passing it the directory name we
would like to use::

    $ bzr init-repo tomboy

You will see that a `tomboy` directory is created in your current working
area.  Change to this new directory for the rest of your work::

    $ cd tomboy


Getting the trunk branch
------------------------

We use the `bzr branch` command to create a local branch of the package.
We'll name the target directory `tomboy.dev` just to keep things easy to
remember::

    $ bzr branch ubuntu:tomboy tomboy.dev

The tomboy.dev directory represents the version of Tomboy in the development
version of Ubuntu, and you can always ``cd`` into this directory and do a `bzr
pull` to get any future updates.

.. _up-to-date:

Ensuring the version is up to date
----------------------------------

When you do your ``bzr branch`` you will get a message telling you if the
packaging branch is up to date.  For example::

    $ bzr branch ubuntu:tomboy
    Most recent Ubuntu version: 1.8.0-1ubuntu1.2
    Packaging branch status: CURRENT
    Branched 86 revisions.

Occasionally the importer fails and packaging branches do not match what is in
the archive.  A message saying::

    Packaging branch status: OUT-OF-DATE

means the importer has failed.  You can find out why on
http://package-import.ubuntu.com/status/ and `file a bug on the UDD
project`_ to get the issue resolved.


Upstream Tar
------------

You can get the upstream tar by running::

    bzr get-orig-source

This will try a number of methods to get the upstream tar, firstly by
recreating it from the ``upstream-x.y`` tag in the bzr archive, then by
downloading from the Ubuntu archive, lastly by running ``debian/rules
get-orig-source``. The upstream tar will also be recreated when using bzr to
build the package::

    bzr builddeb


Getting a branch for a particular release
-----------------------------------------

When you want to do something like a `stable release update`_ (SRU), or you
just want to examine the code in an old release, you'll want to grab the
branch corresponding to a particular Ubuntu release.  For example, to get the
Tomboy package for Maverick do::

    $ bzr branch ubuntu:m/tomboy maverick


Importing a Debian source package
---------------------------------

If the package you want to work on is available in Debian but not Ubuntu, it's
still easy to import the code to a local bzr branch for development.  Let's
say you want to import the `newpackage` source package.  We'll start by
creating a shared repository as normal, but we also have to create a working
tree to which the source package will be imported (remember to cd out of the
`tomboy` directory created above)::

    $ bzr init-repo newpackage
    $ cd newpackage
    $ bzr init debian
    $ cd debian
    $ bzr import-dsc http://ftp.de.debian.org/debian/pool/main/n/newpackage/newpackage_1.0-1.dsc

As you can see, we just need to provide the remote location of the dsc file,
and Bazaar will do the rest.  You've now got a Bazaar source branch.


.. _`status of the package importer`: http://package-import.ubuntu.com/status
.. _`file a bug on the UDD project`: https://bugs.launchpad.net/udd
.. _`stable release update`: https://wiki.ubuntu.com/StableReleaseUpdates
