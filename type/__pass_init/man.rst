cdist-type__pass_init(7)
========================

NAME
----
cdist-type__pass_init - Initialize a local password store.


DESCRIPTION
-----------
This type is intented to be used as a prerequisite to
:strong:`cdist-type__pass`\ (7). It will set up a :strong:`pass`\ (1) password
store with the provided PGP public key IDs.


REQUIRED PARAMETERS
-------------------
storedir
    The host-local directory where the password store is to be found (or
    created if it does not exist).


REQUIRED MULTIPLE PARAMETERS
----------------------------
gpgid
    The PGP IDs of the public keys used to encrypt the password store.


EXAMPLES
--------

.. code-block:: sh

    # Setup a repository with a GPG ID
    __pass_init
        --storedir password/store/location
        --gpgpid 92296965EAA1DD86A93284EF7B21E5AA32FB9810

--

SEE ALSO
--------
* :strong:`pass`\ (1)
* :strong:`cdist-type__pass`\ (7)


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
