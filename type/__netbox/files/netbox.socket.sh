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
# Generate contents of netbox.socket.
#
# This is shared between all WSGI-server types.
#
# Arguments:
#  1: File which list all sockets to listen on (sepearated by \n)
#

if [ $# -ne 1 ]; then
    printf "netbox.socket.sh: argument \$1 missing or too much given!\n" >&2
    exit 1
fi


cat << UNIT
[Unit]
Description=Socket for NetBox via $TYPE

[Socket]
UNIT

# read all sockets to listen to
while read -r line; do
    printf "ListenStream=%s\n" "$line"
done < "$1"

cat << UNIT
SocketUser=netbox
SocketGroup=www-data

[Install]
WantedBy=sockets.target
UNIT
