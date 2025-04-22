Make changes to a package
=========================

This tutorial will go through the process of adding a patch to a package in Ubuntu. Specifically, we will be adding a command line option to the ``hello`` command which greets a user using their username. This will cover topics like ``git-ubuntu``, ``quilt``, and changelogs.

Get the Tools
-------------

We will be using a ``git-ubuntu`` workflow, because most developers are comfortable using git to make changes. It can be installed with ``snap``: ::

    snap install --classic git-ubuntu

Once we have ``git-ubuntu`` installed, we can use it to fetch the source code for the ``hello`` package in Ubuntu::

    git-ubuntu clone hello
    cd hello/

We will also be using some tools from the ``ubuntu-dev-tools`` package. Install that package with: ::

    apt install ubuntu-dev-tools

Understand the Package
----------------------

Initially, we will have the ``ubuntu/devel`` branch checked out. At the time of writing this tutorial, the development series is ``plucky``, so the ``ubuntu/devel`` branch is in line with the ``plucky`` version.

Let's get a feel for the packaging we are dealing with here. In the ``debian`` directory, there are files like ``changelog``, ``rules``, ``control``, and more. Everything outside of the ``debian`` directory is from the original upstream source. If we look at ``debian/source/format``, we see::

    3.0 (quilt)

This means that, like most packages, this package uses ``quilt`` to manage patches to the upstream source code. So, even though we are using git to track our changes to the *packaging*, we need to use a quilt patch to maintain the changes required for our new command line option. In particular, instead of ending up with a git commit that modifies the upstream source code directly, our commit will add a new file ``debian/patches/add-username-command-line-option.patch`` which contains the patch to apply to the upstream source code.

Create a Patch with ``quilt``
-----------------------------

First, create the new patch file using quilt: ::

    $ QUILT_PATCHES=debian/patches quilt new add-username-command-line-option.patch
    Patch add-username-command-line-option.patch is now on top

This should create a new, empty file ``debian/patches/add-username-command-line-option.patch``, and will add a corresponding entry to the ``debian/patches/series`` file. Once that is done, we can start writing our patch. For each source file that will be modified by our patch, we need to tell ``quilt`` about it. In this case: ::

    quilt add src/hello.c

After that, we can edit the source normally using our favorite text editor. To see our progress, we can use the usual git tools to see the diff. So, after adding the new command line flag, the diff might look like:

.. code-block:: diff

    $ git diff -- src/hello.c
    diff --git a/src/hello.c b/src/hello.c
    index 453962f..f1ccf0a 100644
    --- a/src/hello.c
    +++ b/src/hello.c
    @@ -23,6 +23,10 @@
     #include "error.h"
     #include "progname.h"
     #include "xalloc.h"
    +#include "unistd.h"
    +#include "sys/types.h"
    +#include "pwd.h"
    +#include "limits.h"
    
     static const struct option longopts[] = {
       {"greeting", required_argument, NULL, 'g'},
    @@ -44,6 +48,8 @@ main (int argc, char *argv[])
       const char *greeting_msg;
       wchar_t *mb_greeting;
       size_t len;
    +  struct passwd *pwd = NULL;
    +  char user_greeting[sizeof("hello, !") + LOGIN_NAME_MAX] = {};
    
       set_program_name (argv[0]);
    
    @@ -65,7 +71,7 @@ main (int argc, char *argv[])
          This is implemented in the Gnulib module "closeout".  */
       atexit (close_stdout);
    
    -  while ((optc = getopt_long (argc, argv, "g:htv", longopts, NULL)) != -1)
    +  while ((optc = getopt_long (argc, argv, "g:htvu", longopts, NULL)) != -1)
         switch (optc)
           {
            /* --help and --version exit immediately, per GNU coding standards.  */
    @@ -83,6 +89,15 @@ main (int argc, char *argv[])
           case 't':
            greeting_msg = _("hello, world");
            break;
    +      case 'u':
    +        errno = 0;
    +        pwd = getpwuid(geteuid());
    +        if (!pwd)
    +          error (EXIT_FAILURE, errno, _("failed to get user name"));
    +
    +        snprintf(user_greeting, sizeof(user_greeting), "hello, %s!", pwd->pw_name);
    +        greeting_msg = _(user_greeting);
    +        break;
           default:
            lose = 1;
            break;

To save these changes in our quilt patch, we need to *refresh* the patch: ::

    quilt refresh -p ab --no-timestamps --no-index

It is good practice to add `DEP-3 headers <https://dep-team.pages.debian.net/deps/dep3/>_` to patches to add additional context such as the origin, author, and related bugs. The ``quilt`` tool has a helper for this: ::

    quilt header -e --dep3

This will open a text editor with pre-populated text: ::

    Description: <short description, required>
     <long description that can span multiple lines, optional>
    Author: <name and email of author, optional>
    Origin: <upstream|backport|vendor|other>, <URL, required except if Author is present>
    Bug: <URL to the upstream bug report if any, implies patch has been forwarded, optional>
    Bug-<Vendor>: <URL to the vendor bug report if any, optional>
    Forwarded: <URL|no|not-needed, useless if you have a Bug field, optional>
    Applied-Upstream: <version|URL|commit, identifies patches merged upstream, optional>
    Reviewed-by: <name and email of a reviewer, optional>
    Last-Update: 2025-04-23 <YYYY-MM-DD, last update of the meta-information, optional>
    ---
    This patch header follows DEP-3: http://dep.debian.net/deps/dep3/

Not everything here needs to be filled in. In this case, our headers might look like: ::

    Description: Add -u command line option to hello
     This command line option adds a username-specific greeting. E.g.,
     $ hello -u
     hello, user123!
    Author: Nick Rosbrook <enr0n@ubuntu.com>
    Forwarded: no, Ubuntu only
    Last-Update: 2025-04-23 
    ---
    This patch header follows DEP-3: http://dep.debian.net/deps/dep3/

Our final patch should look something like:

.. code-block:: diff

    Description: Add -u command line option to hello
     This command line option adds a username-specific greeting. E.g.,
     $ hello -u
     hello, user123!
    Author: Nick Rosbrook <enr0n@ubuntu.com>
    Forwarded: no, Ubuntu only
    Last-Update: 2025-04-23
    ---
    This patch header follows DEP-3: http://dep.debian.net/deps/dep3/
    --- a/src/hello.c
    +++ b/src/hello.c
    @@ -23,6 +23,10 @@
     #include "error.h"
     #include "progname.h"
     #include "xalloc.h"
    +#include "unistd.h"
    +#include "sys/types.h"
    +#include "pwd.h"
    +#include "limits.h"
     
     static const struct option longopts[] = {
       {"greeting", required_argument, NULL, 'g'},
    @@ -44,6 +48,8 @@
       const char *greeting_msg;
       wchar_t *mb_greeting;
       size_t len;
    +  struct passwd *pwd = NULL;
    +  char user_greeting[sizeof("hello, !") + LOGIN_NAME_MAX] = {};
     
       set_program_name (argv[0]);
     
    @@ -65,7 +71,7 @@
          This is implemented in the Gnulib module "closeout".  */
       atexit (close_stdout);
     
    -  while ((optc = getopt_long (argc, argv, "g:htv", longopts, NULL)) != -1)
    +  while ((optc = getopt_long (argc, argv, "g:htvu", longopts, NULL)) != -1)
         switch (optc)
           {
     	/* --help and --version exit immediately, per GNU coding standards.  */
    @@ -83,6 +89,15 @@
           case 't':
     	greeting_msg = _("hello, world");
     	break;
    +      case 'u':
    +       errno = 0;
    +       pwd = getpwuid(geteuid());
    +       if (!pwd)
    +         error (EXIT_FAILURE, errno, _("failed to get user name"));
    +
    +       snprintf(user_greeting, sizeof(user_greeting), "hello, %s!", pwd->pw_name);
    +       greeting_msg = _(user_greeting);
    +       break;
           default:
     	lose = 1;
     	break;

The patch is currently applied in the working directory, and can be un-applied with ``quilt pop -a`` (and applied again with ``quilt push -a``).

Commit the Changes
------------------

Now that we have created our patch file, we should track the changes in git. We can add the new patch file (and in this case, the newly created ``debian/patches/series`` file) to the git index, and commit our change: ::

    $ git add debian/patches/
    $ git commit -m "debian/patches: add a new -u command line option to hello"

Next, we need to make some housekeeping changes. First, we need to make sure that the ``Maintainer:`` field in ``debian/control`` is set correctly. Second, we need to add a new entry to ``debian/changelog`` explaining our changes, and incrementing the package version number.

To update the maintainer field, we can use the ``update-maintainer`` tool from the ``ubuntu-dev-tools`` package. In this case, the field is already set correctly, so we should see: ::

    $ update-maintainer 
    The Maintainer email is set to an ubuntu.com address. Doing nothing.

If a change was made, we would then want to commit that change with ``git commit -m "update maintainer" -- debian/control``. Once you have either updated the maintainer, or confirmed that it is already correct, you can update the changelog. The ``dch`` tool helps us with this. If you run ``dch -i``, you will see something like this in your text editor: ::

    hello (2.10-3ubuntu1) UNRELEASED; urgency=medium
    
      *
    
     -- Nick Rosbrook <enr0n@ubuntu.com>  Tue, 22 Apr 2025 17:03:03 -0400
    
    hello (2.10-3build2) oracular; urgency=medium
    
      * No-change rebuild to bump version in oracular.
    
     -- Marc Deslauriers <marc.deslauriers@ubuntu.com>  Mon, 27 May 2024 07:18:24 -0400
    
    hello (2.10-3build1) noble; urgency=high
    
      * No change rebuild for 64-bit time_t and frame pointers.
    
     -- Julian Andres Klode <juliank@ubuntu.com>  Mon, 08 Apr 2024 17:58:52 +0200

     [...SNIP...]

The ``dch`` tool has done a couple things here:

1. Created a new empty changelog entry 
2. Set the author line using your name, email, and the current date and time
3. Updated the package version number to ``2.10-3ubuntu1``
4. Set the release name to ``UNRELEASED``

Our job now is to fill in the entry and explain our changes. In this case, we should write something like: ::

    hello (2.10-3ubuntu1) plucky; urgency=medium
    
      * debian/patches: add a new -u command line option to hello
    
     -- Nick Rosbrook <enr0n@ubuntu.com>  Tue, 22 Apr 2025 17:03:03 -0400

Once you are happy with the changelog entry, go ahead and commit the change: ``git commit -m "update changelog" -- debian/changelog``. At this point, we should have two (or three if ``update-maintainer`` was needed) commits: one adding our new patch, and another updating the changelog: ::

    $ git log
    commit a62e1590cc6a12925c8fe9bce49d9b7f5834468e (HEAD -> ubuntu/devel)
    Author: Nick Rosbrook <enr0n@ubuntu.com>
    Date:   Wed Apr 23 10:04:32 2025 -0400
    
        update changelog
    
    commit d6ef1607ce6163e6a611c591e94f478c2c06a35a
    Author: Nick Rosbrook <enr0n@ubuntu.com>
    Date:   Tue Apr 22 16:24:39 2025 -0400
    
        debian/patches: add a new -u command line option to hello
    
    commit fd73db6d7406ee1fb8512a5b54c259f3b3368eab (tag: pkg/import/2.10-3build2, pkg/ubuntu/plucky-devel, pkg/ubuntu/plucky, pkg/ubuntu/oracular-proposed, pkg/ubuntu/oracular-devel, pkg/ubuntu/oracular, pkg/ubuntu/devel, pkg/HEAD)
    Author: Marc Deslauriers <marc.deslauriers@ubuntu.com>
    Date:   Mon May 27 07:18:24 2024 -0400
    
        2.10-3build2 (patches unapplied)
    
        Imported using git-ubuntu import.
    
    Notes (changelog):
          * No-change rebuild to bump version in oracular.

And that's it! We have successfully added a new patch to this package, documented our change, and prepared the package for its next upload to the Ubuntu archive.

Next Steps
----------

From here, there are many options for testing our patch before proposing the change in a merge proposal. We can build and test the package locally using ``sbuild`` and ``autopkgtest``, or we can upload to a PPA and test from there. Once we feel confident that the patch is working correctly, we can open the merge proposal and request sponsorship for our change.
