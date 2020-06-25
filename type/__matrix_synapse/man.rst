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
server_name
  Name of your homeserver (e.g. ungleich.ch) used as part of your MXIDs. This
  value cannot be changed without meddling with the database once the server is
  being used.

base_url
  Public URL of your homeserver (e.g. http://matrix.ungleich.ch).

database_engine
  'sqlite3' or 'postgresql'

database_name
  Path to the database if SQLite3 is used or database name if PostgresSQL is
  used.

OPTIONAL PARAMETERS
-------------------
database_host
  Database node address, only used with PostgresSQL.

database_user
  Database user, only used with PostgresSQL.

database_password
  Database password, only used with PostgresSQL.

ldap_uri
  Address of your LDAP server.

ldap_base_dn
  Base DN of your LDAP tree.

ldap_uid_attribute
  LDAP attriute mapping to Synapse's uid field, default to uid.

ldap_mail_attribute
  LDAP attriute mapping to Synapse's mail field, default to mail.

ldap_name_attribute
  LDAP attriute mapping to Synapse's name field, default to givenName.

ldap_bind_dn
  User used to authenticate against your LDAP server in 'search' mode.

ldap_bind_password
  Password used to authenticate against your LDAP server in 'search' mode.

ldap_filter
  LDAP user filter, defaulting to `(objectClass=posixAccount)`.

turn_uri
  URI to TURN server, can be provided multiple times if there is more than one
  server.

turn_shared_secret
  Shared secret used to access the TURN REST API.

turn_user_lifetime
  Lifetime of TURN credentials. Defaults to 1h.

max_upload_size
  Maximum size for user-uploaded files. Defaults to 10M.

rc_message_per_second
  Message rate-limiting (per second). Defaults to 0.17.

rc_message_burst
  Message rate-limiting (burst). Defaults to 3.

rc_login_per_second
  Login rate-limiting (per-second). Defaults to 0.17.

rc_login_burst
  Login rate-limiting (burst). Defaults to 3.

branding_auth_header_logo_url
  A logo that is shown in the header during authentication flows.

branding_auth_footer_links
  A list of links to show in the authentication page footer: `[{"text": "Link text", "url": "https://link.target"}, {"text": "Other link", ...}]`

registration_allows_email_pattern
    Only allow email addresses matching specified filter. Can be specified multiple times. A pattern must look like `.*@vector\.im`.

auto_join_room
  Room where newly-registered users are automatically added. Can be specified multiple times.

app_service_config_file
  Path (on remote) of an application service configuration file to load. Can be specified multiple times.

extra_setting
  Arbitrary string to be added to the configuration file. Can be specified multiple times.

BOOLEAN PARAMETERS
------------------
allow_registration
  Enables user registration on the homeserver.

enable_ldap_auth
  Enables ldap-backed authentication.

ldap_search_mode
  Enables 'search' mode for LDAP auth backend.

report_stats
  Whether or not to report anonymized homeserver usage statistics.

expose_metrics
  Expose metrics endpoint for Prometheus.

disable_federation
  Disable federation to the broader matrix network.

registration_require_email
  Make email a required field on registration.

allow_public_rooms_over_federation
  Allow other homeservers to fetch this server's public room directory.

allow_public_rooms_without_auth
  If set to 'false', requires authentication to access the server's public rooms directory through the client API.

enable_server_notices
  Enable the server notices room.

global_cache_factor
  Controls the global cache factor, which is the default cache factor
  for all caches if a specific factor for that cache is not otherwise
  set. Defaults to 0.5.

event_cache_size
  Number of events to cache in memory. Defaults to 10K.

allow_guest_access
  Allows users to register as guests without a password/email/etc, and
  participate in rooms hosted on this server which have been made accessible to
  anonymous users.

EXAMPLES
--------

.. code-block:: sh

    __matrix_synapse --server_name ungleich.ch \
      --base_url https://matrix.ungleich.ch \
      --database_engine sqlite3 \
      --database_name /var/lib/matrix-syanpse/homeserver.db

SEE ALSO
--------
- `cdist-type__matrix_riot(7) <cdist-type__matrix_riot.html>`_


AUTHORS
-------
Timothée Floure <timothee.floure@ungleich.ch>


COPYING
-------
Copyright \(C) 2019 Timothée Floure. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
