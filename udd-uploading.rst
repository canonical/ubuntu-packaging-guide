===================
Uploading a package
===================

Once your merge proposal is reviewed and approved, you will want to upload
your package, either to the archive (if you have permission) or to your
`Personal Package Archive`_ (PPA).  You might also want to do an upload if
you are sponsoring someone else's changes.


Uploading a change made by you
==============================

When you have a branch with a change that you would like to upload you need to
get that change back on to the main source branch, build a source package, and
then upload it.

First, you need to check that you have the latest version of the package in
your checkout of the development package trunk::

    $ cd tomboy/tomboy.dev
    $ bzr pull

This pulls in any changes that may have been committed while you were working
on your fix.  From here, you have several options.  If the changes on the
trunk are large and you feel should be tested along with your change you can
merge them into your bug fix branch and test there.  If not,
then you can carry on merging your bug fix branch into the development trunk
branch. You'll want to use the Bazaar ``merge-package`` command rather than just
``merge``::

    $ bzr merge-package ../bug-12345

This will merge the two trees, possibly producing conflicts, which you'll need
to resolve manually.

Next you should make sure the `debian/changelog` is as you would like, with
the correct distribution, version number, etc.

Once that is done you should review the change you are about to commit
with `bzr diff`.  This should show you the same changes as a debdiff would
before you upload the source package.

The next step is to build and test the modified source package as you normally
would::

    $ bzr bd -S

The last step is to mark the change as being the same as the source package
that was uploaded, bzr-builddeb will override the `tag` command to
automatically tag with the version number in debian/changelog so run::

    $ bzr tag

This tag will tell the package importer that what is in the Bazaar branch
is the same as in the archive.

Now you can push the changes back to Launchpad::

    $ bzr push ubuntu:tomboy

(Change the destination if you are uploading an SRU or similar.)

Once you are happy with the upload then you should use `dput` to upload the
built source package to Launchpad. For example, if you want to upload your
changes to your PPA, then you'd do::

    $ dput ppa:imasponsor/myppa tomboy_1.5.2-1ubuntu5_source.changes

or, if you have permission to upload to the primary archive::

    $ dput ubuntu tomboy_1.5.2-1ubuntu5_source.changes

You are now free to delete your feature branch, as it is merged, and can
be re-downloaded from Launchpad if needed.


Sponsoring a change
===================

Sponsoring someone else's change is just like the above procedure, but instead
of merging from a branch you created, you merge from the branch in the merge
proposal::

    $ bzr merge-package lp:~subgenius/ubuntu/natty/tomboy/bug-12345

If there are lots of merge conflicts you would probably want to ask the 
contributor to fix them up.  See the next section to learn how to cancel
a pending merge.

But if the changes look good, commit and then follow the rest of the uploading
process::

    $ bzr commit --author Bob Dobbs <subgenius@example.com>


Canceling an upload
===================

At any time before you `dput` the source package you can decide to cancel an
upload and revert the changes::

    $ bzr revert

You can do this if you notice something needs more work, or if you would like
to ask the contributor to fix up conflicts when sponsoring something.


Sponsoring something and making your own changes
================================================

If you are going to sponsor someone's work, but you would like to roll it up
with some changes of your own then you can merge their work in to a separate
branch first.

If you already have a branch where you are working on the package and you
would like to include their changes, then simply run the `bzr merge-package`
from that branch, instead of the checkout of the development package.  You can
then make the changes and commit, and then carry on with your changes to the
package.

If you don't have an existing branch, but you know you would like to make
changes based on what the contributor provides then you should start by
grabbing their branch::

    $ bzr branch lp:~subgenius/ubuntu/natty/tomboy/bug-12345

then work in this new branch, and then merge it in to the main one and upload
as if it was your own work.  The contributor will still be mentioned in the
changelog, and Bazaar will correctly attribute the changes they made to them.

.. _`Personal Package Archive`: https://help.launchpad.net/Packaging/PPA
