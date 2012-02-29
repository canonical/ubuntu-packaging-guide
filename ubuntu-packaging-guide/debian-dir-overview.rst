Basic Overview of the ``debian/`` Directory
==================================================

This article will briefly explain the different files important to the 
packaging of Ubuntu packages which are contained in the ``debian/`` directory. 
The most important of them are ``changelog``, ``control``, ``copyright``, and 
``rules``. These are required for all packages. A number of additional files 
in the ``debian/`` may be used in order to customize and configure the 
behavior of the package. Some of these files are discussed in this article, 
but this is not meant to be a complete list.

The changelog
-------------------------------

This file is, as its name implies, a listing of the changes made in each 
version. It has a specific format that gives the package name, version, 
distribution, changes, and who made the changes at a given time. If you 
have a GPG key (see: :doc:`Getting set up<./getting-set-up/>`), make sure 
to use the same name and email address in ``changelog`` as you have in 
your key. The following is a template ``changelog``::


 package (version) distribution; urgency=urgency

  * change details
   - more change details
  * even more change details

 -- maintainer name <email address>[two spaces]  date
 
The format (especially of the date) is important. The date should be in :rfc:`5322` 
format, which can be obtained by using the command ``date -R``. For 
convenience, the command ``dch`` may be used to edit changelog. It will update 
the date automatically.

Minor bullet points are indicated by a dash "-", while major points use an 
asterisk "*".

If you are packaging from scratch, ``dch --create`` (``dch`` is in the 
``devscripts`` 
package) will create a standard ``debian/changelog`` for you.

Here is a sample ``changelog`` file for hello::


 hello (2.6-0ubuntu1) natty; urgency=low

   * New upstream release with lots of bug fixes and feature improvements.

 -- Jane Doe <packager@example.com>  Thu, 21 Apr 2011 11:12:00 -0400
 
Notice that the version has a ``-0ubuntu1`` appended to it, this is the distro 
revision, used so that the packaging can be updated (to fix bugs for example) 
with new uploads within the same source release version.

Ubuntu and Debian have slightly different package versioning schemes to avoid 
conflicting packages with the same source version. If a Debian package has been 
changed in Ubuntu, it has ``ubuntuX`` (where ``X`` is the Ubuntu revision 
number) appended to the end of the Debian version. So if the Debian hello 
``2.6-1`` package was changed by Ubuntu, the version string would be 
``2.6-1ubuntu1``. If a package for the application does not exist in Debian, 
then the Debian revision is ``0`` (e.g. ``2.6-0ubuntu1``).

For further information, see the `changelog section (Section 4.4) 
<http://www.debian.org/doc/debian-policy/ch-source.html#s-dpkgchangelog>`_ of 
the Debian Policy Manual.


The control file
-------------------------------

The ``control`` file contains the information that the package manager (such as 
``apt-get``, ``synaptic``, and ``adept``) uses, build-time dependencies, 
maintainer information, and much more.

For the Ubuntu ``hello`` package, the ``control`` file looks something like::

 Source: hello
 Section: devel
 Priority: optional
 Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
 XSBC-Original-Maintainer: Jane Doe <packager@example.com>
 Standards-Version: 3.9.1
 Build-Depends: debhelper (>= 7)
 Bzr-Vcs: lp:ubuntu/hello
 Homepage: http://www.gnu.org/software/hello/
 
 Package: hello
 Architecture: any
 Depends: ${shlibs:Depends}
 Description: The classic greeting, and a good example
  The GNU hello program produces a familiar, friendly greeting. It
  allows non-programmers to use a classic computer science tool which
  would otherwise be unavailable to them. Seriously, though: this is
  an example of how to do a Debian package. It is the Debian version of
  the GNU Project's `hello world' program (which is itself an example
  for the GNU Project).
 
The first paragraph describes the source package including the list of packages 
required to build the package from source in the ``Build-Depends`` field. It 
also 
contains some meta-information such as the maintainer's name, the version of 
Debian Policy that the package complies with, the location of the packaging 
version control repository, and the upstream home page.

Note that in Ubuntu, we set the ``Maintainer`` field to a general address 
because 
anyone can change any package (this differs from Debian where changing packages 
is usually restricted to an individual or a team). Packages in Ubuntu should 
generally have the ``Maintainer`` field set to ``Ubuntu Developers 
<ubuntu-devel-discuss@lists.ubuntu.com>``. If the Maintainer field is modified, 
the old value should be saved in the ``XSBC-Original-Maintainer`` field. This 
can be done automatically with the  ``update-maintainer`` script available in 
the ``ubuntu-dev-tools`` package. For further information, see the `Debian 
Maintainer Field spec <https://wiki.ubuntu.com/DebianMaintainerField>`_ on the 
Ubuntu wiki.

Each additional paragraph describes a binary package to be built.

For further information, see the `control file section (Chapter 5) 
<http://www.debian.org/doc/debian-policy/ch-controlfields.html>`_ of the Debian 
Policy Manual.


The copyright file
-------------------------------

This file gives the copyright information for both the upstream source and the 
packaging. Ubuntu and `Debian Policy (Section 12.5) 
<http://www.debian.org/doc/debian-policy/ch-docs.html#s-copyrightfile>`_ 
require that each package installs a verbatim copy of its copyright and license 
information to ``/usr/share/doc/$(package_name)/copyright``.

Generally, copyright information is found in the ``COPYING`` file in the 
program's 
source directory. This file should include such information as the names of the 
author and the packager, the URL from which the source came, a Copyright line 
with the year and copyright holder, and the text of the copyright itself. An 
example template would be::


 Format: http://svn.debian.org/wsvn/dep/web/deps/dep5.mdwn?op=file&rev=166
 Upstream-Name: Hello
 Source: ftp://ftp.example.com/pub/games
 
 Files: *
 Copyright: Copyright 1998 John Doe <jdoe@example.com>
 License: GPL-2+
  This program is free software; you can redistribute it
  and/or modify it under the terms of the GNU General Public
  License as published by the Free Software Foundation; either
  version 2 of the License, or (at your option) any later
  version.
  .
  This program is distributed in the hope that it will be
  useful, but WITHOUT ANY WARRANTY; without even the implied
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  PURPOSE.  See the GNU General Public License for more
  details.
  .
  You should have received a copy of the GNU General Public
  License along with this package; if not, write to the Free
  Software Foundation, Inc., 51 Franklin St, Fifth Floor,
  Boston, MA  02110-1301 USA
  .
  On Debian systems, the full text of the GNU General Public
  License version 2 can be found in the file
  `/usr/share/common-licenses/GPL-2'.
 
 Files: debian/*
 Copyright: Copyright 1998 Jane Doe <packager@example.com>
 License: GPL-2+
 
This example follows the `DEP-5: Machine-parseable debian/copyright 
<http://dep.debian.net/deps/dep5/>`_ proposal. You are encouraged to use this 
format as well.


The rules file
-------------------------------

The last file we need to look at is ``rules``. This does all the work for 
creating 
our package. It is a Makefile with targets to compile and install the 
application, then create the ``.deb`` file from the installed files. It also 
has a 
target to clean up all the build files so you end up with just a source package 
again.

Here is a simplified version of the rules file created by ``dh_make`` (which 
can be found in the ``dh-make`` package)::

 #!/usr/bin/make -f
 # -*- makefile -*-
 
 # Uncomment this to turn on verbose mode.
 #export DH_VERBOSE=1
 
 %:
 	dh  $@

Let us go through this file in some detail. What this does is pass every build 
target that ``debian/rules`` is called with as an argument to ``/usr/bin/dh``, 
which itself will call all the necessary ``dh_*`` commands. 

``dh`` runs a sequence of debhelper commands. The supported sequences 
correspond to 
the targets of a ``debian/rules`` file: "build", "clean", "install", 
"binary-arch", 
"binary-indep", and "binary". In order to see what commands are run in each 
target, run::

 $ dh binary-arch --no-act

Commands in the binary-indep sequence are passed the "-i" option to ensure they 
only work on binary independent packages, and commands in the binary-arch 
sequences are passed the "-a" option to ensure they only work on architecture 
dependent packages.

Each debhelper command will record when it's successfully run in 
``debian/package.debhelper.log``. (Which dh_clean deletes.) So dh can tell 
which commands have already been run, for which packages, and skip running 
those commands again.

Each time ``dh`` is run, it examines the log, and finds the last logged command 
that is in the specified sequence. It then continues with the next command in 
the sequence. The ``--until``, ``--before``, ``--after``, and ``--remaining`` 
options can override this behavior.

If ``debian/rules`` contains a target with a name like ``override_dh_command``, 
then 
when it gets to that command in the sequence, ``dh`` will run that target from 
the 
rules file, rather than running the actual command. The override target can 
then run the command with additional options, or run entirely different 
commands instead. (Note that to use this feature, you should Build-Depend on 
debhelper 7.0.50 or above.)

Have a look at ``/usr/share/doc/debhelper/examples/`` and ``man dh`` for more 
examples. Also see `the rules section (Section 4.9) 
<http://www.debian.org/doc/debian-policy/ch-source.html#s-debianrules>`_ of the 
Debian Policy Manual.

Additional Files
-------------------------------

The install file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``install`` file is used by ``dh_install`` to install files into the binary 
package. It has two standard use cases:

* To install files into your package that are not handled by the upstream build system.
* Splitting a single large source package into multiple binary packages.

In the first case, the ``install`` file should have one line per file 
installed, 
specifying both the the file and the installation directory. For example, the 
following ``install`` file would install the script ``foo`` in the source 
package's 
root directory to ``usr/bin`` and a desktop file in the ``debian`` directory to 
``usr/share/applications``::

 foo usr/bin
 debian/bar.desktop usr/share/applications

When a source package is producing multiple binary packages ``dh`` will
install the files into ``debian/tmp`` rather than directly into
``debian/<package>``. Files installed into ``debian/tmp`` can then be moved
into separate binary packages using multiple ``$package_name.install`` files.
This is often done to split large amounts of architecture independent data out
of architecture dependent packages and into ``Architecture: all`` packages. In 
this case, only the name of the files (or directories) to be installed are 
needed without the installation directory. For example, ``foo.install`` 
containing only the architecture dependent files might look like::

 usr/bin/
 usr/lib/foo/*.so

While ``foo-common.install`` containing only the architecture independent file 
might look like::

 /usr/share/doc/
 /usr/share/icons/
 /usr/share/foo/
 /usr/share/locale/

This would create two binary packages, ``foo`` and ``foo-common``. Both would 
require their own paragraph in ``debian/control``.

See ``man dh_install`` and the `install file section (Section 5.11) 
<http://www.debian.org/doc/manuals/maint-guide/dother.en.html#install>`_  of 
the Debian New Maintainers' Guide for additional details.

The watch file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``debian/watch`` file allows us to check automatically for new upstream 
versions using the tool ``uscan`` found in the ``devscripts`` package. The 
first line of the watch file must be the format version (3, at the time of this 
writing), while the following lines contain any URLs to parse. For example::

 version=3
 
 http://ftp.gnu.org/gnu/hello/hello-(.*).tar.gz

Running ``uscan`` in the root source directory will now compare the upstream 
version number in ``debian/changelog`` with the latest available upstream 
version. 
If a new upstream version is found, it will be automatically downloaded. For 
example::

 $ uscan 
 hello: Newer version (2.7) available on remote site:
   http://ftp.gnu.org/gnu/hello/hello-2.7.tar.gz
   (local version is 2.6)
 hello: Successfully downloaded updated package hello-2.7.tar.gz
     and symlinked hello_2.7.orig.tar.gz to it

For further information, see ``man uscan`` and the `watch file section (Section 
4.11) <http://www.debian.org/doc/debian-policy/ch-source.html#s-debianwatch>`_ 
of the Debian Policy Manual.

For a list of packages where the ``watch`` file reports they are not in sync
with upstream see `Ubuntu External Health Status
<http://qa.ubuntuwire.org/uehs/no_updated.html>`_.

The source/format file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This file indicates the format of the source package. It should contain 
a single line indicating the desired format:

* ``3.0 (native)`` for Debian native packages (no upstream version)

* ``3.0 (quilt)`` for packages with a separate upstream tarball

* ``1.0`` for packages wishing to explicitly declare the default format

Currently, the package source format will default to 1.0 if this file does not 
exist. You can make this explicit in the source/format file. If you choose not 
to use this file to define the source format, Lintian will warn about the 
missing file. This warning is informational only and may be safely ignored.

You are encouraged to use the newer 3.0 source format. It provides
a number of new features:

* Support for additional compression formats: bzip2, lzma and xz

* Support for multiple upstream tarballs

* Not necessary to repack the upstream tarball to strip the debian directory

* Debian-specific changes are no longer stored in a single .diff.gz but in multiple patches compatible with quilt under ``debian/patches/``

http://wiki.debian.org/Projects/DebSrc3.0 summarizes additional information 
concerning the switch to the 3.0 source package formats.

See ``man dpkg-source`` and the `source/format section (Section 5.21) 
<http://www.debian.org/doc/manuals/maint-guide/dother.en.html#sourcef>`_  of 
the Debian New Maintainers' Guide for additional details.

Additional Resources
-------------------------------

In addition to the links to the Debian Policy Manual in each section above, the 
Debian New Maintainers' Guide has more detailed descriptions of each file. 
`Chapter 4, "Required files under the debian directory" 
<http://www.debian.org/doc/maint-guide/dreq.en.html>`_ further discusses the 
control, changelog, copyright and rules files. `Chapter 5, "Other files under 
the debian directory" <http://www.debian.org/doc/maint-guide/dother.en.html>`_ 
discusses additional files that may be used.
