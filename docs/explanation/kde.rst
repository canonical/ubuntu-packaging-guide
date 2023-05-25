.. _kde:

=============
KDE packaging
=============

Packaging of KDE programs in Ubuntu is managed by the Kubuntu and
MOTU teams.  You can contact the Kubuntu team on the `Kubuntu mailing
list <KubuntuML_>`_ and ``#kubuntu-devel`` Libera Chat channel.  More information
about Kubuntu development is on the `Kubuntu wiki page <Wiki_>`_.

Our packaging follows the practices of the `Debian Qt/KDE Team <QtKDETeam_>`_
and Debian KDE Extras Team.  Most of our packages are derived from the
packaging of these Debian teams.

Patching policy
---------------

Kubuntu does not add patches to KDE programs unless they come from
the upstream authors or submitted upstream with the expectation they
will be merged soon or we have consulted the issue with the upstream
authors.

Kubuntu does not change the branding of packages except where upstream
expects this (such as the top left logo of the Kickoff menu) or to
simplify (such as removing splash screens).

Debian/rules
------------

Debian packages include some additions to the basic Debhelper usage.
These are kept in the ``pkg-kde-tools`` package.

Packages which use Debhelper 7 should add the ``--with=kde`` option.
This will ensure the correct build flags are used and add options such
as handling kdeinit stubs and translations::

    %:
        dh $@ --with=kde

Some newer KDE packages use the ``dhmk`` system, an alternative to
``dh`` made by the Debian Qt/KDE team.  You can read about it in
/usr/share/pkg-kde-tools/qt-kde-team/2/README.  Packages using this
will ``include
/usr/share/pkg-kde-tools/qt-kde-team/2/debian-qt-kde.mk`` instead of
running ``dh``.

Translations
------------

Packages in main have their translations imported into Launchpad and
exported from Launchpad into Ubuntu's language-packs.

So any KDE package in main must generate translation templates,
include or make available upstream translations and handle
``.desktop`` file translations.

To generate translation templates the package must include a
``Messages.sh`` file; complain to the upstream if it does not.  You
can check it works by running ``extract-messages.sh`` which should
produce one or more ``.pot`` files in ``po/``.  This will be done
automatically during build if you use the ``--with=kde`` option to
``dh``.

Upstream will usually have also put the translation ``.po`` files into
the ``po/`` directory.  If they do not, check if they are in separate
upstream language packs such as the KDE SC language packs.  If they
are in separate language packs Launchpad will need to associate
these together manually, contact `David Planella <dpm_>`_ to do this.

If a package is moved from universe to main it will need to be
re-uploaded before the translations get imported into Launchpad.

``.desktop`` files also need translations.  We patch KDELibs to read
translations out of ``.po`` files which are pointed to by a line
``X-Ubuntu-Gettext-Domain=`` added to ``.desktop`` files at package
build time.  A .pot file for each package is be generated at build
time and .po files need to be downloaded from upstream and included in
the package or in our language packs.  The list of .po files to be
downloaded from KDE's repositories is in
``/usr/lib/kubuntu-desktop-i18n/desktop-template-list``.

Library symbols
---------------

Library symbols are tracked in ``.symbols`` files to ensure none go
missing for new releases.  KDE uses C++ libraries which act a little
differently compared to C libraries.  Debian's Qt/KDE Team have
scripts to handle this. See `Working with symbols files <SymbolsFiles_>`_ for how to
create and keep these files up to date.

.. _KubuntuML: https://lists.ubuntu.com/mailman/listinfo/kubuntu-devel
.. _QtKDETeam: https://qt-kde-team.pages.debian.net
.. _dpm: https://launchpad.net/~dpm
.. _SymbolsFiles: https://qt-kde-team.pages.debian.net/symbolfiles.html
.. _Wiki: https://wiki.kubuntu.org/Kubuntu
