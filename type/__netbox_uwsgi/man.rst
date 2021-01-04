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

**As uWSGI will be started as netbox user, it does not have privileges to
bind to a privileaged port (all ports below 1024).** Because uWSGI will
drop privileages anyway before binding to a port, solutions are to use
the systemd sockets to activate the ports as root or set linux kernel
capabilites to bind to such a privileaged port.

As systemd sockets (or uwsgi itself) do not allow to distinguish multiple
sockets if different protocols are used for different sockets, this type does
not use systemd sockets if it is requested from the user. Using the
``--bind-to`` and ``--protocol`` parameters, it uses the systemd socket
activation. Else, it set the different sockets and protocols natively to uwsgi
and add kernel capabilities to be able to listen to privileaged ports.


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
    The socket uwsgi should bind to. Must be UNIX/TCP (or anything that
    systemd sockets accept as stream). Defaults to ``127.0.0.1:3031``. Can be
    set multiple times. The used protocol is defined by ``--protocol``.

    **By setting up the socket via this parameter, it uses systemd sockets to
    handle these.** This parameter will be ignored if a more detailed paramter
    is given (``--$proto-bind``).

protocol
    The protocol which should be used for the socket given by the ``--bind-to``
    parameter. Possible values are ``uwsgi``, ``http``, ``fastcgi`` and
    ``scgi``. If nothing given, it defaults to ``uwsgi``.

scgi-bind, uwsgi-bind, http-bind, fastcgi-bind
    Bind the application to a specific protocol instead of implicit uwsgi via
    ``--bind-to``. If such parameter given, ``--bind-to`` will be ignored. Must
    be a UNIX/TCP socket. Can be set multiple times.

    **By using such parameters instead of ``--bind-to``, no systemd sockets
    will be used because it can not handle sockets for multiple protocols.**
    Instead, the native socket binding will be used. It will add kernel
    capabilites to bind to privileaged ports, too. This allow binds to ports
    like 80 as netbox user.


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
    #  avoids systemd sockets, but can handle multiple protocols
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


NOTES
-----
If systemd sockets are used, uwsgi can not be reloaded because it does not
handle the socket correctly. It works by completly restarting uwsgi (because
it is near the same cause of the systemd socket) or tweaking the service unit
with the line ``StandardInput=socket``, which limits you to only one address
to bind to (else, the service will not start).

Maybe someone is interested in enabling log files, because the "log to stdout"
is not the fanciest approach (because it is shown in the journal). See the
`uwsgi documentation <https://uwsgi.readthedocs.io/en/latest/Logging.html>` for
reference.


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
