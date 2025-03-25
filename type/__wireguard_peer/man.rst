cdist-type__wireguard_peer(7)
=============================

NAME
----
cdist-type__wireguard_peer - Add an authorized peer to a WireGuard interface.

DESCRIPTION
-----------

This type configures a peer to be authorized on a wireguard interface. The
``__object_id`` is used to differentiate the :strong:`cdist-type__block`\ (7)
where each peer is defined. See :strong:`wg`\ (8) for details on the options.

Note that this type **requires** a configuration file named after the ``iface``
parameter to add and remove the peers from. The recommended way to accomplish
this is to call :strong:`cdist-type__wireguard`\ (7), and set it as a requirement for
calls to this type adding peers to that interface.

Currently, this type is only implemented for Alpine Linux.

REQUIRED PARAMETERS
-------------------

iface
  The name of the wireguard interface to add the peer to.

public-key
  The peer's public key.

OPTIONAL PARAMETERS
-------------------

endpoint
  The endpoint for this peer.

persistent-keepalive
  Send a keepalive packet every n seconds, expects an integer.

preshared-key
  A pre-shared symmetric key. Used for "post-quantum resistance".

state
  Directly passed on the :strong:`cdist-type__block`\ (7), to enable removing a user.


OPTIONAL MULTIPLE PARAMETERS
----------------------------

allowed-ip
  A comma-separated list of IP (v4 or v6) addresses with CIDR masks from which
  incoming traffic for this peer is  allowed  and  to which  outgoing  traffic
  for this peer is directed. The catch-all 0.0.0.0/0 may be specified for
  matching all IPv4 addresses, and ::/0 may be specified for matching all IPv6
  addresses.

SEE ALSO
--------
* :strong:`wg`\ (8)
* :strong:`wg-quick`\ (8)
* :strong:`cdist-type__wireguard`\ (7)
* :strong:`cdist-type__block`\ (7)

AUTHORS
-------
* Joachim Desroches <joachim.desroches--@--epfl.ch>

COPYING
-------
Copyright \(C) 2020 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
