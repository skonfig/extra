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
# Generate contents of netbox.service.
#

cat << EOF
[Unit]
Description=Netbox uWSGI WSGI Service
Documentation=https://netbox.readthedocs.io/en/stable/
PartOf=netbox.service
Requires=netbox-rq.service
EOF

# Add dependency to own socket
if [ "$(cat "${__object:?}/files/systemd_socket")" = "yes" ]
then
    echo "Requires=uwsgi-netbox.socket"
fi

cat << EOF
Wants=network.target
After=netbox.service
After=network.target
After=redis-server.service postgresql.service

[Service]
Type=notify

User=netbox
Group=netbox
WorkingDirectory=/opt/netbox

ExecStart=/opt/netbox/venv/bin/uwsgi --master --chdir /opt/netbox/netbox --module netbox.wsgi uwsgi.ini
# signals: https://uwsgi-docs.readthedocs.io/en/latest/Management.html#signals-for-controlling-uwsgi
ExecReload=kill -HUP \$MAINPID
ExecStop=kill -INT \$MAINPID
KillSignal=SIGQUIT

Restart=on-failure
RestartSec=30

[Install]
WantedBy=netbox.service
EOF
