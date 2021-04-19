cdist-type__bird_bgp(7)
=======================

NAME
----
cdist-type__bird_bgp - configure an instance of the BGP protocol.


DESCRIPTION
-----------
This type writes the configuration for an instance of the BGP protocol to be
ran by the bird internet routing daemon. It **expects** to depend on the
`cdist-type__bird_core(7)` type.


REQUIRED PARAMETERS
-------------------
local-as
    The number for the AS in which the daemon is running.

neighbor-as
    The number of the AS with which we are peering.

neighbor-ip
    The IP address of the peer we are opening a session with.


OPTIONAL PARAMETERS
-------------------
description
    An instance desciption to be printed when `birdc show protocols` is called.

local-ip
    The IP address used as a source address for the BGP session.

password
    A password for the BGP session.

ipv4-import
    A string suitable for the bird `import` directive. Usually `all`, `none` or
    a filter definition.

ipv4-export
    See ipv4-import.

ipv4-extended-next-hop
    Allow IPv6 next hop in IPv4 NLRI.

ipv6-import
    See ipv4-import.

ipv6-export
    See ipv4-import.

ipv6-extended-next-hop
    Allow IPv4 next hop in IPv6 NLRI.


BOOLEAN PARAMETERS
------------------
direct
    Specify that the two routers are directly connected.


EXAMPLES
--------

.. code-block:: sh

    # Setup bird and open a BGP session.
    __bird_core --router-id 198.51.100.4

    require='__bird_core' __bird_bgp bgp4 \
        --description "a test IPv4 BGP instance" \
        --ipv4-export all \
        --ipv4-import all \
        --ipv6-export none \
        --ipv6-import none \
        --local-as 1234 \
        --local-ip 198.51.100.4 \
        --neighbor-as 4321 \
        --neighbor-ip 198.51.100.3 \
        --password hunter01


SEE ALSO
--------
cdist-type__bird_core(7)
cdist-type__bird_filter(7)
cdist-type__bird_kernel(7)
cdist-type__bird_ospf(7)
cdist-type__bird_static(7)


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
