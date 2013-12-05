=============
Using Chroots
=============

If you are running one version of Ubuntu but working on packages for
another versions you can create the environment of the other version with a
``chroot``.

A ``chroot`` allows you to have a full filesystem from another distribution
which you can work in quite normally.  It avoids the overhead of running a
full virtual machine.

Creating a Chroot
------------------

Use the command ``debootstrap`` to create a new chroot::

    $ sudo debootstrap saucy saucy/

This will create a directory ``saucy`` and install a minimal saucy system
into it.

If your version of ``debootstrap`` does not know about saucy you can try
upgrading to the version in ``backports``.

You can then work inside the chroot::

    $ sudo chroot saucy

Where you can install or remove any package you wish without affecting your
main system.

You might want to copy your GPG/ssh keys and Bazaar configuration into the
chroot so you can access and sign packages directly::

    $ sudo mkdir saucy/home/<username>
    $ sudo cp -r ~/.gnupg ~/.ssh ~/.bazaar saucy/home/<username>

To stop apt and other programs complaining about missing locales you
can install your relevant language pack::

    $ apt-get install language-pack-en

If you want to run X programs you will need to bind the /tmp directory
into the chroot, from outside the chroot run::

    $ sudo mount -t none -o bind /tmp saucy/tmp
    $ xhost +

Some programs may need you to bind /dev or /proc.

For more information on chroots see our `Debootstrap Chroot wiki page`_.

Alternatives
------------

SBuild is a system similar to PBuilder for creating an environment to run test package builds in.  It closer matches that used by Launchpad for building packages but takes some more setup compared to PBuilder.  See `the Security Team Build Environment wiki page`_ for a full explanation.

Full virtual machines can be useful for packaging and testing
programs.  TestDrive is a program to automate syncing and running
daily ISO images, see `the TestDrive wiki page`_ for more information.

You can also set up pbuilder to pause when it comes across a build
failure.  Copy C10shell from /usr/share/doc/pbuilder/examples into a
directory and use the ``--hookdir=`` argument to point to it.

Amazon's `EC2 cloud computers`_ allow you to hire a computer paying a
few US cents per hour, you can set up Ubuntu machines of any supported
version and package on those.  This is useful when you want to compile
many packages at the same time or to overcome bandwidth restraints.

.. _`Debootstrap Chroot wiki page`: https://wiki.ubuntu.com/DebootstrapChroot
.. _`EC2 cloud computers`: https://help.ubuntu.com/community/EC2StartersGuide
.. _`the TestDrive wiki page`: https://wiki.ubuntu.com/UsingDevelopmentReleases
.. _`the Security Team Build Environment wiki page`: https://wiki.ubuntu.com/SecurityTeam/BuildEnvironment
