cdist-type__netbox_gunicorn(7)
==============================

NAME
----
cdist-type__netbox_gunicorn - Run NetBox with Gunicorn


DESCRIPTION
-----------
This (singleton) type installs Gunicorn into the NetBox `python-venv` to host
the NetBox WSGI application. It provides the application as HTTP over the given
sockets. Static content must be served independent of Gunicorn. The Gunicorn
daemon is available as the `gunicorn-netbox` systemd service, but also
available via the `netbox` wrapper service.

It will use systemd socket activation to listen to the given sockets. This
should allow to bind to privileaged ports (all below 1024) and hot reloads.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
state
    Represents the state of the Gunciron application. Defaults to ``enabled``.

    enabled
        The Gunicorn service is enabled and running.
    disabled
        The Gunicorn service is installed, but disabled.
    absent
        The uWSGI service is not installed and all configuration removed.

    This type does not guarantee anything about the running state of the
    service. To be sure about the service is stopped or not, use the type
    :strong:`cdist-type__systemd_service`\ (7) after this execution.

bind-to
    The hosts the gunicorn socket should be bind to. Formats are `IP`,
    `IP:PORT`, `PATH` or anything other that systemd socket units will
    understand as stream. Parameter can be set multiple times. Defaults
    to ``127.0.0.1:8001``.


BOOLEAN PARAMETERS
------------------
None.


MESSAGES
--------
installed
    The software was installed.

upgraded $old to $new
    The version of the gunicorn software was updated from `$old` to `$new`.

configured
    Configuration for gunicorn changed.

uninstalled
    The Gunicorn application was removed.

In all cases where the application is still present, it restarts the service to
use the up-to-date version.


EXAMPLES
--------

.. code-block:: sh

    # simple
    __netbox $args
    require="__netbox" __netbox_gunicorn

    # with arguments
    __netbox $args
    require="__netbox" __netbox_gunicorn \
        --bind-to 0.0.0.0:8001 \
        --bind-to 1.2.3.4:5678

    # replace uwsgi with gunicorn
    __netbox $args
    require="__netbox" __netbox_uwsgi --state absent
    # it should depend on __netbox_uwsgi if they use the same socket
    require="__netbox_uwsgi" __netbox_gunicorn --state enabled

    # be sure the service is disabled
    __netbox $args
    require="__netbox" __netbox_gunicorn --state disabled
    require="__netbox_gunicorn" __systemd_service gunicorn-netbox --state stopped


SEE ALSO
--------
`Gunicorn Documentation <https://docs.gunicorn.org/en/stable/>`_

:strong:`cdist-type__netbox`\ (7)
:strong:`cdist-type__netbox_uwsgi`\ (7)


AUTHORS
-------
Matthias Stecher <matthiasstecher@gmx.de>


COPYING
-------
Copyright \(C) 2020 Matthias Stecher. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
