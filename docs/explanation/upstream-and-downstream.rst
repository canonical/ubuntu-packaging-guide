Upstream and downstream
=======================

An :term:`Ubuntu` installation consists of :term:`packages <Package>` - copied and unpacked onto
the target machine. The :term:`Ubuntu` project packages, distributes and maintains software of
thousands of :term:`open-source <Open Source Software>` projects for users, ready to install.
The collection of :term:`Ubuntu` :term:`packages <Package>` is derived from the collection of
:term:`packages <Package>` maintained by the community-driven :term:`Debian` project.

An important duty of an :term:`Ubuntu` :term:`Package` :term:`Maintainer` is to collaborate with
the :term:`open-source <Open Source Software>` projects the :term:`Ubuntu`:term:`packages <Package>`
are derive from. Especially with :term:`Debian` by keeping the :term:`Ubuntu` copies of
:term:`packages <Package>` up-to-date and by sharing improvements made in :term:`Ubuntu` back up
to :term:`Debian`.

Terminology
-----------

Ubuntu delta
~~~~~~~~~~~~

Ubuntu delta (noun):
    A modification to an :term:`Ubuntu` :term:`Package` that is derived from a :term:`Debian`
    :term:`Package`.

----

In the context of :term:`Open Source Software` development, the terminology of a stream that
carries modifications, improvements, and code is used. It describes the relationship and direction
of changes made between projects. This stream originates (upwards) from the original project
(and related entities like :term:`Source Code`, authors, and :term:`maintainers <Maintainer>`) and
flows downwards to projects (and associated entities) that depend on it.

.. _Upstream:

Upstream
~~~~~~~~

.. _upstream_noun:

*upstream (noun)*
    A software project (and associated entities), another software project depends on
    directly or indirectly.

    *Examples*
        - :term:`Debian` is the upstream of :term:`Ubuntu`.
        - *"Upstream is not interested in the patch."*

    *Usage note*
        - There can be many layers. For example, *Kubuntu* is a :term:`flavour <Ubuntu flavours>`
          of :term:`Ubuntu`, therefore :term:`Ubuntu` and :term:`Debian` are upstreams of
          *Kubuntu*.
        - The adjective/adverb form is much more commonly used.

.. _upstream_adjective_adverb:

*upstream (adjective, adverb)*
    Something (usually a code modification like a :term:`Patch`) that flows in the direction or is
    relative to a software project closer to the original software project.

    *Examples*
        - :term:`Debian` is the upstream project of :term:`Ubuntu`.
        - *"There is a new upstream release."*
        - *"A pull request was created upstream."*
        - *"A bug was patched upstream."*

.. _upstream_verb:

*upstream (verb)*
    Sending something (usually a :term:`Patch`) upstream that originated from a :term:`Fork` or
    project that depended on the upstream project.
    
    *Examples*
        - *"We upstreamed the patch."*
        - *"Can you upstream the bugfix?"*

.. _Downstream:

Downstream
~~~~~~~~~~

*downstream (noun)*
    Similar to :ref:`upstream_noun`: A software project(s) (and associated entities) that depend on
    another software project directly or indirectly.

    *Example*
        - :term:`Ubuntu` is a downstream of :term:`Debian` and there are many downstreams
          of :term:`Ubuntu`.

    *Usage note*
        - The :ref:`adjective/adverb form <downstream_adjective_adverb>` is much more commonly used.
        - There can be many layers. For example, *Kubuntu* is a :term:`flavour <Ubuntu flavours>`
          of :term:`Ubuntu`, therefore *Kubuntu* and :term:`Ubuntu` are downstreams of
          :term:`Debian`.

.. _downstream_adjective_adverb:

*downstream (adjective, adverb)*
    Similar to :ref:`upstream_adjective_adverb`: Something (usually a code modification like 
    a :term:`Patch`) that flows in the direction or is relative to a software project farther
    away from the original software project.

    *Examples*
        - :term:`Ubuntu` is a downstream project of :term:`Debian`.
        - *"The bug is already patched downstream."*
        - *"The bug was reported by a downstream user."*
        - *"Downstream maintainers have submitted a bugfix."*
        - *"The change may affect downstream users."*

*downstream (verb)*
    Similar to :ref:`upstream_verb`: Sending something (usually a :term:`Patch`) downstream
    that originated from an upstream project.

    *Example*
        - "We downstreamed the :term:`Patch`."

Why upstream changes?
---------------------

.. note::
    The following list does not aim for completeness. There are certainly more good arguments 
    for why changes should be upstreamed.

- **Decreased Maintenance Complexity**: Think of any :term:`Ubuntu` :term:`Package` derived from a 
  :term:`Debian` :term:`Package` that carries a :term:`delta <Ubuntu Delta>`. Every time the
  :term:`Debian` :term:`Package` gets updated, the :term:`Ubuntu` :term:`Package` may be subject
  to a :term:`Merge Conflict` when the changes to the :term:`Debian` :term:`Package` get applied to
  the :term:`Ubuntu` :term:`Package`. Upstreaming changes reduces the maintenance cost to resolve
  :term:`Merge Conflicts <Merge Conflict>` when they occur.
- **Quality Assurance & Security**: Any changes that get upstreamed will also be subject to the
  quality assurance of the upstream project and the testing coverage that the user base of the
  upstream project provides. This increases the likelihood of discovering regressions/bugs/unwanted
  behaviour (especially security-related bugs). Also, be aware that an unpatched
  :term:`security vulnerability <Common Vulnerabilities and Exposures>` in any system could lead to
  the indirect exposure of other systems.
- **Common Benefit**: By syncing the :term:`Debian` :term:`packages <Package>` into the
  :term:`Ubuntu` :term:`Package` collection, :term:`Ubuntu` benefits from the upstream maintenance
  work. In exchange, :term:`Ubuntu` :term:`maintainers <Maintainer>` upstream changes to
  :term:`Debian`. This results in a win-win situation where both parties benefit from working together.
