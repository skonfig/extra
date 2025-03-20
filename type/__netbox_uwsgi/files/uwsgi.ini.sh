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
# Generates uwsgi config
# see https://uwsgi-docs.readthedocs.io/en/latest/Options.html
#  or https://uwsgi-docs-additions.readthedocs.io/en/latest/Options.html
#
# params:
#  1: parameter name
#  2: parameter value file
#
# output: the lines for the configuration option
#

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

if [ "$SYSTEMD_SOCKET" != "yes" ]; then
    # special protocol to bind
    find "$__object/parameter/" -maxdepth 1 -name "*-bind" -print \
     | while read -r param; do
        multi_options "$(basename "$param" | awk -F'-' '{print $1}')-socket" "$param"
    done
else
    # else, systemd will offer socket
    echo "; sockets managed via 'uwsgi-netbox.socket'"
    printf "protocol = %s\n" "$PROTOCOL"
fi


# multi-process settings
cat << EOF

; processes and threads
processes = $(( 2*cores + 1 ))
threads = 2
EOF


# optional mapping of static content
if [ "$STATIC_MAP" != "" ]; then
    cat << EOF

; map static content
static-map = /static=/opt/netbox/netbox/static
EOF
fi
