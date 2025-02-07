.. include:: /reuse/snippets/quilt/install.bash
    :code: bash

By running the following script once in a terminal you will configure :manpage:`quilt(1)`
to look for patches in the ``debian/patches/`` directory if  the ``quilt`` command
is invoked within a :term:`source package <Source Package>` directory:

.. include:: /reuse/snippets/quilt/configure.bash
    :code: bash

.. note::

    If you later want to undo this configuration -- simply delete :file:`~/.quiltrc`:

    .. code-block:: none

        rm ~/.quiltrc
