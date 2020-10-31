cdist-type__nextcloud_user(7)
=============================

NAME
----
cdist-type__nextcloud_user - Setup a Nextcloud user


DESCRIPTION
-----------
It manages a single Nextcloud user given by the object id or parameter `--user`.
This type can create and manage most properties of the Nextcloud user. If you
only want to setup the user, but want that the user will take full control over
all settings (so cdist will not touch the user anymore), use the parameter
`--only-setup` or `--keep-*` for special parameters.


REQUIRED PARAMETERS
-------------------
cloud
    The absolute path of the Nextcloud installation.


OPTIONAL PARAMETERS
-------------------
state
    The state the user should be in. Can be the following:

    present *(default)*
        The user exists.

    enabled
        The user exists and is enabled.

    disabled
        The user exists and is disabled.

    absent
        The user does not exist.

user
    Takes the uid of the Nextcloud user which will be handled by this type. If
    this is not set, the object id will be taken instead.

www-user
    The unix user which will be used to execute Nextcloud related stuff. You
    should always use the same user for all Nextcloud interactions, for the
    webserver and cli execution. As default, `www-data` will be used.

displayname
    The display name the user should have. As the display name can not be unset
    or set to empty, this type will ignore the display name if this parameter
    is not set. Setting the parameter to an empty string leads to an error from
    the Nextcloud side.

email
    The email address of the Nextcloud user. Will be unset if no parameter
    given.

password
    The password of the Nextcloud user. If the password not match, the new
    password will be set to the user. If no password is given, it will not
    touch the current password. **A password is required for the user setup!**
    If you do not want to modify the user password, set a password via this
    parameter and set the parameter `--keep-password`.

quota
    The quota the Nextcloud user have to store it data. Defaults to `default`.

group
    Multiple group names which the Nextcloud user belongs to. If not set, the
    user will be removed from every group he is in.


BOOLEAN PARAMETERS
------------------
only-setup
    Only provisioning the user if he does not exist. Do not touch the user if
    he already exists (except to enforce the given state).

keep-displayname
    Do not touch the display name of the user if he is already set up. This
    will avoid to delete the user-set value because it does not match with the
    predefined state. If the parameter `--displayname` is set despite of this
    parameter, it will only be used in the user setup if he does not already
    exist.

keep-email
    Do not touch the email attributes of the user if he is already set up. This
    will avoid to delete the user-set value because it does not match with the
    predefined state. If the parameter `--email` is set despite of this
    parameter, it will only be used in the user setup if he does not already
    exist.

keep-password
    Do not touch the password if the user is already set up. This will avoid to
    delete user-set passwords because they do not match with the predefined
    state. If the parameter `--password` is set despite of this parameter, it
    will only be used in the user setup if he does not already exists.

keep-quota
    Do not touch the user quota if he is already set up. This will avoid to
    delete the configuration set by an administrator. If the parameter `--quota`
    is set despite of this parameter, it will only be used in the user setup if
    he does not already exist.

keep-groups
    Do not touch the user groups if the user is already set up. This will avoid
    to delete group assosiactions not defined via cdist. If the parameter
    `--group` is set despite of this parameter, it will only be used in the user
    setup if he does not already exists.


MESSAGES
--------
created
    The user as created.

enabled
    The user already exists and was enabled.

disabled
    The user already exists and was disabled.

removed
    The user was removed.


EXAMPLES
--------
TBA.


SEE ALSO
--------
:strong:`cdist-type__nextcloud`\ (7)
:string:`cdist-type__nextcloud_app`\ (7)


AUTHORS
-------
Matthias Stecher <matthiasstecher at gmx.de>


COPYING
-------
Copyright \(C) 2020 Matthias Stecher.
You can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.
