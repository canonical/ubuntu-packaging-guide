================================
 Seeking Review and Sponsorship
================================

One of the biggest advantages to using the UDD workflow is to improve quality
by seeking review of changes by your peers.  This is true whether or not you
have upload rights yourself.  Of course, if you don't have upload rights, you
will need to seek sponsorship.

Once you are happy with your fix, and have a branch ready to go, the following
steps can be used to publish your branch on Launchpad, link it to the bug
issue, and create a *merge proposal* for others to review, and sponsors to
upload.


.. _merge-proposal:

Pushing to Launchpad
====================

We previously showed you how to :ref:`associate your branch to the bug
<link-via-changelog>` using ``dch`` and ``bzr commit``.  However, the branch
and bug don't actually get linked until you push the branch to Launchpad.

It is not critical to have a link to a bug for every change you make,
but if you are fixing reported bugs then linking to them will be useful.

The general form of the URL you should push your branch to is::

    lp:~<user-id>/ubuntu/<distroseries>/<package>/<branch-name>

For example, to push your fix for bug 12345 in the Tomboy package for Trusty,
you'd use::

    $ bzr push lp:~subgenius/ubuntu/trusty/tomboy/bug-12345

The last component of the path is arbitrary; it's up to you to pick
something meaningful.

However, this usually isn't enough to get Ubuntu developers to review and
sponsor your change.  You should next submit a *merge proposal*.

To do this open the bug page in a browser, e.g.::

    $ bzr lp-open

If that fails, then you can use::

    $ xdg-open https://code.launchpad.net/~subgenius/ubuntu/trusty/tomboy/bug-12345

where most of the URL matches what you used for `bzr push`.  On this page,
you'll see a link that says *Propose for merging into another branch*.  Type
in an explanation of your change in the *Initial Comment* box.  Lastly, click
*Propose Merge* to complete the process.

Merge proposals to package source branches will automatically subscribe the
`~ubuntu-branches` team, which should be enough to reach an Ubuntu developer
who can review and sponsor your package change.


Generating a debdiff
====================

As noted above, some sponsors still prefer reviewing a *debdiff* attached to
bug reports instead of a merge proposal.  If you're requested to include a
debdiff, you can generate one like this (from inside your `bug-12345`
branch)::

    $ bzr diff -rbranch:../tomboy.dev

Another way is to is to open the merge proposal and download the diff.

You should ensure that diff has the changes you expect, no more and no less.
Name the diff appropriately, e.g. ``foobar-12345.debdiff`` and attach it to
the bug report.


Dealing with feedback from sponsors
===================================

If a sponsor reviews your branch and asks you to change something, you can do
this fairly easily.  Simply go to the branch that you were working in before,
make the changes requested, and then commit::

    $ bzr commit

Now when you push your branch to Launchpad, Bazaar will remembered where you
pushed to, and will update the branch on Launchpad with your latest commits.
All you need to do is::

    $ bzr push

You can then reply to the merge proposal review email explaining what you
changed, and asking for re-review, or you can reply on the merge proposal page
in Launchpad.

Note that if you are sponsored via a debdiff attached to a bug report you need
to manually update by generating a new diff and attaching that to the bug
report.


Expectations
============

The Ubuntu developers have set up a schedule of "patch pilots", who regularly
review the sponsoring queue and give feedback on branches and patches. Even
though this measure has been put in place it might still take several days
until you hear back. This depends on how busy everybody is, if the development
release is currently frozen, or other factors.

If you haven't heard back in a while, feel free to join `#ubuntu-devel` on 
`irc.freenode.net` and find out if somebody can help you there.

For more information on the generall sponsorship process, review the 
documentation on our wiki as well: https://wiki.ubuntu.com/SponsorshipProcess
