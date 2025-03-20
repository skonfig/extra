#!/bin/sh -e
#
# 2020 Matthias Stecher (matthiasstecher at gmx.de)
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
# Generates gunicorn config
# see https://docs.gunicorn.org/en/stable/settings.html
#

# fix missing $__explorer
# see https://code.ungleich.ch/ungleich-public/cdist/-/issues/834
__explorer="$__global/explorer"

# size workes by cpu
cores=$(cat "$__explorer/cpu_cores")


cat << EOF
# The IP address (typically localhost) and port that the Netbox WSGI process should listen on
#bind = done via systemd socket 'gunicorn-netbox.socket'

# Number of gunicorn workers to spawn. This should typically be 2n+1, where
# n is the number of CPU cores present.
workers = $(( 2*cores + 1 ))

# Number of threads per worker process
threads = 3

# Timeout (in seconds) for a request to complete
timeout = 120

# The maximum number of requests a worker can handle before being respawned
max_requests = 5000
max_requests_jitter = 500
EOF
