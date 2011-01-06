Fixing a bug in Ubuntu
======================

Introduction
------------

If you followed the instructions to :doc:`get set up with Ubuntu 
Development</getting-set-up>`, you should be all set and ready to go.

.. image:: images/fixing-a-bug.png

As you can see in the image above, there is no surprises in the process of
fixing bugs in Ubuntu: you found a problem, you get the code, work on the fix, 
test it, push your changes to Launchpad and ask for it to be reviewed and 
merged. In this guide we will go through all the necessary steps one by one.


Finding the problem
-------------------

There's a lot of different ways to find things to work on. It might be a bug
report you are encountering yourself (which gives you a good opportunity to
test the fix), or a problem you noted elsewhere, maybe in a bug report.

`Harvest <http://harvest.ubuntu.com/>`_ is where we keep track of various TODO
lists regarding Ubuntu development. It lists bugs that were fixed upstream or
in Debian already, lists small bugs (we call them 'bitesize'), and so on. Check
it out and find your first bug to work on.


Get the code
------------

If you know which source package contains the code that shows the problem, it's
trivial. Just type in::

  bzr branch lp:ubuntu/<packagename>

where ``<packagename>`` is the name of the source package. This will check out
the code of the latest Ubuntu development release. If you need the code of a 
stable release, let's say ``hardy``, you'd type in::

  bzr branch lp:ubuntu/hardy/<packagename>

.. XXX: Link to SRU article.


Work on fix
-----------

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


If you find a patch to fix the problem, running this command in the source 
directory should apply the patch::

  patch -p1 < ../bugfix.patch

Refer to the ``patch(1)`` manpage for options and arguments such as 
``--dry-run``, ``-p<num>``, etc.


Testing the fix
---------------

To build a test package with your changes, run these commands::

  bzr bd -- -S -us -uc
  pbuilder-dist <release> build ../<package>_<version>.dsc

This will create a source package from the branch contents (``-us -uc`` will 
just omit the step to sign the source package) and pbuilder-dist will build
the package from source for whatever ``release`` you choose.

Once the build succeeded, install the package from 
``~/pbuilder/<release>_result/`` (using ``sudo dpkg -i 
<package>_<version>.deb``). Then test to see if the bug is fixed.







