cdist-type__bird-ospf(7)
========================

NAME
----
cdist-type__bird-ospf - Configure an instance of the OSPF protocol


DESCRIPTION
-----------

This type is an *extremely rudimentary* method to configure a simple OSPF
protocol instance for bird, the internet routing daemon. Even this manpage is
pretty crude and will be fixed and expanded.

REQUIRED PARAMETERS
-------------------
channel
    The channel the protocol should connect to. Usually `ipv4` or `ipv6`.

import
    The keyword or filter to decide what to import in the above channel.

export
    The keyword or filter to decide what to export in the above channel.


REQUIRED MULTIPLE PARAMETERS
----------------------------
interface
    An interface to include in OSPF area 0.

OPTIONAL PARAMETERS
-------------------
description
    A description given with `show protocol all`

instance-id
    An OSPF instance ID, allowing several OSPF instances to run on the same
    links.

OPTIONAL MULTIPLE PARAMETERS
----------------------------

stubnet
    Add an optionless stubnet definition to the configuration.

SEE ALSO
--------
cdist-type__bird_core(7)

AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
