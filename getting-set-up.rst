Getting Set Up
==============

There are a number of things you need to do in the beginning to enable you to
do Ubuntu development. A few of them you have to do locally on your system.
In addition to that you also need to inform Launchpad about yourself, so it
accepts changes you want to make.

When you followed all the steps in this article, 

* you have all the tools to do Ubuntu development installed on your machine,
* your local developer tools know about you, which simplifies work a lot,
* you can do local builds of packages,
* you can interact with other developers and propose your changes on Launchpad
  to get merged,
* you can upload packages to Launchpad, so they are hosted in your Personal 
  Package Archive (PPA).


Running the development version
-------------------------------

It is advisable to run the current development version of Ubuntu. It will 
allow you to test changes in a "live environment" where they are actually 
built and tested in the development release you uploade them to.

https://wiki.ubuntu.com/UsingDevelopmentReleases shows a variety of ways to 
use the development release in a safe way.



Installing tools locally
------------------------

Just run::

  sudo apt-get install gnupg pbuilder ubuntu-dev-tools bzr-builddeb

and you should have all the tools you will need in the beginning.

* ``gnupg`` you will need to create a GPG key with which you will sign files
  you want to upload to Launchpad.
* ``pbuilder`` is a great tool to do a reproducible build of a package in a 
  clean and isolated environment.
* ``ubuntu-dev-tools`` (and ``devscripts``, a direct dependency) provide you
  with a collection of tools that make a lot of packaging tasks a lot easier.
* ``bzr-builddeb`` (and ``bzr``, a dependency) will get you set up for working
  in the distributed development environment, that makes it easy for many 
  developers to collaborate and work on the same code while keeping it trivial
  to merge each others work.


Setting up a GPG key
--------------------

GPG stands for `GNU Privacy Guard` and implements the OpenPGP standard which
allows you to sign and encrypt messages and files. This is useful for a number
of purposes. In our case it is important that you can sign files with your 
key, so they can be identified as something that you worked on. If you upload
a source package to Launchpad, it will only accept the package if it can tell
who uploaded the package.

To generate a new GPG key, run::

  gpg --key-gen

GnuPG will first ask you which kind of key you want to generate. Choosing the 
default (RSA and DSA) is fine. Next it will ask you about the keysize. The 
default (currently 2048) is fine, but 4096 is more secure. Afterwards it will
ask you if you want it to expire the key at some stage. It is safe to say "0",
which means the key will never expire. The last questions will be about your
name and email address. Just pick the ones you are going to use for Ubuntu
development here, you can add additional email addresses later on. Adding a 
comment is not necessary. Then you will have to set a passphrase. Choose a 
safe one. Now GnuPG will create a key for you, which can take a little bit 
of time, as it needs random bytes, so if you give the system some work to
do it will be just fine.

Once this is done, you will get a message similar to this one::

  pub   4096R/43CDE61D 2010-12-06
        Key fingerprint = 5C28 0144 FB08 91C0 2CF3  37AC 6F0B F90F 43CD E61D
  uid                  Daniel Holbach <dh@mailempfang.de>
  sub   4096R/51FBE68C 2010-12-06

In this case ``43CDE61D`` is they key ID. 

To upload (the public part of) of your key to a keyserver, so the world can 
identify messages and files as yours, just run::

  gpg --send-keys <KEY ID>

There is a network of keyservers that will automatically sync the key between
them.

Setting up an SSH key
---------------------

SSH is a network protocol that allows you to exchange data in a secure way 
over the network. In a lot of cases you will use it to access and open a 
shell on another machine. It is also very useful to transfer files in a secure
way.

To generate a SSH key, run::

  ssh-keygen -t rsa

The default filename makes sense, you can just leave it as it is. Also you 
can choose to use a passphrase or not.

We will use the SSH key to securely push code changes to Launchpad.


Setting up pbuilder
-------------------

``pbuilder`` allows you to build packages locally on your machine. It serves
a couple of purposes:

* the build will be done in a minimal and clean environment, where you can
  see if it succeeds in a reproducible way (with no modifications of the local
  system
* there is no need to install all necessary `build-dependencs` locally
* you can set up multiple instances for various Ubuntu and Debian releases

Setting ``pbuilder`` up is very easy. Edit `~/.pbuilderrc` and add the 
following line to it::

  COMPONENTS="main universe multiverse restricted"

This will ensure that `build-dependends` are satisfied using all components.

Then run::

  pbuilder-dist <release> create

where <release> is for example `natty`, `maverick`, `lucid` or in the case of
Debian maybe `sid`. This will take a while as it will download all the 
necessary packages for a "minimal installation". These will be cached though.


Setting up your development environment
---------------------------------------

Teaching Bazaar about you
^^^^^^^^^^^^^^^^^^^^^^^^^

Bazaar is the tool we use to store code changes in a logical way, to exchange
proposed changes and merge them, even if development is done concurrently.

To tell Bazaar who you are, simply run::

  bzr whoami "Frank Chu <fchu@example.com>"
  bzr launchpad-login fchu

`whoami` will tell Bazaar which name and email address it should use for your 
commit messages. With `launchpad-login` you set your Launchpad ID. This way 
code that you publish in Launchpad will be associated with you.

Note: If you can not remember the ID, go to https://launchpad.net/people/+me 
and see where it redirects you. The part after the "~" in the URL is your 
Launchpad ID.)


Introducing you to the development tools
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Similar to Bazaar, the Debian/Ubuntu packaging tools need to learn about you
as well. Simply open your `~/.bashrc` in a text editor and add something like 
this to the bottom of it::

  export DEBFULNAME="Frank Chu"
  export DEBEMAIL="fchu@example.com"


Now save the file and either restart your terminal or run::

  source ~/.bashrc

(If you use a different than the default shell, which is `bash`, please edit
the configuration file for that shell accordingly.)


Launchpad
---------
Launchpad is the central piece of infrastructure we use in Ubuntu. It stores
not only our packages and our code, but also things like translations, bug
reports, information about the people who work on Ubuntu and which teams they 
are part of.

You will need to register with Launchpad and give it some information about 
you so you can get started and it will accept packages, bug reports, code
branches, etc. from you.


Setting up a profile
^^^^^^^^^^^^^^^^^^^^

Generally it should be enough to head to https://launchpad.net/+login and 
enter your email address. It will send back an email to you with a link you
need to open in your browser. (If you don not receive it, check in your Spam
folder too.)

Next you will have to choose a display name. Almost everybody just uses their
real name here.

https://help.launchpad.net/YourAccount/NewAccount has more information about 
the process and additional settings you can change.


Uploading the GPG key to Launchpad
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To find about your GPG fingerprint, run::

  gpg --fingerprint <email@address.com>

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

Uploading your SSH key
^^^^^^^^^^^^^^^^^^^^^^

Open https://launchpad.net/people/+me/+editsshkeys in a web browser, also open
``~/.ssh/id_rsa.pub`` in a text editor. It is the public part of your SSH key, 
so it is safe to share it with Launchpad. Copy the contents of the file and 
paste them into the text box on the web page that says "Add an SSH key". Now 
click "Import Public Key".

More information is available at 
https://help.launchpad.net/YourAccount/CreatingAnSSHKeyPair
