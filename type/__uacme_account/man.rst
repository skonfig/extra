cdist-type__uacme_account(7)
============================

NAME
----
cdist-type__uacme_account - Install uacme and register Let's Encrypt account.


DESCRIPTION
-----------

This type is used to bootstrap acquiring certificates from the Let's Encrypt
C.A by creating an account and accepting terms of use. The
`cdist-type__uacme_obtain(7)` type instances expect to depend on this type.


OPTIONAL PARAMETERS
-------------------
confdir
    An alternative configuration directory for uacme's private keys and
    certificates.

admin-mail
    Administrative contact email to register the account with.

EXAMPLES
--------

.. code-block:: sh

   # Create account with default settings for the OS.
   __uacme_account

   # Create an account with email and custom location.
   __uacme_account --confdir /opt/custom/uacme --admin-mail admin@domain.tld


SEE ALSO
--------
:strong:`cdist-type__letsencrypt_cert`\ (7)
:strong:`cdist-type__uacme_obtain`\ (7)

AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>

COPYING
-------
Copyright \(C) 2020 Joachim Desroches. You can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.
