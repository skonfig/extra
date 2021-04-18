cdist-type__jool(7)
===================

NAME
----
cdist-type__jool - Configures a NAT64 instance using jool.


DESCRIPTION
-----------
This type configures an instance of a NAT64 using jool. This type **does not**
configure anything related to the other capacities of the jool project, such as
SIIT (see the `jool_siit` daemon / `__jool_siit` type - unimplemented at this
time). See https://jool.mx

Note that this type is only implemented for the Alpine Linux operating system.

Note that this type currently does not implement running several parallel
instances of jool NAT64. Please contribute your implementation if you do so.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
instance
    The instance name, `default` if unspecified.

framework
    The used translation framework, `netfilter` if unspecified.

pool6
    The IPv6 prefix used to map IPv4 addresses, `64:ff9b::/96` if unspecified.


BOOLEAN PARAMETERS
------------------
vm
    Wether this instance is running in a VM or not: configures the kernel
    modules that will be installed.


EXAMPLES
--------

.. code-block:: sh

    __jool # Everything default

    # or, if you're feeling contrary

    __jool --instance "prettysoup" \
        --framework "iptables" \
        --pool6 "2001:DB8:dead:beef::/96"


SEE ALSO
--------
`cdist-type__jool_siit(7)` - yet to be written
`cdist-type__joold(7)` - yet to be written


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
