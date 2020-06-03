cdist-type__unbound(7)
===============================

NAME
----
cdist-type__ungleich_unbound - unbound server deployment for ungleich


DESCRIPTION
-----------
This unbound (dns resolver and cache) deployment provides DNS64 and fetch
answers from specified upstrean DNS server. This is a singleton type.

REQUIRED PARAMETERS
-------------------
dns64_prefix
  IPv6 prefix used for DNS64.

forward_addr
  DNS servers used to lookup names, can be provided multiple times. It can be
  either an IPv4 or IPv6 address but no domain name.

OPTIONAL PARAMETERS
-------------------
interface
  Interface to listen on, can be provided multiple times. Defaults to
  '127.0.0.1' and '::1'.

access_control
  Controls which clients are allowed queries to the unbound service (everything
  but localhost is refused by default), can be provided multiple times. The
  format is described in unbound.conf(5).

BOOLEAN PARAMETERS
------------------
disable-ip4
  Do not answer or issue queries over IPv4. Cannot be used alongside the
  `--disable-ip6` flag.

disable-ip6
  Do not answer or issue queries over IPv6. Cannot be used alongside the
  `--disable-ip4` flag.

EXAMPLES
--------

.. code-block:: sh

    __ungleich_unbound \
      --interface '::0' \
      --dns64_prefix '2a0a:e5c0:2:10::/96' \
      --forward_addr '2a0a:e5c0:2:1::5' \
      --forward_addr '2a0a:e5c0:2:1::6' \
      --access_control '::0/0 deny' \
      --access_control '2a0a:e5c0::/29 allow' \
      --access_control '2a09:2940::/29 allow' \
      --ip6

SEE ALSO
--------
- `unbound.conf(5) <https://nlnetlabs.nl/documentation/unbound/unbound.conf/>`_


AUTHORS
-------
Timothée Floure <timothee.floure@ungleich.ch>


COPYING
-------
Copyright \(C) 2020 Timothée Floure. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
