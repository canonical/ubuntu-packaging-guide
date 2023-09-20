Install built packages
======================

You have a built binary package of a source package and want to install 
it (e.g. to test the package). This article demonstrates multiple ways 
how you can achive that.

Manual installation of binary packages (``.deb`` files)
-------------------------------------------------------

Using the advanced package manager (``apt``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Install binary packages
"""""""""""""""""""""""
::

    $ sudo apt install <PACKAGE.deb>...

Example::

    $ sudo apt install hello_2.10-3_amd64.deb

Uninstall packages (and keep its configuration files)
"""""""""""""""""""""""""""""""""""""""""""""""""""""
.. tip::

    It can be useful to keep the configuration files to avoid having to reconfigure the package if it is reinstalled later.

::

    $ sudo apt remove <PACKAGE-NAME>...

Example::

    $ sudo apt remove hello

Uninstall packages (and delete its configuration files)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
:: 

    $ sudo apt purge <PACKAGE-NAME>...

Example::

    $ sudo apt purge hello

You can find further information on the `man page <https://manpages.ubuntu.com/manpages/lunar/en/man8/apt.8.html>`_.

Using the debian package manager (``dpkg``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Install binary packages
"""""""""""""""""""""""
::

    $ sudo dpkg --install <PACKAGE.deb>...

Example::

    $ sudo dpkg --install hello_2.10-3_amd64.deb

Uninstall packages (and keep its configuration files)
"""""""""""""""""""""""""""""""""""""""""""""""""""""
.. tip::

    It can be useful to keep the configuration files to avoid having to reconfigure the package if it is reinstalled later.

::

    $ sudo dpkg --remove <PACKAGE-NAME>...

Example::

    $ sudo dpkg --remove hello

Uninstall packages (and delete its configuration files)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
::

    $ sudo dpkg --purge <PACKAGE-NAME>...

Example::

    $ sudo dpkg --purge hello
    
You can find further information on the `man page <https://manpages.ubuntu.com/manpages/lunar/en/man1/dpkg.1.html>`_.

Install packages from a PPA
---------------------------

Using ``add-apt-repository``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``add-apt-repository`` command is part of the ``software-properties-common`` 
package. It adds a repository (e.g. Launchpad PPA) into the 
``/etc/apt/sources.list`` or ``/etc/apt/sources.list.d`` (see `sources.list(5)`_), 
so you can install the packages provided by the repository like any other 
package from the archive.

Usage::

    sudo add-apt-repository ppa:<LAUNCHPAD-USERNAME>/<PPA-NAME>

Example::

    $ sudo add-apt-repository ppa:dviererbe/hello
    $ sudo apt install hello

You can find further information about the command on the `man page <https://manpages.ubuntu.com/manpages/lunar/man1/add-apt-repository.1.html>`_.


Add PPA to `sources.list(5)`_ manually
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When you visit the web interface of the PPA you want to add; you can see 
a text called *Technical details about this PPA*. When you click on the text, 
it will unfold und show the details you need to add the PPA.

.. image:: ../images/how-to/install-built-packages/launchpad-ppa-webinterface.png
   :align: center
   :width: 35 em
   :alt: Screenshot of the web-interface of the dviererbe/hello PPA; highlighting the technical details section.

1. Add PPA entry to ``/etc/apt/sources.list.d``
::

    $ sudo editor /etc/apt/sources.list.d/launchpad_ppa.sources

Add the lines like this and save:: 
    
    deb https://ppa.launchpadcontent.net/LAUNCHPAD-USERNAME/PPA-NAME/ubuntu SERIES main 
    deb-src https://ppa.launchpadcontent.net/LAUNCHPAD-USERNAME/PPA-NAME/ubuntu SERIES main 
    
2. Add the PPA signing key to ``/etc/apt/trusted.gpg.d``
::
    $ SIGNING_KEY='PASTE SIGNING KEY HERE'
    $ wget --quiet --output-document - \
      "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x${SIGNING_KEY,,}" \
      | sudo gpg --output /etc/apt/trusted.gpg.d/launchpad-ppa.gpg --dearmor -

3. Update package information
::

    $ sudo apt update

4. Install package from PPA
::

    $ sudo apt install PACKAGE-NAME

Example::

    $ sudo sh -c 'cat <<EOF > /etc/apt/sources.list.d/launchpad_ppa2.sources
    deb https://ppa.launchpadcontent.net/dviererbe/hello/ubuntu mantic main 
    deb-src https://ppa.launchpadcontent.net/dviererbe/hello/ubuntu mantic main 
    EOF'

    $ SIGNING_KEY=C83A46831F1FE7AB597E95B9699E49957C59EA64
    $ wget --quiet --output-document - \
    "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x${SIGNING_KEY,,}" \
    | sudo gpg --output /etc/apt/trusted.gpg.d/launchpad-ppa.gpg --dearmor -

    $ sudo apt update
    $ sudo apt install hello

Download the `.deb` files
^^^^^^^^^^^^^^^^^^^^^^^^^
You can download the binary package from a PPA and install it with ``apt`` 
or ``dpkg`` (see above).

Example::

    $ pull-ppa-deb --ppa dviererbe/hello hello
    $ sudo apt install hello_2.10-3_amd64.deb    

.. note::

    The ``pull-ppa-deb`` command is part of the ``ubuntu-dev-tools`` package. 
    This package also provides the commands: 

    - ``pull-lp-debs`` (to pull binary packages from launchpad) and 
    - ``pull-debian-debs`` (to pull binary packages from debians archive).

    You can find further information about them on the `man page <https://manpages.ubuntu.com/manpages/lunar/en/man1/pull-pkg.1.html>`_.

.. _sources.list(5): https://manpages.ubuntu.com/manpages/lunar/en/man5/sources.list.5.html