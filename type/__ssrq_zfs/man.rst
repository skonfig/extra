cdist-type__ssrq_zfs(7)
=======================

NAME
----
cdist-type__ssrq_zfs - Manage OpenZFS installation and configuration


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
mailto
    The user or email address to which alert mails should be sent to.
tunable
    Set a ZFS tunable parameter to the given value.
    Use this option multiple times to set more than one tunable.

    The value should be a key-value pair separated by a ``=`` (equals sign).

    For a reference of available tunables, cf.
    `zfs-module-parameters(5) <https://openzfs.github.io/openzfs-docs/man/5/zfs-module-parameters.5.html>`_.


BOOLEAN PARAMETERS
------------------
notify-verbose
    Send notification even if the pool is healthy.


EXAMPLES
--------

.. code-block:: sh

    # Make sure OpenZFS is installed on the target.
    __ssrq_zfs


SEE ALSO
--------
- https://openzfs.org/
- :strong:`zed`\ (8)


AUTHORS
-------
Dennis Camera <dennis.camera@ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2020 Dennis Camera. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
