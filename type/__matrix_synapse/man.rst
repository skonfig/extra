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
  value cannot be changed later on.

base-url
  Public URL of your homeserver (e.g. `<http://matrix.ungleich.ch>`_).

database-engine
  'sqlite3' or 'psycopg2' (= Postgresql).

database-name
  Path to database file if SQLite3 is used or database name if PostgresSQL is
  used.

OPTIONAL PARAMETERS
-------------------
database-host
  Database node address, only used with PostgresSQL.

database-user
  Database user, only used with PostgresSQL.

database-password
  Database password, only used with PostgresSQL.

database-connection-pool-min
  The minimum number of connections in pool, defaults to 3.

database-connection-pool-max
  The maximum number of connections in pool, defaults to 5.

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

tls-cert
  Path to PEM-encoded X509 TLS certificate. Not needed if TLS termination is
  handled by a reverse Proxy such as NGINX.

tls-private-key
  Path to PEM-encoded TLS private key. Not needed if TLS termination is
  handled by a reverse Proxy such as NGINX.

smtp-host
  The hostname of the outgoing SMTP server to use. Defaults to 'localhost'.

smtp-port
  # The port on the mail server for outgoing SMTP. Defaults to 25.

smtp-user
  Username for authentication to the SMTP server. By
  default, no authentication is attempted.

smtp-password
  Password for authentication to the SMTP server. By
  default, no authentication is attempted.

notification-from
  From address to use when sending emails. Defaults
  to "%(app)s <no-reply@$SERVER_NAME>".

message-max-lifetime
  Default retention policy. If set, Synapse will apply it to rooms that lack
  the 'm.room.retention' state event. Ignored if
  enable-message-retention-policy is not set. Defaults to 1y.

web-client-url
  Custom URL for client links within the email
  notifications. By default links will be based on
  "https://matrix.to".

global-cache-factor
  Controls the global cache factor, which is the default cache factor for all
  caches if a specific factor for that cache is not otherwise set. Defaults to
  0.5, which will half the size of all caches.

event-cache-size
  The number of events to cache in memory. Not affected by
  caches.global_factor. Defaults to 10K.

remote-room-complexity-threshold
  The limit above which rooms cannot be joined when
  limit-remote-room-complexity is set. Room complexity is an arbitrary measure
  based on factors such as the number of users in the room. The default is 1.0.

room-encrypt-policy
  Controls whether locally-created rooms should be end-to-end encrypted by
  default. Possible options are "all" (any locally-created room), "invite"
  (any room created with the private_chat or trusted_private_chat room
  creation presets , and "off" (this option will take no effect). Defaults to
  "off".

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

registration-allows-email-pattern
    Only allow email addresses matching specified filter. Can be specified multiple times. A pattern must look like `.*@vector\.im`.

auto-join-room
  Room where newly-registered users are automatically added. Can be specified multiple times.

app-service-config-file
  Path (on remote) of an application service configuration file to load. Can be specified multiple times.

worker-replication-secret
  A shared secret used by the replication APIs to authenticate HTTP requests
  from workers. Ignored if worker-mode is not set. By default this is unused and
  traffic is not authenticated.

background-tasks-worker
  The worker that is used to run background tasks (e.g. cleaning up expired
  data). If not provided this defaults to the main process.

outbound-federation-worker
  Worker to be used for sending federation requests. Can be specified multiple
  times. Disables sending outbound federation requests from the master process.

registration-shared-secret
  If set, allows registration of standard or admin accounts by anyone who
  has the shared secret, even if registration is otherwise disabled.

bind-address
  Address used to bind the synapse listeners. Can be specified multiple times.
  Defaults to '::1' and '127.0.0.1'.

extra-setting
  Arbitrary string to be added to the configuration file. Can be specified multiple times.

BOOLEAN PARAMETERS
------------------
enable-registrations
  Enables user registration on the homeserver.

enable-ldap-auth
  Enables ldap-backed authentication.

ldap-use-starttls
  Use STARTTLS when connection to the LDAP server.

report-stats
  Whether or not to report anonymized homeserver usage statistics.

expose-metrics
  Expose metrics endpoint for Prometheus.

enable-notifications
  Enable mail notifications (see smtp-* optinal parameters).

smtp-use-starttls
  Use STARTTLS when connection to the SMTP server.

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

allow-guest-access
  Allows users to register as guests without a password/email/etc, and
  participate in rooms hosted on this server which have been made accessible
  to anonymous users.

limit-remote-room-complexity
  When this is enabled, the room "complexity" will be checked before a user joins
  a new remote room. If it is above the complexity limit (see
  remote-room-complexity-threshold parameter), the server will disallow
  joining, or will instantly leave.

disable-presence
  Disable presence tracking on this homeserver.

user-directory-search-all-users
  Defines whether to search all users visible to your HS when searching the
  user directory, rather than limiting to users visible in public rooms.
  If you set it True, you'll have to rebuild the user_directory search indexes,
  see
  `<https://github.com/matrix-org/synapse/blob/master/docs/user_directory.md>`_.

enable-message-retention-policy
  If this feature is enabled, Synapse will regularly look for and purge events
  which are older than the room's maximum retention period. Synapse will also
  filter events received over federation so that events that should have been
  purged are ignored and not stored again. See message-max-lifetime flag.

worker-mode
  For small instances it recommended to run Synapse in the default monolith
  mode. For larger instances where performance is a concern it can be helpful
  to split out functionality into multiple separate python processes. These
  processes are called 'workers'. Please read the  WORKER MODE section of this
  manpage before enabling, as extra work and considerations are required.

PERFORMANCE
-----------

The Synapse server is not very performant (initial implementation, pretty
resource hungry, etc.) and will eventually be replaced by Dendrite. The
following parameters (see above descriptions) will help you with performance
tuning:

  * global-cache-factor
  * event-cache-size
  * disable-presence
  * limit-remote-room-complexity and remote-room-complexity-threshold

WORKER MODE
-----------

Worker mode allows to move some processing out of the main synapse process for
horizontal scaling. You are expected to use the
`cdist-type__matrix_synapse_worker(7)
<cdist-type__matrix_synapse_worker.html>`_ type to set up workers when the
worker-mode flag is set.

Worker mode depend on the following components:

  * A working `redis <https://redis.io/>`_ server
  * The hiredis python package (`python3-hiredis
    <https://packages.debian.org/buster/python3-hiredis>`_ on debian, not
    packaged in alpine as of 2021-02-17).
  * The txredisapi python package, which is not packaged on debian nor alpine
    as of 2021-02-17.

The current way to install the above two python packages (if not packaged in
your distribution) is sadly to use pip (see `cdist-type__python_pip(7)
<cdist-type__python_pip.html>`_ core cdist type).

It is also recommended to first take a look at:

  - `upstream's high-level overview on workers (matrix.org blog post) <https://matrix.org/blog/2020/11/03/how-we-fixed-synapses-scalability>`_
  - `upstream's documentation on workers <https://github.com/matrix-org/synapse/blob/develop/docs/workers.md>`_

EXAMPLES
--------

.. code-block:: sh

    __matrix_synapse --server-name ungleich.ch \
      --base-url https://matrix.ungleich.ch \
      --database-engine sqlite3 \
      --database-name /var/lib/matrix-syanpse/homeserver.db

You might also be interested in ungleich's `__ungleich_matrix
<https://code.ungleich.ch/ungleich-public/cdist-ungleich/-/tree/master/type/__ungleich_matrix>`_
meta-type.

SEE ALSO
--------
- `cdist-type__matrix_element(7) <cdist-type__matrix_element.html>`_
- `cdist-type__matrix_synapse_admin(7) <cdist-type__matrix_synapse_admin.html>`_
- `cdist-type__matrix_synapse_worker(7) <cdist-type__matrix_synapse_worker.html>`_


AUTHORS
-------
Timothée Floure <timothee.floure@ungleich.ch>


COPYING
-------
Copyright \(C) 2019-2021 Timothée Floure. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
