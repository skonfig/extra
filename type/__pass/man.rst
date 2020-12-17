cdist-type__pass(7)
===================

NAME
----
cdist-type__pass - Generate and use passwords using pass(1).


DESCRIPTION
-----------
This type allows a user to generate and query passwords stored using pass(1) on
the host machine. The password is then printed to the cdist message system, so
types depending on this one should require it. This enables an administrator to
ensure a password exists using this type and then, from another type, use it as
need be.

This type also sets the GPG IDs used to encrypt the password store: beware that
the IDs passed in the last ran invocation of the type will be the ones set for
the store.

REQUIRED PARAMETERS
-------------------
storedir
    The host-local directory where the password store is to be found (or
    created if it does not exist).


REQUIRED MULTIPLE PARAMETERS
----------------------------
gpgid
    The GPG IDs of the public keys used to encrypt the password store.

OPTIONAL PARAMETERS
-------------------
length
    The length of the password to be created if it does not exist. Note that if
    it exists, this has no effect (and hence will not update the password, even
    if the length is different from the one specified).

BOOLEAN PARAMETERS
------------------
no-symbols
    If this parameter is set, then a newly generated password will only contain
    alphanumeric characters, making it easier for typing by meatware.


EXAMPLES
--------

Assuming that __othertype takes the path of the password as an argument and
looks up in the cdist messages to find it:

.. code-block:: sh

    __pass database/services/arandomservice
        --storedir password/store/location
        --gpgpid 92296965EAA1DD86A93284EF7B21E5AA32FB9810

   require='__pass/database/services/arandomservice' \
     __othertype --password database/service/arandomservice

--

SEE ALSO
--------
`pass`\ (7)


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2020 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
