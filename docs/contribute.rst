Contribute to the Ubuntu Packaging Guide
****************************************

The `Ubuntu Packaging Guide <https://github.com/canonical/ubuntu-packaging-guide>`_ is an open source project that warmly welcomes
community contributions and suggestions.

This document describes how to contribute changes to the Ubuntu Packaging
Guide. If you don't already have a GitHub account, you can
`sign up on their website <https://github.com>`_.

How to contribute
=================

I want to raise an issue
------------------------

We use GitHub issues to track things that need to be fixed. If you find a
problem and want to report it to us, you can click on the "Give feedback"
button at the top of any page in the Guide, and it will open an issue for you. 

Alternatively, you can
`open an issue directly <https://github.com/canonical/ubuntu-packaging-guide/issues>`_
and describe the problem you're having, or the suggestion you want to add.

I have a question about packaging
---------------------------------

If you're stuck and have a question, you can use our GitHub discussion board to
`ask, or start a discussion <https://github.com/canonical/ubuntu-packaging-guide/discussions>`_.

Note that we may not be able to respond immediately, so please be patient!

I want to submit a fix
----------------------

If you found an issue and want to submit a fix for it, or have written a guide
you would like to add to the documentation, feel free to
`open a pull request to submit your fix <https://github.com/canonical/ubuntu-packaging-guide/pulls>`_
against our ``main`` branch. If you need help, please use the discussion board
or contact one of the repository administrators.

Contribution format for the project
===================================

Sphinx & reStructuredText
-------------------------

The Guide is built using `Sphinx <https://www.sphinx-doc.org/>`_. Articles should
be written in reStructuredText. The following links might be helpful:

* `A ReStructuredText Primer <https://docutils.sourceforge.io/docs/user/rst/quickstart.html>`_
* `Quick reStructuredText <https://docutils.sourceforge.io/docs/user/rst/quickref.html>`_

How to add a new Sphinx extension
---------------------------------

In general, there are two places you will need to update to add new extensions.

* ``docs/conf.py`` - add the name of the extension to the extensions configuration
  parameter 
* ``docs/.sphinx/requirements.txt`` - add the name of the extension to the
  bottom of the list

The documentation for most Sphinx extensions will tell you what text to add
to the ``conf.py`` file, as in this example: ::

  extensions = [
      'sphinx_copybutton',
      'sphinx_design',
  ]

Translations
------------

We use the localisation (l10n) module for Sphinx and gettext for translating
the Ubuntu Packaging Guide.

Some notes about translating the guide:

- Some formatting is part of reStructuredText and should not be changed,
  including emphasis (which uses asterisks or underscores), paragraph ending
  before a code block (``::``) and double backtick quotes (``````).

- The Guide uses email-style reStructuredText links. If you see a link in
  the text like::

    `Translatable link text <Link_Reference_>`_

  Then replace the "Translatable link text" with your translations, but keep
  the ``Link_Reference`` unchanged (even if it is in English). The same applies
  if a URL is used instead of ``Link_Reference``.

To test your translation, use ``make BUILDER-LANGUAGE`` command (for example,
``make html-it`` will build HTML docs in Italian language).
