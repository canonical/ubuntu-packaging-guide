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

There is a lot of different ways to find things to work on. It might be a bug
report you are encountering yourself (which gives you a good opportunity to
test the fix), or a problem you noted elsewhere, maybe in a bug report.

`Harvest <http://harvest.ubuntu.com/>`_ is where we keep track of various TODO
lists regarding Ubuntu development. It lists bugs that were fixed upstream or
in Debian already, lists small bugs (we call them 'bitesize'), and so on. Check
it out and find your first bug to work on.


Get the code
------------

If you know which source package contains the code that shows the problem, it 
is trivial. Just type in::

  bzr branch lp:ubuntu/<packagename>

where ``<packagename>`` is the name of the source package. This will check out
the code of the latest Ubuntu development release. If you need the code of a 
stable release, let's say ``hardy``, you would type in::

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



Documenting the fix
-------------------

It is very important to document your change sufficiently so developers who 
look at the code in the future won't have to guess what your reasong was and
what your assumptions were. Every Debian and Ubuntu package source includes 
``debian/changelog``, where changes of each uploaded package are tracked.

The easiest way to do this is to run::

  dch -i

This will add a boiletplate changelog entry for you and launch an editor 
where you can fill out the blanks. An example of this could be::

  specialpackage (1.2-3ubuntu4) natty; urgency=low

    * debian/control: updated description to include frobnicator (LP: #123456)

   -- Emma Adams <emma.adams@isp.com>  Sat, 17 Jul 2010 02:53:39 +0200

``dch`` should fill out the first and last line of such a changelog entry for
you already. Line 1 consists of the source package name, the version number,
which Ubuntu release it is uploaded to, the urgency (which almost always is 
'low'). The last line always contains the name, email address and timestamp
(in RFC 2822 format) of the change.

With that out of the way, let's focus on the actual changelog entry itself: 
it is very important to document:

  #. where the change was done
  #. what was changed
  #. where the discussion of the change happened

In our (very sparse) example the last point is covered by "(LP: #123456)" 
which refers to Launchpad bug 123456. Bug reports or mailing list threads
or specifications are usually good information to provide as a rationale for a
change. As a bonus, if you use the ``LP: #<number>`` notation for Launchpad
bugs, the bug will be automatically closed when the package is uploaded to 
Ubuntu.


Committing the fix
------------------

With the changelog entry written and saved, you can just run::

  debcommit

and the change will be committed (locally) with your changelog entry as a 
commit message.

To push it to Launchpad, as the remote branch name, you need to stick to the 
following nomenclature::

  lp:~<yourlpid>/ubuntu/<release>/<package>/<branchname>

This could for example be::

  lp:~emmaadams/ubuntu/natty/specialpackage/fix-for-123456

So if you just run::

  bzr push lp:~emmaadams/ubuntu/natty/specialpackage/fix-for-123456
  bzr lp-open

you should be all set. The push command should push it to Launchpad and the 
second command will open the Launchpad page of the remote branch in your 
browser. There find the "(+) Propose for merging" link, click it to get the
change reviewed by somebody and included in Ubuntu.


Conclusion
----------

.. XXX: link to 'forwarding patches' article
.. XXX: link to 'debdiff' article (in case of slow internet, package not 
        imported, etc.)

