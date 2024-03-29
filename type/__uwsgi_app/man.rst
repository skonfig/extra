cdist-type__uwsgi_app(7)
========================

NAME
----
cdist-type__uwsgi_app - Manage uWSGI apps


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
buffer-size
   set internal buffer size.

   This is the maximum size of a request (excluding request body), i.e. ~ request headers.

   Defaults to: ``4096``

   If you receive a bigger request (for example with big cookies or query
   string) you may need to increase the buffer size.
   It is a security measure too, so adapt to your app needs instead of maxing it
   out.
cache2
   create a new generation shared cache.

   cf. `The New Generation Cache subsystem (cache2) <https://uwsgi-docs.readthedocs.io/en/latest/Changelog-1.9.html#the-new-generation-cache-subsystem-cache2>`_ for more information.
cap
   Can be used multiple times.
chdir
   chdir to specified directory before loading apps.
check-static
   For each request, check if a corresponding file is in the given directory
   before passing the request to the dynamic app.
env
   An environment variable to be passed to the application.
   Takes an argument of the form `VARIABLE=value`.
   Can be used multiple times.
gid
   :strong:`setgid`\ (2) to the specified group/gid.
harakiri
   respawn processes when a request wasn't answered within a number of seconds.
home
   set ``PYTHONHOME``/virtualenv
http
   add an http router/server on the specified address.

   Can be used multiple times.
http-modifier1
   force the specified modifier1 when using HTTP protocol.
http-modifier2
   force the specified modifier2 when using HTTP protocol.
http-socket
   bind to the specified UNIX/TCP socket using HTTP protocol.
http-to
   forward requests to the specified node.

   Can be used multiple times for load balancing.
http-to-https
   add an HTTP router/server on the specified address and redirect all of the
   requests to HTTPS.
max-requests
   Respawn a process after it has served a number of requests.
max-requests-delta
   Add (``worker_id * delta``) to the ``--max-requests`` value of each worker.

   This option can be used to prevent all workers from respawning at the same time.
min-worker-lifetime
   Number of seconds worker must run before being reloaded.
max-worker-lifetime
   Reload workers after the specified amount of seconds.
module
   Run a WSGI module.

   A ``package.module:object`` string.
mount
   Use mountpoints to load multiple apps into the same uWSGI process.
plugin
   Can be used multiple times.
processes
   spawn the specified number of workers/processes.
pythonpath
   add directory (or glob) to pythonpath.
rack
   load a (Ruby) Rack app.
route-if
   add a route based on condition.

   cf. `uWSGI internal routing <https://uwsgi-docs.readthedocs.io/en/latest/InternalRouting.html>`_.
ruby-require
   import/require a Ruby module/script.

   Can be used multiple times to specify more than one import.
shared-socket
   create a shared socket for advanced jailing or IPC.

   Can be used multiple times.
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
static-map
   Takes a value of the form: ``mountpoint=path``

   Serve requests in ``mountpoint`` with static files from ``path``.

   Can be used multiple times to specify more than one mapping.
threads
   run each worker in prethreaded mode with the specified number of threads.
touch-workers-reload
   trigger reload of (only) workers if the specified file is modified/touched.
uid
   :strong:`setuid`\ (2) to the specified user/uid.
uwsgi-socket
   bind to the specified UNIX/TCP socket using uwsgi protocol.
workers
   spawn the specified number of workers/processes.
wsgi-file
   load .wsgi file as app.


BOOLEAN PARAMETERS
------------------
enable-threads
   enable threads.
lazy
   set lazy mode (load apps in workers instead of master).
lazy-apps
   load apps in each worker instead of the master.
manage-script-name
   force management of the ``SCRIPT_NAME`` variable.
skip-atexit
   Skip atexit hooks (ignored by the master).
skip-atexit-teardown
   Skip atexit teardown (ignored by the master).
thunder-lock
   Enable thunder lock.

   cf. `Serializing accept(), AKA Thundering Herd, AKA the Zeeg Problem <https://uwsgi-docs.readthedocs.io/en/latest/articles/SerializingAccept.html>`_.
vacuum
   try to remove all of the generated file/sockets.


EXAMPLES
--------

.. code-block:: sh

   # Simple app
   __uwsgi_app myapp \
      --http-socket 8080 \
      --wsgi-file /path/to/wsgi.py

   # Run a Django app (https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/uwsgi/)
   __uwsgi_app mydjangoapp \
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
* `<https://uwsgi-docs.readthedocs.io/>`_


AUTHORS
-------
Dennis Camera <dennis.camera--@--ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2021-2023 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3
of the License, or (at your option) any later version.
