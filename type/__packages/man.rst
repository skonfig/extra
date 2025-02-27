cdist-type__packages(7)
=======================

NAME
----
cdist-type__packages - Install or remove packages.


DESCRIPTION
-----------
This type calls `:strong:`cdist-type__package`\ (7)` only if a package
needs to be installed or removed based on information gathered by the
explorer. This significantly reduces execution time when handling a
large number of packages.

Additionally, since this type is used to install group of packages, then
it can be used as a requirement for follow-up types.

Currently only Debian, Ubuntu and Devuan are supported.


OPTIONAL MULTIPLE PARAMETERS
----------------------------
present
    Package that must be installed.
absent
    Remove this package.


EXAMPLES
--------
Following is pretty useless example of installing group of packages and
then using it as a requirement for follow-up types.

.. code-block:: sh

    __packages mpd \
        --present mpd \
        --present mpc \
        --present ncmpcpp

    export require='__packages/mpd'

    __systemd_unit mpd.service \
        --enablement-disabled \
        --restart

    __systemd_unit mpd.socket \
        --enablement-disabled \
        --restart

    unset require

How to install huge number of packages.

.. code-block:: sh

    __packages base \
        --present "$(cat "$__files/packages.list")"


AUTHORS
-------
* Ander Punnar <ander--@--kvlt.ee>


COPYING
-------
Copyright \(C) 2025 Ander Punnar.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
