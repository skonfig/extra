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
harakiri
   Respawn processes when a request wasn't answered within a number of seconds.
home
http-socket
max-requests
   Respawn a process after it has served a number of requests.
module
   Run a WSGI module.

   A ``package.module:object`` string.
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

   # Simple app
   __ssrq_uwsgi_app myapp \
      --http-socket 8080 \
      --wsgi-file /path/to/wsgi.py

   # Run a Django app (https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/uwsgi/)
   __ssrq_uwsgi_app mydjangoapp \
      --plugin python3 \
      --chdir /path/to/mydjangoapp \
      --module mydjangoapp.wsgi:application \
      --http-socket :8080 \
      --uid www-data \
      --gid www-data \
      --harakiri 20 \
      --max-requests 5000 \
      --vacuum \
      --home /path/to/virtual/env



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
