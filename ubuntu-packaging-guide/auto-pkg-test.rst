===========================================
autopkgtest: Automatic testing for packages
===========================================

The `DEP 8 specification`_ defines how automatic testing can very easily be 
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
`DEP 8 specification`_ lists all available options.

In a very simple case the file would look like this::

        Tests: build
        Depends: libglib2.0-dev, build-essential

For the test in ``debian/tests/build`` this would ensure that the packages 
``libglib2.0-dev`` and ``build-essential`` are installed.

.. note:: You can use ``@`` in the ``Depends`` line to indicate that you want
        all the packages installed which are built by the source package in
        question.


The actual tests
================

The accompanying test for the example above might be::

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
from the ``autopkgtest`` package to execute the test. Simply run this 
command in the source tree::

        sudo adt-run --no-built-binaries --built-tree=. --- adt-virt-null


Further examples
================

This list is not comprehensive, but might help you get a better idea of how
automated tests are implemented and used in Ubuntu.

* The `libxml2 tests`_ are very similar. They also run a test-build of a 
  simple piece of C code and execute it.
* The `gtk+3.0 tests`_ also do a compile/link/run check in the "build" test. 
  There is an additional "python3-gi" test which verifies that the GTK 
  library can also be used through introspection.
* In the `ubiquity tests`_ the upstream test-suite is executed.
* The `gvfs tests`_ have comprehensive testing of their functionality and
  are very interesting because they emulate usage of CDs, Samba, DAV and
  other bits.

Ubuntu infrastructure
=====================

Packages which have ``autopkgtest`` enabled will have their tests run whenever
they get uploaded or any of their reverse-dependencies change. The output of
`automatically run autopkgtest tests`_ can be viewed on the web and is 
regularly updated.

While Debian does not have an automatic testing infrastructure set up yet, 
they should still be submitted to Debian, as DEP-8 is a Debian specification 
and Debian developers or users can still manually run the tests.

.. _`DEP 8 Specification`: http://anonscm.debian.org/gitweb/?p=autopkgtest/autopkgtest.git;a=blob_plain;f=doc/README.package-tests;hb=HEAD
.. _`libxml2 tests`: http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/quantal/libxml2/quantal/files/head:/debian/tests/
.. _`gvfs tests`: http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/quantal/gvfs/quantal/files/head:/debian/tests/
.. _`gtk+3.0 tests`: http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/quantal/gtk+3.0/quantal/files/head:/debian/tests/
.. _`ubiquity tests`: http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/quantal/ubiquity/quantal/files/head:/debian/tests/
.. _`automatically run autopkgtest tests`: https://jenkins.qa.ubuntu.com/view/Quantal/view/AutoPkg%20Test/
