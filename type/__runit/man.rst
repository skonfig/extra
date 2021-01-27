cdist-type__runit(7)
============================

NAME
----
cdist-type__runit - Install and configure runit


DESCRIPTION
-----------
This is a singleton type.

Install and configure runit, not as an init system, but as a service monitor.
It configures and if necessary starts runsvdir as documented for the
Operating System.

This type currently heavily focuses on FreeBSD, support for other Operating
Systems can be achieved but no effort whatsoever has been put into it.


REQUIRED PARAMETERS
-------------------
None.


EXAMPLES
--------

.. code-block:: sh

    __runit

SEE ALSO
--------
:strong:`cdist-type__runit_service`\ (7)

AUTHORS
-------
Evilham <cvs--@--evilham.com>

COPYING
-------
Copyright \(C) 2020 Evilham. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
