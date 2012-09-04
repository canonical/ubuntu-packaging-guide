================================
Tutorial: Fixing a bug in Ubuntu
================================

While the mechanics for :doc:`fixing a bug<./fixing-a-bug>` are the same for 
every bug, every problem you look at is likely to be different from another.
An example of a concrete problem might help to get an idea what to consider
generally.

.. note:: At the time of writing this article this was not fixed yet. When you 
        are reading the article this might actually be fixed. Take this as an 
        example and try to adapt it to the specific problem you are facing.

Confirming the problem
======================

Let's say the package ``bumprace`` does not have a homepage in its package
description. As a first step you would check if the problem is not solved
already. This is easy to check, either take a look at Software Center or run:: 

        apt-cache show bumprace

The output should be similar to this:: 

        Package: bumprace
        Priority: optional
        Section: universe/games
        Installed-Size: 136
        Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
        Original-Maintainer: Christian T. Steigies <cts@debian.org>
        Architecture: amd64
        Version: 1.5.4-1
        Depends: bumprace-data, libc6 (>= 2.4), libsdl-image1.2 (>= 1.2.10), 
                 libsdl-mixer1.2, libsdl1.2debian (>= 1.2.10-1)
        Filename: pool/universe/b/bumprace/bumprace_1.5.4-1_amd64.deb
        Size: 38122
        MD5sum: 48c943863b4207930d4a2228cedc4a5b
        SHA1: 73bad0892be471bbc471c7a99d0b72f0d0a4babc
        SHA256: 64ef9a45b75651f57dc76aff5b05dd7069db0c942b479c8ab09494e762ae69fc
        Description-en: 1 or 2 players race through a multi-level maze
         In BumpRacer, 1 player or 2 players (team or competitive) choose among 4
         vehicles and race through a multi-level maze. The players must acquire
         bonuses and avoid traps and enemy fire in a race against the clock.
         For more info, see the homepage at http://www.linux-games.com/bumprace/
        Description-md5: 3225199d614fba85ba2bc66d5578ff15
        Bugs: https://bugs.launchpad.net/ubuntu/+filebug
        Origin: Ubuntu

A counter-example would be ``gedit``, which has a homepage set:: 

        $ apt-cache show gedit | grep ^Homepage
        Homepage: http://www.gnome.org/projects/gedit/
        $ 

Sometimes you will find that a particular problem you are looking into is 
already fixed. To avoid wasting efforts and duplicating work it makes sense
to first do some detective work.


Research bug situation
======================

First we should check if a bug for the problem exists in Ubuntu already. Maybe
somebody is working on a fix already, or we can contribute to the solution 
somehow. For Ubuntu we have a quick look at 
https://bugs.launchpad.net/ubuntu/+source/bumprace and there is no open bug
with our problem there.

.. note:: For Ubuntu the URL 
        ``https://bugs.launchpad.net/ubuntu/+source/<package>`` should always
        take to the bug page of the source package in question.

For Debian, which is the major source for Ubuntu's packages, we have a look at
http://bugs.debian.org/src:bumprace and can't find a bug report for our 
problem either.

.. note:: For Debian the URL ``http://bugs.debian.org/src:<package>`` should 
        always take to the bug page of the source package in question.

The problem we are working on is special as it only concerns the 
packaging-related bits of ``bumprace``. If it was a problem in the source code
it would be helpful to also check the Upstream bug tracker. This is 
unfortunately often different for every package you have a look at, but if 
you search the web for it, you should in most cases find it pretty easily.


Offering help
=============

If you found an open bug and it is not assigned to somebody and you are in a
position to fix it, you should comment on it with your solution. Be sure to
include as much information as you can: Under which circumstances does the
bug occur? How did you fix the problem? Did you test your solution?

If no bug report has been filed, you can file a bug for it. What you might
want to bear in mind is: Is the issue so small that just asking for somebody
to commit it is good enough? Did you manage to only partially fix the issue
and you want to at least share your part of it?

It is great if you can offer help and will surely be appreciated.


Fixing the issue
================

For this specific example it is enough to search the web for ``bumprace`` and 
find the homepage of it. Be sure it is a live site and not just a software
catalogue. http://www.linux-games.com/bumprace/ looks like it is the proper
place.

To address the issue in the source package, we first need the source and we 
can easily get it by running:: 

        bzr branch ubuntu:bumprace


If you read :doc:`the Debian Directory Overview<./debian-dir-overview>` before
you might remember, that the homepage for a package is specified in the first 
part of ``debian/control``, the section which starts with ``Source:``.

So what we do next is run:: 

        cd bumprace

and edit ``debian/control`` to add 
``Homepage: http://www.linux-games.com/bumprace/``. At the end of the first
section should be a good place for it. Once you have done this, save the file.

If you now run:: 

        bzr diff

you should see something like this:: 

	=== modified file 'debian/control'
	--- debian/control	2012-05-14 23:38:14 +0000
	+++ debian/control	2012-09-03 15:45:30 +0000
	@@ -12,6 +12,7 @@
	                libtool,
	                zlib1g-dev
	 Standards-Version: 3.9.3
	+Homepage: http://www.linux-games.com/bumprace/
	 
	 Package: bumprace
	 Architecture: any

The diff is pretty simple to understand. The ``+`` indicates a line which was
added. In our cases it was added just before the second section, starting with
``Package``, which indicates a resulting binary package.


Documenting the fix
===================

It is important to explain to your fellow developers what exactly you did. If 
you run:: 

        dch -i


this will start an editor with a boilerplate changelog entry which you just 
have to fill out. In our case something like ``debian/control: Added 
project's homepage.`` should do. Then save the file. To double-check this
worked out, run:: 

        bzr diff debian/changelog 

and you will see something this:: 

        === modified file 'debian/changelog'
	--- debian/changelog	2012-05-14 23:38:14 +0000
	+++ debian/changelog	2012-09-03 15:53:52 +0000
	@@ -1,3 +1,9 @@
	+bumprace (1.5.4-1ubuntu1) UNRELEASED; urgency=low
	+
	+  * debian/control: Added project's homepage.
	+
	+ -- Peggy Sue <peggy.sue@example.com>  Mon, 03 Sep 2012 17:53:12 +0200
	+
	 bumprace (1.5.4-1) unstable; urgency=low
	 
	   * new upstream version, sound and music have been removed (closes: #613344)


A few additional considerations: 

 * If you have a reference to a Launchpad bug which is fixed by the issue, add
   (``LP: #<bug number>``) to the changelog entry line, ie: ``(LP: #123456)``.
 * If it is a reference to an upstream or Debian bug or a mailing list 
   discussion, mention it as well.
 * Try to wrap your lines at 80 characters.
 * Try to be specific, not an essay, but enough for somebody (who did not 
   deeply look into the issue) to understand.
 * Mention how you fixed the issue and where.


Testing the fix
===============

To test the fix, you need to ::doc:`have your to development environment set 
up<./getting-set-up>`, then to build the package, install it and verify the 
problem is solved. In our case this would be:: 

        bzr bd -- -S
        pbuilder-dist <current Ubuntu release> build ../bumprace_*.dsc
        dpkg -I ~/pbuilder/*_result/bumprace_*.deb

In step one we build the source package from the branch, then build it by
using ``pbuilder``, then inspect the resulting package to check if the
Homepage field was added properly.

.. note:: In a lot of cases you will have to actually install the package
        to make sure it works as expected. Our case is a lot easier. If the 
        build succeeded, you will find the binary packages in 
        ``~/pbuilder/<release>_result``. Install them via 
        ``sudo dpkg -i <package>.deb`` or by double-clicking on them in your
        file manager.

As we verified, the problem is now solved, so the next step is sharing our
solution with the world.

Getting the fix included
========================

It makes to get fix included as Upstream as possible. Doing that you can 
guarantee that everybody can take the Upstream source as-is and don't need to 
have local modifications to fix it.

In our case we established that we have a problem with the packaging, both in
Ubuntu and Debian. As Ubuntu is based on Debian, we will send the fix to 
Debian. Once it is included there, it will be picked up by Ubuntu eventually.
The issue in our tutorial is clearly non-critical, so this approach makes 
sense. If it is important to fix the issue as soon as possible, you will
need to send the solution to multiple bug trackers. Provided the issue affects
all parties in question.

To submit the patch to Debian, simply run:: 

        submittodebian

This will take you through a series of steps to make sure the bug ends up in 
the correct place. Be sure to review the diff again to make sure it does not
include random changes you made earlier.

Communication is important, so when you add some more description to it to 
the inclusion request, be friendly, explain it well.

If everything went well you should get a mail from Debian's bug tracking 
system with more information. This might sometimes take a few minutes.

.. note:: If the problem is just in Ubuntu, you might want to consider
        ::doc:`Seeking Review and Sponsorship<./udd-sponsorship>` to get fix
        included.


Additional considerations
=========================

If you find a package and find that there are a couple of trivial things you
can fix at the same time, do it. This will speed up review and inclusion.

If there are multiple big things you want to fix, it might be advisable to 
send individual patches or merge proposals instead. If there are individual
bugs filed for the issues already, this makes it even easier.
