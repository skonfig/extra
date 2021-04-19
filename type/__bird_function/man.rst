cdist-type__bird_function(7)
============================

NAME
----
cdist-type__bird_function - Create a named function to use in configuring bird.


DESCRIPTION
-----------

This type writes a configuration file for the bird internet routing daemon. It
is guaranteed that all functions defined through this type will be loaded
before any other protocol defined using the cdist __bird_xxx types. However,
note that if two functions have a dependency, they will be loaded in
alphabetical order, so some care may need to be taken in the naming.

This type takes it's input through stdin, expecting a valid function definition
as per the bird configuration file syntax.

EXAMPLES
--------

.. code-block:: sh

    # Setup bird, a function and open a BGP session.
    __bird_core --router-id 198.51.100.4

    require='__bird_core' __bird_function is_device <<- EOF
        function is_device (enum source)
        {
        if (source = RTS_DEVICE) then return true;
        return false;
        }
    EOF


SEE ALSO
--------
cdist-type__bird_core(7)
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
