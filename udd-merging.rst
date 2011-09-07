===========================================
Merging - Updating from Debian and Upstream
===========================================

Merging is one of the strengths of Bazaar, and something we do often in Ubuntu
development.  Updates can be merged from Debian, from a new upstream release,
and from other Ubuntu developers.  Doing it in Bazaar is pretty simple, and
all based around the `bzr merge-package` command.

When you are in any branch's working directory then you can merge from
another.  First check you have no uncommitted changes::

    $ bzr status

If that reports anything then you will either have to commit the changes,
revert them, or shelve them to come back to later.


Merging from Debian
===================

Next run `bzr merge-package` passing the URL of the branch to merge from.  For
instance, to merge from the version of the package in Debian Squeeze_ run::

    $ bzr merge-package lp:debian/squeeze/tomboy

This will merge the changes since the last merge point and leave you with
changes to review.  This may cause some conflicts.  You can see everything
that the `merge-package` command did by running::

    $ bzr status
    $ bzr diff

If conflicts are reported then you need to edit those files to make them look
how they should, removing the *conflict markers*.  Once you have done, run::

    $ bzr resolve
    $ bzr conflicts

This will resolve any conflicted files that you fixed, and then tell you what
else you have to deal with.

Once any conflicts are resolved, and you have made any other changes that you
need, you will add a new changelog entry, and commit::

    $ dch -i
    $ bzr commit

as described earlier.

However, before you commit, it is always a good thing to check all the Ubuntu
changes by running::

    $ bzr diff -r tag:0.6.10-5

which will show the diff between the new Debian (0.6.10-5) and Ubuntu versions
(0.6.10-5ubuntu1).  In similar way you can compare to any other versions.  To
see all available versions run::

    $ bzr tags

After testing and committing the merge, you will need to seek sponsorship or
upload to the archive in the normal way.

If you are going to build the source package from this merged branch, you
would use the ``-S`` option to the ``bd`` command.  One other thing you'll
want to consider is also using the ``--package-merge`` option.  This will add
the appropriate ``-v`` and ``-sa`` options to the source package so that all the
changelog entries since the last Ubuntu change will be included in your
``_source.changes`` file.   For example::

    $ bzr bd -S --package-merge


Merging a new upstream version
==============================

When upstream releases a new version (or you want to package a snapshot), you
have to merge a tarball into your branch.

This is done using the `bzr merge-upstream` command.  If your package has a
valid `debian/watch` file, from inside the branch that you want to merge to,
just type this::

    $ bzr merge-upstream

This will download the tarball and merge it into your branch, automatically
adding a `debian/changelog` entry for you.  `bzr-builddeb` looks at the
`debian/watch` file for the upstream tarball location.

If you do *not* have a `debian/watch` file, you'll need to specify the location
of the upstream tarball, and the version manually::

    $ bzr merge-upstream --version 1.2 http://example.org/releases/foo-1.2.tar.gz

The `--version` option is used to specify the upstream version that is being
merged in, as the command isn't able to infer that (yet).

The last parameter is the location of the tarball that you are upgrading to;
this can either be a local filesystem path, or a http, ftp, sftp, etc. URI as
shown.  The command will automatically download the tarball for you.  The
tarball will be renamed appropriately and, if required, converted to .gz.

The `merge-upstream` command will either tell you that it completed
successfully, or that there were conflicts.  Either way you will be able to
review the changes before committing as normal.

If you are merging an upstream release into an existing Bazaar branch that has
not previously used the UDD layout, `bzr merge-upstream` will fail with an
error that the tag for the previous upstream version is not available; the
merge can't be completed without knowing what base version to merge against.
To work around this, create a tag in your existing repository for the last
upstream version present there; e.g., if the last Ubuntu release was
*1.1-0ubuntu3*, create the tag *upstream-1.1* pointing to the bzr revision you
want to use as the tip of the upstream branch.


.. _`package importer`:  http://package-import.ubuntu.com/status/
.. _Squeeze: http://wiki.debian.org/DebianSqueeze
