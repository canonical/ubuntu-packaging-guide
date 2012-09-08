=========================================
Packaging Python modules and applications
=========================================

Our packaging follows Debian’s `Python policy`_. We will use the `python-markdown`_ package as an example, which can be downloaded from `PyPI`_. You can look at its packaging at its `Subversion repository`_.

There are two types of Python packages — *modules* and *apps*.

At the time of writing, Ubuntu has two incompatible versions of Python — *2.x* and *3.x*. ``/usr/bin/python`` is a symbolic link to a default Python 2.x version, and ``/usr/bin/python3`` — to a default Python 3.x version. Python modules should be built against all supported Python versions.

If you are going to package a new Python module, you might find the ``py2dsc`` tool useful (available in `python-stdeb`_ package).

debian/control
--------------

Python 2.x and 3.x versions of the package should be in separate binary packages. Names should have ``python{,3}-modulename`` format (like: ``python3-dbus.mainloop.qt``). Here, we will use ``python-markdown`` and ``python3-markdown`` for module packages and ``python-markdown-doc`` for the documentation package.

Things in ``debian/control`` that are specific for a Python package:

- The section of module packages should be ``python``, and ``doc`` for the documentation package. For an application, a single binary package will be enough.
- We should add build dependencies on ``python-all (>= 2.6.6-3~)`` and ``python3-all (>= 3.1.2-7~)`` to make sure Python helpers are available (see the next section for details).
- It’s recommended to add ``X-Python-Version`` and ``X-Python3-Version`` fields — see “`Specifying Supported Versions`_” section of the Policy for details. For example:
  ::
  
    X-Python-Version: >= 2.6
    X-Python3-Version: >= 3.1
  
  If your package works only with Python 2.x or 3.x, build depend only on one ``-all`` package and use only one ``-Version`` field.
- Module packages should have ``{python:Depends}`` and ``{python3:Depends}`` substitution variables (respectively) in their dependency lists.

debian/rules
------------

The recommended helpers for python modules are ``dh_python2`` and ``dh_python3``. Unfortunately, ``debhelper`` doesn’t yet build Python 3.x packages automatically (see `bug 597105`_ in Debian BTS), so we’ll need to do that manually in override sections (skip this if your package doesn’t support Python 3.x).

Here’s our ``debian/rules`` file (with annotations):

.. code-block:: makefile

   # These command build the list of supported Python 3 versions
   # The last version should be just “python3” so that the scripts
   # get a correct shebang.
   # Use just “PYTHON3 := $(shell py3versions -r)” if your package
   # doesn’t contain scripts
   PY3REQUESTED := $(shell py3versions -r)
   PY3DEFAULT := $(shell py3versions -d)
   PYTHON3 := $(filter-out $(PY3DEFAULT),$(PY3REQUESTED)) python3
   
   %:
       # Adding the required helpers
       dh $@ --with python2,python3

   override_dh_auto_clean:
       dh_auto_clean
       rm -rf build/
   
   override_dh_auto_build:
       # Build for each Python 3 version
       set -ex; for python in $(PYTHON3); do \
           $$python setup.py build; \
       done
       dh_auto_build
   
   override_dh_auto_install:
       # The same for install; note the --install-layout=deb option
       set -ex; for python in $(PYTHON3); do \
           $$python setup.py install --install-layout=deb --root=debian/tmp; \
       done
       dh_auto_install

It is also a good practice to run tests during the build, if they are shipped by upstream. Usually tests can be invoked using ``setup.py test`` or ``setup.py check``.

debian/\*.install
-----------------

Python 2.x modules are installed into ``/usr/share/pyshared/`` directory, and symbolic links are created in ``/usr/lib/python2.x/dist-packages/`` for every interpreter version, while Python 3.x ones are all installed into ``/usr/lib/python3/dist-packages/``.

If your package is an application and has private Python modules, they should be installed in ``/usr/share/module``, or ``/usr/lib/module`` if the modules are architecture-dependent (e.g. extensions) (see “`Programs Shipping Private Modules`_” section of the Policy).

So, our ``python-markdown.install`` file will look like this (we’ll also want to install a ``markdown_py`` executable):

::

  usr/lib/python2.*/
  usr/bin/

and ``python3-markdown.install`` will only have one line:

::

  usr/lib/python3/

The ``-doc`` package
--------------------

The tool most commonly used for building Python docs is `Sphinx`_. To add Sphinx documentation to your package (using ``dh_sphinxdoc`` helper), you should:

* Add a build-dependency on ``python-sphinx`` or ``python3-sphinx`` (depending on what Python version do you want to use);
* Append ``sphinxdoc`` to the ``dh --with`` line;
* Run ``setup.py build_sphinx`` in ``override_dh_auto_build`` (sometimes not needed);
* Add ``{sphinxdoc:Depends}`` to the dependency list of your ``-doc`` package;
* Add the path of the built docs directory (usually ``build/sphinx/html``) to your ``.docs`` file.

In our case, the docs are automatically built in ``build/docs/`` directory when we run ``setup.py build``, so we can simply put this in the ``python-markdown-doc.docs`` file:

::

  build/docs/

Because docs also contain source ``.txt`` files, we’ll also tell ``dh_compress`` to not compress them — by adding this to ``debian/rules``:

.. code-block:: makefile

   override_dh_compress:
       dh_compress -X.txt

Checking for packaging mistakes
-------------------------------

Along with ``lintian``, there is a special tool for checking Python packages — ``lintian4py``. It is available in the `lintian4python`_ package. For example, this command invokes both ``lintian`` and ``lintian4py`` and checks source and binary packages:

::

  lintian{,4py} -EI --pedantic *.dsc *.deb

Here, ``-EI`` option is used to enable experimental and informational tags.

See also
--------

* The `Python policy`_;
* `Python/Packaging`_ article on Debian wiki;
* `Python/LibraryStyleGuide`_ and `Python/AppStyleGuide`_ articles on Debian wiki;
* Debian `python-modules`_ and `python-apps`_ teams.

.. _`Python policy`: http://www.debian.org/doc/packaging-manuals/python-policy/
.. _`python-markdown`: http://packages.python.org/Markdown/
.. _`PyPI`: http://pypi.python.org/pypi/Markdown/
.. _`Subversion repository`: http://anonscm.debian.org/viewvc/python-modules/packages/python-markdown/trunk/debian/
.. _`python-stdeb`: https://launchpad.net/ubuntu/+source/stdeb
.. _`bug 597105`: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=597105
.. _`Specifying Supported Versions`: http://www.debian.org/doc/packaging-manuals/python-policy/ch-module_packages.html#s-specifying_versions
.. _`Programs Shipping Private Modules`: http://www.debian.org/doc/packaging-manuals/python-policy/ch-programs.html#s-current_version_progs
.. _`Sphinx`: http://sphinx.pocoo.org/
.. _`lintian4python`: https://launchpad.net/ubuntu/+source/lintian4python
.. _`Python/Packaging`: http://wiki.debian.org/Python/Packaging
.. _`Python/LibraryStyleGuide`: http://wiki.debian.org/Python/LibraryStyleGuide
.. _`Python/AppStyleGuide`: http://wiki.debian.org/Python/AppStyleGuide
.. _`python-modules`: http://wiki.debian.org/Teams/PythonModulesTeam/
.. _`python-apps`: http://wiki.debian.org/Teams/PythonAppsPackagingTeam/
