cdist-type__bird_filter(7)
==========================

NAME
----
cdist-type__bird_filter - Create a named filter to use in configuring bird.


DESCRIPTION
-----------
This type writes a configuration file defining a filter named `__object_id` for
the bird internet routing daemon. It is guaranteed that all filters defined
through this type will be loaded before any other protocol defined using the
cdist __bird_xxx types, except functions. However, note that if two filters
have a dependency, they will be loaded in alphabetical order, so some care may
need to be taken in the naming.

This type takes it's input through stdin, expecting valid filter statements as
per the bird configuration file syntax. The standard input will be printed out
between a `filter __object_id {\n ... \n}`, so only the inner statements are
needed.


EXAMPLES
--------

.. code-block:: sh

    # Setup bird, a filter and open a BGP session.
    __bird_core --router-id 198.51.100.4

    require='__bird_core' __bird_filter bgp_export <<- EOF
        if (source = RTS_DEVICE) then accept;
        reject;
    EOF

    require='__bird_core' __bird_bgp bgp4 \
        --description "a test IPv4 BGP instance" \
        --ipv4-export "filter bgp_export" \
        --[...]


SEE ALSO
--------
cdist-type__bird_core(7)
cdist-type__bird_bgp(7)
cdist-type__bird_function(7)
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
