cdist-type__nextcloud_app(7)
============================

NAME
----
cdist-type__nextcloud_app - Managese a Nextcloud app installation


DESCRIPTION
-----------
This types manages an app for a Nextcloud installation. For now, you can only
(un-)install or enable/disable an app.

The object id is the appid of the app which will be managed by this type. It
will be overwritten by the parameter `--appid`. See this parameter for more
information about the appid.


REQUIRED PARAMETERS
-------------------
cloud
    The absolute path of the Nextcloud installation.


OPTIONAL PARAMETERS
-------------------
state
    The state of the app. Can be the following:

    present *(default)*
        The app is installed.

    enabled
        The app is installed and enabled.

    disabled
        The app is installed, but disabled.

    absent
        The app is not installed.

appid
    The appid is the uniquie identifier for an app in the Nextcloud app store.
    It is required to know which app should be installed, which is expressed
    via the appid. Apps who are shipped by the installation can not be removed.
    Doing this will throw an error at exeuction time.

    To find the appid, you must select the app in the Nextcloud app menu or on
    the app page in the Nextcloud app store. Then, examine the URL and use the
    lastest part (e.g. "the filename") as appid.

www-user
    The unix user which will be used to execute Nextcloud related stuff. You
    should always use the same user for all Nextcloud interactions, for the
    webserver and cli execution. As default, `www-data` will be used.


MESSAGES
--------
installed
    The app was installed.

enabled
    The app is already installed and was enabled.

disabled
    The app is already installed and was disabled.

removed
    The app was removed.


EXAMPLES
--------

.. code-block:: sh

    # Nextcloud base installation
    __nextcloud /var/www/html/cloud $args

    # install the music app
    require="__nextcloud/var/www/html/cloud" __nextcloud_app music \
        --cloud /var/www/html/cloud/ --state enabled

    # enable a shipped app (already installed)
    require="__nextcloud/var/www/html/cloud" __nextcloud_app files_external \
        --cloud /var/www/html/cloud/ --state enabled

    # remove some app
    require="__nextcloud/var/www/html/cloud" __nextcloud_app drawio \
        --cloud /var/www/html/cloud/ --state absent


    # Different cloud
    __nextcloud /var/www/html/nextcloud $args
    # but same app name
    require="__nextcloud/var/www/html/nextcloud" __nextcloud_user next_music \
        --cloud /var/www/html/nextcloud/ --appid music


NOTES
-----
Currently, it manages just if the app is installed and enabled. Further
implementation is possible, but not done yet. This contains the management of
the app settings (via ``occ config:app:*``) and further finetuning to the
possibilities of installation and enablement (force-enable an app or restrict
enablement only to some groups).

Special app settings could also be written as a new type which completly
handles this one app with all configuration options.

Upgrading an Nextcloud app may be possible, but not the scope of this type.
Also, the upgrade can not be done to a given version, which results that this
type will loose the control over the state of the app. Installing the app
manually or hooking into the Nextcloud code is too unsafe and complex, in
addition it will be used rarely. Most admins would propably just update the app
via the web interface.


SEE ALSO
--------
`Nextcloud app store <https://apps.nextcloud.com/>`_

:strong:`cdist-type__nextcloud`\ (7)
:strong:`cdist-type__nextcloud_user`\ (7)


AUTHORS
-------
Matthias Stecher <matthiasstecher at gmx.de>


COPYING
-------
Copyright \(C) 2020 Matthias Stecher.
You can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.
