Ubuntu Releases
===============

Release Cadence
---------------

:term:`Ubuntu` follows a strict time-based release cycle. Every six months since
2004, :term:`Canonical` publishes a new :term:`Ubuntu` version and its set of
:term:`packages <Package>` are declared stable (production-quality). Simultaneously,
a new version begins development; it is given its own :term:`codename`, but also referred
to as the ":term:`Current Release in Development`" or ":term:`Devel`".

.. _LTSReleases:

LTS Releases
~~~~~~~~~~~~

Since 2006 every fourth release, made every two years in April, receives :ref:`LongTermSupport`
for large-scale deployments. This is the origin of the term *"LTS"* for stable, maintained releases.

An estimated 95% of all :term:`Ubuntu` installations are *LTS releases*.

.. note::
    
    Because of the strict time-based six months release cycle, you will only
    see *LTS releases* in even-numbered years (e.g. ``18``,
    ``20``, ``22``) in April (``04``).
    
    The only exception to this rule was *Ubuntu 6.06 LTS (Dapper Drake)*.

.. _PointReleases:

Point Releases
~~~~~~~~~~~~~~

To ensure that a fresh install of an :ref:`LTS Release <LTSReleases>` will work on
newer hardware and not require a big download of additional updates, :term:`Canonical`
publishes *point releases* that include all the updates made so far.

The first *point release* of an :ref:`LTS Release <LTSReleases>` is published three
months after the initial release and repeated every six months at least until the
next :ref:`LTS Release <LTSReleases>` is published. In practice, :term:`Canonical`
publishes even more *point releases* for a :ref:`LTS <LTSReleases>` :term:`Series`,
depending on the usage of that :ref:`LTS <LTSReleases>` :term:`Series`.

For example, the *Ubuntu 16.04.7 LTS (Xenial Xerus)* *point release* was published more
than four years after the initial release of *Ubuntu 16.04 LTS (Xenial Xerus)*.

.. _InterimReleases:

Interim Releases
~~~~~~~~~~~~~~~~

Every other release, between :ref:`LTSReleases`, is an *"interim release"* that is
also often called a *"regular release"*.

Many developers use *interim releases* because they provide newer compilers or access
to newer :term:`Kernels <Kernel>` and newer libraries, and they are often used inside
rapid devops processes like :term:`CI`/:term:`CD` pipelines where the lifespan of an
artefact is likely to be less than the support period of the *interim release*.

Why does Ubuntu use time-based releases?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:term:`Ubuntu` releases represent an aggregation of the work of thousands of independent
software projects. The time-based release process provides users with the best
balance of the latest software, tight integration, and excellent overall quality. 

Ubuntu version format
---------------------

.. code:: text

    YY.MM[.POINT-RELEASE] [LTS]

:term:`Ubuntu` version identifier as used for :term:`Ubuntu` releases consist of
four components, these are:

``YY``
    The 2-digit year number of the initial release.

``MM``
    The 2-digit months number of the initial release.

    .. note::
        
        Because of the strict time-based six months release cycle, you will only
        see releases in April (``04``) and October (``10``).
        
        The only exception to this rule was *Ubuntu 6.06 LTS (Dapper Drake)*.

``POINT-RELEASE``
    The :ref:`point release <PointReleases>` number starting at ``1`` and
    incrementing with every additional :ref:`point release <PointReleases>`. 
    
    This component is omitted for the initial release, in which case zero can be assumed. 

``LTS``
    Any :term:`Ubuntu` release that receives :ref:`LongTermSupport` will be marked with ``LTS``
    (see the section :ref:`UbuntuReleaseLifespan` for more information).

    Any :term:`Ubuntu` release that does not receive :ref:`LongTermSupport` omits this component.

Examples
~~~~~~~~

.. list-table::
    :header-rows: 1

    * - Version Identifier
      - Release Date
      - Support
      - End of Standard Support
      - End of Life
    * - ``22.04 LTS``
      - 21. April 2022
      - :ref:`LongTermSupport`
      - April 2027
      - April 2032
    * - ``22.04.1 LTS``
      - 11. August 2022
      - :ref:`LongTermSupport`
      - April 2027
      - April 2032
    * - ``22.10``
      - 22. October 2022
      - :ref:`RegularSupport`
      - July 2023
      - July 2023
    * - ``22.04.2 LTS``
      - 13. February 2023
      - :ref:`LongTermSupport`
      - April 2027
      - April 2032
    * - ``23.04``
      - 20. April 2022
      - :ref:`RegularSupport`
      - January 2024 
      - January 2024 

.. _UbuntuReleaseLifespan:

Release Lifespan
----------------

Every :term:`Ubuntu` :term:`Series` receives the same production-grade support quality,
but the length of the period in which an :term:`Ubuntu` :term:`Series` receives support
differs drastically.

.. _RegularSupport:

Regular Support
~~~~~~~~~~~~~~~

:ref:`InterimReleases` are production-quality releases and are supported for nine months,
with sufficient time provided for users to update, but these releases do not receive
the long-term commitment of :ref:`LTSReleases`.

.. _LongTermSupport:

Long Term Support (LTS)
~~~~~~~~~~~~~~~~~~~~~~~

:ref:`LTSReleases` receive five years of standard security maintenance for all
:term:`Packages <Package>` in the :term:`Main` :term:`Component`.

With an :term:`Ubuntu Pro` subscription, you get access to :term:`Expanded Security Maintenance`
(:term:`ESM`), covering security fixes for :term:`Packages <Package>` in the :term:`Universe`
:term:`Component`. Additionally, :term:`ESM` extends the lifetime of an :ref:`LTS <LTSReleases>`
:term:`Series` from five years to ten years.

Editions
--------

Every :term:`Ubuntu` release is provided as a :term:`Server <Ubuntu Server>` and
:term:`Desktop <Ubuntu Desktop>` edition.

:term:`Ubuntu Desktop` is designed for end-users and provides a graphical :term:`User Interface`
(:term:`GUI`) for everyday computing tasks, making it suitable for personal computers
and laptops. :term:`Ubuntu Server`, on the other hand, is a command-line-based
:term:`Operating System` optimized for server environments, lacking a :term:`GUI`
and focusing on server-related services and applications, making it ideal for hosting
web services, databases, and other server functions.

Additionally, each release of :term:`Ubuntu` is available in minimal configurations,
which have the fewest possible :term:`Packages <Package>` installed: available in the
installer for :term:`Ubuntu Server`, :term:`Ubuntu Desktop` and as separate cloud images.

:term:`Canonical` publishes :term:`Ubuntu` on all major public clouds, and the latest
:term:`image` for each :ref:`LTS <LTSReleases>` version will always include security updates
rolled up to at most two weeks ago.

Ubuntu flavours
---------------

*Ubuntu flavours* are :term:`Distributions <Distribution>` of the default :term:`Ubuntu`
releases, which choose their own default applications and settings. *Ubuntu flavours* are
owned and developed by members of the :term:`Ubuntu` community and backed by the full
:term:`Ubuntu Archive` for :term:`Packages <Package>` and updates.

Officially recognised flavours are:

- `Edubuntu`_
- `Kubuntu`_
- `Lubuntu`_
- `Ubuntu Budgie`_
- `Ubuntu Cinnamon`_
- `Ubuntu Kylin`_
- `Ubuntu MATE`_
- `Ubuntu Studio`_
- `Ubuntu Unity`_
- `Xubuntu`_

In addition to the officially recognised flavours, dozens of other :term:`Linux` 
:term:`Distributions <Distribution>` take :term:`Ubuntu` as a base for their own
distinctive ideas and approaches.

Resources
---------

- `The Ubuntu lifecycle and release cadence <https://ubuntu.com/about/release-cycle>`_
- `Ubuntu Wiki -- List of releases <https://wiki.ubuntu.com/Releases>`_
- `Ubuntu flavours <https://ubuntu.com/desktop/flavours>`_
- `Ubuntu Wiki -- Ubuntu Flavors <https://wiki.ubuntu.com/UbuntuFlavors>`_
- `Ubuntu Wiki -- Time based Releases <https://wiki.ubuntu.com/TimeBasedReleases>`_
- `Mark Shuttleworth' Blog -- The Art of Release <https://www.markshuttleworth.com/archives/146>`_
- `Ubuntu Wiki -- Point Release Process <https://wiki.ubuntu.com/PointReleaseProcess>`_
- `Ubuntu Wiki -- End of Life Process <https://wiki.ubuntu.com/EndOfLifeProcess>`_
- `Ubuntu releases <https://releases.ubuntu.com/>`_