Glossary
========

.. glossary::

    80x86
        See :term:`i386`

    AA
        Abbreviation for :term:`Archive Admin`

    AArch32
        See :term:`armhf`

    AArch64
        See :term:`arm64`

    ABI
        Abbreviation for :term:`Application Binary Interface`

        .. warning::

            Do not confuse with :term:`Application Programming Interface` (:term:`API`)!

    amd64
        :term:`CPU` :term:`Architecture` identifier for the ``AMD64`` (also known
        as :term:`x64`, :term:`x86-64`, :term:`x86_64`, and :term:`Intel 64`)
        architecture; a 64-bit version of the :term:`i386` instruction set.

        See also: `X86-64 (Wikipedia) <https://en.wikipedia.org/wiki/X86-64>`_

    ANAIS
        Abbreviation for :term:`Architecture Not Allowed In Source`

    API
        Abbreviation for :term:`Application Programming Interface`

        .. warning::

            Do not confuse with :term:`Application Binary Interface` (:term:`ABI`)!

    Application Binary Interface
        Defines how two binary applications interface eachother like calling conventions,
        data type sizes, and system call interfaces, ensuring compatibility and proper
        communication between different parts of a software system, such as libraries,
        executables, and the :term:`Operating System`. *Application Binary Interfaces*
        are crucial for enabling software components compiled on different systems
        to work together seamlessly.

        See also: `Kernel ABI (Ubuntu Wiki) <https://wiki.ubuntu.com/KernelTeam/BuildSystem/ABI>`_, `Application binary interface (Wikipedia) <https://en.wikipedia.org/wiki/Application_binary_interface>`_

        .. warning::

            Do not confuse with :term:`Application Programming Interface` (:term:`API`)!

    Application Programming Interface
        An *Application Programming Interface* (API), is a set of rules that allows
        different software applications to communicate with each other. It defines
        the methods and data formats that applications can use to request and exchange
        information, perform specific tasks, or access the functionality of another
        software component, such as an :term:`Operating System`, library, or online
        service. *APIs* enable developers to build upon existing software and create
        new applications by providing a standardized way to interact with external
        systems, services, or libraries without needing to understand their internal
        workings.

        .. warning::

            Do not confuse with :term:`Application Binary Interface` (:term:`ABI`)!

    APT
        Abbreviation for *Advanced Package Manager*. 
        
        See: :doc:`/reference/apt`

    Architecture
        Within the context of :term:`Ubuntu`, this refers to the system architecture
        (more specifically, the CPU architecture and its instruction set) an application
        is designed for.

        See also: :doc:`/reference/architectures`, `Computer Architecture (Wikipedia) <https://en.wikipedia.org/wiki/Computer_architecture>`_

    Architecture Not Allowed In Source
        *Work in Progress*

    Archive
        See :term:`Ubuntu Archive`

    Archive Admin
        An administrator that is responsible for maintenance tasks of the
        :term:`Ubuntu Package Archive <Ubuntu Archive>`, including processing of new
        :term:`Packages <Package>`, migration of :term:`Packages <Package>` between
        :term:`Components <Component>`, and other administrative matters.

        See also: `"Ubuntu Package Archive Administrators" team on Launchpad <https://launchpad.net/~ubuntu-archive>`_

    Archive Mirror
        A :term:`Mirror` of the :term:`Ubuntu Archive`.

        See the section :ref:`ArchiveMirrors` for more details.

    ARM
        *ARM* (formerly an acronym for *Advanced RISC Machines* and originally
        *Acorn RISC Machine*) is a widely used family of :term:`RISC` :term:`CPU`
        :term:`Architectures <Architecture>` known for their efficiency,
        low power consumption, and versatility, which are widely used in
        :term:`Embedded Systems` and mobile devices.

        Notable examples are :term:`arm64` and :term:`armhf`.

        See also: `ARM architecture family (Wikipedia) <https://en.wikipedia.org/wiki/ARM_architecture_family>`_

    ARM Hard Float
        See :term:`armhf`

    arm64
        :term:`CPU` :term:`Architecture` identifier (also known as ARM64,
        :term:`ARMv8`, and :term:`AArch64`) for a 64-bit :term:`ARM` :term:`Architecture`
        variant.

        See also: `AArch64 (Wikipedia) <https://en.wikipedia.org/wiki/AArch64>`_

    armhf
        :term:`CPU` :term:`Architecture` identifier (also known as ARM32,
        :term:`ARMv7`, :term:`AArch32`, and :term:`ARM Hard Float`) for a 32-bit
        :term:`ARM` :term:`Architecture` variant.

        See also: `AArch64 (Wikipedia) <https://en.wikipedia.org/wiki/AArch64>`_

    ARMv7
        See :term:`armhf`

    ARMv8
        See :term:`arm64`

    autopkgtest
        *Work in Progress*

    Backports
        *Work in Progress*

    Bazaar
        A distributed :term:`Version Control System` to collaborate on software development,
        that was developed by :term:`Canonical` and is part of the :term:`GNU` system.

        *Bazaar* as a :term:`Canonical` project is discontinued. Development has been carried
        forward in the community as :term:`Breezy`.

        See also: `Bazaar (Launchpad) <https://launchpad.net/bzr>`

        .. note::
        
            *Bazaar* is replaced in favor of a :term:`git`-based workflow as the
            main :term:`Version Control System` within :term:`Ubuntu`. There are
            some projects that still use it, but be aware that documents that reference
            *Bazaar* as an actively used :term:`Version Control System` within :term:`Ubuntu`
            are most likely outdated.

            See also: :term:`git-ubuntu`

    Big-Endian
        *Work in Progress*

        See also: :term:`Endianness`

    Binaries
        *Work in Progress*

    Binary Package
        A :term:`Debian` *binary package* is a standardized format with the file extension
        :file:`.deb` that the :term:`Package Manager` (:manpage:`dpkg(1)` or :manpage:`apt(8)`)
        can understand to install and uninstall software on a target machine to simplify
        distributing software to a target machine and managing software on a target machine.

        See: :ref:`Binary Packages (explanation) <BinaryPackages>`

    Branch
        *Work in Progress*

    Breezy
        A :term:`Fork` of the :term:`Bazaar` :term:`Version Control System`.

        See also: `Breezy (Launchpad) <https://launchpad.net/brz>`_,
        `www.breezy-vcs.org <https://www.breezy-vcs.org/>`_

    BTS
        Abbreviation for :term:`Bug Tracking System`

    Bug
        In software development a *"bug"* refers to unintended or unexpected behaviour
        of a computer program or system that produce incorrect results, or crashes.
        *Bugs* can occur due to programming mistakes, design issues, or unexpected
        interactions between different parts of the software.
        
        Identifying and fixing *Bugs* is a fundamental part of the software development
        process to ensure that the software functions as intended and is free of errors.

        See also: `Software bug (Wikipedia) <https://en.wikipedia.org/wiki/Software_bug>`_

    Bug Tracking System
        A platform used by software development teams to manage and monitor the progress
        of reported issues or :term:`Bugs <Bug>` within a software project. It provides
        a centralized platform for users to report problems, assign tasks to developers,
        track the status of issues, prioritize fixes, and maintain a comprehensive record
        of software defects and their resolutions. This system helps streamline the debugging
        process and enhances communication among team members, ultimately leading to improved
        software quality.

        :term:`Launchpad` is the *Bug Tracking System* for :term:`Ubuntu` :term:`Packages <Package>`.

        See also: `Bug tracking system (Wikipedia) <https://en.wikipedia.org/wiki/Bug_tracking_system>`_

    BZR
        Abbreviation for :term:`Bazaar`

    Canonical
        *Canonical Ltd.* is a UK-based private company that is devoted to the
        :term:`Free and Open Source Software` philosophy and created several
        notable software projects, including :term:`Ubuntu`. *Canonical* offers
        commercial support for :term:`Ubuntu` and related services and is responsible
        for delivering six-monthly milestone releases and regular :term:`LTS` releases
        for enterprise production use, as well as security updates, support and the
        entire online infrastructure for community interaction.

        Find out more on the Canonical website: `canonical.com <https://canonical.com/>`_

    Canonical Discourse
        A :term:`Discourse` instance for internal/company-wide discussions. 
        The discussions here will only be accessible to the :term:`Canonical` employes.

        See: `discourse.ubuntu.com <https://discourse.canonical.com>

    CD
        Abbreviation for :term:`Continuous Delivery`

    CD Mirror
        A :term:`Mirror` of the :term:`Ubuntu` :term:`Image` archive
        (`cdimage.ubuntu.com <https://cdimage.ubuntu.com/>`_).

        You can find a complete list of officially recognized :term:`Ubuntu` :term:`Image`
        archive :term:`Mirrors <Mirror>` `here <https://launchpad.net/ubuntu/+cdmirrors>`_.

    Central Processing Unit
        The main component of a computer, that is responsible for executing the instructions
        of a computer program, such as arithmetic, logic, and input/output (I/O) operations.

    Certified Ubuntu Engineer
        Develop and certify your skills on the world's most popular :term:`Linux` :term:`OS`. https://ubuntu.com/credentials

    Changelog
        The :file:`debian/changelog` file in a :term:`Source Package`.

        See: :doc:`/reference/debian-dir-overview`

        See also: `Section 4.4 Debian changelog (Debian Policy Manual v4.6.2.0) <https://www.debian.org/doc/debian-policy/ch-source.html#debian-changelog-debian-changelog>`_

    Checkout
        *Work in Progress*

    CI
        Abbreviation for :term:`Continuous Integration`

    Circle of Friends
        The :term:`Ubuntu` logo is called *Circle of Friends*, because it is derived
        from a picture that shows three friends extending their arms,
        overlapping in the shape of a circle. It should represent the
        `core values of Ubuntu <https://design.ubuntu.com/brand>`_:
        *Freedom*, *Reliable*, *Precise* and *Collaborative*.

        .. image:: ../images/reference/glossary/CoF-Square.svg
            :width: 200
            :height: 200
            :alt: Circle of Friends (Ubuntu Logo)
        
        .. image:: ../images/reference/glossary/Old-Ubuntu-Login-Background.jpg
            :height: 200
            :alt: Old Ubuntu-Login background showing three people in a circle holding hands.

    CISC
        Abbreviation for :term:`Complex Instruction Set` Computer

    CLA
        Abbreviation for :term:`Contributor Licence Agreement`

    CLI
        Abbreviation for :term:`Command Line Interface`

    Closed Source Software
        *Work in Progress*

    CoC
        Abbreviation for :term:`Code of Conduct`

    Codename
        *Work in Progress*

    Code of Conduct
        *Work in Progress*

        See also: :term:`Ubuntu Code of Conduct`

    Code Review
        *Work in Progress*

    CoF
        Abbreviation for :term:`Circle of Friends`

    Command Line Interface
        *Work in Progress*

    Commit
        *Work in Progress*

    Common Vulnerabilities and Exposures
        *Work in Progress*

    Complex Instruction Set
        A :term:`CPU` :term:`Architecture` featuring a rich and diverse set of instructions,
        often capable of performing complex operations in a single instruction. :term:`CISC`
        processors aim to minimize the number of instructions needed to complete a task,
        potentially sacrificing execution speed for instruction richness.

        See also: `Complex instruction set computer (Wikipedia) <https://en.wikipedia.org/wiki/Complex_instruction_set_computer>`_

    Component
        *Components* are logical subdivisions or namespaces of the :term:`Packages <Package>`
        in a :ref:`ArchiveSuite`. The :term:`APT` :term:`Package Manager` can individually
        subscribe to the *components* of a :ref:`ArchiveSuite`.

        The :term:`Packages <Package>` of an :term:`Ubuntu` :ref:`ArchiveSeries` are categorized
        if they are :term:`Open Source Software` and part of the Base :term:`Packages <Package>`
        for a given :ref:`ArchiveSeries` and sorted into the *components*
        :ref:`ArchiveComponents_Main`,
        :ref:`ArchiveComponents_Restricted`,
        :ref:`ArchiveComponents_Universe`, or
        :ref:`ArchiveComponents_Multiverse`, as shown in the following table:

        +----------------------------+-----------------------------------+-------------------------------------+
        |                            | :term:`Open Source Software`      | :term:`Closed Source Software`      |
        +----------------------------+-----------------------------------+-------------------------------------+
        | **Ubuntu Base Packages**   | :ref:`ArchiveComponents_Main`     | :ref:`ArchiveComponents_Restricted` |
        +----------------------------+-----------------------------------+-------------------------------------+
        | **Community Packages**     | :ref:`ArchiveComponents_Universe` | :ref:`ArchiveComponents_Multiverse` |
        +----------------------------+-----------------------------------+-------------------------------------+

        See: :ref:`Components (explanation) <ArchiveComponents>`

    Continuous Delivery
        *Work in Progress*

        See also: `Continuous delivery (Wikipedia) <https://en.wikipedia.org/wiki/Continuous_delivery>`_

    Continuous Integration
        *Work in Progress*

        See also: `Continuous integration (Wikipedia) <https://en.wikipedia.org/wiki/Continuous_integration>`_

    Contributor Licence Agreement
        *Work in Progress*

    Control File
        The :file:`debian/control` file in a :term:`Source Package`.

        See: :doc:`/reference/debian-dir-overview`

        This can also refer to a :term:`Debian` source control file (``.dsc`` file)
        or the control file in a :term:`Binary Package` (``.deb`` file).

        See: `Chapter 5. Control files and their fields (Debian Policy Manual v4.6.2.0) <https://www.debian.org/doc/debian-policy/ch-controlfields.html>`_

    Coordinated Release Date
        The date at which the details of a :term:`CVE` are to be publicly disclosed.

    Copyleft
        *Work in Progress*

    Copyright
        *Work in Progress*

    Copyright File
        The :file:`debian/copyright` file in a :term:`Source Package`.

        See: :doc:`/reference/debian-dir-overview`

        See also: `Section 4.5. Copyright (Debian Policy Manual v4.6.2.0) <https://www.debian.org/doc/debian-policy/ch-source.html#copyright-debian-copyright>`_

    CPU
        Abbreviation for :term:`Central Processing Unit`

    CRD
        Abbreviation for :term:`Coordinated Release Date`

    CUE
        Abbreviation for :term:`Certified Ubuntu Engineer`

    Current Release in Development
        :term:`Ubuntu` follows a strict time-based release cycle. Every six months a
        new :term:`Ubuntu` version is released.

        The *"Current Release in Development"* is the :term:`Ubuntu` version that is
        in development for the next release at any given time. It is also often referred
        to as "devel".

        See: :doc:`Ubuntu Releases (explanation) </explanation/releases>`

    CVE
        Abbreviation for :term:`Common Vulnerabilities and Exposures`

    Debian
        *Debian* is a widely used community-driven
        :term:`Free and Open Source <Free and Open Source Software>` :term:`Operating System`
        known for its stability and extensive software :term:`Repository`. It follows
        a strict commitment to :term:`Free and Open Source Software` principles and
        serves as the basis for various :term:`Linux` :term:`Distributions <distribution>`
        (including :term:`Ubuntu`). *Debian'* :term:`Package Manager`, :term:`APT`,
        simplifies software installation and updates, making it a popular choice
        for servers and desktops.

        See also: `www.debian.org <https://www.debian.org/>`_

    Debian System Administration
        *Work in Progress*

    deb
    debs
        `.deb` is the file extension of a :term:`Debian` :term:`Binary Package`.

    Detached Signature
        A detached signature is a :term:`Digital Signature <Signature>` that is separated
        from the data it signs. In contrast to an embedded signature, which is included
        within the data it signs, a detached signature is kept as a separate file
        or entity. 

    Devel
        Shorthand term for the :term:`Current Release in Development`.

    Developer Membership Board
        *Work in Progress*

        See also: `Developer Membership Board (Ubuntu Wiki) <https://wiki.ubuntu.com/DeveloperMembershipBoard>`_

    diff
        A text format that shows the difference between files that are compared.
        A file that contains text in this format usually has the file extension `.diff`.
        This file format does not work well for comparing files in a non-text encoded
        fromat (e.g. ``.bin``, ``.png``, ``.jpg``).

        See also :manpage:`diff(1)`, :manpage:`git-diff(1)`

    Discourse
        An :term:`open-source <Open Source Software>` forum software that is used 
        by :term:`Ubuntu` and :term:`Canonical`.

        See also: :term:`Ubuntu Discourse`, :term:`Canonical Discourse`,
        `Discourse Project Homepage <https://www.discourse.org/>`_

    Distribution
        In general, a software *distribution* (also called *"distro"*) is a set of
        software components that is distributed as a whole to users.

        Usually people think specifically of :term:`Linux` *distributions*. A :term:`Linux`
        *distribution* (or distro), is a complete :term:`Operating System` based on the
        :term:`Linux` :term:`Kernel`. It includes essential system components, software
        applications, and :term:`Package Management Tools <Package Manager>`, tailored
        to a specific purpose or user preferences. :term:`Linux` distributions vary
        in features, desktop environments, and software :term:`Repositories <Repository>`,
        allowing users to choose the one that best suits their needs.

        See also: `Linux distribution (Wikipedia) <https://en.wikipedia.org/wiki/Linux_distribution>`_

    DMB
        Abbreviation for :term:`Developer Membership Board`

    DNS
        Abbreviation for :term:`Domain Name System`

    Domain Name System
        *Work in Progress*

    Downstream
        A software project(s) (and associated entities) that depend on
        another software project directly or indirectly.

        See :ref:`Downstream (explanation) <Downstream>`

    DSA
        Abbreviation for :term:`Debian System Administration`

    dsc
        `.dsc` is the file extension of a :term:`Debian` source control file.
        
        See: `Chapter 5. Control files and their fields (Debian Policy Manual v4.6.2.0) <https://www.debian.org/doc/debian-policy/ch-controlfields.html>`_

    End of Life
        Refers to the :term:`End of Support` (Life) for a product/software.

    End of Line
        The end of a line of :term:`encoded text <Text Encoding>` is indicated by
        a control character or sequence of control characters.

        This is relevant for text parser which often parse text line by line.

        The most common examples for control character(s) that indicate a *end of line* are:

        +--------------------------------------------+---------------+---------------+---------------+------------------+
        | :term:`Operating System`                   | Abbreviation* | hex value(s)* | dec value(s)* | Escape sequence* |
        +--------------------------------------------+---------------+---------------+---------------+------------------+
        | :term:`Unix` and :term:`Unix`-like systems | ``LF``        | ``0A``        | ``10``        | ``\n``           |
        +--------------------------------------------+---------------+---------------+---------------+------------------+
        | Windows systems                            | ``CR`` ``LF`` | ``0D`` ``0A`` | ``13`` ``10`` | ``\r`` ``\n``    |
        +--------------------------------------------+---------------+---------------+---------------+------------------+

        \* for the character encoding ``ASCII``

    End of Support
        *Work in Progress*

    End-user license agreement
        *Work in Progress*

    Embedded Systems
        *Work in Progress*

    Endianness
        *Work in Progress*

        See also: :term:`Little-Endian`, :term:`Big-Endian`, `Endianness (Wikipedia) <https://en.wikipedia.org/wiki/Endianness>`_

    EoL
        Abbreviation for either :term:`End of Life` or :term:`End of Line`

    EoS
        Abbreviation for :term:`End of Support`

    ESM
        Abbreviation for :term:`Expanded Security Maintenance`

    EULA
        Abbreviation for :term:`End-user license agreement`

    Expanded Security Maintenance
        *Work in Progress*
        
        See also: `Expanded Security Maintenance (homepage) <https://ubuntu.com/esm>`_

    Failed to build from Source
        *Work in Progress*

    Failed to install
        *Work in Progress*

    Feature Freeze Exception
        *Work in Progress* (see https://wiki.ubuntu.com/FreezeExceptionProcess)

    Feature Request
        *Work in Progress*

    Federal Information Processing Standards
        A set of standards and guidelines of the United States federal government
        developed by :term:`National Institute of Standards and Technology` (:term:`NIST`)
        to ensure the security and interoperability of computer systems and software
        used by non-military federal agencies and its contractors.
            
        See also: `Federal Information Processing Standards (Wikipedia) <https://en.wikipedia.org/wiki/Federal_Information_Processing_Standards>`_

    FFE
        Abbreviation for :term:`Feature Freeze Exception`

    FIPS
        Abbreviation for :term:`Federal Information Processing Standards`

    Fork
        In the context of :term:`Open Source Software` development, a *"fork"* refers
        to the process of creating a new, independent version of a software project by
        copying its :term:`Source Code` to evolve separately, potentially with different
        goals, features, or contributors.

    FOSS
        Abbreviation for :term:`Free and Open Source Software`

    FR
        Abbreviation for :term:`Feature Request`

    Free and Open Source Software
        *Work in Progress*

        See also: `Free and open-source software (Wikipedia) <https://en.wikipedia.org/wiki/Free_and_open-source_software>`_

    Free Software
        *Work in Progress*

    FTBFS
        Abbreviation for :term:`Failed to build from Source`

    FTI
        Abbreviation for :term:`Failed to install`

    GA
        Abbreviation for :term:`General Availability`

    General Availability
        *Work in Progress*

    General Public License
        *Work in Progress*

    git
        *Work in Progress*

    git-ubuntu
        *Work in Progress*

    GNU
        *GNU* is a recursive acronym for *"GNU's Not Unix!"*. It is a collection
        of :term:`Free and Open Source Software` that can be used as an :term:`Operating System`
        and aims to respect its users' freedom. The collection of
        :term:`Free and Open Source Software` is often used with :term:`Unix`-like
        kernels like :term:`Linux` (these :term:`Distributions <Distribution>` are
        commonly referred to as *"GNU/Linux"*).

        For example, :term:`Debian` and :term:`Ubuntu` are *GNU/Linux*
        :term:`Distributions <Distribution>`.

        Most of the *GNU* software is licensed under the *GNU*
        :term:`General Public License` (:term:`GPL`).

        See also: `GNU (Wikipedia) <https://en.wikipedia.org/wiki/GNU>`_, `www.gnu.org <https://www.gnu.org>`_

    GPL
        Abbreviation for :term:`GNU` :term:`General Public License`

    GUI
        Abbreviation for Graphical :term:`User Interface`

    i386
        :term:`CPU` :term:`Architecture` identifier (also known as :term:`Intel x86`,
        :term:`80x86`, and :term:`x86`), that was originally released as 80386; a
        32-Bit Microprocessor by Intel.

        See also: `i386 (Wikipedia) <https://en.wikipedia.org/wiki/I386>`_

    IBM
        *Work in Progress* Abbreviation for *International Business Machines*

        Find more information on the `IBM website <https://www.ibm.com/>`_.

    IBM zSystems
        *Work in Progress*

    IC
        Abbreviation for :term:`Individual Contributor`

    ICE
        Abbreviation for :term:`Internal Compiler Error`

    IEEE
        Abbreviation for :term:`Institute of Electrical and Electronics Engineers`

    Intel 64
        See :term:`arm64`

    Intel x86
        See :term:`i386`

    IRC
        Abbreviation for :term:`Internet Relay Chat`

    IRCC
        Abbreviation for :term:`Ubuntu IRC Council`

    Image
        Within the context of :term:`Ubuntu` development, an *"Image"* refers to an
        ``.iso`` file that contains a bootable :term:`Ubuntu` installer that can be
        burned to a CD to make installation disks.

        See also: `www.releases.ubuntu.com <https://www.releases.ubuntu.com/>`_,
        `Optical disc image (Wikipedia) <https://en.wikipedia.org/wiki/Optical_disc_image>`_

    Individual Contributor
        *Work in Progress*

    Institute of Electrical and Electronics Engineers
        *Work in Progress* (see https://www.ieee.org/)

    Intent to Package
        *Work in Progress* (see https://wiki.debian.org/ITP)

    Internal Compiler Error
        *Work in Progress*

    Internet Relay Chat
        Internet Relay Chat (:term:`IRC`)

    ISO
        *Work in Progress*

    ITP
        Abbreviation for :term:`Intent to Package`

    Kernel
        *Work in Progress*

    Keyring
        *Work in Progress*

    Launchpad
        The general development platform where :term:`Ubuntu` itself and most of
        :term:`Ubuntu` related software projects live.

        See: :doc:`Launchpad (explanation article) </explanation/launchpad>`

    Linux
        *Linux* is an :term:`Open Source <Open Source Software>` :term:`Operating System`
        :term:`Kernel` originally created by *Linus Torvalds* in 1991. It forms the
        core of various *Linux* :term:`Distributions <Distribution>`, such as :term:`Debian`
        and :term:`Ubuntu`. *Linux* is known for its stability, security, and flexibility,
        making it a popular choice for servers, desktops, and embedded systems.

        See also: `Linux (Wikipedia) <https://en.wikipedia.org/wiki/Linux>`_

    LinuxONE
        *Work in Progress*

    Linux Containers
        See :term:`LXC`

    Little-Endian
        *Work in Progress*

        See also: :term:`Endianness`

    Long Term Support
        *Work in Progress*

    LP
        Abbreviation for :term:`Launchpad`

    LTS
        Abbreviation for :term:`Long Term Support`

    LXC
        :term:`Linux` Containers (see https://linuxcontainers.org/lxc/introduction/)

    LXD
        LXD is system container manager (see https://documentation.ubuntu.com/lxd/en/latest/)

    Main
        A :term:`Component` of every :term:`Ubuntu` :ref:`ArchiveSeries` in the
        :term:`Ubuntu Archive` that contains :term:`Open Source <Open Source Software>`
        :term:`Packages <Package>` which are supported and maintained by :term:`Canonical`.

        See: :ref:`ArchiveComponents`

    Main Inclusion Review
        The review process when a :term:`Package` in :term:`Universe` or :term:`Multiverse`
        gets requested to be promoted to :term:`Main` or :term:`Restricted`.

        See: :doc:`Main Inclusion Review (explanation article) </explanation/main-inclusion-review>`

    Mailing List
        *Work in Progress*

    Maintainer
        *Work in Progress*

    Masters of the Universe
        *Work in Progress*

    Merge
        *Work in Progress*

    Merge Conflict
        *Work in Progress*

    Merge Proposal
        *Work in Progress*

    Micro Release Exception
        See https://wiki.ubuntu.com/StableReleaseUpdates/MicroReleaseExceptions

    MIR
        Abbreviation for :term:`Main Inclusion Review`

    MIR Team
        The :term:`Ubuntu` team that reviews requests to promote :term:`Packages <Package>`
        in :term:`Universe` or :term:`Multiverse` to :term:`Main` or :term:`Restricted`.

        See: :doc:`Main Inclusion Review (explanation article) </explanation/main-inclusion-review>`

    Mirror
        A server that *"mirrors"* (replicates and keeps in sync) the content of another
        server to distribute network traffic, reduce latency, and provide redundancy,
        ensuring high availability and fault tolerance.

        See also: :term:`Archive Mirror`, :term:`CD Mirror`

    MOTU
        Abbreviation for :term:`Masters of the Universe`

    MP
        Abbreviation for :term:`Merge Proposal`

    MRE
        Abbreviation for :term:`Micro Release Exception`

    Multiverse
        A :term:`Component` of every :term:`Ubuntu` :ref:`ArchiveSeries` in the
        :term:`Ubuntu Archive` that contains :term:`Packages <Package>` of
        :term:`Closed Source Software` or :term:`Open Source Software` restricted by
        copyright or legal issues. These :term:`Packages <Package>` are maintained and supported by
        the :term:`Ubuntu` community.

        See: :ref:`ArchiveComponents`

    Namespace
        A concept in computer science and software development that defines a scope
        or context in which identifiers (such as variable names, functions, or classes)
        are unique and distinct. It helps prevent naming conflicts and organizes
        code elements into separate compartments. Namespaces are commonly used in
        programming languages to group and categorize code, making it more manageable
        and maintainable. They play a crucial role in encapsulation and modularity,
        allowing developers to create reusable and organized code structures.
        Namespaces are particularly important in larger software projects where
        numerous components and libraries need to coexist without clashing with
        each other's names.

    National Institute of Standards and Technology
        *Work in Progress*

    Native Package
        *Native source packages* are :term:`Source Packages <Source Package>` that
        are their own :term:`Upstream`, therefore they do not have an :term:`orig tarball`.

        See: :ref:`Native Source Packages (explanation) <NativeSourcePackages>`

    Not built from Source
        *Work in Progress*

    NBS
        Abbreviation for :term:`Not built from Source`

    Never Part Of A Stable Release
        *Work in Progress*

    NIST
        Abbreviation for :term:`National Institute of Standards and Technology`

    NPOASR
        Abbreviation for :term:`Never Part Of A Stable Release`

    NVIU
        Abbreviation for :term:`Newer Version in Unstable`

    Newer Version in Unstable
        *Work in Progress*

    Open Source Software
        *Work in Progress*

    Operating System
        An *operating system* (OS) is essential system software that manages computer
        hardware and software resources. It provides crucial services for computer
        programs, including hardware control, task scheduling, memory management,
        file operations, and user interfaces, simplifying program development and
        execution.

        See also: `Operating system (Wikipedia) <https://en.wikipedia.org/wiki/Operating_system>`_

    orig tarball
    original tarball
        The ``.orig.tar.ext`` and ``.orig-component.tar.ext`` (where ``ext`` can be
        ``gz``, ``bz2``, ``lzma`` and ``xz`` and ``component`` can contain alphanumeric
        characters (``a-zA-Z0-9``) and hyphens ``-``) :manpage:`tar(5)` archive files
        of a :term:`Debian` :term:`Source Package` that contains the original :term:`Source`
        of the :term:`Upstream` project.

        See also: :manpage:`dpkg-source(1)`, :term:`tarball`

    OS
        Abbreviation for :term:`Operating System`

    OSS
        Abbreviation for :term:`Open Source Software`

    Package
        *Work in Progress*

    Package Manager
        *Work in Progress*

    Patch
        A *patch* is a (often small) piece of code or a software update designed
        to fix or improve a computer program or system. It is typically applied
        to address :term:`Security Vulnerabilities <Common Vulnerabilities and Exposures>`,
        :term:`Bugs <Bug>`, or enhance functionality, ensuring the software remains
        up-to-date and reliable. *Patches* are essential for maintaining software
        integrity and security.

        See also: `Patch (Wikipedia) <https://en.wikipedia.org/wiki/Patch_(computing)>`_

    PCRE
        Abbreviation for :term:`Perl Compatible Regular Expressions`

    Perl Compatible Regular Expressions
        *Work in Progress*
        
        See also: `PCRE (Reference Implementation) <https://www.pcre.org/>`_

    Personal Package Archive
        *Work in Progress*

    PKCS
        Abbreviation for :term:`Public Key Cryptography Standards`

    Pocket
        A *pocket* is a :term:`Package` sub-:term:`repository <Repository>` within
        the :term:`Ubuntu Archive`. Every :term:`Ubuntu` :term:`Series` has the *pockets*
        :ref:`ArchivePockets_Release`, :ref:`ArchivePockets_Security`,
        :ref:`ArchivePockets_Updates`, :ref:`ArchivePockets_Proposed`, and
        :ref:`ArchivePockets_Backports`.

        See: :ref:`Pockets (explanation) <ArchivePockets>`

    POSIX
        Abbreviation for *Portable Operating System Interface*: A family of
        standards specified by the :term:`IEEE` Computer Society for maintaining
        compatibility between :term:`Operating Systems <Operating System>`. POSIX defines the :term:`API`,
        along with command line shells and utility interfaces, for software
        compatibility with variants of Unix and other :term:`Operating Systems <Operating System>`.

    PowerPC
        *Work in Progress*

    PPA
        Abbreviation for :term:`Personal Package Archive`

    ppc64el
        *Work in Progress* (PowerPC64 Little-Endian)

    PR
        Abbreviation for :term:`Pull Request`

    Public Key Cryptography Standards
        *Work in Progress*

        See also: `PKCS (Wikipedia) <https://en.wikipedia.org/wiki/PKCS>`_

    Pull
        *Work in Progress*

    Pull Request
        *Work in Progress*

    Push
        *Work in Progress*

    Real Time Operating System
        *Work in Progress*

    Rebase
        *Work in Progress*

    Reduced Instruction Set
        a :term:`CPU`  characterized by a simplified and streamlined
        set of instructions, optimized for efficient and fast execution of basic operations.
        :term:`RISC` processors typically prioritize speed over complexity.

        Examples of :term:`RISC` :term:`Architectures <Architecture>` are :term:`arm64`,
        :term:`armhf`, :term:`RISC-V`, :term:`ppc64el`, and :term:`PowerPC`.

        See also: `Reduced instruction set computer (Wikipedia) <https://en.wikipedia.org/wiki/Reduced_instruction_set_computer>`_

    RegEx
        Abbreviation for :term:`Regular Expression`

    Regular Expression
        A sequence of characters that specifies a text-matching pattern. String-search
        algorithms usually use these patterns for input validation or find (and replace)
        operations on strings.

        While this general term stems from theoretical computer science and formal language
        theory, people usually think of :term:`Perl Compatible Regular Expressions` (:term:`PCRE`).

    Repository
        *Work in Progress* 
        
        .. note::
    
            ambiguity between git or apt repository

    Request for Comments
        *Work in Progress*

        See also: `Request for Comments (Wikipedia) <https://en.wikipedia.org/wiki/Request_for_Comments>`_

    Request of Maintainer
        *Work in Progress*

    Request of Porter
        *Work in Progress*

    Requested by the QA team
        *Work in Progress*

    Request of Security Team
        *Work in Progress*

    Request of Stable Release Manager
        *Work in Progress*

    Restricted
        A :term:`Component` of every :term:`Ubuntu` :ref:`ArchiveSeries` in the
        :term:`Ubuntu Archive` that contains :term:`Closed Source <Closed Source Software>`
        :term:`Packages <Package>` which are supported and maintained by :term:`Canonical`.

        See: :ref:`ArchiveComponents`

    RFC
        Abbreviation for :term:`Request for Comments`

    RISC
        Abbreviation for :term:`Reduced Instruction Set` Computer

    RISC-V
        *Work in Progress*

    riscv64
        *Work in Progress*

    RoM
        Abbreviation for :term:`Request of Maintainer`

    RoP
        Abbreviation for :term:`Request of Porter`

    RoQA
        Abbreviation for :term:`Requested by the QA team`

    RoSRM
        Abbreviation for :term:`Request of Stable Release Manager`

    RoST
        Abbreviation for :term:`Request of Security Team`

    RTOS
        Abbreviation for :term:`Real Time Operating System`

    Rules File
        The :file:`debian/rules` file in a :term:`Source Package`.

        See: :doc:`/reference/debian-dir-overview`

        See also: `Section 4.9. Main building script (Debian Policy Manual v4.6.2.0) <https://www.debian.org/doc/debian-policy/ch-source.html#main-building-script-debian-rules>`_

    s390x
        *Work in Progress*

    Series
        A *series* refers to the :term:`Packages <Package>` in the :term:`Ubuntu Archive`
        that target a specific :term:`Ubuntu` version. A *series* is usually referred
        to by its :term:`Codename`.

        See: :ref:`Series (explanation) <ArchiveSeries>`

    Service-level Agreement
        *Work in Progress*

    Signature
        A digital signature is a cryptographic record that verifies the authenticity
        and integrity of data.

        Every :term:`Package` in the :term:`Ubuntu Archive` is digitally signed,
        enabling users to detect data corruption during the download or unwanted/malicious
        modifications. Furthermore, some :term:`Upstream` projects sign their releases,
        which lets Ubuntu :term:`Maintainers <Maintainer>` and users of the corresponding
        packages verify that the :term:`Source Code` is from the developers of the
        upstream project.

        The tool :manpage:`gpg(1)` is commonly used to create and modify digital
        signatures. Further information can be found in the
        `GNU Privacy Handbook <https://www.gnupg.org/gph/en/manual.html#AEN136>`_.

    Signing Key
        *Work in Progress*

    SLA
        Abbreviation for :term:`Service-level Agreement`

    Source
        *Work in Progress*

    Source Code
        *Work in Progress*

    Source Package
        A :term:`Debian` *source package* contains the :term:`Source` material used
        to build one or more :term:`Binary Packages <Binary Package>`.

        See: :ref:`Source Packages (explanation) <SourcePackages>`

    Source Tree
        *Work in Progress*

    Sponsor
        *Work in Progress*

    SRU
        Abbreviation for :term:`Stable Release Update`

    Stable Release Update
        *Work in Progress*

    Stack
        In computer science, a **Stack** is a data-structure that can store a
        collection of elements linearly with two primary operations:

        - "Push": adds an element to the collection
        - "Pop": removes the most recently added element in the collection

        Stack implementatuons also often have a "Peak" operation to see the most
        recently added element in the collection without removing it.

        The name **Stack** stems from the analogy of items "stacked" ontop of
        eachother like a stack of plates where you have to remove the plates
        above to access the plates below.

        See also: `Stack (abstract data type) <https://en.wikipedia.org/wiki/Stack_(abstract_data_type)>`_

    Staging Environment
        *Work in Progress*

    tarball
        A file in the :manpage:`tar(5)` archive format, which collects any number of
        files, directories, and other file system objects (symbolic links, device nodes, etc.)
        into a single stream of bytes. The format was originally designed to be used with
        tape drives, but nowadays it is widely used as a general packaging mechanism.

        See also: :term:`orig tarball`

    Text Encoding
        **Text encoding** refers to the method or schema used to represent and store
        text characters in a digital format. It involves assigning numerical codes
        (typically binary) to each character in a character set, which allows computers
        to process and display text. 

        For example, ``ASCII`` and ``UTF-8`` are commonly used text encoding formats.

        The choice of a text encoding format is essential for ensuring proper character
        representation, especially when dealing with different languages and special
        characters.

    TLS
        Abbreviation for :term:`Transport Layer Security`

    TPM
        Abbreviation for :term:`Trusted Platform Module`

    Transport Layer Security
        *Work in Progress*

    Trusted Platform Module
        *Work in Progress*

    Ubuntu
        The word *"ubuntu"* is derived from the pronunciation of an an ancient African word
        *"oǒ’boǒntoō"* meaning *'humanity to others'*. It is often described as reminding
        us that *'I am what I am because of who we all are'*.

        The *Ubuntu* :term:`Operating System` tries to bring that spirit to the world of
        computers and software. The *Ubuntu* :term:`Distribution` is a :term:`Debian`-based
        :term:`Linux` :term:`Distribution` and aims to represents the best of what the world's
        software community has shared with the world.

        See: `The story of Ubuntu <https://ubuntu.com/about>`_,
        `Ubuntu ethos <https://ubuntu.com/community/ethos>`_,
        `Ubuntu Project Governance <https://ubuntu.com/community/governance>`_

    Ubuntu Archive
        The *Ubuntu Package Archive* is and :term:`APT` :term:`Repository` that is
        preconfigured by default on :term:`Ubuntu` installations. It hosts :term:`Debian`
        :term:`Binary Packages <Binary Package>` (``.deb`` files) and
        :term:`Source Packages <Source Package>` (``.dsc`` files).

        See: :doc:`Ubuntu Package Archive (explanation) </explanation/archive>`

    Ubuntu autopkgtest Cloud
        *Work in Progress*

        See: `autopkgtest.ubuntu.com <https://autopkgtest.ubuntu.com/>`_

    Ubuntu Base Packages
        :term:`Packages <Package>` that are in the :term:`Main` or :term:`Restricted`
        :term:`Component`. These are packages that are maintained by :term:`Canonical`,
        because they are fundamental for :term:`Ubuntu`.

        See also: :term:`Main Inclusion Review`

    Ubuntu Cloud Archive
        *Work in Progress* 
        
        See: `Cloud Archive (Ubuntu Wiki) <https://wiki.ubuntu.com/OpenStack/CloudArchive>`_

    Ubuntu Code of Conduct
        *Work in Progress*

        See: https://ubuntu.com/community/ethos/code-of-conduct

    Ubuntu CVE Tracker
        *Work in Progress* (see https://launchpad.net/ubuntu-cve-tracker and https://ubuntu.com/security/cves)

    Ubuntu Delta
        A modification to an :term:`Ubuntu` :term:`Package` that is derived from a :term:`Debian`
        :term:`Package`.

        See also: :doc:`Upstream & Downstream (explanation) </explanation/upstream-and-downstream>`

    Ubuntu Desktop
        *Work in Progress*

    Ubuntu Developer Summit
        Between 2004 and 2012, :term:`Ubuntu` releases were planned during regularly scheduled
        summits, where the greater :term:`Ubuntu` community would come together for
        planning and hacking sessions. This event occurred two times a year, each one
        running for a week. The discussions were highly technical and heavily influenced
        the direction of the subsequent :term:`Ubuntu` release.

        These events were called *"Ubuntu Developer Summit"* (UDS).

        These events are continued since November 2022 as ":term:`Ubuntu Summit`" (US)
        to include the broader :term:`Ubuntu` community and not only developers.
        
        See also:
        `Ubuntu Developer Summit is now Ubuntu Summit (Ubuntu Blog) <https://ubuntu.com/blog/uds-is-now-ubuntu-summit>`_,
        `Developer Summit (Ubuntu Wiki) <https://wiki.ubuntu.com/DeveloperSummit>`_

    Ubuntu Discourse
        A :term:`Discourse` instance about general :term:`Ubuntu` development that
        is accessible to the general public, where you can find discussions,
        announcements, team updates, documentation and much more.

        Feel free `to introduce yourself <https://discourse.ubuntu.com/c/intro/101>`_.

        See: `discourse.ubuntu.com <https://discourse.ubuntu.com>

    Ubuntu flavours
        *Ubuntu flavours* are :term:`Distributions <Distribution>` of the default :term:`Ubuntu`
        releases, which choose their own default applications and settings. *Ubuntu flavours* are
        owned and developed by members of the :term:`Ubuntu` community and backed by the full
        :term:`Ubuntu Archive` for :term:`Packages <Package>` and updates.

        Officially recognised flavours are:

        - `Edubuntu`_
        - `Kubuntu`_
        - `Lubuntu`_
        - `Ubuntu Budgie`_
        - `Ubuntu Cinnamon`_
        - `Ubuntu Kylin`_
        - `Ubuntu MATE`_
        - `Ubuntu Studio`_
        - `Ubuntu Unity`_
        - `Xubuntu`_

    Ubuntu IRC Council
        *Work in Progress*

        See also: `IRC Council (Ubuntu Wiki) <https://wiki.ubuntu.com/IRC/IrcCouncil>`_

    Ubuntu Pro
        *Work in Progress*

        See: `Ubuntu Pro (homepage) <https://ubuntu.com/pro>`_

    Ubuntu Server
        *Work in Progress*

    Ubuntu Summit
        The *Ubuntu Summit* (US) is a continuation of :term:`Ubuntu Developer Summit`
        since November 2022. The change in name aims to broadening the scope, which
        opens the event up to additional audiences.

        While the :term:`Ubuntu Developer Summit` was focused on technical development,
        the talks and workshops of the *Ubuntu Summit* will cover development as well
        as design, writing, and community leadership with a wide range of technical
        skill levels.
        
        The name also results in a nifty new acronym, *"US"*, or more appropriately,
        simply *"Us"*. This fits very nicely with the meaning of :term:`Ubuntu`,
        *"I am what I am because of who we all are"*.

        If you have any question feel free to send an email at
        `summit@ubuntu.com <mailto:summit@ubuntu.com>`_.

        Also, check out the :term:`Mailing List` specific to the *Ubuntu Summit*, you can
        sign up `here <https://lists.ubuntu.com/mailman/listinfo/summit-news>`_.

        You can find more information at `summit.ubuntu.com <https://summit.ubuntu.com/>`_.

    UCA
        Abbreviation for :term:`Ubuntu Cloud Archive`

    UCT
        Abbreviation for :term:`Ubuntu CVE Tracker`

    UDS
        Abbreviation for :term:`Ubuntu Developer Summit`

    UI
        Abbreviation for :term:`User Interface`

    UIFe
        Abbreviation for :term:`User Interface Freeze Exception`

    Uniform Resource Identifier
        *Work in Progress*

        See also: `Uniform Resource Identifier (Wikipedia) <https://en.wikipedia.org/wiki/Uniform_Resource_Identifier>`_

    Uniform Resource Locator
        *Work in Progress*

        See also: `URL (Wikipedia) <https://en.wikipedia.org/wiki/URL>`_

    Universe
        A :term:`Component` of every :term:`Ubuntu` :ref:`ArchiveSeries` in the
        :term:`Ubuntu Archive` that contains :term:`Open Source <Open Source Software>`
        :term:`Packages <Package>` which are supported and maintained by the :term:`Ubuntu`
        community.

        See: :ref:`ArchiveComponents`

    Unix
        *Unix* is an :term:`Operating System` whose development started in the late 1960s
        at AT&T Bell Labs. It is characterized by its multi-user and multi-tasking
        capabilities, hierarchical file system, and a suite of
        :term:`Command Line <Command Line Interface>` utilities.
        *Unix* has been influential in shaping modern :term:`Operating Systems <Operating System>`
        and remains the basis for various *Unix*-like systems, including :term:`Linux` and *macOS*.

        See also: `Unix (Wikipedia) <https://en.wikipedia.org/wiki/Unix>`_

    Upstream
        A software project (and associated entities), another software project
        depends on directly or indirectly.

        See :ref:`Upstream (explanation) <Upstream>`

    URI
        Abbreviation for :term:`Uniform Resource Identifier`

    URL
        Abbreviation for :term:`Uniform Resource Locator`

    US
        Abbreviation for :term:`Ubuntu Summit`

    User Experience
        The overall experience and satisfaction a user has while interacting with
        a product or system. It considers usability, accessibility, user flow, and
        the emotional response of users to ensure a positive and efficient interaction
        with the :term:`User Interface` and the product as a whole.

    User Interface
        Refers to the visual elements and design of a digital product or application
        that users interact with. It includes components like buttons, menus, icons,
        and layout, focusing on how information is presented and how users navigate
        through the interface.

    User Interface Freeze Exception
        *Work in Progress*

        See: :doc:`/explanation/development-process`

    UX
        Abbreviation for :term:`User Experience`

    VCS
        Abbreviation for :term:`Version Control System`

    Version Control System
        A software tool or system that enables developers to track and manage changes
        to their :term:`Source Code` and collaborate with others effectively. It maintains
        a history of :term:`Source Code` revisions, allowing users to revert to previous
        versions, track modifications, and work on different :term:`Branches <Branch>`
        of :term:`Source Code` simultaneously. *Version Control Systems* are crucial
        for :term:`Source Code` management and collaboration in :term:`Open Source Software`
        development projects.

    Waiting on Upstream
        *Work in Progress*

        See also: :term:`Upstream`

    Watch File
        The :file:`debian/watch` file in a :term:`Source Package`.

        See: :doc:`/reference/debian-dir-overview`

        See also: :manpage:`uscan(1)`, `Section 4.11. Upstream source location (Debian Policy Manual v4.6.2.0) <https://www.debian.org/doc/debian-policy/ch-source.html#upstream-source-location-debian-watch>`_

    Whitespace
        *Whitespace* characters refer to characters in a text (especially :term:`Source Code`)
        that are used for formatting and spacing, but do not produce visible marks
        or symbols when rendered. Common *Whitespace* characters include spaces,
        tabs, and newline characters.

    WoU
        Abbreviation for :term:`Waiting on Upstream`

    x64
        See :term:`amd64`
    
    x86
        See :term:`i386`

    x86-64
        See :term:`amd64`

    x86_64
        See :term:`amd64`
