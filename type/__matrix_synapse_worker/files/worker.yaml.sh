#!/bin/sh
#
# 2021 Timothée Floure (timothee.floure at posteo.net)
#
# This file is part of skonfig-extra.
#
# skonfig-extra is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# skonfig-extra is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with skonfig-extra. If not, see <http://www.gnu.org/licenses/>.
#
# Generate contents of worker’s YAML configuration.
#

generate_bind_addresses () {
	if [ -n "${WORKER_BIND_ADDRESSES}" ]; then
		echo "bind_addresses:"
		for addr in ${WORKER_BIND_ADDRESSES}; do
			echo "    - '${addr}'"
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
echo "       - ${resource}"
done

cat << EOF

worker_log_config: "${WORKER_LOG_CONFIG:?}"
EOF
