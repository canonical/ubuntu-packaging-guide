The Ubuntu Packaging Guide
--------------------------

This guide is often one of the first things that a new Ubuntu contributor will
look at. Helping make it better can have a big impact.

It is split up into two sections:

- A list of articles based on tasks, things you want to get done.
- A set of knowledge-base articles that dig deeper into specific bits of our
  tools and workflows.

The actual articles can be found under the ``ubuntu-packaging-guide``
directory in rst files. The html template and css can be found under
``themes/ubuntu``. If adding a new article, make sure to add it to the
``ubuntu-packaging-guide/index.rst`` file so that it appears in the table of
contents.

This project is licensed under the CC-BY-SA-3.0, the full text of which can be
found in ``COPYING``. Further information can be found in ``debian/copyright``.

Contributing
------------

We welcome everyone who wants to improve the Ubuntu documentation! 
Whether you've found a typo, have a suggestion for improving existing 
content, or want to add new content, we'd love to hear from you.
 
You can find this ``git`` repository on `GitHub <https://github.com/canonical/ubuntu-packaging-guide>`_ 
and `Launchpad <https://code.launchpad.net/~ubuntu-packaging-guide-team/ubuntu-packaging-guide/+git/main>`_.

To contribute, simply choose the platform of your liking and submit a pull request with your changes, open a bug ticket to describe your issue or just ask a question:
 
* `Issues on GitHub <https://github.com/canonical/ubuntu-packaging-guide/issues>`_ 
* `Discussions on GitHub <https://github.com/canonical/ubuntu-packaging-guide/discussions>`_
* `Pull Requests on GitHub <https://github.com/canonical/ubuntu-packaging-guide/pulls>`_ 
* `Bugs on Launchpad <https://bugs.launchpad.net/ubuntu-packaging-guide>`_


We'll review your contribution as soon as possible, but please note that 
our Ubuntu maintainers often have full inboxes, so it may take some time 
before we can get to your request.

**Note:** We are currently in a transition phase from ``bazaar`` to ``git``. 
Please ignore instructions to use ``bazaar`` to contribute, or even better – 
bring such instructions to our attention, so we can fix them.


Sphinx & reStructuredText
-------------------------

The guide is built using `Sphinx <https://sphinx-doc.org/>`_. Articles should
be written in reStructuredText. The following links might be helpful:

* https://docutils.sourceforge.io/docs/user/rst/quickstart.html
* https://docutils.sourceforge.io/docs/user/rst/quickref.html


Building
--------

The power of Sphinx is that it can generate documentation in many formats.
Running ``make all`` will generate the guide in html, dirhtml, singlehtml,
pickle, json, htmlhelp, qthelp, devhelp, epub, latex, latexpdf, text, and
man formats. They will be written to the ``_build`` directory.

Not all of these formats are important to us. You can build an individual
format with, for example, ``make html``. Run ``make help`` for a list of all
targets.

Please at least test your fixes by building the html version.

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
