======================
Fixing a bug in Ubuntu
======================

Introduction
============

If you followed the instructions to :doc:`get set up with Ubuntu
Development<./getting-set-up>`, you should be all set and ready to go.

.. image:: ../images/fixing-a-bug.png

As you can see in the image above, there is no surprises in the process of
fixing bugs in Ubuntu: you found a problem, you get the code, work on the fix,
test it, push your changes to Launchpad and ask for it to be reviewed and
merged. In this guide we will go through all the necessary steps one by one.


Finding the problem
===================

There are a lot of different ways to find things to work on. It might be a bug
report you are encountering yourself (which gives you a good opportunity to
test the fix), or a problem you noted elsewhere, maybe in a bug report.

Take a look at `the bitesize bugs`_ in Launchpad, and that might give you an
idea of something to work on. It might also interest you to look at the bugs
`triaged`_ by the Ubuntu One Hundred Papercuts team.

.. _the bitesize bugs: https://launchpad.net/ubuntu/+bugs?field.tag=bitesize
.. _triaged: https://wiki.ubuntu.com/One%20Hundred%20Papercuts/Fix/Lists%20of%20bugs
.. _what-to-fix:

Figuring out what to fix
========================

If you don't know the source package containing the code that has the problem,
but you do know the path to the affected program on your system, you can
discover the source package that you'll need to work on.

Let's say you've found a bug in Tomboy, a note taking desktop application.
The Tomboy application can be started by running ``/usr/bin/tomboy`` on the
command line.  To find the binary package containing this application, use
this command::

    $ apt-file find /usr/bin/tomboy

This would print out::

    tomboy: /usr/bin/tomboy

Note that the part preceding the colon is the binary package name.  It's often
the case that the source package and binary package will have different names.
This is most common when a single source package is used to build multiple
different binary packages.  To find the source package for a particular binary
package, type::

    $ apt-cache showsrc tomboy | grep ^Package:
    Package: tomboy
    $ apt-cache showsrc python-vigra | grep ^Package:
    Package: libvigraimpex

``apt-cache`` is part of the standard installation of Ubuntu.

Getting the code
================

Once you know the source package to work on, you will want to get a copy of
the code on your system, so that you can debug it. The ubuntu-dev-tools
package has a tool called ``pull-lp-source`` that a developer can use to grab
the source code for any package. For example, to grab the source code for the
tomboy package in ``xenial``, you can type this::

    $ pull-lp-source tomboy xenial

If you do not specify a release such as ``xenial``, it will automatically get
the package from the development version.

Once you've got a local clone of the source package, you can investigate the
bug, create a fix, generate a debdiff, and attach your debdiff to a bug report
for other developers to review. We'll describe specifics in the next sections.

.. _working-on-a-fix:

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
.. XXX: Link to 'send stuff upstream/Debian' article. (Launchpad bug 704845)

You now want to create a patch which includes the fix.  The command
``edit-patch`` is a simple way to add a patch to a package. Run::

    $ edit-patch 99-new-patch

This will copy the packaging to a temporary directory.  You can now edit files
with a text editor or apply patches from upstream, for example::

    $ patch -p1 < ../bugfix.patch

After editing the file type ``exit`` or press ``control-d`` to quit the
temporary shell.  The new patch will have been added into ``debian/patches``.

You must then add a header to your patch containing meta information so that
other developers can know the purpose of the patch and where it came from. To
get the template header that you can edit to reflect what the patch does, type
this::

    $ quilt header --dep3 -e

This will open the template in a text editor. Follow the template and make
sure to be thorough so you get all the details necessary to describe the
patch.


Testing the fix
===============

To build a test package with your changes, run these commands::

  $ debuild -S -d -us -uc
  $ pbuilder-dist <release> build ../<package>_<version>.dsc

This will create a source package from the branch contents (``-us -uc`` will
just omit the step to sign the source package and ``-d`` will skip the step
where it checks for build dependencies, pbuilder will take care of that) and
``pbuilder-dist`` will build the package from source for whatever ``release``
you choose.

.. note::
 If ``debuild`` errors out with "Version number suggests Ubuntu changes, but
 Maintainer: does not have Ubuntu address" then run the ``update-maintainer``
 command (from ubuntu-dev-tools) and it will automatically fix this for you.
 This happens because in Ubuntu, all Ubuntu Developers are responsible for all
 Ubuntu packages, while in Debian, packages have maintainers.

Once the build succeeds, install the package from
``~/pbuilder/<release>_result/`` (using ``sudo dpkg -i
<package>_<version>.deb``).  Then test to see if the bug is fixed.



Documenting the fix
-------------------

It is very important to document your change sufficiently so developers who
look at the code in the future won't have to guess what your reasoning was and
what your assumptions were. Every Debian and Ubuntu package source includes
``debian/changelog``, where changes of each uploaded package are tracked.

The easiest way to update this is to run::

  $ dch -i

This will add a boilerplate changelog entry for you and launch an editor
where you can fill in the blanks. An example of this could be::

  specialpackage (1.2-3ubuntu4) trusty; urgency=low

    * debian/control: updated description to include frobnicator (LP: #123456)

   -- Emma Adams <emma.adams@isp.com>  Sat, 17 Jul 2010 02:53:39 +0200

``dch`` should fill out the first and last line of such a changelog entry for
you already. Line 1 consists of the source package name, the version number,
which Ubuntu release it is uploaded to, the urgency (which almost always is
'low'). The last line always contains the name, email address and timestamp
(in :rfc:`5322` format) of the change.

With that out of the way, let's focus on the actual changelog entry itself:
it is very important to document:

    #. Where the change was done.
    #. What was changed.
    #. Where the discussion of the change happened.

In our (very sparse) example the last point is covered by ``(LP: #123456)``
which refers to Launchpad bug 123456. Bug reports or mailing list threads or
specifications are usually good information to provide as a rationale for a
change. As a bonus, if you use the ``LP: #<number>`` notation for Launchpad
bugs, the bug will be automatically closed when the package is uploaded to
Ubuntu.

In order to get it sponsored in the next section, you need to file a bug
report in Launchpad (if there isn't one already, if there is, use that) and
explain why your fix should be included in Ubuntu. For example, for tomboy,
you would file a bug `here`_ (edit the URL to reflect the package you have a
fix for). Once a bug is filed explaining your changes, put that bug number in
the changelog.

.. _here: https://bugs.launchpad.net/ubuntu/+source/tomboy/+filebug

Submitting the fix and getting a review
---------------------------------------

With the changelog entry written and saved, run ``debuild`` one more time::

  $ debuild -S -d

and this time it will be signed and you are now ready to get your diff to
submit to get sponsored. Now it's time to generate a "debdiff", which shows
the difference between two Debian packages. The name of the command used to
generate one is also ``debdiff``. It is part of the ``devscripts`` package.
See ``man debdiff`` for all the details. To compare two source packages,
pass the two dsc files as arguments::

  $ debdiff <package_name>_1.0-1.dsc <package_name>_1.0-1ubuntu1.dsc

In this case, ``debdiff`` the dsc you downloaded with ``pull-lp-source`` and
the new dsc file you generated. This will generate a patch that your sponsor
can then apply locally (by using ``patch -p1 < /path/to/debdiff``). In this
case, pipe the output of the debdiff command to a file that you can then
attach to the bug report::

  $ debdiff <package_name>_1.0-1.dsc <package_name>_1.0-1ubuntu1.dsc > 1-1.0-1ubuntu1.debdiff

The format shown in ``1-1.0-1ubuntu1.debdiff`` shows:

    #. ``1-`` tells the sponsor that this is the first revision of your patch.
       Nobody is perfect, and sometimes follow-up patches need to be provided.
       This makes sure that if your patch needs work, that you can keep a
       consistent naming scheme.
    #. ``1.0-1ubuntu1`` shows the new version being used. This makes it easy
       to see what the new version is.
    #. ``.debdiff`` is an extension that makes it clear that it is a debdiff.

While this format is optional, it works well and you can use this.

Before you continue, if this patch is a security update or an update for a
stable release, make sure you take a look at our
:doc:`Security and stable release updates<./security-and-stable-release-updates>`
article if this is your first time doing this to save you and your sponsor
time.

Next, go to the bug report, make sure you are logged into Launchpad, and click
"Add attachment or patch" under where you would add a new comment. Attach the
debdiff, and leave a comment telling your sponsor how this patch can be
applied and the testing you have done. An example comment can be::

  This is a debdiff for Artful applicable to 1.0-1. I built this in pbuilder
  and it builds successfully, and I installed it, the patch works as intended.

Make sure you mark it as a patch (the Ubuntu Sponsors team will automatically
be subscribed) and that you are subscribed to the bug report. You will then
receive a review anywhere between an hour from submitting the patch to two
weeks. If it takes longer than that, please join ``#ubuntu-motu`` on freenode
and mention it there. Stick around until you get an answer from someone, and
they can guide you as to what to do next.

Once you have received a review, your patch was either uploaded or needs work.
If your patch needs work, follow the same steps and submit a follow-up patch
on the bug report.

Remember: good places to ask your questions are ``ubuntu-motu@lists.ubuntu.com``
and ``#ubuntu-motu`` on freenode. You will easily find a lot of new friends
and people with the same passion that you have: making the world a better
place by making better Open Source software.
