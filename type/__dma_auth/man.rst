cdist-type__dma_auth(7)
=======================

NAME
----
cdist-type__dma_auth - Configure SMTP logins for the DragonFly Mail Agent MTA.


DESCRIPTION
-----------
This cdist type allows you to set up credentials to log in to remote SMTP
servers.

NB: dma currently (v0.13) does not differentiate between users on a host.
    It will use whatever user it finds in the ``auth.conf`` first.
    Thus, this type will use the ``__object_id`` as the host specifier.


REQUIRED PARAMETERS
-------------------
login
    The user's LOGIN name on the SMTP server.
password
    The user's password (in plain text.)


OPTIONAL PARAMETERS
-------------------
state
    Either `present` or `absent`. Defaults to `present`.

BOOLEAN PARAMETERS
------------------
None.


EXAMPLES
--------

.. code-block:: sh

    # Set the password for smarthost
    __dma_auth smarthost.example.com --login joe --password hunter2

    # Set credentials for user at an external provider
    __dma_auth mail.provider.com --login paul@example.com --password letmein

    # Delete credentials for example.com (for all users)
    __dma_auth example.com --login '' --password '' --state absent

SEE ALSO
--------
:strong:`cdist-type__dma`\ (7), :strong:`dma`\ (8)


AUTHORS
-------
Dennis Camera <dennis.camera@ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2020 Dennis Camera. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
