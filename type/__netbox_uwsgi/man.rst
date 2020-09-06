cdist-type__netbox_uwsgi(7)
===========================

NAME
----
cdist-type__netbox_uwsgi - Run NetBox with uWSGI


DESCRIPTION
-----------
This (singleton) type installs uWSGI into the NetBox `python-venv`. It hosts
the NetBox WSGI application via the WSGI protocol. A further server must be
installed to provide it as HTTP and serve static content. It supports multiple
protocols like uwsgi, fastcgi or HTTP to comunicate with the proxy server. This
application is available via the `uwsgi-netbox` systemd service. It is
controllable via the `netbox` wrapper service, too.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
state
    Represents the state of the uWSGI application. Defaults to ``enabled``.

    enabled
        The uWSGI service is enabled and running.
    disabled
        The uWSGI service is installed, but disabled.
    absent
        The uWSGI service is not installed and all configuration removed.

    This type does not guarantee anything about the running state of the
    service. To be sure about the service is stopped or not, use the type
    :strong:`cdist-type__systemd_service`\ (7) after this execution.


bind-to
    The socket uwsgi should bind to. Must be UNIX/TCP for the uwsgi protocol.
    Defaults to ``127.0.0.1:3031``. Can be set multiple times.

uwsgi-bind
http-bind
fastcgi-bind
scgi-bind
    Bind the application to a specific protocol instead of implicit uwsgi via
    ``--bind-to``. If such parameter given, ``--bind-to`` will be ignored. Must
    be a UNIX/TCP socket. Can be set multiple times.


BOOLEAN PARAMETERS
------------------
serve-static
    Setup uWSGI to serve the static content, too. This is generally not
    recommended for real production setups, as it is the job of the reverse
    proxy server, who will thread it as static cachable content. This option
    is only recommended for small setups or direct usage of the uWSGI socket
    like using it as standalone HTTP server for NetBox.

    **Hint**: This parameter does not work in junction with the `__netbox`
    parameter ``--basepath``. It is because this type does not know the
    parameter value and this case is very unlikly to happen; although an
    implementation is not difficult.


MESSAGES
--------
installed
    The uwsgi service was installed.

upgraded
    The uwsgi service was upgraded.

configured
    The uwsgi configuration got updated.

uninstalled
    The uWSGI application was removed.

In all cases where the application is still present, it restarts the service to
use the up-to-date version.


EXAMPLES
--------

.. code-block:: sh

    # simple
    __netbox $args
    require="__netbox" __netbox_uwsgi

    # with multiple binds
    __netbox $args
    require="__netbox" __netbox_uwsgi --bind-to 0.0.0.0:3032 \
                                      --bind-to 0.0.0.0:3033

    # with multiple protocols
    #  parameter `--bind-to` will be ignored
    __netbox $args
    require="__netbox" __netbox_uwsgi --uwsgi-bind 0.0.0.0:3031 \
                                      --http-bind 0.0.0.0:8080 \
                                      --fastcgi-bind 1.2.3.4:5678

    # as standalone server
    __netbox $args
    require="__netbox" __netbox_uwsgi --serve-static --http-bind 0.0.0.0:80

    # replace gunicorn with uwsgi
    __netbox $args
    require="__netbox" __netbox_gunicorn --state absent
    # it should depend on __netbox_gunicorn if they use the same socket
    require="__netbox_gunicorn" __netbox_uwsgi --state enabled

    # be sure the service is disabled
    __netbox $args
    require="__netbox" __netbox_uwsgi --state disabled
    require="__netbox_uwsgi" __systemd_service uwsgi-netbox --state stopped


SEE ALSO
--------
`uWSGI Documentation <https://uwsgi-docs.readthedocs.io/en/latest/>`_

:strong:`cdist-type__netbox`\ (7)
:strong:`cdist-type__netbox_gunicorn`\ (7)


AUTHORS
-------
Matthias Stecher <matthiasstecher@gmx.de>


COPYING
-------
Copyright \(C) 2020 Matthias Stecher. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
