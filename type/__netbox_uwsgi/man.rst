cdist-type__netbox_uwsgi(7)
===========================

NAME
----
cdist-type__netbox_uwsgi - run netbox with uwsgi


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
bind-to
    The socket uwsgi should bind to. Must be UNIX/TCP for the uwsgi protocol.
    Defaults to ``127.0.0.1:3031``.


BOOLEAN PARAMETERS
------------------
None.


MESSAGES
--------
installed
    The uwsgi service was installed.

upgraded
    The uwsgi service was upgraded.

configured
    The uwsgi configuration got updated.

In both cases, and at messages from the `__netbox` type, it restarts the
service to using the up-to-date version.


EXAMPLES
--------

.. code-block:: sh

    # simple
    __netbox $args
    require="__netbox" __netbox_uwsgi

    # with special bind
    require="__netbox" __netbox_uwsgi --bind-to 0.0.0.0:3032 \
                                      --bind-to 0.0.0.0:3033


SEE ALSO
--------
:strong:`TODO`\ (7)


AUTHORS
-------
Matthias Stecher <matthiasstecher@gmx.de>


COPYING
-------
Copyright \(C) 2020 Matthias Stecher. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
