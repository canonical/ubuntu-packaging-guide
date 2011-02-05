===============
Testing the fix
===============

To build a test package with your changes, run these commands::

    $ bzr bd -S -- -us -uc
    $ pbuilder-dist <release> build ../<package>_<version>.dsc

This will create a source package from the branch contents (``-us -uc`` will
just omit the step to sign the source package) and ``pbuilder-dist`` will
build the package from source for whatever ``release`` you choose.

Once the build succeeded, install the package from 
``~/pbuilder/<release>_result/`` (using ``sudo dpkg -i 
<package>_<version>.deb``).  Then test to see if the bug is fixed.


Documenting the fix
===================

It is very important to document your change sufficiently so developers who 
look at the code in the future won't have to guess what your reasoning was and
what your assumptions were. Every Debian and Ubuntu package source includes 
``debian/changelog``, where changes of each uploaded package are tracked.

The easiest way to do this is to run::

    $ dch -i

This will add a boilerplate changelog entry for you and launch an editor 
where you can fill out the blanks. An example of this could be::

  specialpackage (1.2-3ubuntu4) natty; urgency=low

    * debian/control: updated description to include frobnicator (LP: #123456)

   -- Emma Adams <emma.adams@isp.com>  Sat, 17 Jul 2010 02:53:39 +0200

``dch`` should fill out the first and last line of such a changelog entry for
you already. Line 1 consists of the source package name, the version number,
which Ubuntu release it is uploaded to, the urgency (which almost always is 
'low'). The last line always contains the name, email address and timestamp
(in :rfc:5322 format) of the change.

With that out of the way, let's focus on the actual changelog entry itself: 
it is very important to document:

    #. where the change was done
    #. what was changed
    #. where the discussion of the change happened

In our (very sparse) example the last point is covered by ``(LP: #123456)``
which refers to Launchpad bug 123456. Bug reports or mailing list threads or
specifications are usually good information to provide as a rationale for a
change. As a bonus, if you use the ``LP: #<number>`` notation for Launchpad
bugs, the bug will be automatically closed when the package is uploaded to
Ubuntu.


Conclusion
==========

.. XXX: link to 'forwarding patches' article
.. XXX: link to 'debdiff' article (in case of slow internet, package not 
        imported, etc.)

