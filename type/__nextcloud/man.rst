cdist-type__nextcloud(7)
========================

NAME
----
cdist-type__nextcloud - Installs and manages a nextcloud instance


DESCRIPTION
-----------
This type installs, upgrades and configure a nextcloud instance.

It installs the application in the webspace based on the object id as relative
path from the webroot. If you want to install it directly in the webroot, you
must trick out this type by setting the webroot as parent directory.


REQUIRED PARAMETERS
-------------------
version
    The version that should be installed. If it is already installed and the
    installed version lower, it will upgrade nextcloud if ``--install-only`` is
    not set.

    The type will never downgrade a nextcloud instance. Rather, it will fail,
    as this is a missconfiguration. Downgrades are not recommended and
    supported by upstream. Such cases can happen if the nextcloud instance was
    upgraded via the built-in nextcloud installer. In such cases, it is
    recommended to use the ``--install-only`` option.

admin-password
    The administrator password to access the nextcloud instance. Must be given
    in plain text.


OPTIONAL PARAMETERS
-------------------
webroot
    The webroot which will be used as basis for the installation. This may be
    already detected by an explorer. Must be an absolute path (starting with a
    slash).

mode
    Sets the unix file mode of the nextcloud directory. This is not inherited
    to child files or folders. Defaults to `755`.

user
    The user which owns the complete nextcloud directory. The php application
    should be executed with this user. All nextcloud commands will be executed
    with this user. This type will not create the unix user.

    The type assumes the default `www-data` user, which is common on Debian
    systems. **If you change this option, please do the same with the group
    parameter!**

group
    The group all files and folders of the nextcloud installation should have.
    Defaults to `www-data`. Should be changed with ``--user``.


BOOLEAN PARAMETERS
------------------
install-only
    Skips all nextcloud upgrades done by this type. Should be used when
    nextcloud upgrades are (*exclusively*) done via the built-in updater.


NEXTCLOUD CONFIG PARAMETERS
---------------------------
host
    All hostnames where the the users can log into nextcloud. If you access
    nextcloud via a hostname not given to this list, the access fails. This
    parameter can be set multiple times.

admin-user
    The username of the administrative user which will be created while the
    installation. If not set, nextcloud defaults to "admin". This parameter has
    no effect if nextcloud will not be installed.

admin-email
    The email address of the administrative user. This parameter has no effect
    if nextcloud will not be installed.

data-directory
    This will set or change the data directory where nextcloud will keep all
    its data, including the SQLite database if any. By default, it will be
    saved in the ``data`` directory below the nextcloud directory.

    If this directory change, this type will move the old location to the new
    one to preserve all data. This is not supported by upstream, as some apps
    may not handle this.

database-type
    Sets the type of database that should be used as backend. Possible backends
    are:

    SQLite
        Use ``sqlite3`` as value. Saves everything in a database file
        stored in the data directory. It is only recommended for very small
        installations or test environments from upstream.

        *All further database options are ignored if SQLite is selected as
        database backend.*

    MariaDB
        Use ``mysql`` as value. MariaDB and MySQL are threated the same
        way. They are the recommended database backends recommended from
        upstream.

    PostgreSQL
        Use ``pgsql`` as value.

    **This parameter defaults to the SQLite database backend, as it is the
    simplest one to setup and do not require extra parameters.**

database-host
    The database host to connect to. Possible are hostnames, ip addresses or
    UNIX sockets. UNIX sockets must set in the format of
    ``localhost:/path/to/socket``. If an non-standard port is used, set it
    after the hostname or ip address seperated by an colon (``:``).

    If this value is not set, nextcloud defaults to the value ``localhost``.

database-name
    The name of the database to connect to. Required if MariaDB or PostgreSQL
    is used.

database-user
    The username to access the database. Required if MariaDB or PostgreSQL is
    used.

database-password
    The password required to authorize the given user. Required if MariaDB or
    PostgreSQL is used.

database-prefix
    The table prefix used by nextcloud. If nothing set, nextcloud defaults to
    ``oc_``.


WEBROOT DETECTION
-----------------
TBA.


MESSAGES
--------
installed
    Nextcloud was successfully installed.

upgraded $old to $new
    The nextcloud version was upgraded from `$old` to `$new`.

configured
    Nextcloud configuration was changed.


ABORTS
------
Aborts in the following cases:

The current installed version is greather than the version that should be
installed. See the parameter description of `--version` for detailed
information. The problem can be fixed by bumping the version value to at least
the version that is currently installed or use the parameter `--install-only`.

The type aborts if there is no webroot given as parameter and no could be
detected by the type itself. Please set the webroot via `--webroot` or extend
this type.

It may abort if the data directory can not be moved correctly. Then, the
nextcloud configuration is broken and must be resolved manually: Move the data
directory to the correct location or change the configuration to point to the
old destination and retry.


EXAMPLES
--------
TBA.


AUTHORS
-------
Matthias Stecher <matthiasstecher at gmx.de>


COPYRIGHT
---------
Copyright \(C) 2020 Matthias Stecher. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
