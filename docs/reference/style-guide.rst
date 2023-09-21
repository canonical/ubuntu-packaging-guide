Ubuntu Package Guide -- Style Guide
===================================

.. note::

    This Style Guide is based on `Canonical' reStructuredText style guide`_.

All documentation files should use `reStructuredText`_ (reST) syntax. Community
contributions in `markdown`_ are welcome, but they should be reformated to reST, before
they are merged into the main branch 

For general style conventions, see the `Canonical Documentation Style Guide`_.

Headings
--------

.. grid:: 2
    
    .. grid-item::

        .. code:: reStructuredText

            Title
            =====

    .. grid-item::
        :child-align: center

        Page title and ``<h1>`` heading

    .. grid-item::

        .. code:: reStructuredText

            Heading
            -------   
            
    .. grid-item::
        :child-align: center

        ``<h2>`` heading
    
    .. grid-item::

        .. code:: reStructuredText

            Heading
            ~~~~~~~   
            
    .. grid-item::
        :child-align: center

        ``<h3>`` heading

    .. grid-item::

        .. code:: reStructuredText

            Heading
            ^^^^^^^
            
    .. grid-item::
        :child-align: center

        ``<h4>`` heading        

    .. grid-item::

        .. code:: reStructuredText

            Heading
            .......   
            

    .. grid-item::
        :child-align: center

        ``<h5>`` heading

Underlines must be the same length as the title or heading.

Adhere to the following conventions:

- Do not use consecutive headings without intervening text.
- Be consistent with the characters you use for each level. Use the ones specified above.
- Do not skip levels (for example, do not follow an H2 heading with an H4 heading).
- Use sentence style for headings (capitalise only the first word).

.. _Canonical' reStructuredText style guide: https://canonical-documentation-with-sphinx-and-readthedocscom.readthedocs-hosted.com/style-guide/
.. _reStructuredText: https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html
.. _markdown: https://www.sphinx-doc.org/en/master/usage/markdown.html
.. _Canonical Documentation Style Guide: https://docs.ubuntu.com/styleguide/en