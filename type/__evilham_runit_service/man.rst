cdist-type__evilham_runit_service(7)
====================================

NAME
----
cdist-type__evilham_runit_service - Create a runit-compatible service dir.


DESCRIPTION
-----------
Create a directory structure compatible with runit-like service management.

Note that sv(8) and runsvdir(8) must be present on the target system, this can
be achieved with e.g. `__runit`.

The `__object_id` will be used as the service name.


REQUIRED PARAMETERS
-------------------
source
   File to save as <servicedir>/run. If set to '-', standard input will be used.


BOOLEAN PARAMETERS
------------------
log
   Setup logging with `svlogd -tt ./main`.


EXAMPLES
--------

.. code-block:: sh

    require="__evilham_runit" __evilham_runit_service tasksched \
        --source - << EOF
    #!/bin/sh -e
    cd "${HOME}/.local/share/tasksched"
    exec ./server.js 2>&1
    EOF


SEE ALSO
--------
:strong:`cdist-type__evilham_runit`\ (7)


AUTHORS
-------
Evilham <cvs--@--evilham.com>

COPYING
-------
Copyright \(C) 2020 Evilham. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
