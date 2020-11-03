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
