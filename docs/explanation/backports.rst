.. _backports:

============================
Backporting software updates
============================

Sometimes you might want to make new functionality available in a stable
release which is not connected to a critical bug fix. For these scenarios
you have two options: either you `upload to a PPA <ppadoc_>`_
or prepare a backport.


Personal Package Archive (PPA)
==============================

Using a PPA has a number of benefits. It is fairly straight-forward, you
don't need approval of anyone, but the downside of it is that your users will
have to manually enable it. It is a non-standard software source.

The `PPA documentation on Launchpad <ppadoc_>`_ is fairly comprehensive and should get
you up and running in no time.

.. _ppadoc: https://help.launchpad.net/Packaging/PPA


Official Ubuntu Backports
=========================

The Backports Project is a means to provide new features to users. Because of 
the inherent stability risks in backporting packages, users do not get 
backported packages without some explicit action on their part. This 
generally makes backports an inappropriate avenue for fixing bugs. If a 
package in an Ubuntu release has a bug, it should be fixed either through the 
:ref:`Security Update or the Stable Release Update 
process<security-and-stable-release-updates>`, as appropriate.

Once you determined you want a package to be backported to a stable release,
you will need to test-build and test it on the given stable release. 
``pbuilder-dist`` (in the ``ubuntu-dev-tools`` package) is a very handy tool 
to do this easily.

To report the backport request and get it processed by the Backporters team,
you can use the ``requestbackport`` tool (also in the ``ubuntu-dev-tools``
package). It will determine the intermediate releases that package needs to 
be backported to, list all reverse-dependencies, and file the backporting 
request.  Also will it include a testing checklist in the bug.
