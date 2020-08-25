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
    NetBox version to be installed. You can find the correct and newest version
    on GitHub at the NetBox project page under
    "`Releases <https://github.com/netbox-community/netbox/releases>`_".

database
    PostgreSQL database name.

database-user
    PostgreSQL database user.

database-password
    PostgreSQL database password.

host
    Hostname (domain or IP address) on which the application is served.
    Multiple hostnames are possible; given as multiple arguments.

OPTIONAL PARAMETERS
-------------------
secret-key
    Random secret key of at least 50 alphanumeric characters and symbols. This
    key must be unique to this installation and must not be shared outside the
    local system. If no secret key is given, the type generates an own 50 chars
    long key and saves it on the remote host to remember it for the next run.

    The secret, random string is used to assist in the creation new
    cryptographic hashes for passwords and HTTP cookies. It is not directly
    used for hasing user passwords or for encrpted storage. It can be changed
    at any time, but will invalidate all existing sessions.

database-host
    PostgreSQL database hostname. Defaults to ``localhost``.

database-port
    PostgreSQL database port. Defaults to empty (uses the default port).

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

redis-host
    Redis database hostname. Defaults to ``localhost``.

redis-port
    Redis database port. Defaults to ``6379``.

redis-password
    Redis password. Defaults to empty password.

redis-dbid-offset
    Offset to set the redis database id's. The `tasks` database id is
    `offset + 0`     and `caching` is `offset + 1`. The offset defaults
    to ``0``.

smtp-host
    Host of the SMTP email server. Defaults to ``localhost``.

smtp-port
    Port of the SMTP email server. Defaults to ``25``.

smtp-user
    Username to access the SMTP email server. Defaults to empty.

smtp-password
    Password to access the SMTP email server. Defaults to empty.

smtp-from-email
    Email from which NetBox will be sent of. Defaults to empty.

basepath
    Base URL path if accessing netbox within a directory instead of directly the
    webroot ``/``. For example, if installed at https://example.com/netbox/, set
    the value ``netbox/``.

http-proxy
https-proxy
    Proxy which will be used with any HTTP request like webhooks.

data-root
    This parameter set's the media, reports and scripts root to subdirectories
    of the given directory. Values can be overwritten by special parameters like
    `--media-root` for example. Use this option if you want to store persistant
    data of netbox on an other partition. A trailing shlash is not needed.

    The data directories have following predefined sub-directory names:

    media root:
        ``$data_root/media``
    reports root:
        ``$data_root/reports``
    scripts root:
        ``$data_root/scripts``

media-root
    The file path to where media files (like image attachments) are stored.
    Change this path if you require to store data on an other partiotion.
    A trailing slash is not needed. By default, it will be stored into the
    installation directory (``/opt/netbox/netbox/netbox/media``).

reports-root
    The file path of where custom reports are kept. Change this path if you
    require to store data on an other partition. A trailing slash is not
    needed. By default, it will be stored into the installation directory
    (``/opt/netbox/netbox/netbox/reports``).

scripts-root
    The file path of where custom scripts are kept. Change this path if you
    require to store data on an other partition. A trailing slash is not
    needed. By default, it will be stored into the installation directory
    (``/opt/netbox/netbox/netbox/scripts``).

BOOLEAN PARAMETERS
------------------
redis-ssl
    Enables a secure TLS/SSL connection to the redis database. By default, ssl
    is disabled.

smtp-use-tls
    Uses TLS to connect to the SMTP email server. `See documentation
    <https://docs.djangoproject.com/en/3.1/ref/settings/#email-use-tls`_
    for more information.

smtp-use-ssl
    Uses implicit TLS with the SMTP email server. `See documentation
    <https://docs.djangoproject.com/en/3.1/ref/settings/#email-use-ssl`_
    for more information.

login-required
    Sets if a login is required to access all sites. By default, anonymous
    users can see most data (excluding secrets) but not make any changes.

update-notify
    Enables the NetBox version check for new upstream updates. It checks every
    24 hours for new releases and notify the admin users in the gui if any.

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
                --host "cool-netbox.xyz" \
                --ldap-server "ldaps://ldap.domain.tld" \
                --ldap-bind-dn "uid=netbox,ou=services,dc=domain,dc=tld" \
                --ldap-bind-password "secretsecretsecret" \
                --ldap-user-base "ou=users,dc=domain,dc=tld" \
                --ldap-group-base "ou=groups,dc=domain,dc=tld" \
                --ldap-require-group "cn=netbox-login,ou=groups,dc=domain,dc=tld" \
                --ldap-superuser-group "cn=netbox-admin,ou=groups,dc=domain,dc=tld"


NOTES
-----
The configuration of NetBox contains more optional settings than that what can
be set with this type. If you think an important setting is missing or there
is a more good way to inject python code for dynamic configuration variables,
you are welcome to contribute!

- `Possible optional settings
  <https://netbox.readthedocs.io/en/stable/configuration/optional-settings/>`

If you not setup ldap authentification, you may be interested into how to
`setting up a super user
<https://netbox.readthedocs.io/en/stable/installation/3-netbox/#create-a-super-user>`
directly on the machine to be able to access and use NetBox.

SEE ALSO
--------
- `NetBox documentation <https://netbox.readthedocs.io/en/stable/>`_

AUTHORS
-------
Timothée Floure <t.floure@e-durable.ch>
Matthias Stecher <matthiasstecher@gmx.de>


COPYING
-------
Copyright \(C) 2020 Timothée Floure.
Copyright \(C) 2020 Matthias Stecher.
You can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.
