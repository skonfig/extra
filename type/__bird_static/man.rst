cdist-type__bird_static(7)
==========================

NAME
----
cdist-type__bird_static - configure an instance of the bird static protocol.


DESCRIPTION
-----------
This type write the configuration file for an instance of the static protocl to
be ran bu the bird internet routing daemon, allowing an administrator to inject
static routes into the daemon's routing tables. This protocol allows for only
one of two channels to be used, either ``ipv4`` or ``ipv6``, by default ``ipv6`` is
used unless the `ipv4` flag is passed. This type **expects** to depend on
:strong:`cdist-type__bird_core`\ (7).


REQUIRED PARAMETERS
-------------------
channel
   The channel to use between the protocol and the table.

REQUIRED MULTIPLE PARAMETERS
----------------------------
route
    This flag expects a valid route to be inserted between the bird `route`
    keyword and the end of line. It may be specified as many times as necessary.


OPTIONAL PARAMETERS
-------------------
description
    An instance desciption to be printed when `birdc show protocols` is called.


EXAMPLES
--------

.. code-block:: sh

    # Setup bird and open a BGP session.
    __bird_core --router-id 198.51.100.4

    require='__bird_core' __bird_static static4 \
        --description "static ipv4 routes plugged into bird" \
        --route "198.51.0.0/16 via 192.51.100.1" \
        --route "192.52.0.0/16 via 192.51.100.1"


SEE ALSO
--------
cdist-type__bird_core(7)
cdist-type__bird_bgp(7)
cdist-type__bird_kernel(7)
cdist-type__bird_ospf(7)


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
