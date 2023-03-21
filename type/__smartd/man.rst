cdist-type__smartd(7)
=====================

NAME
----
cdist-type__smartd - Configure the S.M.A.R.T. monitoring daemon.


DESCRIPTION
-----------
This type installs `smartmontools <http://www.smartmontools.org>`_' S.M.A.R.T.
monitoring daemon (``smartd``).

This type only works on Debian derivatives.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
state
   One of:

   ``present``
      the S.M.A.R.T. monitoring daemon is installed and running.
   ``absent``
      the S.M.A.R.T. monitoring daemon is not installed.

   Defaults to ``present``.


BOOLEAN PARAMETERS
------------------
None.


EXAMPLES
--------

.. code-block:: sh

    # Install and configure smartd
    __smartd


SEE ALSO
--------
- :strong:`smartd`\ (8)
- :strong:`smartd.conf`\ (5)


AUTHORS
-------
Dennis Camera <dennis.camera--@--ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2020-2023 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3
of the License, or (at your option) any later version.
