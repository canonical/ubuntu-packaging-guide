Basic Overview of the ``debian/`` Directory
==================================================

The changelog
-------------------------------

The changelog file is, as its name implies, a listing of the changes made in each version. It has a specific format that gives the package name, version, distribution, changes, and who made the changes at a given time. If you have a GPG key, make sure to use the same name and email address in changelog as you have in your key. The following is a template changelog::


 package (version) distribution; urgency=urgency

  * change details
   - more change details
  * even more change details

 -- maintainer name <email address>[two spaces]  date
 
The format (especially of the date) is important. The date should be in RFC822 format, which can be obtained by using the command ``date -R``. For convenience, the command ``dch`` may be used to edit changelog. It will update the date automatically.

Minor bullet points are indicated by a dash "-", while major points use an asterisk "*".

If you are packaging from scratch, ``dch --create`` (dch is in the devscripts package) will create a standard ``debian/changelog`` for you.

Here is a sample changelog file for hello::


 hello (2.4-0ubuntu1) jaunty; urgency=low

   * New upstream release with lots of bug fixes and feature improvements.

 -- Jane Doe <packager@example.com>  Wed,  5 Jan 2009 22:38:49 -0700
 
Notice that the version has a ``-0ubuntu1`` appended to it, this is the distro revision, used so that the packaging can be updated (to fix bugs for example) with new uploads within the same source release version.

Ubuntu and Debian have slightly different package versioning schemes to avoid conflicting packages with the same source version. If a Debian package has been changed in Ubuntu, it has ``ubuntuX`` (where ``X`` is the Ubuntu revision number) appended to the end of the Debian version. So if the Debian hello ``2.4-1`` package was changed by Ubuntu, the version string would be ``2.4-1ubuntu1``. If a package for the application does not exist in Debian, then the Debian revision is ``0`` (e.g., ``2.4-0ubuntu1``).

For further information, see the `changelog section (Section 4.4) <http://www.debian.org/doc/debian-policy/ch-source.html#s-dpkgchangelog>`_ of the Debian Policy Manual.


The control file
-------------------------------

The control file contains the information that the package manager (such as ``apt-get``, ``synaptic``, and ``adept``) uses, build-time dependencies, maintainer information, and much more.

For the Ubuntu hello package, the control file looks something like::

 Source: hello
 Section: devel
 Priority: optional
 Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
 XSBC-Original-Maintainer: Jane Doe <packager@example.com>
 Standards-Version: 3.7.3
 Build-Depends: debhelper (>= 5)
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
 
In Ubuntu we set the Maintainer field to a general address because anyone can change any package (this differs from Debian where changing packages is usually restricted to an individual or a team).

For further information, see the `control file section (Chapter 5) <http://www.debian.org/doc/debian-policy/ch-controlfields.html>`_ of the Debian Policy Manual.


The copyright file
-------------------------------

This file gives the copyright information for both the upstream source and the packaging. Ubuntu and `Debian Policy (Section 12.5) <http://www.debian.org/doc/debian-policy/ch-docs.html#s-copyrightfile>`_ require that each package installs a verbatim copy of its copyright and license information to ``/usr/share/doc/$(package_name)/copyright``.

Generally, copyright information is found in the COPYING file in the program's source directory. This file should include such information as the names of the author and the packager, the URL from which the source came, a Copyright line with the year and copyright holder, and the text of the copyright itself. An example template would be::


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
 
This example follows the `DEP-5: Machine-parseable debian/copyright <http://dep.debian.net/deps/dep5/>`_ proposal. You are encouraged to use this format as well.


The rules file
-------------------------------

The last file we need to look at is rules. This does all the work for creating our package. It is a Makefile with targets to compile and install the application, then create the .deb file from the installed files. It also has a target to clean up all the build files so you end up with just a source package again.

Here is a simplified version of the rules file created by dh_make::

 #!/usr/bin/make -f
 # -*- makefile -*-
 
 # Uncomment this to turn on verbose mode.
 #export DH_VERBOSE=1
 
 %:
 	dh  $@

Let us go through this file in some detail. What this does is pass every build target that debian/rules is called with as an argument to ``/usr/bin/dh``, which itself will call all the necessary dh_* commands.

dh runs a sequence of debhelper commands. The supported sequences correspond to the targets of a debian/rules file: "build", "clean", "install", "binary-arch", "binary-indep", and "binary".

Commands in the binary-indep sequence are passed the "-i" option to ensure they only work on binary independent packages, and commands in the binary-arch sequences are passed the "-a" option to ensure they only work on architecture dependent packages.

Each debhelper command will record when it's successfully run in debian/package.debhelper.log. (Which dh_clean deletes.) So dh can tell which commands have already been run, for which packages, and skip running those commands again.

Each time dh is run, it examines the log, and finds the last logged command that is in the specified sequence. It then continues with the next command in the sequence. The --until, --before, --after, and --remaining options can override this behavior.

If debian/rules contains a target with a name like "override_dh_command", then when it gets to that command in the sequence, dh will run that target from the rules file, rather than running the actual command. The override target can then run the command with additional options, or run entirely different commands instead. (Note that to use this feature, you should Build-Depend on debhelper 7.0.50 or above.)

Have a look at ``/usr/share/doc/debhelper/examples/`` for more examples. Also see `the rules section (Section 4.9) <http://www.debian.org/doc/debian-policy/ch-source.html#s-debianrules>`_ of the Debian Policy Manual.
