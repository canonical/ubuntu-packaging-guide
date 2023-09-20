Main Inclusion Review (MIR)
===========================

.. important::

    Do not confuse the abbreviation :term:`MIR` with the `display server <https://mir-server.io/>`_.

:term:`Packages <Package>` in :term:`Main` and :term:`Restricted` are officially
maintained, supported and recommended by the :term:`Ubuntu` project.
:term:`Canonical's <Canonical>` support services applies to these :term:`Packages <Package>`, 
which include security updates and certain :term:`SLA` grantees when bugs are reported
and technical support is requested.

Therefore, special consideration is necessary before adding new :term:`Packages <Package>`
to :term:`Main` or :term:`Restricted`. The :term:`Ubuntu` :term:`MIR Team` reviews
:term:`Packages <Package>` for promotion

- from :term:`Universe` to :term:`Main`
- or from :term:`Multiverse` to :term:`Restricted`.

This review process is called *Main Inclusion Review (MIR)*.

Apply a package for Main Inclusion Review
-----------------------------------------

The `Main Inclusion Review Documentation <MainInclusionReviewDocumentation_>`_
by the :term:`MIR Team` provides instructions how to apply a package for
:term:`Main Inclusion Review`. The documentation even contains the instructions
how the application gets reviewed by the :term:`MIR Team`.

.. note::

    The guidelines and review process is constantly evolving. Therefore you should
    re-read the `Main Inclusion Review Documentation <MainInclusionReviewDocumentation_>`_
    even if you have applied a package for :term:`Main Inclusion Review` in the past.

    The `Main Inclusion Review Documentation <MainInclusionReviewDocumentation_>`_ is
    is also a living document. External contributions, suggestions, discussions or
    questions about the process are always welcome.

MIR Team weekly Meeting
-----------------------

The :term:`MIR Team` holds weekly meetings every Tuesday at 16:30 CET on the
:term:`IRC` Server ``irc.libera.chat`` in the ``#ubuntu-meeting`` channel.
You can follow these `instructions <https://libera.chat/guides/connect>`_ on
how to connect to ``irc.libera.chat``.

The purpose of the meeting is

- to distribute the workload fairly between the members of the :term:`MIR Team`
- a timely response to reporters of :term:`MIR` applications
- detection and discussion of any current or complex cases

Due to the nature of the :term:`Main Inclusion Review` process there are times
when this meeting is very busy. Usually at the beginning of a new :term:`Ubuntu`
release not a lot is happening.


Resources
---------

- `Main Inclusion Review Documentation <MainInclusionReviewDocumentation_>`_ by the :term:`MIR Team`
    - `MIR Process Overview <https://github.com/canonical/ubuntu-mir#process-states>`_
    - `MIR Application Template <https://github.com/canonical/ubuntu-mir#main-inclusion-requirements>`_
    - `Helper Tools <https://github.com/canonical/ubuntu-mir#tools>`_
    - `Bug Lists <https://github.com/canonical/ubuntu-mir#bug-lists>`_
    - `Pull Requests <https://github.com/canonical/ubuntu-mir/pulls>`_
    - `Issues <https://github.com/canonical/ubuntu-mir/issues>`_
- :term:`MIR Team` on :term:`Launchpad`: |MainInclusionReviewTeamLaunchpadGroup|_

.. _MainInclusionReviewDocumentation: https://github.com/canonical/ubuntu-mir
.. _MainInclusionReviewTeamLaunchpadGroup: https://launchpad.net/~ubuntu-mir
.. |MainInclusionReviewTeamLaunchpadGroup| replace:: ``~ubuntu-mir`` 
