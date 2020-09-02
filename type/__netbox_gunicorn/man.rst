cdist-type__netbox_uwsgi(7)
===========================

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


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
bind-to
    The hosts the gunicorn socket should be bind to. Formats are `IP`,
    `IP:PORT`, `unix:PATH` and `fd://FD`. Parameter can be set a multiple
    times. Defaults to ``127.0.0.1:8001``.


BOOLEAN PARAMETERS
------------------
None.


MESSAGES
--------
updated $old to $new
    The version of the gunicorn software was updated from `$old` to `$new`.

configured
    Configuration for gunicorn changed.

In both cases, it restarts the service to use the up-to-date version.


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
