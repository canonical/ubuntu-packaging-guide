Install built packages
======================

You have a built :term:`binary package <Binary Package>` of a
:term:`source package <Source Package>` and want to install it (e.g. to test
the package). This article demonstrates three ways to achieve that: manually
installing binaries with the Advanced Package Manager (APT), manually
installing with the Debian Package Manager (dpkg), and installing from a
Personal Package Archive (PPA).

Manually install ``.deb`` files with APT
----------------------------------------

Install binary packages
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    sudo apt install <PACKAGE.deb>...

Example
^^^^^^^

.. code:: bash

    sudo apt install hello_2.10-3_amd64.deb

Uninstall packages (keeping config files)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tip::

    It can be useful to keep the configuration files to avoid needing to reconfigure the package if it is reinstalled later.

.. code:: bash

    sudo apt remove <PACKAGE-NAME>...

Example
^^^^^^^

.. code:: bash

    sudo apt remove hello

Uninstall packages (deleting config files)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    sudo apt purge <PACKAGE-NAME>...

Example
^^^^^^^

.. code:: bash

    sudo apt purge hello

You can find further information on the manual page: :manpage:`apt(8)`.

Install using :command:`dpkg`
-----------------------------

Install binary packages
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    sudo dpkg --install <PACKAGE.deb>...

Example
^^^^^^^

.. code:: bash

    sudo dpkg --install hello_2.10-3_amd64.deb

Uninstall packages (keeping config files)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tip::

    It can be useful to keep the configuration files to avoid having to reconfigure
    the package if it is reinstalled later.

.. code:: bash

    sudo dpkg --remove <PACKAGE-NAME>...

Example
^^^^^^^

.. code:: bash

    sudo dpkg --remove hello

Uninstall packages (deleting config files)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

    sudo dpkg --purge <PACKAGE-NAME>...

Example
^^^^^^^

.. code:: bash

    sudo dpkg --purge hello
    
You can find further information on the manual page: :manpage:`dpkg(1)`.

.. _InstallPackagesFromPPA:

Install packages from a PPA
---------------------------

Using :command:`add-apt-repository`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The :command:`add-apt-repository` command is part of the
``software-properties-common`` package. It adds a :term:`Repository` (e.g. a
:term:`Personal Package Archive` from :term:`Launchpad`) to the
:file:`/etc/apt/sources.list.d` directory (see :manpage:`sources.list(5)`),
so you can install the packages provided by the repository like any other
package from the :term:`Ubuntu Archive`.

Usage
^^^^^

.. code:: bash

    sudo add-apt-repository ppa:<LAUNCHPAD-USERNAME>/<PPA-NAME>

Example
^^^^^^^

.. code:: bash

    sudo add-apt-repository ppa:dviererbe/hello
    sudo apt install hello

You can find further information about the command on the manual page:
:manpage:`add-apt-repository(1)`.


Add PPA to :file:`sources.list` manually
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When you visit the web interface of the :term:`PPA` you want to add, you can
see a text reading something like "Technical details about this PPA". When you
click on the text, it will unfold und show the details you need to add the
PPA.

.. image:: ../images/how-to/install-built-packages/launchpad-ppa-webinterface.png
   :align: center
   :width: 35 em
   :alt: Web-interface of the dviererbe/hello PPA; highlighting the technical details section.

The steps to add the PPA are as follows:

1. Add the PPA entry to :file:`/etc/apt/sources.list.d`
   
   .. code-block:: bash

       sudo editor /etc/apt/sources.list.d/launchpad_ppa.sources

   Add the following lines (substituting ``LAUNCHPAD-USERNAME`` AND
   ``PPA-NAME`` for your own case) and save the file:
    
   .. code-block::
        
       deb https://ppa.launchpadcontent.net/LAUNCHPAD-USERNAME/PPA-NAME/ubuntu SERIES main 
       deb-src https://ppa.launchpadcontent.net/LAUNCHPAD-USERNAME/PPA-NAME/ubuntu SERIES main 
    
2. Add the PPA :term:`Signing Key` to ``/etc/apt/trusted.gpg.d``:
   
   .. code-block::

       SIGNING_KEY='PASTE SIGNING KEY HERE'
       wget --quiet --output-document - \
       "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x${SIGNING_KEY,,}" \
       | sudo gpg --output /etc/apt/trusted.gpg.d/launchpad-ppa.gpg --dearmor -

3. Update the package information:
   
   .. code::

       sudo apt update

4. Install the package from the PPA:

   .. code:: bash

       sudo apt install PACKAGE-NAME

Example:
^^^^^^^^

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

You can download the binary package from a PPA and install it with
:command:`apt` or :command:`dpkg` (see above).

Example
^^^^^^^

.. code:: bash

    pull-ppa-deb --ppa dviererbe/hello hello
    sudo apt install hello_2.10-3_amd64.deb    

.. note::

    The ``pull-ppa-deb`` command is part of the ``ubuntu-dev-tools`` package. 
    This package also provides the commands: 

    - ``pull-lp-debs`` (to pull binary packages from Launchpad) and 
    - ``pull-debian-debs`` (to pull binary packages from Debian's archive).

    You can find further information about them on the manual page :manpage:`pull-pkg(1)`.

Resources
---------

- `Ubuntu Server documentation -- Package management <https://ubuntu.com/server/docs/package-management>`_
- `Ubuntu wiki -- Installing Software <https://help.ubuntu.com/community/InstallingSoftware>`_