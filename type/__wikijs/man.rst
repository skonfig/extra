cdist-type__wikijs(7)
========================

NAME
----
cdist-type__wikijs - Deploy the wiki.js software.

DESCRIPTION
-----------

See wiki.js.org for more information. This type deploys with a postgresql
database, since it is the upstream recommended for production, and they seem to
strongly suggest that in the next releases, they will not support anything else.

Currently, this type servers wikijs as standalone, listening on ports 80 and
443, and with a service file for OpenRC. Feel free to contribute a
generalisation if you require one.

REQUIRED PARAMETERS
-------------------

database-password
  The password to the PSQL database.

version
  'wikijs' version to be deployed.

OPTIONAL PARAMETERS
-------------------

database
  The name of the PSQL database to connect to. If omitted, then 'wikijs' is
  used.

database-user
  The name of the PSQL database user to connect as. If omitted, then 'wikijs' is
  used.

letsencrypt-mail
  If the SSL parameter is passed, then we setup wikijs to automatically obtain
  certificates: this is the email used to sign up to a LE account.

http-port
  Specify HTTP port, defaults to 80.

https-port
  Specify HTTPS port, defaults to 443. Only relevant if the SSL flag is enabled.

BOOLEAN PARAMETERS
------------------

ssl
  Whether or not to enable the wikijs automatic obtention of LE certificates.

AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>

COPYING
-------
Copyright \(C) 2020 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
