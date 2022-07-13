cdist-type__networktime(7)
==========================

NAME
----
cdist-type__networktime - Generic time synchronization type


DESCRIPTION
-----------

This type is intended to be a simple abstraction over the various backends and
programs available for network time synchronization. This type only takes a
list of peers to synchronize to as argument, and then chooses an appropriate
backend depending on the operating system, configures, starts and enables it to
start on boot.

Currently, the following OSes are supported with the following backends:

- Alpine Linux: builtin busybox NTPd
- Debian/Ubuntu: systemd-timesyncd


REQUIRED MULTIPLE PARAMETERS
----------------------------
peer:
    The name or IP address of a peer to synchronize to.


EXAMPLES
--------

.. code-block:: sh

    # 2.XXX.ntp.org are IPv6-enabled pools
    __networktime --peer 2.ch.pool.ntp.org \
        --peer 2.europe.pool.ntp.org


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
