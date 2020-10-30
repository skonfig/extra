cdist-type__nextcloud_user(7)
=============================

NAME
----
cdist-type__nextcloud_user - Setup a Nextcloud user


DESCRIPTION
-----------
It manages a single Nextcloud user given by the object id or parameter `--user`.


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
    The display name the user should have.

email
    The email address of the Nextcloud user.

password
    The password of the Nextcloud user.

quota
    TBA.

group
    Multiple group names which the Nextcloud user belongs to. If not set, the
    user will be removed from every group he is in.


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
