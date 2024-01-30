Launchpad text markup
=====================

Any `textarea <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea>`_
input field on Launchpad will process the entered text to recognise certain patterns
to enhance the resulting displayed output.

Examples of textareas where the Launchpad text markup is accepted are:

.. grid:: 1 2 2 2
    :gutter: 1

    .. grid-item-card::

        .. image:: /images/reference/launchpad-comments/ReportABug.png
            :align: center
            :width: 100%
            :alt: Screenshot of an example Launchpad "Report a bug" page where "You can write Launchpad text markup here." is written in the textarea input field "Further Information".

        +++

        Bug reporting

    .. grid-item-card::

        .. image:: /images/reference/launchpad-comments/Bug.png
            :align: center
            :width: 100%
            :alt: Screenshot of an example Launchpad bug page where the description is currently beeing edited and "You can write Launchpad text markup here." is written in the textarea input fields "Bug Description" and "Add comment". 

        +++

        Bug report descriptions and comments

    .. grid-item-card::

        .. image:: /images/reference/launchpad-comments/ProposeBranchForMerging.png
            :align: center
            :width: 100%
            :alt: Screenshot of an example Launchpad "Propose for merging" page where "You can write Launchpad text markup here." is written in the textarea input field "Description of the change".

        +++

        Merge proposal creation

    .. grid-item-card::

        .. image:: /images/reference/launchpad-comments/EditMergeRequestComment.png
            :align: center
            :width: 100%
            :alt: Screenshot of an example Launchpad merge proposal page where the first comment is beeing edited and the textarea input field contains the text "You can write Launchpad text markup here.".

        +++

        Comment for a Merge proposal

    .. grid-item-card::

        .. image:: /images/reference/launchpad-comments/EditProfileDescription.png
            :align: center
            :width: 100%
            :alt: Screenshot of an example Launchpad Profile page where the description is beeing edited and the textarea input field contains the text "You can write Launchpad text markup here.".

        +++
        
        Profile description

    .. grid-item-card::

        .. image:: /images/reference/launchpad-comments/EditPPADescription.png
            :align: center
            :width: 100%
            :alt: Screenshot of an example Launchpad PPA page where the description is beeing edited and the textarea input field contains the text "You can write Launchpad text markup here.".

        +++
        
        :term:`PPA` description

Unlike platforms like GitHub, Launchpad unfortunately only recognises a very limited
set of markup patterns when you write comments. The most useful pattern are documented
in this article.

.. note::
    
    Support for a wider range of markup patterns is a very common and old request/wish; 
    take for example LP: `#391780 <https://bugs.launchpad.net/launchpad/+bug/391780>`_.
    
    You can "upvote" (mark yourself as affected) or leave a comment on this bug report to
    show your support for the feature request.

    **Reminder:** Please stay civil! The Launchpad team has only limited resources.

Referencing Launchpad bugs
--------------------------

It is very common to refer to a specific Launchpad bug e.g. to point other people
to a bug during a discussion.

Pattern
~~~~~~~

The following pattern is used by Launchpad to detect bug references:

.. code:: text

    LP: #<LP-Bug-Number>[, #<LP-Bug-Number>]... 

This pattern is case invariant, and the amount of blank space can be variable, but if you place blank space anywhere else, the regular expression used by Launchpad might not parse the bug reference correctly.

.. note::

    This pattern is also commonly used outside of Launchpad e.g. on :term:`IRC`, in :term:`source package changelogs <Changelog>`
    or on :term:`Discourse`.

Examples
~~~~~~~~

The following table shows examples how text entered into a text input field will
be displayed on Launchpad:

.. list-table::
    :header-rows: 1

    * - Input
      - Result
      - Comment
    * - .. code:: text

            LP: #1

      - LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_
      - references Launchpad bug with the number 1
    * - .. code:: text

            (LP: #1)

      - (LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_)
      - a bug reference can be surrounded by brackets
    * - .. code:: text

            LP: #1, #2.

      - LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_, `#2 <https://bugs.launchpad.net/ubuntu/+bug/2>`_.
      - | there can be multiple bug references
        | separated by a ``,``
    * - .. code:: text

            LP:
            #1,
            #2,
            #3,
            #4

      - | LP:
        | `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_,
        | `#2 <https://bugs.launchpad.net/ubuntu/+bug/2>`_,
        | `#3 <https://bugs.launchpad.net/ubuntu/+bug/3>`_,
        | `#4 <https://bugs.launchpad.net/ubuntu/+bug/4>`_
      - | the amount of :term:`blank space <Blank space>` can be variable and
        | a new-line will not disrupt this pattern
    * - .. code:: text

            lp: #1

      - lp: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_
      - the pattern is case invariant
    * - .. code:: text

            (lp: #1)

      - (lp: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_)
      - the pattern is case invariant
    * - .. code:: text

            lp: #1, #2.

      - lp: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_, `#2 <https://bugs.launchpad.net/ubuntu/+bug/2>`_.
      - the pattern is case invariant
    * - .. code:: text

            LP #1

      - LP #1
      - the ``:`` is strictly needed
    * - .. code:: text

          LP: #1 , #2  

      - LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_ , #2
      - | if you place blank space anywhere else the
        | :term:`regular expression <Regular Expression>` might not parse the
        | input correctly
    * - .. code:: text

            LP: #1, #2,

            #3

      - | LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_, `#2 <https://bugs.launchpad.net/ubuntu/+bug/2>`_,
        |
        | #3 
      - | an empty new-line will interrupt the pattern,
        | but a trailing ``,`` will not

Blank spaces
------------

Launchpad will:

- cut off any blank space to the right,
- keep any blank space to the left, and
- reduce any blank space between non-blank-space characters to
  just one (this includes new-line characters as well).

.. note::

    Technically Launchpad passes blank space through and the browser just
    ignores the blank space.

.. warning::

    Because of the behaviour described above you will have a hard time trying to
    write a table or long chunks of blank space between two sections.

    The following table shows examples how text entered into a text input field
    will be displayed on Launchpad:

    .. list-table::
        :header-rows: 1

        * - Input
          - Result
        * - .. code:: text

                | Column 1   | Column 2 | Column 3    |
                |------------+----------+-------------|
                | Example    | table    | text        |
                | Example    | table    | text        |
                | Example    | table    | text        |

          - | \| Column 1 \| Column 2 \| Column 3 \|  
            | \|\-\-\-\-\-\-\-\-\-\-\-\-+\-\-\-\-\-\-\-\-\-\-+\-\-\-\-\-\-\-\-\-\-\-\-\-\|  
            | \| Example | table | text \|
            | \| Example | table | text \|
            | \| Example | table | text \|
        * - .. code:: text

                Here are two paragraphs with lots   
                of blank space between them.
                
                
                
                
                But they're still just two paragraphs

          - | Here are two paragraphs with lots of blank space between them.
            | 
            | But they're still just two paragraphs

URI addresses
-------------

Launchpad can recognise ``http``, ``https``, ``ftp``, ``sftp``, ``mailto``,
``news``, ``irc`` and ``jabber`` :term:`URIs <URI>`.

.. note::

    ``tel``, ``urn``, ``telnet``, ``ldap`` :term:`URI <URI>`, relative
    :term:`URLs <URL>` like ``example.com`` and email addresses like 
    ``test@example.com`` are **NOT** recognised.

Examples
~~~~~~~~

The following examples show how text entered into a text input field will
be displayed on Launchpad:

.. list-table::

    * - Input
      - .. code:: text

          http://localhost:8086/example/sample.html

    * - Result
      - `http://localhost:8086/example/sample.html <DemoUrl_>`_
        
.. list-table::

    * - Input
      - .. code:: text

          http://localhost:8086/example/sample.html

    * - Result
      - `http://localhost:8086/example/sample.html <DemoUrl_>`_

.. list-table::

    * - Input
      - .. code:: text

            ftp://localhost:8086/example/sample.html

    * - Result
      - `ftp://localhost:8086/example/sample.html <ftp://localhost:8086/example/sample.html>`_
    
.. list-table::

    * - Input
      - .. code:: text

            sftp://localhost:8086/example/sample.html.

    * - Result
      - `sftp://localhost:8086/example/sample.html <sftp://localhost:8086/example/sample.html>`_.

.. list-table::

    * - Input
      - .. code:: text

            http://localhost:8086/example/sample.html;

    * - Result
      - `http://localhost:8086/example/sample.html <DemoUrl_>`_;

.. list-table::

    * - Input
      - .. code:: text

            news://localhost:8086/example/sample.html:

    * - Result
      - `news://localhost:8086/example/sample.html <news://localhost:8086/example/sample.html>`_:

.. list-table::

    * - Input
      - .. code:: text

            http://localhost:8086/example/sample.html?

    * - Result
      - `http://localhost:8086/example/sample.html <DemoUrl_>`_?

.. list-table::

    * - Input
      - .. code:: text

            http://localhost:8086/example/sample.html,

    * - Result
      - `http://localhost:8086/example/sample.html <DemoUrl_>`_,

.. list-table::

    * - Input
      - .. code:: text

            <http://localhost:8086/example/sample.html>

    * - Result
      - <`http://localhost:8086/example/sample.html <DemoUrl_>`_>

.. list-table::

    * - Input
      - .. code:: text

            <http://localhost:8086/example/sample.html>,

    * - Result
      - <`http://localhost:8086/example/sample.html <DemoUrl_>`_>,

.. list-table::

    * - Input
      - .. code:: text

            <http://localhost:8086/example/sample.html>.

    * - Result
      - <`http://localhost:8086/example/sample.html <DemoUrl_>`_>.

.. list-table::

    * - Input
      - .. code:: text

            <http://localhost:8086/example/sample.html>;

    * - Result
      - <`http://localhost:8086/example/sample.html <DemoUrl_>`_>;

.. list-table::

    * - Input
      - .. code:: text

            <http://localhost:8086/example/sample.html>:

    * - Result
      - <`http://localhost:8086/example/sample.html <DemoUrl_>`_>:


.. list-table::

    * - Input
      - .. code:: text

            <http://localhost:8086/example/sample.html>?

    * - Result
      - <`http://localhost:8086/example/sample.html <DemoUrl_>`_>?

.. list-table::

    * - Input
      - .. code:: text

            (http://localhost:8086/example/sample.html)

    * - Result
      - (`http://localhost:8086/example/sample.html <DemoUrl_>`_)

.. list-table::

    * - Input
      - .. code:: text

            (http://localhost:8086/example/sample.html),

    * - Result
      - (`http://localhost:8086/example/sample.html <DemoUrl_>`_),

.. list-table::

    * - Input
      - .. code:: text

            (http://localhost:8086/example/sample.html).

    * - Result
      - (`http://localhost:8086/example/sample.html <DemoUrl_>`_).

.. list-table::

    * - Input
      - .. code:: text

            (http://localhost:8086/example/sample.html);

    * - Result
      - (`http://localhost:8086/example/sample.html <DemoUrl_>`_);

.. list-table::

    * - Input
      - .. code:: text

            (http://localhost:8086/example/sample.html):

    * - Result
      - (`http://localhost:8086/example/sample.html <DemoUrl_>`_):

.. list-table::

    * - Input
      - .. code:: text

            http://localhost/example/sample.html?a=b&b=a

    * - Result
      - `http://localhost/example/sample.html?a=b&b=a <http://localhost/example/sample.html?a=b&b=a>`_

.. list-table::

    * - Input
      - .. code:: text

            http://localhost/example/sample.html?a=b&b=a.

    * - Result
      - `http://localhost/example/sample.html?a=b&b=a <http://localhost/example/sample.html?a=b&b=a>`_.

.. list-table::

    * - Input
      - .. code:: text

            http://localhost/example/sample.html?a=b&b=a,

    * - Result
      - `http://localhost/example/sample.html?a=b&b=a <http://localhost/example/sample.html?a=b&b=a>`_,

.. list-table::

    * - Input
      - .. code:: text

            http://localhost/example/sample.html?a=b&b=a;

    * - Result
      - `http://localhost/example/sample.html?a=b&b=a <http://localhost/example/sample.html?a=b&b=a>`_;

.. list-table::

    * - Input
      - .. code:: text

            http://localhost/example/sample.html?a=b&b=a:

    * - Result
      - `http://localhost/example/sample.html?a=b&b=a <http://localhost/example/sample.html?a=b&b=a>`_:

.. list-table::

    * - Input
      - .. code:: text

            http://localhost/example/sample.html?a=b&b=a:b;c@d_e%f~g#h,j!k-l+m$n*o'p

    * - Result
      - `http://localhost/example/sample.html?a=b&b=a:b;c@d_e%f~g#h,j!k-l+m$n*o'p <http://localhost/example/sample.html?a=b&b=a:b;c@d_e%f~g#h,j!k-l+m$n*o'p>`_

.. list-table::

    * - Input
      - .. code:: text

            http://www.example.com/test/example(parentheses).html

    * - Result
      - `http://www.example.com/test/example(parentheses).html <http://www.example.com/test/example(parentheses).html>`_

.. list-table::

    * - Input
      - .. code:: text

            http://www.example.com/test/example-dash.html

    * - Result
      - `http://www.example.com/test/example-dash.html <http://www.example.com/test/example-dash.html>`_

.. list-table::

    * - Input
      - .. code:: text

            http://www.example.com/test/example_underscore.html

    * - Result
      - `http://www.example.com/test/example_underscore.html <http://www.example.com/test/example_underscore.html>`_

.. list-table::

    * - Input
      - .. code:: text

            http://www.example.com/test/example.period.x.html

    * - Result
      - `http://www.example.com/test/example.period.x.html <http://www.example.com/test/example.period.x.html>`_

.. list-table::

    * - Input
      - .. code:: text

            http://www.example.com/test/example!exclamation.html

    * - Result
      - `http://www.example.com/test/example!exclamation.html <http://www.example.com/test/example!exclamation.html>`_

.. list-table::

    * - Input
      - .. code:: text

            http://www.example.com/test/example~tilde.html

    * - Result
      - `http://www.example.com/test/example~tilde.html <http://www.example.com/test/example~tilde.html>`_

.. list-table::

    * - Input
      - .. code:: text

            http://www.example.com/test/example*asterisk.html

    * - Result
      - `http://www.example.com/test/example*asterisk.html <http://www.example.com/test/example*asterisk.html>`_

.. list-table::

    * - Input
      - .. code:: text

            irc://chat.freenode.net/launchpad

    * - Result
      - `irc://chat.freenode.net/launchpad <irc://chat.freenode.net/launchpad>`_

.. list-table::

    * - Input
      - .. code:: text

            irc://chat.freenode.net/%23launchpad,isserver

    * - Result
      - `irc://chat.freenode.net/%23launchpad,isserver <irc://chat.freenode.net/%23launchpad,isserver>`_

.. list-table::

    * - Input
      - .. code:: text

            mailto:noreply@launchpad.net

    * - Result
      - `mailto:noreply@launchpad.net <mailto:noreply@launchpad.net>`_

.. list-table::

    * - Input
      - .. code:: text

            jabber:noreply@launchpad.net

    * - Result
      - `jabber:noreply@launchpad.net <jabber:noreply@launchpad.net>`_

.. list-table::

    * - Input
      - .. code:: text

            http://localhost/foo?xxx&

    * - Result
      - `http://localhost/foo?xxx& <http://localhost/foo?xxx&>`_

.. list-table::

    * - Input
      - .. code:: text

            http://localhost?testing=[square-brackets-in-query]

    * - Result
      - `http://localhost?testing=[square-brackets-in-query] <http://localhost?testing=[square-brackets-in-query]>`_

Removal of `"` 
--------------

If the entire comment is encapsulated in `"` like this Launchpad will remove the `"`.

The following table shows an example how text entered into a text input field
will be displayed on Launchpad:

.. list-table::
    :header-rows: 1

    * - Input
      - Result
    * - .. code:: text
  
            "Content"
  
      - Content

Resources
---------

- `Comments (help.launchpad.net) <https://help.launchpad.net/Comments>`_

.. _DemoUrl: http://localhost:8086/example/sample.html
