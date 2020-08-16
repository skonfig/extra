cdist-type__netbox(7)
=====================

NAME
----
cdist-type__netbox - Install and configure NetBox


DESCRIPTION
-----------
This (singleton) type installs and configures a NetBox instance, a web
application to help manage and document computer networks.

It installs it with the user ``netbox`` at ``/opt/netbox`` with `python-venv`.
Netbox will be run via `gnuicorn` as WSGI service. It setup systemd unit files
for the services `netbox` and `netbox-rq`.


REQUIRED PARAMETERS
-------------------
version
    NetBox version to be installed.

database
    PostgreSQL database name.

database-password
    PostgreSQL database password.

secret-key
    Random secret key of at least 50 alphanumeric characters. This key must be
    unique to this installation and must not be shared outside the local
    system.

host
    Hostname (domain or IP address) on which the application is served.

OPTIONAL PARAMETERS
-------------------
ldap-server
  LDAP server URI. Enables LDAP-backed authentication if specified.

ldap-bind-dn
  DN for the NetBox service account. Required for LDAP authentication.

ldap-bind-password
  Password for the NetBox service account. Required for LDAP authentication.

ldap-user-base
  Base used for searching user entries. Required for LDAP authentication.

ldap-group-base
  Base used for searching group entries.

ldap-require-group
  Group required to login.

ldap-superuser-group
  Make members of this groups superusers.

BOOLEAN PARAMETERS
------------------
None.

MESSAGES
--------
installed $VERSION
    Netbox was fresh installed or updated. The new version number is appended.

configuration
    Some configuration files got updated and therefore the service was
    restarted. This message will not be echoed if configuration got updated due
    a standard installation.


EXAMPLES
--------

.. code-block:: sh

  __netbox --version 2.8.7 --database netbox \
			--database-password "secretsecretsecret" \
			--secret-key "secretsecretsecret" \
			--host "${__target_host:?}" \
			--ldap-server "ldaps://ldap.domain.tld" \
			--ldap-bind-dn "uid=netbox,ou=services,dc=domain,dc=tld" \
			--ldap-bind-password "secretsecretsecret" \
			--ldap-user-base "ou=users,dc=domain,dc=tld" \
			--ldap-group-base "ou=groups,dc=domain,dc=tld" \
			--ldap-require-group "cn=netbox-login,ou=groups,dc=domain,dc=tld" \
			--ldap-superuser-group "cn=netbox-admin,ou=groups,dc=domain,dc=tld"


SEE ALSO
--------
- `NetBox documentation <https://netbox.readthedocs.io/en/stable/>`_

AUTHORS
-------
Timothée Floure <t.floure@e-durable.ch>


COPYING
-------
Copyright \(C) 2020 Timothée Floure. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
