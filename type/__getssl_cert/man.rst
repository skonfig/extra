cdist-type__getssl_cert(7)
==========================

NAME
----
cdist-type__getssl_cert - Manage an SSL certficiate using GetSSL.


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
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
preferred-chain
   Select the chain which should be used to sign the certificate.

   For more information cf. https://github.com/srvrco/getssl#preferred-chain
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
validation
   Specifies the method GetSSL should use to validate the domains.

   Currently, these methods are supported:

   http-01
      Stores a file in the webroot of the web server.

      **Parameters:**

      webroot
         The location of the domain's web server's document root.
   dns-01
      Adds a TXT record to the domain's DNS.

      **Parameters:**

      add-script
         Executable script that adds a TXT record.
      del-script
         Executable script that deletes a TXT record.

   Methods and parameters are specified as a single parameter, e.g.:

   - ``--validation http-01:webroot=/var/www``
   - ``--validation dns-01:add-script=/usr/local/bin/dns-add,del-script=/usr/local/bin/dns-del``

BOOLEAN PARAMETERS
------------------
no-check-remote
   Do not check the remote server for correct installation of the certificate
   (based on ``--server-type``.


EXAMPLES
--------

.. code-block:: sh

   # Get an SSL certficate for example.com
   __getssl_cert example.com


SEE ALSO
--------
:strong:`cdist-type__getssl`\ (7)


AUTHORS
-------
Dennis Camera <skonfig--@--dtnr.ch>


COPYING
-------
Copyright \(C) 2021 Dennis Camera. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
