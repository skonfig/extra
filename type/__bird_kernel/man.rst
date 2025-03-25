cdist-type__bird_kernel(7)
==========================

NAME
----
cdist-type__bird_kernel - configure syncing of routes with the kernel.


DESCRIPTION
-----------

This type writes the configuration for an instance of the kernel protocol to be
ran by the bird internet routing daemon. It **expects** to depend on
:strong:`cdist-type__bird_core`\ (7).

OPTIONAL PARAMETERS
-------------------
description
    An instance desciption to be printed when `birdc show protocols` is called.

persist
    Instruct bird to leave routes in kernel table after exiting. See the bird
    `persist` keyword.

learn
    Learn routes added externally to the kernel routing table. See the bird
    `learn` keyword.

channel
    The channel to connect the protocol to. Usually `ipv4` or `ipv6`.

import
    A string suitable for the bird `import` directive. Usually `all`, `none` or
    a filter definition.

export
    See import.


EXAMPLES
--------

.. code-block:: sh

    # Setup bird and open a BGP session.
    __bird_core --router-id 198.51.100.4

    require='__bird_core' __bird_kernel k4 \
        --learn --persist --channel ipv4 \
        --import all \
        --export all


SEE ALSO
--------
cdist-type__bird_bgp(7)
cdist-type__bird_core(7)
cdist-type__bird_filter(7)
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
