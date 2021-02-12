cdist-type__matrix_synapse(7)
======================

NAME
----
cdist-type__matrix_synapse - Install and configure Synapse, a Matrix homeserver


DESCRIPTION
-----------
This type install and configure the Synapse Matrix homeserver. This is a
signleton type.


REQUIRED PARAMETERS
-------------------
server-name
  Name of your homeserver (e.g. ungleich.ch) used as part of your MXIDs. This
  value cannot be changed without meddling with the database once the server is
  being used.

base-url
  Public URL of your homeserver (e.g. http://matrix.ungleich.ch).

database-engine
  'sqlite3' or 'postgresql'

database-name
  Path to the database if SQLite3 is used or database name if PostgresSQL is
  used.

OPTIONAL PARAMETERS
-------------------
database-host
  Database node address, only used with PostgresSQL.

database-user
  Database user, only used with PostgresSQL.

database-password
  Database password, only used with PostgresSQL.

ldap-uri
  Address of your LDAP server.

ldap-base-dn
  Base DN of your LDAP tree.

ldap-uid-attribute
  LDAP attriute mapping to Synapse's uid field, default to uid.

ldap-mail-attribute
  LDAP attriute mapping to Synapse's mail field, default to mail.

ldap-name-attribute
  LDAP attriute mapping to Synapse's name field, default to givenName.

ldap-bind-dn
  User used to authenticate against your LDAP server in 'search' mode.

ldap-bind-password
  Password used to authenticate against your LDAP server in 'search' mode.

ldap-filter
  LDAP user filter, defaulting to `(objectClass=posixAccount)`.

turn-uri
  URI to TURN server, can be provided multiple times if there is more than one
  server.

turn-shared-secret
  Shared secret used to access the TURN REST API.

turn-user-lifetime
  Lifetime of TURN credentials. Defaults to 1h.

max-upload-size
  Maximum size for user-uploaded files. Defaults to 10M.

rc-message-per-second
  Message rate-limiting (per second). Defaults to 0.17.

rc-message-burst
  Message rate-limiting (burst). Defaults to 3.

rc-login-per-second
  Login rate-limiting (per-second). Defaults to 0.17.

rc-login-burst
  Login rate-limiting (burst). Defaults to 3.

branding-auth-header-logo-url
  A logo that is shown in the header during authentication flows.

branding-auth-footer-links
  A list of links to show in the authentication page footer: `[{"text": "Link text", "url": "https://link.target"}, {"text": "Other link", ...}]`

registration-allows-email-pattern
    Only allow email addresses matching specified filter. Can be specified multiple times. A pattern must look like `.*@vector\.im`.

auto-join-room
  Room where newly-registered users are automatically added. Can be specified multiple times.

app-service-config-file
  Path (on remote) of an application service configuration file to load. Can be specified multiple times.

extra-setting
  Arbitrary string to be added to the configuration file. Can be specified multiple times.

BOOLEAN PARAMETERS
------------------
allow-registration
  Enables user registration on the homeserver.

enable-ldap-auth
  Enables ldap-backed authentication.

ldap-search-mode
  Enables 'search' mode for LDAP auth backend.

report-stats
  Whether or not to report anonymized homeserver usage statistics.

expose-metrics
  Expose metrics endpoint for Prometheus.

disable-federation
  Disable federation to the broader matrix network.

registration-require-email
  Make email a required field on registration.

allow-public-rooms-over-federation
  Allow other homeservers to fetch this server's public room directory.

allow-public-rooms-without-auth
  If set to 'false', requires authentication to access the server's public rooms directory through the client API.

enable-server-notices
  Enable the server notices room.

global-cache-factor
  Controls the global cache factor, which is the default cache factor
  for all caches if a specific factor for that cache is not otherwise
  set. Defaults to 0.5.

event-cache-size
  Number of events to cache in memory. Defaults to 10K.

allow-guest-access
  Allows users to register as guests without a password/email/etc, and
  participate in rooms hosted on this server which have been made accessible to
  anonymous users.

EXAMPLES
--------

.. code-block:: sh

    __matrix_synapse --server-name ungleich.ch \
      --base-url https://matrix.ungleich.ch \
      --database-engine sqlite3 \
      --database-name /var/lib/matrix-syanpse/homeserver.db

SEE ALSO
--------
- `cdist-type__matrix_element(7) <cdist-type__matrix_element.html>`_


AUTHORS
-------
Timothée Floure <timothee.floure@ungleich.ch>


COPYING
-------
Copyright \(C) 2019 Timothée Floure. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
