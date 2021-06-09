cdist-type__wireguard(7)
========================

NAME
----
cdist-type__wireguard - Configure a wireguard interface

DESCRIPTION
-----------

This type creates a wireguard interface named using the `${__object_id}`. It
generates a configuration file for wireguard and a configuration file for
ifconfig, and then brings the interface up.

Additional peers for the created wireguard interface can be added using
`cdist-type__wireguard_peers(7)`.

Currently, this type is only implemented for Alpine Linux.

Currently, this type only supports setting an IPv6 address to assign to the
wireguard interface.

REQUIRED PARAMETERS
-------------------

privkey
  The private key for this wireguard instance.

address
  The IPv6 address to assign to the wireguard interface, optionally with a CIDR
  mask.

OPTIONAL PARAMETERS
-------------------

port
  The port to listen on. If not specified, wireguard will choose one randomly.

SEE ALSO
--------

`wg(8)`, `wg-quick(8)`, `cdist-type__wireguard(7)`, `cdist-type__block(7)`

AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>

COPYING
-------
Copyright \(C) 2020 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
