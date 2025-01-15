Writing patch files
===================

Patches can come in many forms, including but not limited to:

* Upstream features or bugfixes not present in the current release.
* Ubuntu-specific changes, such as custom defaults and theming.
* CVE fixes and other security-related updates.

It is important to treat patches with care, and ensure the format and headers
follow best practices. In Ubuntu, we try to follow `DEP-3 <https://dep-team.pages.debian.net/deps/dep3/>`_,
which details a standard format for patch headers.

When you should (not) rewrite a patch header to follow DEP-3
------------------------------------------------------------

You **should** rewrite a patch header to follow DEP-3 if:

* You are introducing a new patch altogether.
* You are making substantive modifications to an existing patch.
* More information is known about the patch, and a DEP-3 header would contain
  updated information.

You **should not** rewrite a patch header to follow DEP-3 if:

* You are preparing a non-Microexception Release Stable Release Update and
  changing the patch header is not directly related to the bug being fixed.
* You intend on keeping only the modifications to the header as part of the
  Ubuntu delta without making substantive changes to the diff contents, and
  have no plans to forward it to Debian.
* The team claiming responsibility for this package in Ubuntu explicitly
  disagrees with the usage of DEP-3 headers. (This should be brought up on the
  ubuntu-devel mailing list.)

Prerequisites
-------------

No additional prerequisites in terms of packages to install compared to
existing development dependencies.

You should, however, write the following to :file:`~/.quiltrc`:

.. code-block:: bash

    for where in ./ ../ ../../ ../../../ ../../../../ ../../../../../; do
        if [ -e ${where}debian/rules -a -d ${where}debian/patches ]; then
            export QUILT_PATCHES=debian/patches
            break
        fi
    done

    export QUILT_PUSH_ARGS="--color=auto"
    export QUILT_DIFF_ARGS="--no-timestamps --no-index -p ab --color=auto"
    export QUILT_REFRESH_ARGS="--no-timestamps --no-index -p ab"
    export QUILT_DIFF_OPTS='-p'

Making a New Patch From Scratch
---------------------------------

Assuming you are in the same directory that contains :file:`debian/`, the
first step is to determine whether the source package in question is *native*
or *quilt*. You can find this information in the :file:`debian/source/format`
file.

If the format is *native*, you can disregard the following instructions and
simply write your changes to the files. There is no need to explicitly create
and track a patch for native packages.

For *quilt* packages, naturally, you use :manpage:`quilt(1)`. To create a new
patch, simply run:

.. code-block:: bash

    quilt new <PATCH_NAME>.<EXTENSION>

It is best practice to read the existing filenames in :file:`debian/patches`
and ensure your new patch name is consistent with the existing ones.

After that, you can edit a specific file and add it to the patch at the same
time by running:

.. code-block:: bash

    quilt edit path/to/my/file.cpp

Alternatively, you can run this to add your file to the patch without
immediately opening an editor:

.. code-block:: bash

    quilt add path/to/my/file.cpp

Once you have made your changes, you can run the following command to "commit"
them to the patch:

.. code-block:: bash

    quilt refresh

And, while the patch is still applied, run this to get a DEP-3 boilerplate:

.. code-block:: bash

    quilt header --dep3 -e

Working with the Quilt stack
----------------------------

Quilt patches are applied from top to bottom in the order they are listed in
:file:`debian/patches/series`, excluding lines starting with `#`.

To get the current patch name at the top of the stack:

.. code-block:: bash

    quilt top

Apply the next patch to the stack:

.. code-block:: bash

    quilt push [-a] [-f]

.. note::

    If the patch fails to apply, you will need to run `quilt push` with `-f`,
    solve the diff application errors, and run `quilt refresh`.

Unapply the top patch:

.. code-block:: bash

    quilt pop [-a] [-f]

To refresh all patches in one loop, you can run this:

.. code-block:: bash

    while quilt push; do quilt refresh; done

Resources
---------

* `DEP-3 <https://dep-team.pages.debian.net/deps/dep3/>`_
* `How to use quilt to manage patches in Debian packages by Raphaël Hertzog <https://raphaelhertzog.com/2012/08/08/how-to-use-quilt-to-manage-patches-in-debian-packages/>`_
* `Debian Policy 4.3. Changes to the upstream sources <https://www.debian.org/doc/debian-policy/ch-source.html#changes-to-the-upstream-sources>`_
* `Debian Policy 4.13. Embedded code copies <https://www.debian.org/doc/debian-policy/ch-source.html#embedded-code-copies>`_
* `Debian Policy 4.17. Vendor-specific patch series <https://www.debian.org/doc/debian-policy/ch-source.html#vendor-specific-patch-series>`_
* `Debian Policy Appendix 7. Diversions - overriding a package’s version of a file (from old Packaging Manual) <https://www.debian.org/doc/debian-policy/ap-pkg-diversions.html>`_
