======================
 Working with Patches
======================

Many existing packages that have changes from upstream express those changes
using a patch system, of which there are several to choose from.  Usually,
when you make an additional change to a package, you'll want to add a patch
file to the patch system being used, rather than editing the source code in
place.  Note however that it is considered bad practice to add a patch system
to a package that does not already have one.  In that case, either coordinate
with the Debian maintainer, or edit the files in place.  You can find out if
your package has a patch system by using the ``what-patch`` command (from the
``ubuntu-dev-tools`` package).

While Debian has several patch systems, Quilt_ is becoming the most popular.
Quilt acts something like a version control system itself, and in the context
of UDD, this can be both a good thing and a bad thing.  With Bazaar 2.5 and
``bzr-builddeb`` 2.8.1 (in Ubuntu 12.04 Precise), handling source packages
with quilt patches has become much easier.

There are two main tasks where you'll have to be aware of quilt patches, when
developing your own patch to the upstream code, and when merging new versions
of the package from Debian where either the Debian or Ubuntu (or both) have
quilt patches in the source branch.

Here are some guidelines for working with quilt patches in UDD in these two
scenarios.  Some of these techniques are works-in-progress, so you should
adapt them to your own workflow, and keep watching for improvements from the
Bazaar teams.


Patches are applied in source branches
======================================

One important thing to keep in mind: all source branches reflect the tree
after a ``quilt push -a``.  In other words, when you branch a source branch
from Launchpad, you get the tree with all patches applied, ready for you to
jump right into hacking.  You do not need to ``quilt push -a`` manually, and
in fact, you'll get a tree with lots of distracting modifications if you push
or pop all the changes.  Or to put it another way, once you have a branch,
jump right in!


Merging from Debian with quilt patches
======================================

With newer versions of Bazaar as mentioned above, merging new Debian versions
to Ubuntu versions should be quite easy now, even when one or both packages
have quilt patches.  Just use ``bzr merge`` as you normally would.  Under the
hood, Bazaar will first un-apply all the patches, then do the merge, then if
there are no conflicts, it will re-apply the patches leaving you again with a
source branch in the ``quilt push -a`` state.

For example, if we want to merge the Debian version of the ``aptitude``
package with the Ubuntu version, we would do something like this::

    $ bzr init-repo aptitude
    $ cd aptitude
    $ bzr branch ubuntu:aptitude precise
    $ bzr branch debianlp:aptitude wheezy
    $ cd precise
    $ bzr merge ../wheezy

If there are merge conflicts, the quilt patches will remain un-applied so that
you can resolve the conflicts more easily.  You would use a combination of bzr
and quilt commands to resolve the conflicts, until all the quilt patches are
applied again.  Then you're ready to commit, push, and build as you normally
would.


Develop your patch
==================

There is a strong preference to fixing packages using a patch system like
quilt, rather than modifying the source code directly.  This is because with a
patch system, it's easier to communicate those changes to Debian or upstream
(where UDD isn't used), and to remove patches when upstream fixes the bug the
patch addresses (possibly in a completely different way).

Let's say there's a bug in the ``dbus`` package that you want to fix.  You
start the way you normally would with any package in UDD::

    $ bzr init-repo dbus
    $ cd dbus
    $ bzr branch ubuntu:dbus precise
    $ bzr branch precise bug-12345
    $ cd bug-12345

Maybe the bug is pretty simple; there's a typo in the ``README`` file.  Just
fix the typo in your favorite editor, then do a ``bzr stat`` to prove that the
file has been edited::

    $ bzr stat
    modified:
      README

Now, in order to get this fix into a quilt patch, we need to generate a diff,
but we need the resulting patch to have a format that is consumable by quilt.
The way to do that is to use the ``--prefix`` (or ``-p``) option to ``bzr
diff``::

    $ bzr diff -p "a/:b/" > ../bug-12345.patch

What this actually does is to produce a *level 1* diff, which is required by
the quilt command we're going to use below.  Normally, ``bzr diff`` produces
*level 0* diffs which are more easily read by humans, but this won't work with
quilt (despite the implication in the quilt documentation).

The above command generates the patch and stores it in a file one level up
from the working tree.  Note that here we're using the ``a`` and ``b``
directory prefixes for the diff, but the actual names don't really matter.

Now all you need to do is to import the patch into your quilt patches.  If you
named the file above with the same name you want into your quilt stack, then
just do this::

    $ quilt import ../bug-12345.patch
    $ bzr add debian/patches/bug-12345.patch

You need the last line to inform Bazaar about the new quilt patch file.  You
can see that the quilt patch's name is the same as the file name you generated
above.  Of course, you can change this by using the ``-P`` option to ``quilt
import``.

One important thing to notice is that if you do the commands ``bzr stat`` and
a ``quilt applied`` , you'll see that the ``README`` file is still modified,
but the ``bug-12345.patch`` is not yet applied.  If you try to apply the newly
imported quilt patch (with ``quilt push``), it will fail because you're
applying a patch on top of the already patched file.

One way around this is to revert the change to ``README`` before doing the
``quilt push``.  However, if you think you may want to continue to develop the
patch, and thus do not want to throw away your in-tree changes, use ``bzr
shelve`` to save the change in the working tree to the side, then do ``quilt
push``.  Either way, once you've pushed your top quilt patch, you can just
edit the tree in place, and do ``quilt refresh`` commands to update the top
quilt patch.


Gotchas
=======

One thing to keep in mind is that quilt uses a hidden ``.pc`` directory to
record its status.  This directory is under version control in all source
branches.  *Watch out* for changes to the ``.pc`` directory that are unrelated
(or more accurately, uninteresting) to your patch.  This can happen because
the UDD source branch importer `currently includes any existing .pc
directory`_ in the imported branch.  This can cause conflicts, or other
unwanted or unknown changes because you've essentially got two conflicting
version control systems competing for the same thing (i.e. bzr and quilt).
For now, the best recommendation is to revert any changes to the ``.pc``
directory in your branch.


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
    level, but this isn't yet exposed in ``edit-patch``.  If you use the
    ``--prefix`` argument to the ``bzr diff`` command as shown above, you
    should be okay.
  * By default, ``edit-patch`` requires a path to an existing patch file, but
    it's more convenient to pipe the output of ``bzr diff`` to the stdin of
    ``edit-patch``, as shown above.  The alternative would be to save the diff
    in a temporary file, and then point ``edit-patch`` to this temporary file.


.. _quilt: http://www.wzdftpd.net/blog/index.php?2008/02/05/3-quilt-a-patch-management-system-how-to-survive-with-many-patches
.. _`currently includes any existing .pc directory`: https://bugs.launchpad.net/udd/+bug/672740
.. _`a different patch system`: http://wiki.debian.org/debian/patches
