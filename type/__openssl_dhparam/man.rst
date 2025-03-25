cdist-type__openssl_dhparam(7)
==============================

NAME
----
cdist-type__openssl_dhparam - Manage DH parameter files


DESCRIPTION
-----------
This type can be used to manage DH parameter files.

It uses `OpenSSL <https://www.openssl.org/>`_ to generate the parameters.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
bits
   The length of the DH parameters.

   cf. `openssl-dhparam(1)
   <https://www.openssl.org/docs/manmaster/man1/openssl-dhparam.html#numbits>`_
   for more information.

   Defaults to: 2048
state
   One of:

   ``present``
      the DH parameters file exists
   ``absent``
      the DH parameters file does not exist


BOOLEAN PARAMETERS
------------------
background
   The generation of the DH parameters file can take quite some time.
   This parameter will make the generation run in the background
   (using :strong`nohup`\ (1)).

   Please note that some applications will not start if the parameters file does
   not exist. Using ``--background`` may break your configuration.


EXAMPLES
--------

.. code-block:: sh

   # Create a DH parameters file with default values
   __openssl_dhparam /etc/dh.pem

   # Create a 4096 big DH parameters file
   __openssl_dhparam /etc/dh4096.pem --bits 4096


SEE ALSO
--------
:strong:`openssl-dhparam`\ (1)


AUTHORS
-------
Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
