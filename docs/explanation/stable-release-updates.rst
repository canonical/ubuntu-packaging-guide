Stable Release Updates (SRU)
============================

After publication of a :term:`Ubuntu Stable Release`, there may be a need
to update it or fix bugs. You can fix these newly discovered bugs and make
updates through a special process known as Stable Release Update (SRU).

The SRU process ensures that any changes made to a stable release are thoroughly
vetted and tested before being made available to users. This is because many of
the users rely on the stability of the stable release for their day-to-day
operations, and any problem they experience with it can be disruptive.

When are Stable Release Updates necessary?
------------------------------------------

SRUs require great caution because they're automatically recommended to a large
number of users. So, when you propose an update, there should be a strong rationale
for it. Also, the update should present a low risk of :ref:`regressions <Regressions>`.

You can propose an SRU in the following cases:

- To fix high-impact bugs, including those that may directly cause security
  vulnerabilities, severe regressions from the previous release, or
  bugs that may directly cause loss of user data.
- To adjust to changes in the environment, server protocols, or web services. This
  ensures that Ubuntu remains compatible with evolving technologies.
- For safe cases with low regression potential but high user experience improvement.
- To introduce new features in :term:`LTS releases <LTS>`, usually under strict
  conditions.
- To update commercial software in the :term:`Canonical partner archive`.
- To fix :term:`Failed to build from Source` issues.
- To fix :term:`autopkgtest` failures, usually in conjunction with other
  high-priority fixes.

Low priority and Extended Security Maintenance (ESM) uploads
------------------------------------------------------------

You can stage and bundle low-priority uploads with a future SRU or
security update. These uploads may include updates that fix bugs that don't
affect users at runtime.

For uploads to stable releases in their :term:`ESM` period, please prepare the 
SRU bug, then contact the :term:`Ubuntu ESM Team`.

General requirements
--------------------

The general requirements for SRU are designed to ensure the stability and 
reliability of :ref:`Ubuntu releases <UbuntuReleases>`.

To prevent future regressions when users upgrade to newer
Ubuntu versions, bugs should be fixed in the :term:`current development release <Current Release in Development>` before being
considered for an SRU.

Also, all subsequent supported releases should be fixed at the same time. This
ensures consistency across different Ubuntu versions. There are two exceptions to
this requirement. These exceptions apply only to bug fixes, not to hardware
enablement or new features:

- When there are two current subsequent interim releases, fixing only the most
  recent one is acceptable. This provides an upgrade path for users facing the
  regression.
- When resources are limited, it's recommended but not a strict requirement to
  fix all subsequent interim releases. If you're unable to fix all subsequent interim
  releases, mark the bug tasks for those releases as ``Won't Fix`` and explicitly state
  your intention not to fix them. The :term:`Ubuntu SRU Team` may accept this at their
  discretion. Failure to communicate your intentions may result in additional review.

SRU procedures
--------------

The following steps outline the process for submitting and managing an
SRU in Ubuntu:

1. Ensure that the bug is fixed in the current development release and that its
   status is marked as ``Fix Released``. If the source package has changed names
   between releases, add the new source package as ``Also affecting``
   in the bug report.
2. Don't create a meta-bug with a title like ``Please SRU this`` instead of using
   existing bug reports. This approach is redundant and lacks transparency for the
   original bug reporters, whose feedback is important for verification. Such meta-bugs
   will be invalidated by the Ubuntu SRU Team, and the corresponding uploads
   will be rejected from the queue.
3. Ensure that the bug report for the issue is public. If the bug has been reported
   privately and can't be published, create a separate public bug report in
   :term:`Launchpad` and transfer as much information as can be published.
4. Update the bug report with the following sections:

  - **Impact**: Explain the bug's effect on users and the reasons for backporting the  
    fix to the stable release. Optionally, include an explanation of how the upload
    fixes the bug.
  - **Test Plan**: Provide detailed instructions on how to reproduce the bug. These
    instructions should be clear enough for someone unfamiliar with the package to
    verify the fix.
  - **Where Problems Could Occur**: Highlight potential areas where
    regressions might happen. This section should show that
    potential risks have been considered. It should also provide additional test cases
    to ensure there are no regressions.

5. Prepare the SRU upload, attach a ``debdiff`` to the bug, and request sponsorship
   by subscribing ``ubuntu-sponsors`` to the bug. The upload should have the correct
   release in the changelog header, a detailed and user-readable changelog and no
   unrelated changes. If you can upload directly, use ``dput`` as normal. Once uploaded,
   change the bug status to ``In Progress``. The status will be automatically updated to
   ``Fix Committed`` once accepted into ``release-proposed``.
6. Ensure that the version number doesn't conflict with any future versions in other
   Ubuntu releases. Also, include a reference to the SRU bug
   number in the changelog using the ``LP: #NNNNNN`` format, and only reference public bugs.
7. Once the Ubuntu SRU Team reviews and accepts your upload, test the binaries
   in the :term:`Ubuntu Archive` and follow up in the bug report with your verification
   results. The Ubuntu SRU Team will evaluate the testing feedback and move the
   package into :ref:`updates <ArchivePockets_Updates>` after it passes a minimum aging
   period of 7 days.
8. Subscribe to the bugmail of the package in Launchpad, and monitor
   Launchpad for bug reports relating to the update for at least one week. If
   you notice and confirm any regression, document it in a bug report marked with an
   ``Importance: critical`` label.

SRU phasing
-----------

Once a package is released to ``updates``, the update is then phased so that the update
is gradually made available to expanding subsets of Ubuntu users.

Initially, the ``Phased-Update-Percentage`` is set to 10%, with a job running every 6
hours to monitor for regressions. If no issues are detected, the
update percentage increments by 10% until it reaches 100%. So an update will become
fully phased after 54 hours. If a regression is found, the update is halted and the
``Phased-Update-Percentage`` is set to 0%. This will then cause supported package
managers not to install the update.

Investigating halted phased updates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To investigate why phasing stopped, use the phased updates report.

When investigating an increased rate of crashes, focus on the crashes with the highest
number of occurrences. Examine the occurrences table to determine if these crashes are
happening more frequently with the updated version of the package. If they are,
investigate the cause and address the crash in a follow-up SRU. If not,
contact the :term:`Ubuntu SRU Team` about overriding the crash report.

For new errors, verify that they're indeed new by reviewing the versions table and checking
the ``Traceback`` or ``Stacktrace`` to determine if the error originates from the updated
package or an underlying library. If you believe the error wasn't caused by the update,
you can contact the :term:`Ubuntu SRU Team` to override the crash.

Overriding halted phased updates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Overriding halted phasing is similar to handling :term:`autopkgtest` failures.The phased
update machinery uses a file named ``phased-update-overrides.txt``, a simple CSV file
containing lines of the form ``source package``, ``version``, and ``$THING_TO_IGNORE``.

``$THING_TO_IGNORE`` can either be an ``errors.ubuntu.com`` problem URL to ignore or
``increased-rate``.

.. _Verification:

Verification
------------

SRU verification should be done in a software environment that closely resembles
that which will exist after the package is copied to ``updates``.
Generally, this will be with a system that's up to date from
:ref:`release <ArchivePockets_Release>`,
:ref:`security <ArchivePockets_Security>`, and ``updates``.
It shouldn't include other packages from
:ref:`proposed <ArchivePockets_Proposed>` or
:ref:`backports <ArchivePockets_Backports>`,
with one exception: other packages built from the affected source package must
be updated if they're generally installed.

If the fix is sufficient, the :term:`SRU Verification Team` will update the bug status
to ``In Progress``, and change the  ``verification-needed-$RELEASE`` tag to
``verification-failed-$RELEASE``. If the fix is sufficent, the SRU Verification Team
will tag it as ``verification-done-$RELEASE``.

If you encounter a regression in a package uploaded to
proposed, do the following:

1. File a bug report describing the nature of the regression.
#. Tag the bug as ``regression-proposed``.
#. Ask a :term:`Bug supervisor` to target the bug to the appropriate Ubuntu releases.
#. Follow up on the SRU bug report referenced from the package changelog, pointing
   to the new bug. If there is more than one bug in the SRU changelog, follow up to
   the bug that is most closely related to the regression.
#. Set the ``verification-failed-$RELEASE`` tag on the corresponding SRU bug report.

.. note::
   ``$RELEASE`` represents the release name of your upload.

Packages accepted into proposed automatically trigger related ``autopkgtests``.

If an SRU upload triggers an ``autopkgtests`` regression, the target package will
not be released into updates until the issue is resolved. Once the tests are completed,
the pending SRU page provides links to any failures noticed for the selected upload.
It's the responsibility of the uploader or the person performing update verification to
ensure that the upload doesn't cause any regressions, both in manual and automated testing.

.. _Regressions:

Regressions
-----------

Regressions are unintended negative consequences that updates introduce. They appear
as new bugs or failures in previously well-functioning aspect of an Ubuntu release. 

If a package update introduces a regression that makes it through the
:ref:`verification <Verification>` process to ``updates``, file a bug report about
the issue and add the tag ``regression-update`` to the bug.

For regressions that only apply to the package in proposed, follow up on the bug with
a detailed explanation and tag it with ``regression-proposed``.

Regression tests
~~~~~~~~~~~~~~~~

To minimise the risk of regressions being introduced through
SRU, :term:`Canonical` will test each proposed kernel.

The Ubuntu Platform QA team will perform ``Depth Regression Testing`` on a minimal set of
hardware that represents the different flavours of Ubuntu editions and architectures. This
test verifies that the update didn't introduce hardware-independent regressions.

The Ubuntu HW Certification team will perform ``Breadth Hardware Testing`` on release-certified
hardware. This test verifies that the proposed kernel can be successfully installed on the
latest release, that network access is functional, and that no other functionality critical
for Update Manager is missing.

Updates removal
---------------

If a bug fixed by an update doesn't get any testing or verification feedback for 90 days, an
automated call for testing comment will be made on the bug report. If no testing occurs within
an additional 15 days, totaling 105 days without any testing, the :term:`Stable Release Managers`
will remove the package from proposed and close the bug
task as ``Won't Fix``.

Also, updates will be removed from proposed if
they introduce a nontrivial regression.

Resources
---------

- `StableReleaseUpdates wiki <https://wiki.ubuntu.com/StableReleaseUpdates>`_
- `Ubuntu autopkgtest package <https://launchpad.net/ubuntu/+source/autopkgtest/>`_
- `Ubuntu update-manager package <https://launchpad.net/ubuntu/+source/update-manager/>`_
- `Phasing Ubuntu Stable Release Updates <https://ubuntu-archive-team.ubuntu.com/phased-updates.html>`_
