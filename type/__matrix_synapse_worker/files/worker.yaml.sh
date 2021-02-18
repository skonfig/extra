#!/bin/sh

cat << EOF
worker_app: "${WORKER_APP:?}"
worker_name: "${WORKER_NAME:?}"

# The replication listener on the main synapse process.
worker_replication_host: "${WORKER_REPLICATION_HOST:?}"
worker_replication_http_port: ${WORKER_REPLICATION_PORT:?}

worker_listeners:
 - type: http
   port: ${WORKER_PORT:?}
   x_forwarded: true
   bind_addresses: ['::1', '127.0.0.1']
   resources:
     - names:
EOF

for resource in ${WORKER_RESOURCES:?}; do
echo "       - $resource"
done

cat << EOF

worker_log_config: "${WORKER_LOG_CONFIG:?}"
EOF
