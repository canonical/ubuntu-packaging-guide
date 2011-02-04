======================
Fixing a bug in Ubuntu
======================

Introduction
============

If you followed the instructions to :doc:`get set up with Ubuntu 
Development</getting-set-up>`, you should be all set and ready to go.

.. image:: images/fixing-a-bug.png

As you can see in the image above, there is no surprises in the process of
fixing bugs in Ubuntu: you found a problem, you get the code, work on the fix, 
test it, push your changes to Launchpad and ask for it to be reviewed and 
merged. In this guide we will go through all the necessary steps one by one.


Finding the problem
===================

There is a lot of different ways to find things to work on. It might be a bug
report you are encountering yourself (which gives you a good opportunity to
test the fix), or a problem you noted elsewhere, maybe in a bug report.

`Harvest <http://harvest.ubuntu.com/>`_ is where we keep track of various TODO
lists regarding Ubuntu development. It lists bugs that were fixed upstream or
in Debian already, lists small bugs (we call them 'bitesize'), and so on. Check
it out and find your first bug to work on.


Figuring out what to fix
========================

If you don't know the source package containing the code that has the problem,
but you do know the path to the affected program on your system, you can
discover the source package that you'll need to work on.

Let's say you've found a bug in Tomboy, a note taking desktop application.
The Tomboy application can be started by running ``/usr/bin/tomboy`` on the
command line.  To find the binary package containing this application, use
this command::

  apt-file find /usr/bin/tomboy

This would print out::

  tomboy: /usr/bin/tomboy

Note that the part preceding the colon is the binary package name.  It's often
the case that the source package and binary package will have different names.
This is most common when a single source package is used to build multiple
different binary packages.  To find the source package for a particular binary
package, type::

  apt-cache show tomboy | grep -i source

In this case, nothing is printed, meaning that ``tomboy`` is also the name of
the binary package.  An example where the source and binary package names
differ is ``python-vigra``.  While that is the binary package name, the source
package is actually ``libvigraimpex`` and can be found with this command (and
its output)::

  apt-cache show python-vigra | grep -i source
  Source: libvigraimpex

.. XXX: Link to SRU article.


Getting the code
================

Once you know the source package to work on, you will want to get a copy of
the code on your system, so that you can debug it.  This is done by
*branching* the source package branch corresponding to the source package.
Launchpad maintains source package branches for all the packages in Ubuntu.

Once you've got a local branch of the source package, you can investigate the
bug, create a fix, and upload your proposed fix to Launchpad, in the form of a
Bazaar branch.  When you are happy with your fix, you can submit a *merge
proposal*, which asks other Ubuntu developers to review and approve your
change.  If they agree with your changes, an Ubuntu developer will upload the
new version of the package to Ubuntu so that everyone gets the benefit or your
excellent fix - and you get a little bit of credit.  You're now on your way to
becoming an Ubuntu developer!

We'll describe specifics on how to branch the code, push your fix, and request
a review in the following sections.


Work on a fix
=============

There are entire books written about finding bugs, fixing them, testing them, 
etc. If you are completely new to programming, try to fix easy bugs such as
obvious typos first. Try to keep changes as minimal as possible and document
your change and assumptions clearly.

Before working on a fix yourself, make sure to investigate if nobody else has
fixed it already or is currently working on a fix. Good sources to check are:

* Upstream (and Debian) bug tracker (open and closed bugs),
* Upstream revision history (or newer release) might have fixed the problem,
* bugs or package uploads of Debian or other distributions.

.. XXX: Link to 'update to a new version' article.

If you find a patch to fix the problem, say, attached to a bug report, running
this command in the source directory should apply the patch::

  patch -p1 < ../bugfix.patch

Refer to the ``patch(1)`` manpage for options and arguments such as 
``--dry-run``, ``-p<num>``, etc.
