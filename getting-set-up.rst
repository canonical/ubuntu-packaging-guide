==============
Getting Set Up
==============

There are a number of things you need to do to get started developing for Ubuntu.
This article is designed to get your computer set up so that you can start 
working with packages, and upload your packages to Ubuntu's hosting
platform, Launchpad. Here's what we'll cover:

* Installing packaging-related software. This includes:

  * Ubuntu-specific packaging utilities
  * Encryption software so your work can be verified as being done by you
  * Additional encryption software so you can securely transfer files

* Creating and configuring your account on Launchpad
* Setting up your development environment to help you do local builds of packages,
  interact with other developers, and propose your changes on Launchpad.
 

.. note:: 
  It is advisable to do packaging work using the current development version of 
  Ubuntu. Doing so will allow you to test changes in the same environment where 
  those changes will actually be applied and used. 

  Don't worry, though, the `Ubuntu development release wiki page 
  <https://wiki.ubuntu.com/UsingDevelopmentReleases>`_ shows a variety of ways to 
  safely use the development release.


Install basic packaging software
================================

There are a number of tools that will make your life as an Ubuntu developer
much easier.  You will encounter these tools later in this guide.  To install
most of the tools you will need run this command::

    $ sudo apt-get install gnupg pbuilder ubuntu-dev-tools bzr-builddeb apt-file

This command will install the following software:

* ``gnupg`` -- `GNU Privacy Guard`_ contains tools you will need to create a
  cryptographic key with which you will sign files you want to upload to
  Launchpad.
* ``pbuilder`` -- a tool to do a reproducible builds of a package in a
  clean and isolated environment.
* ``ubuntu-dev-tools`` (and ``devscripts``, a direct dependency) -- a
  collection of tools that make many packaging tasks easier.
* ``bzr-builddeb`` (and ``bzr``, a dependency) -- distributed version control
  tools that makes it easy for many developers to collaborate and work on the
  same code while keeping it trivial to merge each others work.
* ``apt-file`` provides an easy way to find the binary package that contains a
  given file.
* ``apt-cache`` (part of the ``apt`` package) provides even more information 
  about packages on Ubuntu.


Create your GPG key
-------------------

GPG stands for `GNU Privacy Guard`_ and it implements the OpenPGP standard
which allows you to sign and encrypt messages and files. This is useful for a
number of purposes. In our case it is important that you can sign files with
your key so they can be identified as something that you worked on. If you
upload a source package to Launchpad, it will only accept the package if it
can absolutely determine who uploaded the package.

To generate a new GPG key, run::

    $ gpg --gen-key

GPG will first ask you which kind of key you want to generate. Choosing the
default (RSA and DSA) is fine. Next it will ask you about the keysize. The
default (currently 2048) is fine, but 4096 is more secure. Afterward, it will
ask you if you want it to expire the key at some stage. It is safe to say "0",
which means the key will never expire. The last questions will be about your
name and email address. Just pick the ones you are going to use for Ubuntu
development here, you can add additional email addresses later on. Adding a
comment is not necessary. Then you will have to set a passphrase, choose a
safe one (a passphrase is just a password which is allowed to include spaces). 

Now GPG will create a key for you, which can take a little bit of time; it 
needs random bytes, so if you give the system some work to do it will be 
just fine.  Move the cursor around!

Once this is done, you will get a message similar to this one::

    pub   4096R/43CDE61D 2010-12-06
          Key fingerprint = 5C28 0144 FB08 91C0 2CF3  37AC 6F0B F90F 43CD E61D
    uid                  Daniel Holbach <dh@mailempfang.de>
    sub   4096R/51FBE68C 2010-12-06

In this case ``43CDE61D`` is the *key ID*.

Next, you need to upload the public part of your key to a keyserver so the 
world can identify messages and files as yours. To do so, enter::

    $ gpg --send-keys <KEY ID>

This will send your key to one keyserver, but a network of keyservers will 
automatically sync the key between themselves. Once this syncing is complete, 
your signed public key will be ready to verify your your contributions 
around the world.


Create your SSH key
-------------------

SSH_ stands for *Secure Shell*, and it is a protocol that allows you to 
exchange data in a secure way over a network. It is common to use SSH to access 
and open a shell on another computer, and to use it to securely transfer files. 
For our purposes, we will mainly be using SSH to securely communicate with 
Launchpad. 

To generate a SSH key, enter::

    $ ssh-keygen -t rsa

The default file name usually makes sense, so you can just leave it as it is.
For security purposes, it is highly recommended that you use a passphrase.


Set up pbuilder
---------------

``pbuilder`` allows you to build packages locally on your machine. It serves
a couple of purposes:

* The build will be done in a minimal and clean environment. This helps you
  make sure your builds succeed in a reproducible way, but without modifying 
  your local system
* There is no need to install all necessary *build dependencies* locally
* You can set up multiple instances for various Ubuntu and Debian releases

Setting ``pbuilder`` up is very easy. Edit `~/.pbuilderrc` and add the
following line to it::

    COMPONENTS="main universe multiverse restricted"

This will ensure that build dependencies are satisfied using all components.

Then run::

    $ pbuilder-dist <release> create

where <release> is for example `natty`, `maverick`, `lucid` or in the case of
Debian maybe `sid`. This will take a while as it will download all the
necessary packages for a "minimal installation". These will be cached though.


Get set up to work with Launchpad
=================================

With a basic local configuration in place, your next step will be to 
configure your system to work with Launchpad. This section will focus
on the following topics:

 * What Launchpad is, and creating a Launchpad account
 * Uploading your GPG and SSH keys to Launchpad
 * Configuring Bazaar to work with Launchpad
 * Configuring Bash to work with Bazaar


About Launchpad
---------------

Launchpad is the central piece of infrastructure we use in Ubuntu. It not only 
stores our packages and our code, but also things like translations, bug
reports, and information about the people who work on Ubuntu and their team 
memberships.  You will also use Launchpad to publish your proposed fixes, and
get other Ubuntu developers to review and sponsor them.

You will need to register with Launchpad and provide a minimal amount of
information. This will allow you to download and upload code, submit bug 
reports, and more.


Get a Launchpad account
--------------------------

If you don't already have a Launchpad account, you can easily `create one`_.
If you have a Launchpad account but cannot remember your Launchpad id, you can
find this out by going to https://launchpad.net/people/+me and looking for the
part after the `~` in the URL.

Launchpad's registration process will ask you to choose a display name. It is
encouraged for you to use your real name here so that your Ubuntu developer
colleagues will be able to get to know you better.

When you register a new account, Launchpad will send you an email with a link
you need to open in your browser in order to verify your email address. If
you don't receive it, check in your spam folder.

`The new account help page <https://help.launchpad.net/YourAccount/NewAccount>`_ 
on Launchpad has more information about the process and additional settings you 
can change.
 

Upload your GPG key to Launchpad
----------------------------------

To find about your GPG fingerprint, run::

    $ gpg --fingerprint <email@address.com>

and it will print out something like::

    pub   4096R/43CDE61D 2010-12-06
          Key fingerprint = 5C28 0144 FB08 91C0 2CF3  37AC 6F0B F90F 43CD E61D
    uid                  Daniel Holbach <dh@mailempfang.de>
    sub   4096R/51FBE68C 2010-12-06


Head to https://launchpad.net/people/+me/+editpgpkeys and copy the part about
your "Key fingerprint" into the text box. In the case above this would be
``5C28 0144 FB08 91C0 2CF3  37AC 6F0B F90F 43CD E61D``. Now click on "Import
Key".

Launchpad will use the fingerprint to check the Ubuntu key server for your
key and, if successful, send you an encrypted email asking you to confirm
the key import. Check your email account and read the email that Launchpad
sent you. `If your email client supports OpenPGP encryption, it will prompt
you for the password you chose for the key when GPG generated it. Enter the
password, then click the link to confirm that the key is yours.`

Launchpad encrypts the email, using your public key, so that it can be sure
that the key is yours. If your email software does not support OpenPGP
encryption, copy the encrypted email's contents, type ``gpg`` in your
terminal, then paste the email contents into your terminal window.

Back on the Launchpad website, use the Confirm button and Launchpad will
complete the import of your OpenPGP key.

Find more information at
https://help.launchpad.net/YourAccount/ImportingYourPGPKey

Upload your SSH key to Launchpad
--------------------------------

Open https://launchpad.net/people/+me/+editsshkeys in a web browser, also open
``~/.ssh/id_rsa.pub`` in a text editor. This is the public part of your SSH key,
so it is safe to share it with Launchpad. Copy the contents of the file and
paste them into the text box on the web page that says "Add an SSH key". Now
click "Import Public Key".

For more information on this process, visit the `<creating an SSH keypair 
<https://help.launchpad.net/YourAccount/CreatingAnSSHKeyPair>`_ page on 
Launchpad.


Configure Bazaar
----------------

Bazaar is the tool we use to store code changes in a logical way, to exchange
proposed changes and merge them, even if development is done concurrently.

To tell Bazaar who you are, simply run::

    $ bzr whoami "Bob Dobbs <subgenius@example.com>"
    $ bzr launchpad-login subgenius

`whoami` will tell Bazaar which name and email address it should use for your
commit messages. With `launchpad-login` you set your Launchpad ID. This way
code that you publish in Launchpad will be associated with you.

Note: If you can not remember the ID, go to https://launchpad.net/people/+me
and see where it redirects you. The part after the "~" in the URL is your
Launchpad ID.)


Configure your shell
--------------------
Similar to Bazaar, the Debian/Ubuntu packaging tools need to learn about you
as well. Simply open your `~/.bashrc` in a text editor and add something like
this to the bottom of it::

    $ export DEBFULLNAME="Bob Dobbs"
    $ export DEBEMAIL="subgenius@example.com"


Now save the file and either restart your terminal or run::

    $ source ~/.bashrc

(If you do not use the default shell, which is `bash`, please edit
the configuration file for that shell accordingly.)


.. _`GNU Privacy Guard`: http://gnupg.org/
.. _SSH: http://www.openssh.com/
.. _Launchpad: http://launchpad.net
.. _`create one`: https://launchpad.net/+login
