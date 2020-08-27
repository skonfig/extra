#!/bin/sh -e

# Generates uwsgi config
# see https://uwsgi-docs.readthedocs.io/en/latest/Options.html

# fix missing $__explorer
# see https://code.ungleich.ch/ungleich-public/cdist/-/issues/834
__explorer="$__global/explorer"

# size workes by cpu
cores="$(cat "$__explorer/cpu_cores")"


cat << EOF
[uwsgi]
; socket to bind
socket = $HOST

; processes and threads
processes = $(( 2*cores + 1 ))
threads = 2
EOF
