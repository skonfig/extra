cdist-type__ssrq_uwsgi_app(7)
=============================

NAME
----
cdist-type__ssrq_uwsgi_app - Manage uWSGI apps


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
cap
   Can be used multiple times.
chdir
env
   An environment variable to be passed to the application.
   Takes an argument of the form `VARIABLE=value`.
   Can be used multiple times.
gid
home
http-socket
plugin
   Can be used multiple times.
processes
pythonpath
state
   The state of the configuration files.

   One of:

   present
      Create and enable an app configuration.
   disabled
      Create a configuration file for the app, but do not enable it (yet).
   absent
      Completely remove the app configuration.

   Defaults to ``present``.
threads
uid
uwsgi-socket
wsgi-file


BOOLEAN PARAMETERS
------------------
enable-threads
vacuum


EXAMPLES
--------

.. code-block:: sh

    # TODO
    __ssrq_uwsgi_app


SEE ALSO
--------
None.


AUTHORS
-------
Dennis Camera <dennis.camera--@--ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2021 Dennis Camera. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
