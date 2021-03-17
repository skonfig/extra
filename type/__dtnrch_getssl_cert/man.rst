cdist-type__dtnrch_getssl_cert(7)
=================================

NAME
----
cdist-type__dtnrch_getssl_cert - Manage an SSL certficiate using GetSSL.


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
acl
   "ACME Challenge Location"

   The ACME Challenge Location for the domain and each SAN.
   Can be used multiple times, to specify different ACLs for each of the SANs.
   If used only once, the same ACL will be used for all domains.

   cf. https://github.com/srvrco/getssl/wiki/Config-variables#acl
ca
   The URL of the ACME CA to use.

   Will use the CA specified in the global configuration, by default.
ca-loc
   Location to copy the signed ``ca.crt`` to.
cert-loc
   Location to copy the signed ``domain.crt`` to.
chain-loc
   Location to copy the signed ``chain.crt`` to.

   This is a single file containing both the domain certificate and the CA
   certificate concatenated.
key-loc
   Location to copy the signed ``domain.key`` to.
pem-loc
   Location to copy the ``domain.pem`` to.

   This is a single file with all three certificates in it.
extra-config
   Other configuration options that should be added to the domain
   ``getssl.cfg``.
reload-cmd
   The command to be executed once a certificate has been issued and copied to
   the ``--*-loc`` locations.

   Typically, this would be something like ``/etc/init.d/httpd reload``.

   | Commands can also be executed on a remote server, e.g.
   | ``ssh:www@other-server.example.com:/etc/init.d/httpd reload``
san
   Subject Alternate Name.

   The default is blank.
   Can be any alternate domain you want on the same certificate, e.g. ``www.${__object_id}``.
   This parameter can be used multiple times to add multiple alternate domains.

   The primary domain ``${__object_id}`` should not be include in the SAN list.
server-type
   Determines the server type that GetSSL will check to determine if the
   certificate was installed correctly.

   cf. https://github.com/srvrco/getssl/wiki/Config-variables#server_typehttps
state
   One of:

   present
      the certficate should be created and requested
   absent
      | the certificate configuration should be removed from GetSSL.
      | NB: certificates copied to ``--*-loc`` will not be removed.


BOOLEAN PARAMETERS
------------------
no-check-remote
   Do not check the remote server for correct installation of the certificate
   (based on ``--server-type``.


EXAMPLES
--------

.. code-block:: sh

    # Get an SSL certficate for example.com
    __dtnrch_getssl_cert example.com


SEE ALSO
--------
:strong:`cdist-type__dtnrch_getssl`\ (7)


AUTHORS
-------
Dennis Camera <cdist--@--dtnr.ch>


COPYING
-------
Copyright \(C) 2021 Dennis Camera. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
