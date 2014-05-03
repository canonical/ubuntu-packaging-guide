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

While this test is very small and basic, it tests quite a number of core
components on a system. This may help to uncover critical issues early on.

Executing the test
==================

The test script can be easily executed on its own, but if you want to make 
sure that the testbed is properly set up, you might want to use ``adt-run`` 
from the ``autopkgtest`` package to execute the test. The easiest way to do
this is to run this command in the source tree::

        sudo adt-run --no-built-binaries --built-tree=. --- adt-virt-null

The downside of this approach is that you test it locally, but can't ensure
that this will work in a minimal environment. For example will it be hard to
ensure that all the required packages are installed for the tests. With 
`lp:auto-package-testing <autotesting_>`_ we have a more comprehensive testing tool. It 
uses a pristine virtual machine to run the tests. To set it up, firstly
install the needed dependencies::

        sudo apt-get install qemu-utils kvm eatmydata

Then, get the source code from Launchpad::

        bzr branch lp:auto-package-testing
        cd auto-package-testing

And provision a Trusty AMD64 system::

    ./bin/prepare-testbed -r trusty amd64

This command will create a pristine Trusty AMD64 VM from a cloud image. To
run the tests, simply run::

        ./bin/run-adt-test -r trusty -a amd64 \
            -S file:///tmp/glib2.0-2.35.7/ glib2.0

This would use the source package in ``/tmp/glib2.0-2.35.7/`` and run the
tests from this tree against the package ``glib2.0`` from the archive. The
option ``-S`` also supports schemes for bzr, git, and apt sources. If you
only specify a source with ``-S`` but do not specify a package name, this will
instead build the branch and install the binaries from that build; this is
useful if you want to run tests on a newer version than the one packaged in
Ubuntu, or the package is not in Ubuntu at all. If use the ``-k`` flag you can
log into the virtual machine after the tests were run. This makes it very easy
to debug issues.

The `auto-package-testing documentation <autotesting-doc_>`_ has a lot more valuable information
on other testing options.



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

While Debian does not have an automatic testing infrastructure set up yet, 
they should still be submitted to Debian, as DEP-8 is a Debian specification 
and Debian developers or users can still manually run the tests.

Packages in Debian with a testsuite header will also be automatically added 
when they are synced to Ubuntu.

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

.. _DEP8: http://anonscm.debian.org/gitweb/?p=autopkgtest/autopkgtest.git;a=blob_plain;f=doc/README.package-tests;hb=HEAD
.. _libxml2: https://bazaar.launchpad.net/+branch/ubuntu/libxml2/files/head:/debian/tests/
.. _gvfs: https://bazaar.launchpad.net/+branch/ubuntu/gvfs/files/head:/debian/tests/
.. _gtk3: https://bazaar.launchpad.net/+branch/ubuntu/gtk+3.0/files/head:/debian/tests/
.. _ubiquity: https://bazaar.launchpad.net/+branch/ubiquity/files/head:/debian/tests/
.. _jenkins: https://jenkins.qa.ubuntu.com/view/Saucy/view/AutoPkgTest/
.. _autotesting: https://code.launchpad.net/auto-package-testing
.. _autotestingdoc: http://bazaar.launchpad.net/~auto-package-testing-dev/auto-package-testing/trunk/view/head:/doc/USAGE.md
.. _requiredtests: https://wiki.ubuntu.com/QATeam/RequiredTests
.. _qualityirc: http://webchat.freenode.net/?channels=ubuntu-quality
