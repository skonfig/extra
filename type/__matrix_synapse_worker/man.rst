cdist-type__matrix_synapse(7)
======================

NAME
----
cdist-type__matrix_synapse_worker - Configure a synapse worker


DESCRIPTION
-----------
This type configures and start a matrix worker. This type does not install
synapse: `cdist-type__matrix_synapse(7) <cdist-type__matrix_synapse.html>`_
type must be run first.

It is also recommended to take a look at:

  - `upstream's high-level overview on workers (matrix.org blog post) <https://matrix.org/blog/2020/11/03/how-we-fixed-synapses-scalability>`_
  - `upstream's documentation on workers <https://github.com/matrix-org/synapse/blob/develop/docs/workers.md>`_

REQUIRED PARAMETERS
-------------------
app
  Worker application to be used. A detailed list is available on `upstream's
  documentation
  <https://github.com/matrix-org/synapse/blob/master/docs/workers.md#available-worker-applications>`_.

port
  Port on which this worker will listen.

OPTIONAL PARAMETERS
-------------------
replication-host
  Replication endpoint host of your main synapse process. Defaults to
  localhost.

replication-port
  Replication endpoint port of your main synapse process. Defaults to 9093.

log-config
  Path to log configuration. Defaults to synapse's main process log
  configuration.

resource
  Resources to be served by this worker. Can be specified multiple times.
  Defaults to 'client' and 'federation'.

bind-address
  Address used to bind the synapse listeners. Can be specified multiple times.
  Defaults to '::1' and '127.0.0.1'.


EXAMPLES
--------

.. code-block:: sh

    __matrix_synapse --server-name ungleich.ch \
      --base-url https://matrix.ungleich.ch \
      --database-engine sqlite3 \
      --database-name /var/lib/matrix-syanpse/homeserver.db \
      --worker-mode
    require="__matrix_synapse" __matrix_synapse_worker generic \
      --app 'synapse.app.generic_worker' \
      --port 8083 \
      --resource 'federation' \
      --resource 'client'

SEE ALSO
--------
- `cdist-type__matrix_synapse(7) <cdist-type__matrix_synapse.html>`_


AUTHORS
-------
Timothée Floure <timothee.floure@ungleich.ch>


COPYING
-------
Copyright \(C) 2019-2021 Timothée Floure. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
