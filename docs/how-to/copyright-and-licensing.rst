Copyright and Licensing
=======================

Ubuntu is a collection of free and open source software. As such, it is
critical to ensure the licensing of our packages is reviewed carefully.

It is important to verify a package's :file:`debian/copyright` file when
creating patches, updating to new upstream releases, and creating new packages
altogether. Understanding copyright can be a time-consuming task, but being
conscious of licensing standards broadens your perspective on how software may
interact.

DEP-5 and Copyright Files
-------------------------

Ubuntu and Debian use the `DEP-5 standard <https://dep-team.pages.debian.net/deps/dep5/>`_
for tracking copyright references in packages. Per Debian Policy `4.5 <https://www.debian.org/doc/debian-policy/ch-source.html#copyright-debian-copyright>`_,
`12.5 <https://www.debian.org/doc/debian-policy/ch-docs.html#s-copyrightfile>`_, and
`2.3 <https://www.debian.org/doc/debian-policy/ch-archive.html#s-pkgcopyright>`_
(which should be considered as the Single Source Of Truth for policy regarding
copyright files), every package must have a copyright file. While DEP-5 is
technically not a hard requirement, it is best practice to use DEP-5 when
creating or updating packages.

When you should (not) rewrite a copyright file to use DEP-5
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

You **should** rewrite a copyright file to use DEP-5 if:
* you are updating to a new upstream version in an Ubuntu-only package.
* you are updating to a new upstream version in a package that is in both
  Debian and Ubuntu, and you are sending the delta upstream to Debian.
* a package you maintain in Debian does not use DEP-5.

You **should not** rewrite a copyright file to use DEP-5 if:
* you are performing a Stable Release Update, except in the case of
  documented Microrelease Exceptions.
* a package does not have an extensive Ubuntu delta and you do not plan on
  sending the change to Debian.
* there is general disagreement with the team claiming maintenance of the
  package in Ubuntu (this should be discussed on the ubuntu-devel mailing
  list).
* the package contains an extremely large number of files under different
  copyrights, and the maintenance of an accurate DEP-5 copyright file for
  the package would render further maintenance effectively impossible.
  This exception is not to be used lightly, and should be fallen back on
  only for the largest and most extremely complicated packages in Debian
  and Ubuntu, such as the Linux kernel.

Unclear Licensing and Special Cases
+++++++++++++++++++++++++++++++++++

There are several cases in which the licensing of source files is
questionable. Below you will find several examples; when in doubt about a
specific license, please review the DFSG FAQ linked in the Resources section:
* A source package which contains no licensing information is considered to be
  proprietary, and thus not eligible for inclusion in Ubuntu.
* Files licensed in the public domain still must be listed in the copyright
  file. Some jurisdictions allow copyright for software to be changed
  posthumously, so it is important to still credit authors in this case.

Tools for Copyright File Verification
-------------------------------------

Many tools exist to verify the licenses in a package. You can find a current
list on the `CopyrightReviewTools Debian Wiki page <https://wiki.debian.org/CopyrightReviewTools>`_.

The most commonly used tool for this is :manpage:`licensecheck(1)`. Here is an
example of how you may use it:

.. code-block:: bash

    licensecheck --check '.*' --recursive --deb-machine --lines 0 -- *

If all else fails, you will need to manually open each file and make a
determination based on its copyright header (if there is one).

Resources
---------

* `Debian Free Software Guidelines <https://www.debian.org/social_contract.html#guidelines>`_
* `DFSG and Software License FAQ (Draft) <https://people.debian.org/~bap/dfsg-faq.html>`_
* `Licensing exercises from the Debian Developer process <https://salsa.debian.org/nm-team/nm-templates/-/blob/master/nm_pp1.txt?ref_type=heads#L48>`_
  - It can be incredibly helpful to answer these questions in your own notes,
    and ask a Debian Developer to verify your answers. Alternatively, you may
    politely ask a Debian Developer for their own answers to those questions.
* `Ubuntu open-source licenses <https://ubuntu.com/legal/open-source-licences>`_
* `Debian license information <https://www.debian.org/legal/licenses/>`_
* `DFSGLicenses on the Debian Wiki <https://wiki.debian.org/DFSGLicenses>`_
* `The Open Source Definition from OSI <https://opensource.org/osd>`_
* `debian-legal mailing list archives <https://lists.debian.org/debian-legal/>`_
