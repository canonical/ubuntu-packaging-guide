==================
Getting The Latest
==================

If someone else has landed changes on a package, you will want to pull down
those changes in your own copies of the package branches.


Updating your main branch
=========================

Updating your copy of a branch that corresponds to the package in a particular
release is very simple, simply use `bzr pull` from the appropriate directory::

    $ cd tomboy/natty
    $ bzr pull

This works wherever you have a checkout of a branch, so it will work for
things like branches of `maverick`, `hardy-proposed`, etc.


Getting the latest in to your working branches
==============================================

Once you have updated your copy of a distroseries branch, then you may want to
merge this in to your working branches as well, so that they are based on the
latest code.

You don't have to do this all the time though.  You can work on slightly older
code with no problems.  The disadvantage would come if you were working on
some code that someone else changed.  If you are not working on the latest
version then your changes may not be correct, and may even produce conflicts.

The merge does have to be done at some point though.  The longer it is left,
the harder may be, so doing it regularly should keep each merge simple.  Even
if there are many merges the total effort would hopefully be less.

To merge the changes you just need to use `bzr merge-package`, but you must
have committed your current work first::

    $ cd tomboy/bug-12345
    $ bzr merge-package ../natty

Any conflicts will be reported, and you can fix them up.  To review the
changes that you just merged use `bzr diff`.  To undo the merge use `bzr
revert`.  Once you are happy with the changes then use `bzr commit`.
