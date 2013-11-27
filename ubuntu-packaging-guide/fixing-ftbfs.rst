.. XXX list of common issue and how to fix, possibly explain the MIR process.

=====================
Fixing FTBFS packages 
=====================

Before a package can be used in Ubuntu, it has to build from source. If it 
fails this, it will probably wait in -proposed and will not be available in 
the Ubuntu archives. You can find a complete list of packages that are 
failing to build from source at http://qa.ubuntuwire.org/ftbfs/. There are 5 
main categories shown on the page:

 * Package failed to build (F): Something actually went wrong with the build 
   process.
 * Cancelled build (X): The build has been cancelled for some reason. These 
   should probably be avoided to start with.
 * Package is waiting on another package (M): This package is waiting on 
   another package to either build, get updated, or (if the package is in 
   main) one of it's dependancies is in the wrong part of the archive.
 * Failure in the chroot (C): Part of the chroot failed, this is most likely 
   fixed by a rebuild. Ask a developer to rebuild the package and that should 
   fix it.
 * Failed to upload (U): The package could not upload. This is usually just a 
   case of asking for a rebuild, but check the build log first.

First steps
===========
The first thing you'll want to do is see if you can reproduce the FTBFS 
yourself. Get the code either by running ``bzr branch lp:ubuntu/PACKAGE`` and 
the getting the tarball or running ``dget PACKAGE_DSC`` on the .dsc file from 
the launchpad page. Once you have that, build it in a schroot. 

.. XXX add a link

You should be able to reproduce the FTBFS. If not, check if the build is 
downloading a missing dependency, which means you just need to make that a 
build-dependency in debian/control. Building the package locally can also 
help find if the issue is caused by a missing, unlisted, dependency (builds 
locally but fails on a schroot).

Checking Debian
===============
Once you have reproduced the issue, it's time to try and find a solution. If 
the package is in Debian as well, you can check if the package builds there 
by going to http://packages.qa.debian.org/PACKAGE. If Debian has a newer 
version, you should merge it. If not, check the buildlogs and bugs linked on 
that page for any extra information on the ftbfs or patches. Debian also 
maintains a list of command FTBFSs and how to fix them which can be found at 
https://wiki.debian.org/qa.debian.org/FTBFS, you will want to check it for 
solutions too.

ARM64
=====
Ubuntu has added arm64 as a architecture recently, but many packages fail to 
build on it. A full list of the packages not building are at 
qa.ubuntuwire.org/ftbfs/arm64.html. Many of these are caused by packages 
using outdated autotools helper files. Any package with the lintian warning 
ancient-autotools-helper-file or outdated-autotools-helper-file will have 
this issue. Adding autotools-dev or dh-autoreconf to the build proccess will 
usually fix this. 

Other causes of a package to FTBFS
==================================
If a package is in main and missing a dependency that is nor in main, you 
will have to file a MIR bug. https://wiki.ubuntu.com/MainInclusionProcess
explains the procedure.

.. XXX add more

Fixing the issue
================
Once you have found a fix to the problem, follow the same process as any 
other bug. Make a patch, add it to a bzr branch or bug, subscribe 
ubuntu-sponsors, then try to get it included upstream and/or in Debian.

