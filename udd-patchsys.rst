==============================================================
Ubuntu Distributed Development - Working with Patches via Loom
==============================================================

Here are some guidelines for working with Quilt_ patches using the Bazaar Loom
plugin. A loom allows the development of multiple patches at once, while still
giving each patch a branch of its own.  This is a work in progress for the UDD
developers who will be working on improving this workflow.

Many existing packages that have changes from upstream express those changes
using a patch system, of which there are several to choose from.  Usually,
when you make an additional change to a package, you'll want to add a patch
file to the patch system being used, rather than editing the source code in
place.  Note however that it is considered bad practice to add a patch system
to a package that does not already have one.  In that case, either coordinate
with the Debian maintainer, or edit the files in place.  You can find out if
your package has a patch system by using the ``what-patch`` command (from the
``ubuntu-dev-tools`` package).

Although UDD, and in particular `Bazaar looms`_ makes it pretty easy to keep
individual patches separated, if you're submitting changes to be uploaded,
you're currently better off playing along with the package's patch system.
*You will want at least bzr loom version 2.2.1dev, otherwise you'll have
problems pushing and pulling your threads to Launchpad.* Do ``bzr plugins`` to
find the version you're using.

One important thing to know: all source branches reflect the tree after a
``quilt push -a``.  In other words, when you branch a source branch, you get
the tree with all patches applied, ready for you to jump right into hacking.
You do not need to ``quilt push -a`` manually, and in fact, you'll get a tree
with lots of distracting modifications if you push or pop all the changes.  Or
to put it another way, once you have a branch, jump right in!


Develop your patch
==================

Start as you normally would with UDD and looms::

    $ bzr init-repo foobar
    $ cd foobar
    $ bzr branch ubuntu:foobar
    $ bzr branch foobar bug-12345
    $ cd bug-12345
    $ bzr loomify --base trunk
    $ bzr create-thread sourcefix

Now that you are in the ``sourcefix`` thread, just edit the source code,
making whatever changes you need to fix the bug.  Don't worry about the patch
system at this point, at least until you are happy with your changes.  If
someone else pushes changes to the package while you're working on it, just
``bzr commit`` your current work, ``bzr down-thread`` to ``trunk``, pull the
updates, and ``bzr up-thread --auto`` back to the ``sourcefix`` thread,
resolving any conflicts along the way.  You can periodically commit your
changes, ``bzr record`` and push them to Launchpad as you go, of course
linking your branch to the bug in Launchpad.  So far, it's just normal
development with looms.

Once you're happy with your changes, you need to essentially import your
thread's changes into a quilt patch.  This is fairly easy to do.  While inside
the ``sourcefix`` thread do::

    $ bzr create-thread quiltfix
    $ bzr diff -rthread:trunk..thread:sourcefix | quilt import -p0 -P bug-12345 /dev/stdin
    $ bzr add debian/patches/bug-12345
    $ quilt push
    $ quilt pop
    $ bzr commit

Why the last push/pop before the commit?  The push gets the imported changes
into the quilt patch, but also leaves the tree modified, so you'll essentially
have the changes both in the ``debian/`` directory and in the source tree.
The pop undoes the tree changes (which are also available in the ``sourcefix``
thread), but leaves the quilt change available.  A ``bzr commit`` at this
point gives you a thread with just the changes to ``debian/``.


Problems
========

The problem comes when you want to modify the patch, e.g.::

    $ bzr down-thread
    <hack, commit>

This does *not* work well::

    $ bzr up-thread

You'd expect at this point to be able to ``quilt fold`` your new changes to
update your ``bug-12345`` quilt patch, but in fact, this doesn't work.  You can
end up with difficult to resolve conflicts, patch failures and rejections.  My
recommendation is that when you make changes to your ``sourcefix`` thread,
blow away your ``quiltfix`` thread and regenerate it.  Looms make this easy::

    $ bzr up-thread
    $ bzr revert
    $ bzr combine-thread --force (throws away your quiltfix changes)
    $ bzr create-thread quiltfix
    $ bzr diff -rthread:trunk..thread:sourcefix | quilt import -p0 -P bug-12345 /dev/stdin
    etc...

So you've thrown away the original ``quiltfix`` thread and recreated it, with
your updated ``sourcefix`` changes.


Gotchas
=======

One thing to keep in mind is that quilt uses a hidden ``.pc`` directory to
record its status.  This directory is under version control in all source
branches.  *Watch out* for changes to the ``.pc`` directory that are unrelated
(or more accurately, uninteresting) to your patch.  This can happen because
the UDD source branch importer `currently includes any existing .pc
directory`_ in the imported branch.  This can cause conflicts, or other
unwanted or unknown changes because you've essentially got two conflicting
version control systems competing for the same thing (i.e. bzr and quilt3).
For now, the best recommendation is to revert any changes to the ``.pc``
directory in your branch.


Publishing your changes
=======================

It's actually easier at this point to generate a diff for attaching to the bug
report.  While inside the ``quiltfix`` thread, just::

    $ bzr up-thread --auto
    $ bzr diff -rthread: > bug-12345.diff

The differences between the ``quiltfix`` thread and the ``sourcefix`` thread
are the interesting bits, and totally appropriate for committing and upload.
Because of the way looms interacts with Launchpad, you can still link your
branch to the bug and request a merge proposal, but understand that the diff
will include all changes between ``quiltfix`` (top) and ``trunk`` (bottom)
threads.  So the merge proposal will include the changes in the ``debian/``
directory, *and* the changes in the source tree.  As long as you and your
reviewer understands this, you should be okay, but it can be confusing at
first.

If you need a sponsor to merge and upload your changes, one thing they *do
not* want to do is::

    $ bzr branch ubuntu:foobar
    $ cd foobar
    $ bzr merge lp:~you/ubuntu/natty/foobar/yourfix

Much badness (in the form of infinite *maximum recursion depth* exceptions)
ensues.  Yes, we need to file a bug on that.


edit-patch
==========

``edit-patch`` is a nice little wrapper script that comes as part of the
``ubuntu-dev-tools`` package.  It pretty much hides the nasty details of
dealing with the patch system specifically.  For example, while the above
works well if your package is using quilt already, you'll have to adjust the
workflow, perhaps significantly, to work with `a different patch system`_.  In
theory ``edit-patch`` should solve this, but there are currently two blockers.

  * By default, ``bzr diff`` produces a ``-p0`` patch, but ``edit-patch``
    defers to the underlying patch system's default.  For quilt, this is
    ``-p1``.  ``quilt import`` takes a ``-p`` argument to specify the prefix
    level, but this isn't yet exposed in ``edit-patch``.  If you're
    adventurous, try changing the ``bzr diff`` command above to specify the
    proper prefixes using its ``-p`` option.
  * By default, ``edit-patch`` requires a path to an existing patch file, but
    it's more convenient to pipe the output of ``bzr diff`` to the stdin of
    ``edit-patch``, as shown above.  The alternative would be to save the diff
    in a temporary file, and then point ``edit-patch`` to this temporary file.


Future
======

Ideally, it would be nice to add a ``bzr edit-patch`` or some such command
which does the whole loom -> patch system import.  At least ``edit-patch``
could grow a ``-p`` and ``-P`` option, as well as read from stdin.  Stay
tuned, or get involved!

There's now `a bug` that tracks this.


.. _`Bazaar looms`: https://launchpad.net/bzr-loom
.. _quilt: http://www.wzdftpd.net/blog/index.php?2008/02/05/3-quilt-a-patch-management-system-how-to-survive-with-many-patches
.. _`currently includes any existing .pc directory`: https://bugs.launchpad.net/udd/+bug/672740
.. _`a different patch system`: http://wiki.debian.org/debian/patches
.. _`a bug`: https://launchpad.net/bugs/620721
