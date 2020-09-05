#!/bin/sh -e

# Generates uwsgi config
# see https://uwsgi-docs.readthedocs.io/en/latest/Options.html
#  or https://uwsgi-docs-additions.readthedocs.io/en/latest/Options.html

# params:
#  1: parameter name
#  2: parameter value file
#
# output: the lines for the configuration option
multi_options() {
    while read -r line; do
        printf "%s = %s\n" "$1" "$line"
    done < "$2"
}

# fix missing $__explorer
# see https://code.ungleich.ch/ungleich-public/cdist/-/issues/834
__explorer="$__global/explorer"

# size workes by cpu
cores="$(cat "$__explorer/cpu_cores")"


cat << EOF
[uwsgi]
; socket(s) to bind
EOF

# special protocol to bind
for param in $(find "$__object/parameter/" -maxdepth 1 -name "*-bind" -print); do
    multi_options "$(basename "$param" | awk -F'-' '{print $1}')-socket" "$param"
    socket_changes=yes
done
# else, default bind to
if [ -z "$socket_changes" ]; then
    multi_options "socket" "$__object/parameter/bind-to"
fi


cat << EOF

; processes and threads
processes = $(( 2*cores + 1 ))
threads = 2
EOF
