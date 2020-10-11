#!/bin/sh -e
# __netbox/files/netbox.socket.sh

# This is shared between all WSGI-server types.

# Arguments:
#  1: File which list all sockets to listen on (sepearated by \n)

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
while read line; do
    printf "ListenStream=%s\n" "$line"
done < "$1"

cat << UNIT
SocketUser=netbox
SocketGroup=www-data

[Install]
WantedBy=sockets.target
UNIT
