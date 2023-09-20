Ubuntu Package Archive
======================

:term:`Linux` :term:`Distributions <Distribution>` like :term:`Ubuntu` use :ref:`Repositories`
to hold :term:`Packages <Package>` you can install on target machines. :term:`Ubuntu`
has several :ref:`Repositories` that anyone can access. The *Ubuntu Package Archive* 
hosts :term:`Debian` :term:`Binary Packages <Binary Package>` (``.deb`` files) and
:term:`Source Packages <Source Package>` (``.dsc`` files). On :term:`Ubuntu` installations,
the *Ubuntu Package Archive* is configured as the default source for the :term:`APT`
:term:`Package Manager` to download and install :term:`Packages <Package>` from.

.. note::

    Some of the following terminologies have only loose or no formal definitions.
    Also, be aware that the terminology surrounding the *Ubuntu Package Archive*
    gets mixed up in day-to-day communications. This can be confusing, but the
    meaning is usually evident from the surrounding context once you are familiar
    with the following terminologies.

.. _Repositories:

Repositories
------------

In the context of :term:`Package` management, *repositories* are servers
containing sets of :term:`Packages <Package>` that a :term:`Package Manager`
can download and install.

This term refers to the *Ubuntu Package Archive* as a whole or just 
:ref:`Suites <ArchiveSuite>`, :ref:`ArchivePockets`, or :ref:`ArchiveComponents`.

.. _ArchiveSeries:

Series
------

A *series* refers to the :term:`Packages <Package>` that target a specific :term:`Ubuntu`
version. A *series* is usually referred to by its :term:`Codename`.

Example *series'* are: ``mantic``, ``lunar``, ``jammy``, ``focal``, ``bionic``, ``xenial``, ``trusty``.

.. note::

    In practice, the terms *"Ubuntu series"* and *"Ubuntu release"* are often used
    synonymously or are mistaken for each other. There is technically a tiny difference;
    for example, an LTS version usually has an initial release (e.g. 22.04 LTS) and
    multiple point releases (e.g. 22.04.1 LTS, 22.04.2 LTS), which are all part of the
    same *series* (e.g. ``jammy``).

.. _ArchivePockets:

Pockets
-------

*Pockets* are :term:`Package` sub-repositories within the *Ubuntu Package Archive*.
Every :term:`Ubuntu` :ref:`ArchiveSeries` has the following *pockets*:

.. _ArchivePockets_Release:

release
~~~~~~~

This *pocket* contains the :term:`Packages <Package>` that an :term:`Ubuntu`
:ref:`ArchiveSeries` was initially released with. After the initial release of an
:term:`Ubuntu` :ref:`ArchiveSeries`, the :term:`Packages <Package>` in this *pocket*
are not updated (not even for security-related fixes).

.. _ArchivePockets_Security:

security
~~~~~~~~

This *pocket* contains security-related updates to :term:`Packages <Package>` in the
:ref:`ArchivePockets_Release` *pocket*.

.. _ArchivePockets_Updates:

updates
~~~~~~~

This *pocket* contains non-security-related updates to :term:`Packages <Package>` in the
:ref:`ArchivePockets_Release` *pocket*.

.. _ArchivePockets_Proposed:

proposed
~~~~~~~~

This *pocket* is a :term:`Staging Environment` the :term:`Ubuntu` community can
opt in to verify the stability of any updates before they get deployed to a broader
range of consumers.

| After the initial release of an :term:`Ubuntu` :ref:`ArchiveSeries`, this
  *pocket* contains non-security-related updates to :term:`Packages <Package>`
  in the :ref:`ArchivePockets_Release` *pocket* before they get uploaded to the
  :ref:`ArchivePockets_Updates` *pocket*.
| Before the initial release of an :term:`Ubuntu` :ref:`ArchiveSeries`, this
  *pocket* contains non-security-related updates to :term:`Packages <Package>`
  in the :ref:`ArchivePockets_Release` *pocket* before they get uploaded to the
  :ref:`ArchivePockets_Release` *pocket*.

.. _ArchivePockets_Backports:

backports
~~~~~~~~~

This *pocket* contains :term:`Packages <Package>` the :term:`Ubuntu` :ref:`ArchiveSeries`
was initially **NOT** released with.

The article :doc:`/explanation/backports` provides more information on backporting software.

.. important::

    The *backports pocket* does not come with any security support guarantee.
    The :term:`Ubuntu` Security Team does not update :term:`Packages <Package>`
    in the *backports pocket*. The :term:`Ubuntu` community is responsible for
    maintaining packages in backports with later patches for bug fixes and
    security updates.

.. _ArchiveSuite:

Suite
-----

A combination of a :ref:`ArchiveSeries` and a :ref:`ArchivePockets`. For example:

+---------------------+----------------------+---------------------------------+
| *Suite*             | :ref:`ArchiveSeries` | :ref:`Pocket <ArchivePockets>`  |
+---------------------+----------------------+---------------------------------+
| ``jammy``           | ``jammy``            | :ref:`ArchivePockets_Release`   |
+---------------------+----------------------+---------------------------------+
| ``jammy-security``  | ``jammy``            | :ref:`ArchivePockets_Security`  |
+---------------------+----------------------+---------------------------------+
| ``jammy-updates``   | ``jammy``            | :ref:`ArchivePockets_Updates`   |
+---------------------+----------------------+---------------------------------+
| ``jammy-proposed``  | ``jammy``            | :ref:`ArchivePockets_Proposed`  |
+---------------------+----------------------+---------------------------------+
| ``jammy-backports`` | ``jammy``            | :ref:`ArchivePockets_Backports` |
+---------------------+----------------------+---------------------------------+

You can see all active suites here: http://archive.ubuntu.com/ubuntu/dists/

.. note::

    The ``devel`` :ref:`ArchiveSeries` allways mirrors the :ref:`ArchiveSeries` with
    the :term:`Codename` of the :term:`Current Release in Development`.

.. _ArchiveComponents:

Components
----------

*Components* are logical subdivisions or namespaces of the :term:`Packages <Package>`
in a :ref:`ArchiveSuite`. The :term:`APT` :term:`Package Manager` can individually
subscribe to the *components* of a :ref:`ArchiveSuite`.

The :term:`Packages <Package>` of an :term:`Ubuntu` :ref:`ArchiveSeries` are categorized
if they are :term:`Open Source Software` and part of the Base :term:`Packages <Package>`
for a given :ref:`ArchiveSeries` and sorted into the *components* |main|, |restricted|, 
|universe|, or |multiverse|, as shown in the following table:

+----------------------------+-----------------------------------+-------------------------------------+
|                            | :term:`Open Source Software`      | :term:`Closed Source Software`      |
+----------------------------+-----------------------------------+-------------------------------------+
| **Ubuntu Base Packages**   | :ref:`ArchiveComponents_Main`     | :ref:`ArchiveComponents_Restricted` |
+----------------------------+-----------------------------------+-------------------------------------+
| **Community Packages**     | :ref:`ArchiveComponents_Universe` | :ref:`ArchiveComponents_Multiverse` |
+----------------------------+-----------------------------------+-------------------------------------+

:term:`Canonical` maintains the Base :term:`Packages <Package>` and provides security
updates. See :ref:`UbuntuReleaseLifespan` for more information about the official support
provided by :term:`Canonical`.

For example, if you look into any of the :ref:`ArchivePockets`
of the ``devel`` :ref:`ArchiveSeries` (|devel-release|_, |devel-updates|_,
|devel-security|_, |devel-proposed|_, |devel-backports|_) you
will see the four components (|main|, |restricted|, |universe|, |multiverse|)
as directories.

.. _ArchiveComponents_Main:

main
~~~~

This *component* contains :term:`Open Source <Open Source Software>` :term:`Packages <Package>`
for a given :ref:`ArchiveSeries` that are supported and maintained by :term:`Canonical`.

.. _ArchiveComponents_Restricted:

restricted
~~~~~~~~~~

This *component* contains :term:`Closed Source <Closed Source Software>` :term:`Packages <Package>`
for a given :ref:`ArchiveSeries` that are supported and maintained by :term:`Canonical`.

:term:`Packages <Package>` in this *component* are mostly proprietary drivers for devices and similar.

.. _ArchiveComponents_Universe:

universe
~~~~~~~~

This *component* contains :term:`Open Source <Open Source Software>` :term:`Packages <Package>`
for a given :ref:`ArchiveSeries` that are supported and maintained by the :term:`Ubuntu` community.

.. _ArchiveComponents_Multiverse:

multiverse
~~~~~~~~~~

This *component* contains :term:`Packages <Package>` (for a given :ref:`ArchiveSeries`) 
of :term:`Closed Source Software` or :term:`Open Source Software` restricted by copyright
or legal issues. These :term:`Packages <Package>` are maintained and supported by
the :term:`Ubuntu` community, but because of the restrictions, patching bugs or updates 
may not be possible.

.. _ArchiveMirrors:

Mirrors
-------

Every day, hundreds of thousands of people want to download & install :term:`Packages <Package>`
from the *Ubuntu Package Archive*. To provide a decent :term:`User Experience`, the
content of ``http://archive.ubuntu.com/ubuntu`` gets mirrored (replicated and kept
in sync) by other servers to distribute network traffic, reduce latency, and provide
redundancy, ensuring high availability and fault tolerance.

You can find a complete list of officially recognized *Ubuntu Package Archive Mirrors*
`here <https://launchpad.net/ubuntu/+archivemirrors>`_.

.. note::

    There also exist mirrors for the Ubuntu :term:`ISO` images (also called *"CD images"*,
    because :term:`ISO` images which can be downloaded and burned to a CD to make
    installation disks.)

    You can find a complete list of officially recognized *Ubuntu CD Mirrors*
    `here <https://launchpad.net/ubuntu/+cdmirrors>`_.
    

Country Mirrors
~~~~~~~~~~~~~~~

*Ubuntu Package Archive Mirrors* that provide a very reliable service in a country
can request to be the official *Country Mirror* for that country. :term:`Ubuntu`
installations are configured by default to use the *Country Mirror* for their selected country.

*Country Mirrors* are accessible via the domain name format:
  
.. code:: text

    <country-code>.archive.ubuntu.com

You can see which mirror is the *Country Mirror* by doing a simple :term:`DNS` lookup. For example:

.. tab-set::

    .. tab-item:: Finland (FI)

        .. code:: bash

            dig fi.archive.ubuntu.com +noall +answer

        .. code:: text

            fi.archive.ubuntu.com.	332	IN	CNAME	mirrors.nic.funet.fi.
            mirrors.nic.funet.fi.	332	IN	A	193.166.3.5

        Therefore ``mirrors.nic.funet.fi`` is finlands *Country Mirror*.

    .. tab-item:: Tunisia (TN)

        Tunisia does not have any third-party mirrors in its country. Therefore the
        Tunisia *Country Mirror* is just the main *Ubuntu Package Archive* server
        (``archive.ubuntu.com``).

        .. code:: bash

            dig tn.archive.ubuntu.com +noall +answer

        .. code:: text

            tn.archive.ubuntu.com.	60	IN	A	185.125.190.36
            tn.archive.ubuntu.com.	60	IN	A	91.189.91.83
            tn.archive.ubuntu.com.	60	IN	A	91.189.91.82
            tn.archive.ubuntu.com.	60	IN	A	185.125.190.39
            tn.archive.ubuntu.com.	60	IN	A	91.189.91.81

        which are just the ``archive.ubuntu.com`` IP addresses:

        .. code:: bash

            dig archive.ubuntu.com +noall +answer

        .. code:: text

            archive.ubuntu.com.	1	IN	A	185.125.190.39
            archive.ubuntu.com.	1	IN	A	185.125.190.36
            archive.ubuntu.com.	1	IN	A	91.189.91.83
            archive.ubuntu.com.	1	IN	A	91.189.91.81
            archive.ubuntu.com.	1	IN	A	91.189.91.82

Package Uploads
---------------

:term:`Ubuntu` encourages contributions from any person in the wider community.
However, direct uploading to the *Ubuntu Package Archive* is restricted. These
general contributions need to be reviewed and uploaded by a :term:`Sponsor`.

See the article :doc:`/explanation/sponsoring` that explains this process in more detail.

Resources
---------

- `Ubuntu Release Cycle <https://ubuntu.com/about/release-cycle>`_
- `Ubuntu Blog -- Ubuntu updates, releases and repositories explained <https://ubuntu.com/blog/ubuntu-updates-releases-and-repositories-explained>`_
- `Ubuntu Server Docs -- Package Management <https://ubuntu.com/server/docs/package-management>`_
- `Ubuntu Wiki -- Mirrors <https://wiki.ubuntu.com/Mirrors>`_

- `Ubuntu Help -- Repositories <https://help.ubuntu.com/community/Repositories>`_
- `Ubuntu Help -- Repositories/Ubuntu <https://help.ubuntu.com/community/Repositories/Ubuntu>`_

Landscape Repositories
~~~~~~~~~~~~~~~~~~~~~~

Landscape is a management and administration tool for :term:`Ubuntu`.
See more information `here <https://ubuntu.com/landscape>`_.

Landscape allows you to mirror :term:`APT` :ref:`Repositories` like the
*Ubuntu Package Archive*. Although it is not directly related to the
*Ubuntu Package Archive* it can be educational to understand how
:term:`APT` :ref:`Repositories` work in general.

.. |main| replace:: :ref:`ArchiveComponents_Main`
.. |restricted| replace:: :ref:`ArchiveComponents_Restricted`
.. |universe| replace:: :ref:`ArchiveComponents_Universe`
.. |multiverse| replace:: :ref:`ArchiveComponents_Multiverse`

.. _devel-release: http://archive.ubuntu.com/ubuntu/dists/devel/
.. |devel-release| replace:: ``devel-release``
.. _devel-updates: http://archive.ubuntu.com/ubuntu/dists/devel-updates/
.. |devel-updates| replace:: ``devel-updates``
.. _devel-security: http://archive.ubuntu.com/ubuntu/dists/devel-security/
.. |devel-security| replace:: ``devel-security``
.. _devel-proposed: http://archive.ubuntu.com/ubuntu/dists/devel-proposed/
.. |devel-proposed| replace:: ``devel-proposed``
.. _devel-backports: http://archive.ubuntu.com/ubuntu/dists/devel-backports/
.. |devel-backports| replace:: ``devel-backports``
