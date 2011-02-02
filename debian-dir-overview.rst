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

 -- Captain Packager <packager@coolness.com>  Wed,  5 Jan 2009 22:38:49 -0700
 
Notice that the version has a ``-0ubuntu1`` appended to it, this is the distro revision, used so that the packaging can be updated (to fix bugs for example) with new uploads within the same source release version.

Ubuntu and Debian have slightly different package versioning schemes to avoid conflicting packages with the same source version. If a Debian package has been changed in Ubuntu, it has ``ubuntuX`` (where ``X`` is the Ubuntu revision number) appended to the end of the Debian version. So if the Debian hello ``2.4-1`` package was changed by Ubuntu, the version string would be ``2.4-1ubuntu1``. If a package for the application does not exist in Debian, then the Debian revision is ``0`` (e.g., ``2.4-0ubuntu1``).

For further information, see the `changelog section <http://www.debian.org/doc/debian-policy/ch-source.html#s-dpkgchangelog>`_ of the Debian Policy Manual.


The control file
-------------------------------

The control file contains the information that the package manager (such as ``apt-get``, ``synaptic``, and ``adept``) uses, build-time dependencies, maintainer information, and much more.

For the Ubuntu hello package, the control file looks something like::

 Source: hello
 Section: devel
 Priority: optional
 Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
 XSBC-Original-Maintainer: Captain Packager <packager@coolness.com>
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


