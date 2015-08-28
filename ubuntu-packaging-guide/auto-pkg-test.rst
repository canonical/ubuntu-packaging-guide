===========================================
autopkgtest: Automatic testing for packages
===========================================

The `DEP 8 specification <DEP8_>`_ defines how automatic testing can very easily be 
integrated into packages. To integrate a test into a package, all you need to 
do is:

* add the following to the Source section in ``debian/control``:: 

        XS-Testsuite: autopkgtest

* add a file called ``debian/tests/control`` which specifies the requirements 
  for the testbed,
* add the tests in ``debian/tests/``.


Testbed requirements
====================

In ``debian/tests/control`` you specify what to expect from the testbed. So 
for example you list all the required packages for the tests, if the testbed
gets broken during the build or if ``root`` permissions are required. The 
`DEP 8 specification <DEP8_>`_ lists all available options.

Below we are having a look at the ``glib2.0`` source package. In a very 
simple case the file would look like this::

        Tests: build
        Depends: libglib2.0-dev, build-essential

For the test in ``debian/tests/build`` this would ensure that the packages 
``libglib2.0-dev`` and ``build-essential`` are installed.

.. note:: You can use ``@`` in the ``Depends`` line to indicate that you want
        all the packages installed which are built by the source package in
        question.


The actual tests
================

The accompanying test for the example above might be:

.. code-block:: sh

        #!/bin/sh
        # autopkgtest check: Build and run a program against glib, to verify that the
        # headers and pkg-config file are installed correctly
        # (C) 2012 Canonical Ltd.
        # Author: Martin Pitt <martin.pitt@ubuntu.com>

        set -e

        WORKDIR=$(mktemp -d)
        trap "rm -rf $WORKDIR" 0 INT QUIT ABRT PIPE TERM
        cd $WORKDIR
        cat <<EOF > glibtest.c
        #include <glib.h>

        int main()
        {
            g_assert_cmpint (g_strcmp0 (NULL, "hello"), ==, -1);
            g_assert_cmpstr (g_find_program_in_path ("bash"), ==, "/bin/bash");
            return 0;
        }
        EOF

        gcc -o glibtest glibtest.c `pkg-config --cflags --libs glib-2.0`
        echo "build: OK"
        [ -x glibtest ]
        ./glibtest
        echo "run: OK"

Here a very simple piece of C code is written to a temporary directory. Then 
this is compiled with system libraries (using flags and library paths as 
provided by `pkg-config`). Then the compiled binary, which just exercises some
parts of core glib functionality, is run.

While this test is very small and simple, it covers quite a lot: that your -dev
package has all necessary dependencies, that your package installs working
pkg-config files, headers and libraries are put into the right place, or that
the compiler and linker work. This helps to uncover critical issues early on.

Executing the test
==================

While the test script can be easily executed on its own, it is strongly
recommended to actually use ``adt-run`` from the ``autopkgtest`` package for
verifying that your test works; otherwise, if it fails in the Ubuntu Continuous
Integration (CI) system, it will not land in Ubuntu.  This also avoids cluttering
your workstation with test packages or test configuration if the test does
something more intrusive than the simple example above.

The `README.running-tests <running_tests_local_>`_
(`online version <DEP8_>`_) documentation explains all
available testbeds (schroot, LXC, QEMU, etc.) and the most common scenarios how
to run your tests with ``adt-run``, e. g. with locally built binaries, locally
modified tests, etc.

The Ubuntu CI system uses the QEMU runner and runs the tests from the packages
in the archive, with ``-proposed`` enabled. To reproduce the exact same
environment, first install the necessary packages::

        sudo apt-get install autopkgtest qemu-system qemu-utils

Now build a testbed with::

        adt-buildvm-ubuntu-cloud -v

(Please see its manpage and ``--help`` output for selecting different releases,
architectures, output directory, or using proxies). This will build e. g.
``adt-trusty-amd64-cloud.img``.

Then run the tests of a source package like ``libpng`` in that QEMU image::

        adt-run libpng --- qemu adt-trusty-amd64-cloud.img

The Ubuntu CI system runs packages with ``-proposed`` enabled; to enable that,
run::

        adt-run libpng -U --apt-pocket=proposed --- qemu adt-trusty-amd64-cloud.img

The ``adt-run`` manpage has a lot more valuable information on other testing
options.


Further examples
================

This list is not comprehensive, but might help you get a better idea of how
automated tests are implemented and used in Ubuntu.

* The `libxml2 tests <libxml2_>`_ are very similar. They also run a test-build of a 
  simple piece of C code and execute it.
* The `gtk+3.0 tests <gtk3_>`_ also do a compile/link/run check in the "build" test. 
  There is an additional "python3-gi" test which verifies that the GTK 
  library can also be used through introspection.
* In the `ubiquity tests <ubiquity_>`_ the upstream test-suite is executed.
* The `gvfs tests <gvfs_>`_ have comprehensive testing of their functionality and
  are very interesting because they emulate usage of CDs, Samba, DAV and
  other bits.

Ubuntu infrastructure
=====================

Packages which have ``autopkgtest`` enabled will have their tests run whenever
they get uploaded or any of their dependencies change. The output of
`automatically run autopkgtest tests <jenkins_>`_ can be viewed on the web and is 
regularly updated.

Debian also uses ``adt-run`` to run package tests, although currently only in
schroots, so results may vary a bit. Results and logs can be seen on
http://ci.debian.net. So please submit any test fixes or new
tests to Debian as well.

Getting the test into Ubuntu
============================

The process of submitting an autopkgtest for a package is largely similar to 
:doc:`fixing a bug in Ubuntu<./fixing-a-bug>`. Essentially you simply:

* run ``bzr branch ubuntu:<packagename>``,
* edit ``debian/control`` to enable the tests,
* add the ``debian/tests`` directory,
* write the ``debian/tests/control`` based on the `DEP 8 Specification <dep8_>`_,
* add your test case(s) to ``debian/tests``,
* commit your changes, push them to Launchpad, propose a merge and get it 
  reviewed just like any other improvement in a source package.


What you can do
===============

The Ubuntu Engineering team put together a `list of required test-cases <requiredtests_>`_,
where packages which need tests are put into different categories. Here you
can find examples of these tests and easily assign them to yourself.

If you should run into any problems, you can join the `#ubuntu-quality IRC
channel <qualityirc_>`_ to get in touch with developers who can help you.

.. _DEP8: http://anonscm.debian.org/cgit/autopkgtest/autopkgtest.git/tree/doc/README.package-tests.rst
.. _libxml2: https://bazaar.launchpad.net/+branch/ubuntu/libxml2/files/head:/debian/tests/
.. _gvfs: https://bazaar.launchpad.net/+branch/ubuntu/gvfs/files/head:/debian/tests/
.. _gtk3: https://bazaar.launchpad.net/+branch/ubuntu/gtk+3.0/files/head:/debian/tests/
.. _ubiquity: https://bazaar.launchpad.net/+branch/ubiquity/files/head:/debian/tests/
.. _jenkins: http://autopkgtest.ubuntu.com/
.. _running_tests_local: file:///usr/share/doc/autopkgtest/RREADME.running-tests.html
.. _requiredtests: https://wiki.ubuntu.com/QATeam/RequiredTests
.. _qualityirc: http://webchat.freenode.net/?channels=ubuntu-quality
