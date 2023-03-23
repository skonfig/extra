cdist-type__libvirtd(7)
=======================

NAME
----
cdist-type__libvirtd - Manage the libvirt hypervisor


DESCRIPTION
-----------
This type can be used to manage the `libvirt <https://libvirt.org>`_ hypervisor.

This type has been tested on Debian derivatives and Arch Linux only.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
None.


BOOLEAN PARAMETERS
------------------
with-zfs-storage
   Install ``libvirt-driver-storage-zfs``.


EXAMPLES
--------

.. code-block:: sh

   # Install the libvirtd hypervisor
   __libvirtd

   # Install the libvirtd hypervisor with ZFS storage driver
   __libvirtd --with-zfs-storage


SEE ALSO
--------
- `<https://libvirt.org/docs.html>`_


AUTHORS
-------
Dennis Camera <dennis.camera--@--ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2020-2023 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
