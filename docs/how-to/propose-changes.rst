Propose changes
===============

This guide outlines the process for proposing changes to Ubuntu. The process is straightforward. If you find a problem, you obtain the code, work on a solution, test the fix, push your changes to Launchpad, and then request a review and merge.

.. attention::

    There are information placed within angle brackets in this guide. Ensure you replace them with the appropriate values. For example, replace ``<package-name>`` with the name of the package you are working on.

Find a bug to fix
-----------------

Start by identifying an issue to work on. This can be a bug you encountered while using an application, something you noticed in the bug report, or a known issue in the Ubuntu community.

You can also explore known bugs using these resources:

- `Bitesize bugs on Launchpad <https://bugs.launchpad.net/ubuntu/+bugs?field.tag=bitesize>`_: These are small, well-scoped bugs that are great for new contributors.
- `One Hundred Papercuts <https://launchpad.net/hundredpapercuts>`_: This resource focuses on fixing minor bugs that negatively affect the user experience.

Check bug reports for existing issues
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To check bug reports for existing issues, use :term:`Launchpad` and Debian’s bug tracking systems.

For Ubuntu packages, use URLs like ``https://bugs.launchpad.net/ubuntu/+source/<package-name>``. For example:
https://bugs.launchpad.net/ubuntu/+source/bumprace.

.. note::

    Replace ``<package-name>`` with the name of the package related to the issue.

Review the list of open bugs for anything that matches the issue you want to fix. Open the bug reports and read their descriptions, comments, and any attached logs or crash files. Ensure that:

- The bug is still open
- No one else is working on a fix

To check the Debian bug tracker, use URLs like ``http://bugs.debian.org/src:<package-name>``. For example:
``http://bugs.debian.org/src:bumprace``.

Evaluate the bug report
-----------------------

Once you find a bug report on Launchpad that you want to work on, the next step is to evaluate the bug.

Start by reading the bug description carefully. Look for:

- Steps to reproduce the problem
- Crash logs or terminal output
- Details about the affected version and package
- Attached ``.crash`` files or `Apport crash files <https://github.com/canonical/ubuntu-maintainers-handbook/blob/main/PackageFixing.md#evaluate-the-bug>`_

For example, this `bug report <https://bugs.launchpad.net/ubuntu/+source/postfix/+bug/1753470>`_ shows a ``segfault`` in ``postconf`` on Ubuntu 18.04. It includes logs from ``/var/log/kern.log``, shell commands that reproduce the issue, and metadata about the system environment. This information helps confirm whether the bug still affects current versions and if the report is complete.

If the bug includes a .crash file, extract and inspect the stack trace. Use the information to better understand where the failure occurs in the code.

For more details, see `Evaluate the bug <https://github.com/canonical/ubuntu-maintainers-handbook/blob/main/PackageFixing.md#evaluate-the-bug>`_.

Identify the source package
---------------------------

After selecting a bug to fix, the first step is to identify the source package that contains the code related to the issue.

Start by identifying the name of the binary package. If you know the path to the affected program, run the following command:

.. code-block:: bash

    apt-file find /path/to/executable

.. note::

    Replace ``/path/to/executable`` with the actual path.

    For example:

    .. code-block:: bash

        apt-file find /usr/games/bumprace

Running this command will return an output similar to:

.. code-block:: text

    bumprace: /usr/games/bumprace

The the preceding output, the part before the colon is the name of the binary package.

Once you've identified the name of the binary package, the next step is to find the source package. Use the following command:

.. code-block:: bash

    apt-cache showsrc <binary-package-name> | grep ^Package:

.. note::

    Replace ``<binary-package-name>`` with the actual name of the binary package.

    For example:

    .. code-block:: bash

        apt-cache showsrc bumprace | grep ^Package:

This command will return output similar to:

.. code-block:: text

    Package: bumprace

In the preceding example, the source package has the same name as the binary package. However, in some cases, the names may differ. For example, the binary package ``libgtk-3-0`` comes from the source package ``gtk+3.0``.

Check if the bug has been fixed
-------------------------------

Once you identify the source package, make sure the issue still exists. Fixes may already exist in a newer Ubuntu release, in Debian, or upstream. Checking first can save time and avoid duplicate work.

Use the following steps to confirm whether the problem has already been addressed.

Check if the bug is fixed in a newer Ubuntu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use ``rmadison`` to review the versions of the package available across Ubuntu releases.

.. code-block:: bash

    rmadison <package-name>

This shows you which versions are available in different Ubuntu series. Look for a newer version than the one you are using. If a fix was introduced in a later version, check the changelog or commit history to verify.

To review changes, clone the package with `git ubuntu`:

.. code-block:: bash

    git ubuntu clone postfix postfix-gu
    cd postfix-gu
    git log -b pkg/ubuntu/<ubuntu-series>

Look through the commit messages and patch files to identify if the issue has been resolved.

..
    We need to add instructions for reviewing changes when users are using apt-get source, pull-lp-source, or pull-pkg.

Check if the bug is fixed in Debian
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Debian is a key source for Ubuntu packages. Search for bug reports or patches applied there.

First, check Debian’s bug tracker using the URL ``https://bugs.debian.org/src:<package-name>``.

To inspect changes in more detail, look at Debian’s Git repository. For many packages, you can find this via ``Salsa``:

.. code-block:: shell

    git clone https://salsa.debian.org/<team>/<repo>.git  <repo>-debian
    cd <repo>-debian
    git log

Look for commit messages that describe fixes relevant to your issue. If a bug number is referenced, open the link and review the context.

Check if the bug is fixed upstream
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If the problem originates from the software itself and not packaging, investigate upstream. Each project has its own bug tracker and code repository.

You can find the upstream project by doing the following:

- Search the package homepage listed by running the command ``apt-cache show <package>``.
- Look up the project through web search if no homepage is set.
- Check the metadata in the package description or Debian tracker.

Once you find the upstream repository, do the following:

- Look through open and closed issues.
- Search the commit history for relevant fixes.
- Clone the upstream Git repository if available and inspect the logs.

If upstream has resolved the problem, consider if that version has reached Debian or Ubuntu. If not, you may propose packaging the new version or backporting the patch.

Offer to help
-------------

Once you confirm the issue still exists, a bug report is open, and no one is working on it, you can offer to help. This step signals your interest in resolving the issue and helps prevent duplicated efforts.

Start by commenting on the bug report in Launchpad. Let others know that you intend to work on the issue. Include any relevant details you have, such as:

- When and how the bug occurs
- How you plan to fix the issue or what you've tried so far
- Any testing you’ve done or plan to do

If the bug doesn't yet exist in Launchpad, create a new bug report. Provide a clear title and description. Explain how the issue can be reproduced, and add logs or screenshots if helpful.

Get the source code
-------------------

Once you're assigned to the bug, get the source code for the affected package. There are four methods to do this and they include:

- ``git-ubuntu``
- ``pull-pkg``
- ``apt-get source``
- ``dget``

For detailed instructions on using these methods to get the source code, see :ref:`get-package-source`.

Create a patch to fix the issue
-------------------------------

You may have to create a patch to make changes to a package. Start by checking where your changes are located. If your changes are only within the ``debian/`` directory, for example, in ``debian/control``, you don't need to create a patch. However, if you changed upstream source code—that is anything outside ``debian/``, you must create a patch and include it in ``debian/patches``.

There are two main methods for creating patches for Ubuntu packages. The method you choose will depend on the workflow that the package source uses:

- If the package uses **quilt**, use the ``quilt`` tool to create and manage patches. To learn how to create a patch using ``quilt``, see `Making a patchfile <https://github.com/canonical/ubuntu-maintainers-handbook/blob/main/DebianPatch.md>`_.
- If the package is a **native Ubuntu package**, or the repository uses Git to track patches, use ``git-ubuntu`` and commit your changes directly.

Document the fix
----------------

It’s important to document your changes so future developers can understand your reasoning and assumptions without having to guess.

Explain your changes in the ``debian/changelog`` file. This file tracks every change uploaded to Ubuntu or Debian, and future developers rely on it to understand what changed, where it happened, and why.

Run the following command to create a new changelog entry:

.. code-block:: bash

    dch -i

This command generates a new entry and opens your text editor. The top and bottom lines will be filled out for you automatically. The top line includes the package name, version, Ubuntu release, and urgency (usually low). The bottom line shows your name, email, and a timestamp.

You should also write a short and informative message in between the top and bottom lines. This message should include:

- Where you made the change (e.g., file or component).
- What the change does.
- Why you made it. Link to the Launchpad bug or mailing list discussion if available.

Use this format to reference a Launchpad bug:

.. code-block:: text

    LP: #<bug-number>

This ensures the bug will close automatically when the fix is uploaded.

Test the fix
------------

Run package tests to check that your change doesn't introduce regressions. Ubuntu uses :term:`autopkgtest` to automate this process. Package maintainers can run tests in several ways: 

- through a :term:`Personal Package Archive` (PPA) on Launchpad
- in a local virtual machine (VM)
- in a container
- in the Canonistack cloud environment.

Use the PPA-based method if possible. It produces results closest to what Launchpad runs for archive packages. After uploading your package to a PPA and building it, you can trigger tests using the ``PPA`` tool from ``ppa-dev-tools``. You will need special permissions to launch these tests. Ask for help in the ``#ubuntu-devel`` IRC channel if needed.

For local testing, use a VM or container. The `autopkgtest` tool builds test images and runs the tests in an isolated environment. Use this method when you want to debug failures or verify changes before uploading to a PPA. If your testbed needs to reboot or be isolated, use a VM or container as defined in the package’s ``debian/tests/control`` file.

Testing in Canonistack offers the most realistic test environment, as it mirrors the infrastructure used in the Ubuntu archive. It requires setup and access to Canonistack.

To learn how to set up and run these test methods, see `Running package tests <https://github.com/canonical/ubuntu-maintainers-handbook/blob/main/PackageTests.md>`_.
