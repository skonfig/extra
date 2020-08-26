#!/bin/sh -e

# Generates gunicorn config
# see https://docs.gunicorn.org/en/stable/settings.html

# fix missing $__explorer
# see https://code.ungleich.ch/ungleich-public/cdist/-/issues/834
__explorer="$__global/explorer"

# size workes by cpu
cores="$(cat "$__explorer/cpu_cores")"


cat << EOF
# The IP address (typically localhost) and port that the Netbox WSGI process should listen on
bind = [$HOST ]

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
