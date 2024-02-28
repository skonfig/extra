cdist-type__openzfs(7)
======================

NAME
----
cdist-type__openzfs - Manage OpenZFS installation and configuration


DESCRIPTION
-----------
This type can be used to set up OpenZFS on the system and set tunables.

**NOTE:** This type only works on Debian derivatives.


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
auto-load-keys
    Automatically load encryption keys when mounting at boot time.

    Attention: if a filesystem has ``keylocation=prompt`` this will
    cause the terminal to interactively block after asking for the key.
notify-verbose
    Send notification even if the pool is healthy.
verbose-mount
    Display a mount counter when mounting at boot time.


EXAMPLES
--------

.. code-block:: sh

   # Make sure OpenZFS is installed on the target.
   __openzfs

   # Install OpenZFS from backports to get a newer version
   __apt_backports \
      --component main \
      --component contrib
   require=__apt_backports/ \
   __apt_pin zfs-backports \
      --package 'src:zfs-linux' \
      --release 'n=*-backports*' \
      --priority 600
   require=__apt_pin/zfs-backports \
   __openzfs


SEE ALSO
--------
- https://openzfs.org/
- :strong:`zed`\ (8)


AUTHORS
-------
Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2020-2024 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3
of the License, or (at your option) any later version.
