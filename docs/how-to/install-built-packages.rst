Install built packages
======================

You have a built :term:`binary package <Binary Package>` of a
:term:`source packages <Source Package>` and want to install it (e.g. to test
the package). This article demonstrates multiple ways how you can achive that.

Manual installation of binary packages (``.deb`` files)
-------------------------------------------------------

Using the Advanced Package Manager (APT)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install binary packages
^^^^^^^^^^^^^^^^^^^^^^^

.. code:: text

    sudo apt install <PACKAGE.deb>...

Example

.. code:: bash

    sudo apt install hello_2.10-3_amd64.deb

Uninstall packages (and keep its configuration files)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tip::

    It can be useful to keep the configuration files to avoid having to reconfigure the package if it is reinstalled later.

.. code:: text

    sudo apt remove <PACKAGE-NAME>...

Example

.. code:: bash

    sudo apt remove hello

Uninstall packages (and delete its configuration files)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: text

    sudo apt purge <PACKAGE-NAME>...

Example

.. code:: bash

    sudo apt purge hello

You can find further information on the manual page: :manpage:`apt(8)`.

Using the debian package manager (:command:`dpkg`)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install binary packages
^^^^^^^^^^^^^^^^^^^^^^^

.. code:: text

    sudo dpkg --install <PACKAGE.deb>...

Example

.. code:: bash

    sudo dpkg --install hello_2.10-3_amd64.deb

Uninstall packages (and keep its configuration files)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tip::

    It can be useful to keep the configuration files to avoid having to reconfigure
    the :term:`Package` if it is reinstalled later.

.. code:: text

    sudo dpkg --remove <PACKAGE-NAME>...

Example

.. code:: bash

    sudo dpkg --remove hello

Uninstall packages (and delete its configuration files)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: text

    sudo dpkg --purge <PACKAGE-NAME>...

Example

.. code:: bash

    sudo dpkg --purge hello
    
You can find further information on the manual page: :manpage:`dpkg(1)`.

.. _InstallPackagesFromPPA:

Install packages from a PPA
---------------------------

Using :command:`add-apt-repository`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The :command:`add-apt-repository` command is part of the ``software-properties-common`` 
package. It adds a :term:`Repository` (e.g. :term:`Launchpad` :term:`Personal Package Archive`)
into the :file:`/etc/apt/sources.list` or :file:`/etc/apt/sources.list.d`
(see :manpage:`sources.list(5)`), so you can install the :term:`Packages <Package>`
provided by the :term:`Repository` like any other :term:`Package` from the :term:`Ubuntu Archive`.

Usage

.. code:: text

    sudo add-apt-repository ppa:<LAUNCHPAD-USERNAME>/<PPA-NAME>

Example

.. code:: bash

    sudo add-apt-repository ppa:dviererbe/hello
    sudo apt install hello

You can find further information about the command on the manual page: :manpage:`add-apt-repository(1)`.


Add PPA to :file:`sources.list` manually
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When you visit the web interface of the :term:`PPA` you want to add; you can see 
a text called *Technical details about this PPA*. When you click on the text, it
will unfold und show the details you need to add the :term:`PPA`.

.. image:: ../images/how-to/install-built-packages/launchpad-ppa-webinterface.png
   :align: center
   :width: 35 em
   :alt: Screenshot of the web-interface of the dviererbe/hello PPA; highlighting the technical details section.

1. Add :term:`PPA` entry to :file:`/etc/apt/sources.list.d`
   
   .. code:: bash

       sudo editor /etc/apt/sources.list.d/launchpad_ppa.sources

   Add the lines like this and save
    
   .. code::
        
       deb https://ppa.launchpadcontent.net/LAUNCHPAD-USERNAME/PPA-NAME/ubuntu SERIES main 
       deb-src https://ppa.launchpadcontent.net/LAUNCHPAD-USERNAME/PPA-NAME/ubuntu SERIES main 
    
2. Add the :term:`PPA` :term:`Signing Key` to ``/etc/apt/trusted.gpg.d``
   
   .. code::

       SIGNING_KEY='PASTE SIGNING KEY HERE'
       wget --quiet --output-document - \
       "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x${SIGNING_KEY,,}" \
       | sudo gpg --output /etc/apt/trusted.gpg.d/launchpad-ppa.gpg --dearmor -

3. Update package information
   
   .. code::

       sudo apt update

4. Install package from :term:`PPA`

   .. code:: bash

       sudo apt install PACKAGE-NAME

Example

.. code:: bash

    sudo sh -c 'cat <<EOF > /etc/apt/sources.list.d/launchpad_ppa2.sources
    deb https://ppa.launchpadcontent.net/dviererbe/hello/ubuntu mantic main 
    deb-src https://ppa.launchpadcontent.net/dviererbe/hello/ubuntu mantic main 
    EOF'

    SIGNING_KEY=C83A46831F1FE7AB597E95B9699E49957C59EA64
    wget --quiet --output-document - \
    "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x${SIGNING_KEY,,}" \
    | sudo gpg --output /etc/apt/trusted.gpg.d/launchpad-ppa.gpg --dearmor -

    sudo apt update
    sudo apt install hello

Download the `.deb` files
~~~~~~~~~~~~~~~~~~~~~~~~~
You can download the :term:`Binary Package` from a :term:`Personal Package Archive`
and install it with :command:`apt` or :command:`dpkg` (see above).

Example

.. code:: bash

    pull-ppa-deb --ppa dviererbe/hello hello
    sudo apt install hello_2.10-3_amd64.deb    

.. note::

    The ``pull-ppa-deb`` command is part of the ``ubuntu-dev-tools`` :term:`Package`. 
    This :term:`Package` also provides the commands: 

    - ``pull-lp-debs`` (to pull binary packages from launchpad) and 
    - ``pull-debian-debs`` (to pull binary packages from debians archive).

    You can find further information about them on the manual page :manpage:`pull-pkg(1)`.

Resources
---------

- `Ubuntu Server documentation -- Package management <https://ubuntu.com/server/docs/package-management>`_
- `Ubuntu wiki -- Installing Software <https://help.ubuntu.com/community/InstallingSoftware>`_