Launchpad
=========

Launchpad is a software collaboration and hosting platform similar to platforms
like `GitHub`_. Launchpad is also the platform where the :term:`Ubuntu` project lives.
This is one of the major differences between the Ubuntu and :term:`Debian`
infrastructure.

.. note::

    Although the Ubuntu project is probably the largest user base of Launchpad, 
    Launchpad can be used by anyone. 

Launchpad features, among others, are:

- **Bugs**: :term:`Bug Tracking System`
- **Code**: :term:`source code <Source Code>` hosting with :term:`git` or :term:`Bazaar`,
  :term:`version control <Version Control System>` and :term:`code review <Code Review>` features
- **Answers**: community support site and knowledge base
- **Translations**: collaboration platform for localizing software 
- **Blueprints**: feature planning and specification tracking
- Ubuntu :term:`package <Package>` building and hosting
- Team/Group management

While platforms like GitHub put users and groups at the top level, Launchpad
puts projects at the top level. If you take Ubuntu as an example, you can
see that you can access it at the top level: https://launchpad.net/ubuntu.
Users and groups begin with a ``~``, for instance https://launchpad.net/~techboard.

Why not use platforms like GitHub?
----------------------------------

Although Launchpad's :term:`UI` and :term:`UX` are a bit dated, Launchpad offers an
unparalleled Ubuntu package building and hosting infrastructure that
no other platform offers. Even simple requirements like building for architectures
like :term:`PowerPC`, :term:`s390x`, or :term:`RISC-V` can not be fulfilled by GitHub 
or similar platforms.

Personal Package Archive (PPA)
------------------------------

Launchpad PPAs allow you to build installable Ubuntu packages for multiple
:term:`architectures <Architecture>` and to host them in your own software
:term:`repository <Repository>`. 

Using a PPA is straightforward; you don't need the approval of anyone, therefore users 
will have to enable it manually. See how to :ref:`InstallPackagesFromPPA`.

This is useful when you want to test a change, or to show others that a change
builds successfully or is installable. Some people have special permission to
trigger the :term:`autopkgtests <autopkgtest>` for packages in a PPA.

.. tip::

    You can ask in the :term:`IRC` channel ``#ubuntu-devel`` if someone can trigger 
    autopkgtests in your PPA if you don't have the permission.

git-based workflow for the development of Ubuntu source packages
----------------------------------------------------------------

Launchpad hosts a :doc:`/reference/git-ubuntu` importer service that maintains
a view of the entire packaging version history of Ubuntu :term:`source packages <Source Package>` using
git repositories with a common branching and tagging scheme. The git-ubuntu
:term:`CLI` provides tooling and automation that understands these repositories
to make the development of Ubuntu itself easier.

You can see the web-view of these repositories when you click on the "Code" tab
of any source package on Launchpad, for example, in the
`"hello" source package <https://code.launchpad.net/ubuntu/+source/hello>`_ as
shown in the following screenshot:

.. image:: ../images/explanation/launchpad/GitUbuntuRepositoryOfTheHelloPackage.png
   :align: center
   :width: 35 em
   :alt: Screenshot of the Launchpad Code page for the hello source package with an arrow pointing to the Code tab. 

Comment markup
--------------

Unfortunately Launchpad only recognizes a very limited set of markup patterns when you write comments. 

.. note::
    
    Support for a wider range of markup patterns is a very common and old request/wish; 
    take for example LP: `#391780 <https://bugs.launchpad.net/launchpad/+bug/391780>`_.
    
    You can "upvote" (mark yourself as affected) or leave a comment on this bug report to
    show your support for the feature request.

    **Reminder:** Please stay civil! The Launchpad team has only limited resources.


The full range of patterns
`is documented in Launchpad <https://help.launchpad.net/Comments>`_. 

URIs
~~~~

Launchpad can recognize ``http``, ``https``, ``ftp``, ``sftp``, ``mailto``,
``news``, ``irc`` and ``jabber`` :term:`URIs <URI>`.

.. note::

    ``tel``, ``urn``, ``telnet``, ``ldap`` URIs, relative 
    :term:`URLs <URL>` like ``example.com`` and email addresses like 
    ``test@example.com`` are **NOT** recognized. 


Referencing Launchpad bugs
~~~~~~~~~~~~~~~~~~~~~~~~~~

Synopsis
^^^^^^^^

.. code:: text

    LP: #<LP-Bug-Number>[, #<LP-Bug-Number>]...

.. note::

    This pattern is case invariant. The amount of :term:`whitespace <Whitespace>` can be 
    variable, but if you place whitespace anywhere else the 
    :term:`regular expression <Regular Expression>` might not parse the input
    correctly. 

Examples
^^^^^^^^

.. list-table::
    :header-rows: 1

    * - Input
      - Output
    * - .. code:: text

            LP: #1
            (LP: #1)
            LP: #1, #2.
            LP:
            #1,
            #2,
            #3,
            #4
            lp: #1
            (lp: #1)
            lp: #1, #2.
            LP #1
            LP: #1 , #2
            LP: #1, #2,

            #3

      - | LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_
        | (LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_)
        | LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_, `#2 <https://bugs.launchpad.net/ubuntu/+bug/2>`_.
        | LP:
        | `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_,
        | `#2 <https://bugs.launchpad.net/ubuntu/+bug/2>`_,
        | `#3 <https://bugs.launchpad.net/ubuntu/+bug/3>`_,
        | `#4 <https://bugs.launchpad.net/ubuntu/+bug/4>`_
        | lp: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_
        | (lp: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_)
        | lp: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_, `#2 <https://bugs.launchpad.net/ubuntu/+bug/2>`_.
        | LP #1
        | LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_ , #2
        | LP: `#1 <https://bugs.launchpad.net/ubuntu/+bug/1>`_, `#2 <https://bugs.launchpad.net/ubuntu/+bug/2>`_,
        |
        | #3 

Whitespaces
~~~~~~~~~~~

Launchpad will:

- cut off any whitespace to the right,
- keep any whitespace to the left, and
- reduce any whitespace between non-whitespace characters to 
  just one (this includes new-line characters as well).

.. note::

    Technically Launchpad passes whitespace through and the browser just
    ignores the whitespace.

.. warning::

    Because of the behaviour described above you will have a hard time trying to write a table:

    .. list-table::
        :header-rows: 1

        * - Input
          - Output
        * - .. code:: text

                | Column 1   | Column 2 | Column 3    |
                |------------+----------+-------------|
                | Lorem      | ipsum    | dolor       |
                | sit        | amet     | consectetur |
                | adipiscing | elit     | sed         |

          - | \| Column 1 \| Column 2 \| Column 3 \|  
            | \|\-\-\-\-\-\-\-\-\-\-\-\-+\-\-\-\-\-\-\-\-\-\-+\-\-\-\-\-\-\-\-\-\-\-\-\-\|  
            | \| Lorem | ipsum | dolor \|  
            | \| sit \| amet \| consectetur \|  
            | \| adipiscing \| elit \| sed \|

    or long chunks of whitespace between two sections:

    .. list-table::
        :header-rows: 1

        * - Input
          - Output
        * - .. code:: text

                Here are two paragraphs with lots   
                of whitespace between them.
                
                
                
                
                But they're still just two paragraphs

          - | Here are two paragraphs with lots of whitespace between them.
            | 
            | But they're still just two paragraphs

Getting help
------------

If you need help with Launchpad you can choose any of the following methods:

IRC chatrooms
~~~~~~~~~~~~~

On the ``irc.libera.chat`` :term:`IRC` server you will find the ``#launchpad`` channel, where you
can ask the Launchpad team and the Ubuntu community for help.

Mailing lists
~~~~~~~~~~~~~

If you prefer to ask for help via email, you can write to the
`launchpad-users <https://launchpad.net/~launchpad-users>`_ 
mailing list (``launchpad-users@lists.launchpad.net``).

Ask a question
~~~~~~~~~~~~~~

As mentioned above, Launchpad has a `community FAQ feature <https://answers.launchpad.net/launchpad>`_
(called "Answers") where
you can see other people's questions or ask one yourself. Use can use the *Answers*
feature of the Launchpad project on Launchpad itself.

Report a bug
~~~~~~~~~~~~

If you encounter any bug related to Launchpad, you can submit a bug report to the
:term:`Bug Tracking System` of the Launchpad project `on Launchpad itself <https://bugs.launchpad.net/launchpad>`_.

Staging environment
-------------------

Before new features are deployed to the production environment they get
`deployed to a staging environment <https://qastaging.launchpad.net/>`_ where
the changes can get tested.

You can use the staging environment, to try out Launchpad features.

API
---

Launchpad has a web :term:`API` that you can use to interact with its services.
This makes it easy for developer communities like Ubuntu's to
automate specific workflows.

You can find the reference `documentation for the web API <https://launchpad.net/+apidoc/>`_ on Launchpad.

The Launchpad team even created an :term:`open source <Open Source Software>`
Python library, `launchpadlib <https://help.launchpad.net/API/launchpadlib>`_.

Resources
---------

- `Launchpad home page <Launchpad_>`_
- `The Launchpad software project on Launchpad itself <https://launchpad.net/launchpad>`_
    - `Launchpad bug tracker <https://bugs.launchpad.net/launchpad>`_
    - `Launchpad questions and answers <https://answers.launchpad.net/launchpad>`_
- `Launchpad wiki <https://help.launchpad.net/>`_
- `Launchpad development wiki <https://dev.launchpad.net/>`_
- `Launchpad blog <https://blog.launchpad.net/>`_
- :doc:`/reference/git-ubuntu`
