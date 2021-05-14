cdist-type__unbound(7)
=======================

NAME
----
cdist-type__unbound - configure an instance of unbound, a DNS validating resolver.


DESCRIPTION
-----------
This type writes the configuration and OpenRC init scripts to run an instance
of unbound. The most commonly used options for unbound are configurable through
flags.

Note that this type is currently only implemented (and tested) on Alpine Linux.
Please contribute other implementations if you can.


OPTIONAL PARAMETERS
-------------------
verbosity
  Control the `unbound.conf(5)` verbosity parameter.

port
  Control the `unbound.conf(5)` port parameter.

control-port
  Control the `unbound.conf(5)` control-port parameter.

dns64-prefix
  Control the `unbound.conf(5)` dns64-prefix parameter.

OPTIONAL MULTIPLE PARAMETERS
----------------------------
interface
  Control the `unbound.conf(5)` interface parameter. Can be
  given multiple times, will generate multiple `interface:
  xxx` clauses.

access-control
  Control the `unbound.conf(5)` access-control parameter. Can be given
  multiple times, will generate multiple `access-control` clauses. The format
  is an IP block followed by an access-control keyword.

control-interface
  Control the `unbound.conf(5)` control-interface parameter. Can be given
  mutltiple times, will generate multiple `control-interface` clauses. Note
  that without the `enable-rc` boolean flags, remote control will not be
  enabled. Note that if at least one control interfaces is not a local socket,
  then you should enable the `control-use-certs` boolean flag to generate and
  configure TLS certificates for use between `unbound(8)` and
  `unbound-control(8)`

forward-zone
  Define a forward zone. Each zone is comprised of a name, which defines for
  what domains this zone applies, and at least one DNS server to which the
  queries should be forwarded. The format is a comma-separated list of values
  where the first element is the name of the zone, and the following elements
  are the IP addresses of the DNS servers; e.g. `example.com,1.2.3.4,4.3.2.1`

local-data
  Control the `unbound.conf(5)` local-data parameter. Note that no local-zone
  is defined, so the unbound default is to treat this data as a transparent
  local zone.

BOOLEAN PARAMETERS
------------------
ip-transparent
  Control the `unbound.conf(5)` ip-transparent parameter.

dns64
  Enables the addition of the DNS64 module.

enable-rc
  Enable remote control.

control-use-certs
  Enable the generation using `unbound-control-setup(8)` of TLS certificates
  for the interaction between `unbound(8)` and `unbound-control(8)`, as well as
  their inclusion in the configuration file.

disable-ip4
  Disable answering queries over IPv4.

disable-ip6
  Disable answering queries over IPv6.

EXAMPLES
--------

.. code-block:: sh

        # Setup two resolvers, one with dns64, the other without.
        __unbound unbound \
                --dns64 \
                --ip-transparent \
                --interface "$address" \
                --access-control "$address/64 allow" \
                --enable-rc \
                --control-interface "/var/run/unbound_control.sock"

        __unbound unbound6only \
                --ip-transparent \
                --interface "$addresstwo" \
                --access-control "$addresstwo/64 allow" \
                --forward-zone "example.com,1.1.1.1,2.2.2.2"


SEE ALSO
--------
`unbound(8)`
`unbound.conf(5)`
`unbound-control(8)`


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
