====================
Working on a Package
====================

Once you have the source package branch in a shared repository, you'll want to
create additional branches for the fixes or other work you plan to do.  You'll
want to base your branch off the package source branch for the distro release
that you plan to upload to.  Usually this is the current development release,
but it may be older releases if you're backporting to an SRU for example.


Branching for a change
======================

The first thing to do is to make sure your source package branch is
up-to-date.  It will be if you just checked it out, otherwise do this::

    $ cd natty
    $ bzr pull

Any updates to the package that have uploaded since your checkout will now be
pulled in.  You do not want to make changes to this branch.  Instead, create a
branch that will contain just the changes you're going to make.  Let's say you
want to fix bug 12345 for the Tomboy project.  When you're in the shared
repository you previously created for Tomboy, you can create your bug fix
branch like this::

    $ bzr branch natty bug-12345
    $ cd bug-12345

Now you can do all my work in the `bug-12345` directory.  You make changes
there as necessary, committing as you go along.  This is just like doing any
kind of software development with Bazaar.  You can make intermediate commits
as often as you like, and when your changes are finished, you will use the
standard `dch` command (from the `devscripts` package)::

    $ dch -i

This will drop you in an editor to add an entry to the `debian/changelog`
file.

.. _link-via-changelog:

Here's where things diverge a little from typical Bazaar usage.  When you
added your `debian/changelog` entry, you should have included a bug fix tag
that indicated which Launchpad bug issue you're fixing.  The format of this
textual tag is pretty strict: ``LP: #12345``.  The space between the ``:`` and
the ``#`` is required and of course the number will be replaced by the actual
bug number you're fixing.  Your `debian/changelog` entry might look something
like::

    tomboy (1.5.2-1ubuntu5) natty; urgency=low

        * Don't fubar the frobnicator. (LP: #12345)

     -- Bob Dobbs <subgenius@example.com>  Mon, 10 Jan 2011 16:10:01 -0500

Normally, when you want to commit changes to your branch, you just use ``bzr
commit``, but in the case where you've made a change to ``debian/changelog``,
you'll want to use the ``debcommit`` command instead::

    $ debcommit

The reason to use ``debcommit`` instead is that it automatically includes your
``debian/changelog`` entry in the commit message, and it also adds the
necessary metadata to link your branch to the bug report when you push your
branch to Launchpad.  You can do that manually with ``bzr commit`` (and
eventually, ``bzr commit`` may get smart enough to do it for you), but for now
``debcommit`` is the most convenient way to do it.


Building the package
====================

Along the way, you'll want to build your branch so that you can test it to
make sure it does actually fix the bug.

In order to build the package you can use the `bzr builddeb` command from
the `bzr-builddeb` package.  You can build a source package with::

    $ bzr bd -S

(`bd` is an alias for `builddeb`.)  You can leave the package unsigned by
appending `-- -uc -us` to the command.

It is also possible to use your normal tools, as long as they are able to
strip the .bzr directories from the package, e.g.::

    $ debuild -i -I

If you ever see an error related to trying to build a native package without a
tarball, check to see if there is a `.bzr-builddeb/default.conf` file
erroneously specifying the package as native.  If the changelog version has a
dash in it, then it's not a native package, so remove the configuration file.
Note that while `bzr bd` has a `--native` switch, it does not have a
`--no-native` switch.

You might also see an error that looks something like this:

    dpkg-source: error: Version number suggests Ubuntu changes, but
    Maintainer: does not have Ubuntu address

In a sense, this is a safeguard to ensure that ``update-maintainer`` is run
when necessary.  However in this case, you can just temporarily set the
``$DEBEMAIL`` environment variable to a non-@ubuntu.com address::

    $ DEBEMAIL='me@example.com' bzr bd -S

Once you've got the source package, you can build it as normal with
``pbuilder`` or ``sbuild``.
