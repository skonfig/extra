#!/bin/sh -e

cat << EOF
[Unit]
Description=Netbox uWSGI WSGI Service
Documentation=https://netbox.readthedocs.io/en/stable/
PartOf=netbox.service
Requires=netbox-rq.service
EOF

# Add dependency to own socket
if [ "$(cat "$__object/files/systemd_socket")" = "yes" ]; then
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
