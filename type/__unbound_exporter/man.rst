cdist-type__unbound_exporter(7)
===============================

NAME
----
cdist-type__unbound_exporter - A prometheus exporter for unbound


DESCRIPTION
-----------
Simple Prometheus metrics exporter for the Unbound DNS
resolver. It leverages the unbound remote control endpoint
and exposes metrics on port 9167.


REQUIRED PARAMETERS
-------------------
version
  unbound_exporter release to be used.

OPTIONAL PARAMETERS
-------------------
None.


BOOLEAN PARAMETERS
------------------
None.


EXAMPLES
--------

.. code-block:: sh

    __unbound \
      --interface '::0' \
      --forward_addr '2a0a:e5c0:2:1::5' \
      --forward_addr '2a0a:e5c0:2:1::6' \
      --access_control '::0/0 deny' \
      --access_control '2a0a:e5c0::/29 allow' \
      --access_control '2a09:2940::/29 allow' \
      --disable_ip4 \
      --enable_rc \
      --rc_interface '::1'

    __unbound_exporter --version 0.1.3

SEE ALSO
--------
:strong:`cdist-type__unbound(7)`

AUTHORS
-------
Timothée Floure <timothee.floure@ungleich.ch>


COPYING
-------
Copyright \(C) 2020 Timothée Floure. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
