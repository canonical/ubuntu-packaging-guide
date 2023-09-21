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

Inline formatting
-----------------

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - ``*Italic*``
     - *Italic*
   * - ``**Bold**``
     - **Bold**
   * - ````code````
     - ``code``
   * - ``:term:`Ubuntu```
     - :term:`Ubuntu`
   * - ``:file:`/file/path```
     - :file:`/file/path`
   * - ``:manpage:`man(1)```
     - :manpage:`man(1)`
   * - ``:command:`command```
     - :command:`command`
   * - ``:kbd:`key```
     - :kbd:`key`

Adhere to the following conventions:

- Use italics sparingly. Common uses for italics are titles and names (for example,
  when referring to a section title that you cannot link to, or when introducing
  the name for a concept).
- Use bold sparingly. Avoid using bold for emphasis and rather rewrite the sentence
  to get your point across.


Notes
-----

.. grid:: 2
    :gutter: 2
    
    .. grid-item::
        :child-align: center

        .. code:: reStructuredText

            .. note::
                A note.

    .. grid-item-card::

            .. note::
                A note.

    .. grid-item::
        :child-align: center

        .. code:: reStructuredText

            .. tip::
                A tip.

    .. grid-item-card::

            .. tip::
                A tip. 
    
    .. grid-item::
        :child-align: center

        .. code:: reStructuredText

            .. important::
                Important information.

    .. grid-item-card::

            .. important::
                Important information. 
    
    .. grid-item::
        :child-align: center

        .. code:: reStructuredText

            .. caution::
                This might damage your hardware!

    .. grid-item-card::

            .. caution::
                This might damage your hardware!

Adhere to the following conventions:

- Use notes sparingly.
- Only use the following note types: ``note``, ``tip``, ``important``, ``caution``
- Only use a caution if there is a clear hazard of hardware damage or data loss.

Code blocks
-----------

To start a code block, start a code block with ``.. code::``.
The code block must be surrounded by empty lines.

When starting a code block, you can specify the code language to enforce a specific
sytax highlighting, but in many cases, the default sytax highlighting works just fine.

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code:: reStructuredText
       
            .. code::
       
                echo "Hello, World!"
     - .. code::
       
           echo "Hello, World!"
   * - .. code:: reStructuredText

            .. code:: text
       
                echo "Hello, World!"
     - .. code:: text
       
           echo "Hello, World!"
   * - .. code:: reStructuredText

            .. code:: bash
       
                echo "Hello, World!"
     - .. code:: bash
       
           echo "Hello, World!"

Fore the sake of consistency, please **do not** use the pattern:

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code:: reStructuredText
       
            Look, after this text starts a code block::
       
                echo "Hello, World!"
     - Look, after this text starts a code block::
       
           echo "Hello, World!"

Instead you can do this:

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code:: reStructuredText
       
            Look, after this text starts a code block:

            .. code::
       
                echo "Hello, World!"
     - Look, after this text starts a code block:

       .. code::
       
           echo "Hello, World!"

Definition lists
----------------

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code:: reStructuredText

            Term 1:
                Definition

            Term 2:
                Definition
     - Term 1:
           Definition
       
       Term 2:
           Definition

Cards
-----

.. grid:: 2
    
    .. grid-item::
        :child-align: center

        .. code:: reStructuredText

            .. card:: Card title
                Card content

    .. grid-item::
        :child-align: center

        .. card:: Card title
            
            Card content

Tabs
----

.. list-table::
   :header-rows: 1

   * - Input
     - Output
   * - .. code:: reStructuredText

           .. tab-set::
    
               .. tab-item:: Label1
                   :sync: key1
       
                   Content 1
       
               .. tab-item:: Label2
                   :sync: key2
       
                    Content 2
       
           .. tab-set::
       
               .. tab-item:: Label1
                   :sync: key1
       
                   Content 1
       
               .. tab-item:: Label2
                   :sync: key2
       
                   Content 2
     - .. tab-set::

           .. tab-item:: Label1
               :sync: key1
   
               Content 1
   
           .. tab-item:: Label2
               :sync: key2
   
               Content 2
   
       .. tab-set::
   
           .. tab-item:: Label1
               :sync: key1
   
               Content 1
   
           .. tab-item:: Label2
               :sync: key2
   
               Content 2

.. _Canonical' reStructuredText style guide: https://canonical-documentation-with-sphinx-and-readthedocscom.readthedocs-hosted.com/style-guide/
.. _reStructuredText: https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html
.. _markdown: https://www.sphinx-doc.org/en/master/usage/markdown.html
.. _Canonical Documentation Style Guide: https://docs.ubuntu.com/styleguide/en