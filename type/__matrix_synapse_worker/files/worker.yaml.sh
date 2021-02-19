#!/bin/sh

generate_bind_addresses () {
	if [ -n "$WORKER_BIND_ADDRESSES" ]; then
		echo "bind_addresses:"
		for addr in $WORKER_BIND_ADDRESSES; do
			echo "    - '$addr'"
		done
	else
		echo "bind_addresses: []"
	fi
}

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
   $(generate_bind_addresses)
   resources:
     - names:
EOF

for resource in ${WORKER_RESOURCES:?}; do
echo "       - $resource"
done

cat << EOF

worker_log_config: "${WORKER_LOG_CONFIG:?}"
EOF
