cdist-type__bird_core(7)
========================

NAME
----
cdist-type__bird_core - setup a skeleton bird configuration.


DESCRIPTION
-----------
The `bird`_ daemon is an internet routing daemon, running protocols such as
OSPF and BGP. This type creates a skeleton configuration file suitable for
running a no-op bird. It is then intended to be combined - and depended on - by
types specific to the instances of the various protocols that bird should run.

.. _bird: https://bird.network.cz/

OPTIONAL PARAMETERS
-------------------
router-id
    This parameter follows the format of an IPv4 address, and will be used by
    bird as its router id. See `the documentation for router id`_.

.. _the documentation for router id: https://bird.network.cz/?get_doc&v=20&f=bird-3.html#opt-router-id

log-params

    This parameter expects a string suitable to follow the `log` bird
    configuration key. If this parameter is not include, the value `syslog all`
    is used. See `the documentation for log`_.

.. _the documentation for log: https://bird.network.cz/?get_doc&v=20&f=bird-3.html#opt-log


EXAMPLES
--------

.. code-block:: sh

    __bird_core --router-id 198.51.100.4

    require='__bird_core' __bird_bgp <...>
    require='__bird_core' __bird_ospf <...>


SEE ALSO
--------
cdist-type__bird_bgp(7)
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
