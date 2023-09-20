Supported Architectures
=======================

.. list-table::
    :header-rows: 1

    * - Identifier
      - Alternative Architecture Names
      - Endianness
      - Architecture Type
    * - ``amd64``
      - *x86-64*, *x86_64*, *x64*, *AMD64*, *Intel 64*
      - :term:`Little-Endian`
      - :term:`CISC`
    * - ``i386`` [1]_
      - *Intel x86*, *80x86*
      - :term:`Little-Endian`
      - :term:`CISC`
    * - ``arm64``
      - *ARM64*, *ARMv8*, *AArch64*
      - :term:`Little-Endian`
      - :term:`RISC`
    * - ``armhf``
      - *ARM32*, *ARMv7*, *AArch32*, *ARM Hard Float*
      - :term:`Little-Endian`
      - :term:`RISC`
    * - ``ppc64el``
      - *PowerPC64 Little-Endian* 
      - :term:`Little-Endian`
      - :term:`RISC`
    * - ``powerpc``
      - *PowerPC* (32-bit)
      - :term:`Big-Endian`
      - :term:`RISC`
    * - ``s390x``
      - *IBM System z*, *S/390*, *S390X*       
      - :term:`Big-Endian`
      - :term:`CISC`
    * - ``riscv64``
      - *RISC-V* (64-bit)
      - :term:`Little-Endian`
      - :term:`RISC`

.. [1] ``i386`` is a partial-port of :term:`Ubuntu`, which is supported as a multi-arch supplementary :term:`Architecture`. There is no kernel, installers, bootloaders for ``i386``, therefore it cannot be booted as pure ``i386`` installation. You have to crossbuild ``i386`` or build in a ``i386`` chroot on a ``amd64`` host.

Other Architectures
-------------------

:term:`Ubuntu` doesn't currently support any other :term:`architectures <Architecture>`.
This doesn't mean that :term:`Ubuntu` won't run on other :term:`architectures <Architecture>`
-- in fact it is entirely possible that it *will* install without a problem, because,
:term:`Ubuntu` is based on the :term:`Debian` distribution, which has support for eight
additional :term:`architectures <Architecture>` (see `Debian Supported Architectures <https://wiki.debian.org/SupportedArchitectures>`_).

However, if you run into problems, the :term:`Ubuntu` community may not be able to help you.

Resources
---------

- `Ubuntu Wiki -- Supported Architectures <https://help.ubuntu.com/community/SupportedArchitectures>`_
- `Ubuntu Wiki -- i386 <https://wiki.ubuntu.com/i386>`_
- `Statement on 32-bit i386 packages for Ubuntu 19.10 and 20.04 LTS <https://canonical.com/blog/statement-on-32-bit-i386-packages-for-ubuntu-19-10-and-20-04-lts>`_
- `Ubuntu Wiki -- S390X <https://wiki.ubuntu.com/S390X>`_
- `Ubuntu Downloads <https://ubuntu.com/download>`_
