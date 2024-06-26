The Ubuntu Packaging Guide
--------------------------

This guide is often one of the first things that a new Ubuntu contributor will
look at. Helping make it better can have a big impact.

The actual articles can be found under the ``docs/`` directory in rst files.
Images can be placed in the ``docs/images/`` folder.

The html, js and css files can be found under ``docs/_static``. The theme used
in these docs is the "furo" theme, which has been modified to approach a more
Ubuntu-esque appearance. The 'furo documentation <https://github.com/pradyunsg/furo>'_ has instructions on how to
change most of the theme's functionality.

If adding a new article, make sure to add it to the index page for the Diataxis
section it belongs in. These indexes are in ``docs/`` and should be easy to
locate. Place the file in the corresponding sub-folder in the ``docs/``
directory, and your article should appear in both the Diataxis section page and
the navigation menu on the left-hand-side of the screen.

This project is licensed under the CC-BY-SA-3.0, the full text of which can be
found in ``COPYING``.

How to build this documentation
-------------------------------
Find the full documentation for the `Ubuntu Packaging Guide <https://canonical-ubuntu-packaging-guide.readthedocs-hosted.com/en/latest/>`_ at "Read the Docs".

To build this documentation on your own machine, first clone this
repository: ::

    git clone git@github.com:canonical/ubuntu-packaging-guide.git 

Navigate to the ``docs/`` folder, which is inside the root directory. Now
run: ::

    make install

This will install the necessary packages and other dependencies, and set up
the Python 3 virtual environment. Finally, use the ``make run`` command to
build the documentation, serve it, and watch for changes. Other options are
available and are printed to the terminal when you run ``make install``. You
can also refer to ``make help`` for a full and complete list of options.

Files are written to the ``_build`` directory.

We use the autobuild module so that any edits you make (and save) as you work
will be applied and the documentation refreshed immediately.

Contributing
------------

We welcome everyone who wants to improve the Ubuntu documentation! 
Whether you've found a typo, have a suggestion for improving existing 
content, or want to add new content, we'd love to hear from you.
 
You can find this ``git`` repository on `GitHub <https://github.com/canonical/ubuntu-packaging-guide>`_ 
and `Launchpad <https://code.launchpad.net/~ubuntu-packaging-guide-team/ubuntu-packaging-guide/+git/main>`_.

To contribute, simply choose the platform you prefer: 
 
GitHub
^^^^^^

* `Open an issue and describe your problem <https://github.com/canonical/ubuntu-packaging-guide/issues>`_
* `Ask a question or start a discussion <https://github.com/canonical/ubuntu-packaging-guide/discussions>`_
* `Open a pull request to submit your fix <https://github.com/canonical/ubuntu-packaging-guide/pulls>`_

Launchpad
^^^^^^^^^

* `Open a bug ticket <https://bugs.launchpad.net/ubuntu-packaging-guide>`_

We'll review your contribution as soon as possible, but please note that 
our Ubuntu maintainers often have full inboxes, so we may not get to your
message immediately.

**Note:** We are currently in a transition phase from ``bazaar`` to ``git``. 
If you spot any instructions to use ``bazaar`` to contribute, bringing them to
our attention so we can fix them is a great way to start contributing!

Sphinx & reStructuredText
-------------------------

The guide is built using `Sphinx <https://sphinx-doc.org/>`_. Articles should
be written in reStructuredText. The following links might be helpful:

* https://docutils.sourceforge.io/docs/user/rst/quickstart.html
* https://docutils.sourceforge.io/docs/user/rst/quickref.html

Adding a new Sphinx extension
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In general, there are two places you will need to update to add new extensions.

* ``docs/conf.py`` - add the name of the extension to the extensions config
  parameter
* ``docs/.sphinx/requirements.txt`` - add the name of the extension to the
  bottom of the list

The documentation for most Sphinx extensions will tell you what text to add
to the ``conf.py`` file. ::

  extensions = [
      'm2r2',
      'sphinx_copybutton',
      'sphinx_design',
  ]

Translating
-----------

We use Sphinx l10n module and Gettext for translating Ubuntu Packaging Guide.

Some notes about translating the guide:

- Some formatting is part of reStructuredText and should not be changed,
  including emphasis (which uses asterisks or underscores), paragraph ending
  before a code block (``::``) and double backtick quotes (``````).

- This guide uses email-style reStructuredText links. If you see a link in
  the text like::

    `Translatable link text <LinkReference_>`_

  Then replace the link text with your translations, but keep the
  LinkReference unchanged (even if it is in English). The same applies
  if URL is used instead of LinkReference.

To test your translation, use ``make BUILDER-LANGUAGE`` command (for example,
``make html-it`` will build HTML docs in Italian language).
