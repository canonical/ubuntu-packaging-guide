=====================
Traditional Packaging
=====================

The majority of this guide deals with :doc:`Ubuntu Distributed Development
<./udd-intro>` (UDD) which utilizes the distributed version control system (DVCS)
Bazaar for :ref:`retrieving package sources <branching>` and submitting fixes
with :ref:`merge proposals. <merge-proposal>` This article will discuss what we
will call traditional packaging methods for lack of a better word. Before Bazaar
was adopted for Ubuntu development, these were the typical methods for
contributing to Ubuntu.

In some cases, you may need to use these tools instead of UDD. So it is good to
be familiar with them. Before you begin, you should already have read the
article :doc:`Getting Set Up. <./getting-set-up>`

Getting the Source
------------------

In order to get a source package, you can simply run::

    $ apt-get source <package_name>

This method has some draw backs though. It downloads the version of the source
that is available on **your system.** You are likely running the current stable
release, but you want to contribute your change against the package in the
development release. Luckily, the ``ubuntu-dev-tools`` package provides a helper
script::

    $ pull-lp-source <package_name>

By default, the  latest version in the development release will be downloaded.
You can also specify a version or Ubuntu release like::

    $ pull-lp-source <package_name> trusty

to pull the source from the ``trusty`` release, or::

    $ pull-lp-source <package_name> 1.0-1ubuntu1

to download version ``1.0-1ubuntu1`` of the package. For more information on the
command, see ``man pull-lp-source``.

For our example, let's pretend we got a bug report saying that "colour" in the
description of ``xicc`` should be "color," and we want to fix it. *(Note: This
is just an example of something to change and not really a bug.)* To get the
source, run::

    $ pull-lp-source xicc 0.2-3

Creating a Debdiff
------------------

A ``debdiff`` shows the difference between two Debian packages. The name of the
command used to generate one is also ``debdiff``. It is part of the
``devscripts`` package. See ``man debdiff`` for all the details. To compare two
source packages, pass the two ``dsc`` files as arguments::

    $ debdiff <package_name>_1.0-1.dsc <package_name>_1.0-1ubuntu1.dsc

To continue with our example, let's edit the ``debian/control`` and "fix" our
"bug"::

    $ cd xicc-0.2
    $ sed -i 's/colour/color/g' debian/control

We also must adhere to the `Debian Maintainer Field Spec
<https://wiki.ubuntu.com/DebianMaintainerField>`_ and edit ``debian/control``
to replace::

    Maintainer: Ross Burton <ross@debian.org>

with::

    Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
    XSBC-Original-Maintainer: Ross Burton <ross@debian.org>

You can use the ``update-maintainer`` tool (in the ``ubuntu-dev-tools`` package)
to do that.

Remember to document your changes in ``debian/changelog`` using ``dch -i`` and
then we can generate a new source package::

    $ debuild -S

Now we can examine our changes using ``debdiff``::

    $ cd ..
    $ debdiff xicc_0.2-3.dsc xicc_0.2-3ubuntu1.dsc | less

To create a patch file that you can send to others or attach to a bug report for
sponsorship, run::

    $ debdiff xicc_0.2-3.dsc xicc_0.2-3ubuntu1.dsc > xicc_0.2-3ubuntu1.debdiff


Applying a Debdiff
------------------

In order to apply a debdiff, first make sure you have the source code of the
version that it was created against::

    $ pull-lp-source xicc 0.2-3

Then in a terminal, change to the directory where the source was 
uncompressed::

    $ cd xicc-0.2

A debdiff is just like a normal patch file. Apply it as usual with::

    $ patch -p1 < ../xicc_0.2.2ubuntu1.debdiff
