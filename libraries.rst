================
Shared Libraries
================

Shared libraries are compiled code which is intended to be shared
among several different programmes.  They are distributed as ``.so``
files in ``/usr/lib/``.  

A library exports symbols which are the compiled versions of
functions, classes and variables.  A library has a name called an
SONAME which includes a version number.  This SONAME version does not
necessarily match the public release version number.  A programme gets
compiled against a given SONAME version of the library.  If any of the
symbols is removed or changes then the version number needs to be
changed which forces any packages using that library to be recompiled
against the new version.  Version numbers are usually set by upstream
and we follow them in our binary package names called an ABI number,
but sometimes upstreams do not use sensible version numbers and
packagers have to keep separate version numbers.

Libraries are usually distributed by upstream alone.  They should be
split into a binary package for the library and one for the
development files.

Sometimes they are distributed as part of a programme.  They can be
included in the binary package along with the programme if you do not
expect any other programmes to use the library, otherwise you should
split out the library into its own package and -dev package.


An Example
-----------

We will use libnova as an example::

    $ bzr branch ubuntu:natty/libnova
    $ sudo apt-get install libnova-dev

To find the SONAME of the library run

    $ readelf -a /usr/lib/libnova-0.12.so.2 | grep SONAME

The SONAME is ``libnova-0.12.so.2``.  Here upstream has put the upstream
version number as part of the SONAME and given is an ABI version of ``2``.  The
library binary package is called ``libnova-0.12-2`` where ``libnova-0.12`` is
the name of the library and ``2`` is the ABI number. Looking in
debian/libnova-0.12-2.install we see it includes two files::

    usr/lib/libnova-0.12.so.2
    usr/lib/libnova-0.12.so.2.0.0

The last one is the actual library, complete with minor and point version
number.  The first one is a symlink which points to the actual library.  The
symlink is what programmes using the library will look for, the running
programmes do not care about the minor version number.

``libnova-dev.install`` includes all the files needed to compile a programme
with this library.  Header files, a config binary, the ``.la`` libtool file and
``libnova.so`` which is another symlink pointing at the library, programmes
compiling against the library do not care about the major version number
(although the binary they compile into will).


Static Libraries
----------------

The -dev package also ships ``usr/lib/libnova.a``.  This is a static library,
an alternative to the shared library.  Any programme compiled against the
static library will include the code directory into itself.  This gets round
worrying about binary compatibility of the library.  However it also means that
any bugs, including security issues, will not be updated along with the libary
until the programme is recompiled.  For this reason programmes using static
libraries are discouraged.


Symbol Files
------------

When a package builds against a library the ``shlibs`` mechanism will add a
package dependency on that library.  This is why most programmes will have
``Depends: ${shlibs:Depends}`` in ``debian/control``.  That gets replaced with
the library dependencies at build time.  However shlibs can only make it depend
on the major ABI version number, ``2`` in our libnova example, so if new symbols
get added in libnova 2.1 a programme using these symbols could still be
installed against libnova ABI 2.0 which would then crash.

To make the library dependencies more precise we keep ``.symbols`` files that
list all the symbols in a library and the version they appeared in.

libnova has no symbols file so we can create one.  Start by compiling the
package::

    $ bzr builddeb -- -nc

The ``-nc`` will cause it to finish at the end of the compile without removing
the build.  Change to the build and run ``dpkg-gensymbols`` for the library
package::

    $ cd ../build-area/libnova-0.12.2/
    $ dpkg-gensymbols -plibnova-0.12-2 > symbols.diff

This makes a diff file which you can self apply::

    $ patch -p0 < symbols.diff

Which will create a file named similar to ``dpkg-gensymbolsnY_WWI`` that lists
all the symbols.  It also lists the current package version.  We can remove the
packaging version from that listed in the symbols file because new symbols are
not generally added by new packaging versions::

    $ sed -i s,-0ubuntu2,, dpkg-gensymbolsnY_WWI

Now move the file into its location, commit and do a test build::

    $ mv dpkg-gensymbolsnY_WWI ../../libnova/debian/libnova-0.12-2.symbols
    $ cd ../../libnova
    $ bzr add debian/libnova-0.12-2.symbols
    $ bzr commit -m "add symbols file"
    $ bzr builddeb

If it successfully compiles the symbols file is correct.  With the next
upstream version of libnova you would run dpkg-gensymbols again and it will
give a diff to update the symbols file.

C++ Library Symbols Files
-------------------------

C++ has even more exacting standards of binary compatibility than C.  The
Debian Qt/KDE Team maintain some scripts to handle this, see their `Working with
symbols files`_ page for how to use them.

.. _`Working with symbols files`: http://pkg-kde.alioth.debian.org/symbolfiles.html
