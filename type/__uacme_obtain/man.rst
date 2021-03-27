cdist-type__uacme_obtain(7)
===========================

NAME
----
cdist-type__uacme_obtain - obtain, renew and deploy Let's Encrypt certificates

DESCRIPTION
-----------

This type leverage uacme to issue and renew Let's Encrypt certificates and
provides a simple deployment mechanism. It is expected to be called after
`__uacme_account`.

REQUIRED PARAMETERS
-------------------
None.

OPTIONAL PARAMETERS
-------------------
challengedir
  Path to publicly available (served by a third-party HTTP server, under
  `$DOMAIN/.well-known/acme-challenge`) challenge directory.

confdir
  uacme configuration directory.

hookscript
  Path to the challenge hook program.

owner
  Owner of installed certificate (e.g. `www-data`), passed to `chown`.

install-cert-to
  Installation path of the issued certificate.

install-key-to
  Installation path of the certificate's private key.

renew-hook
  Renew hook executed on certificate renewal (e.g. `service nginx reload`).

force-cert-ownership-to
  Override default ownership for TLS certificate, passed as argument to chown.

OPTIONAL MULTIPLE PARAMETERS
----------------------------
altdomains
  Alternative domain names for this certificate.

BOOLEAN PARAMETERS
------------------
no-ocsp
  When this flag is *not* specified and the certificate has an Authority
  Information Access extension with an OCSP server location  *uacme* makes an
  OCSP request to the server; if the certificate is reported as revoked *uacme*
  forces reissuance regardless of the expiration date.

must-staple
  Request certificates with the RFC7633 Certificate Status Request
  TLS Feature Extension, informally also known as "OCSP Must-Staple".

use-rsa
  Use RSA instead of EC for the private key. Only applies to newly generated keys.

SEE ALSO
--------
:strong:`cdist-type__letsencrypt_cert`\ (7)
:strong:`cdist-type__uacme_account`\ (7)

AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>
Timothée Floure <timothee.floure@posteo.net>

COPYING
-------
Copyright \(C) 2020 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
