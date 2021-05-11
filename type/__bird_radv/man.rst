cdist-type__bird_radv(7)
========================

NAME
----
cdist-type__bird_radv - Configure the Bird Internet Router Daemon to send RAdvs.


DESCRIPTION
-----------

The Bird Internet Router Daemon knows about a bunch of internet routing
protocols. In particular, it can send Router Advertisements to help
autoconfigure IPv6 hosts, this type is a rudimentary implementation to generate
configuration for Bird to do so.


REQUIRED MULTIPLE PARAMETERS
----------------------------
interface
  The interfaces to activate the protocol on. RAs will be sent using the
  prefixes configured on these interfaces.


OPTIONAL MULTIPLE PARAMETERS
----------------------------
route
  Routes to be added to the RA for hosts.

ns
  Recursive DNS servers given to the hosts through RAs.

dnssl
  Search domain to be given to the hosts through RAs.


EXAMPLES
--------

.. code-block:: sh

    __bird_radv datacenter \
        --interface eth1 \
        --route ::/0 \
        --ns 2001:DB8:cafe::4 \
        --ns 2001:DB8:cafe::14 \
        --dnssl "example.com"


SEE ALSO
--------
`__bird_core(7)`


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
