#!/bin/sh -e
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
# Generate debconf selections to apply on the target.
#

# This can be obtained with debconf-get-selections on a host with jitsi
# (and also analysing the deb-src)
if false
then
	# We are currently not using these, just here as documentation
	DEBCONF_SETTINGS=$(cat <<EOF
# Jicofo user password:
jicofo	jicofo/jicofo-authpassword	password	STH
jitsi-meet-prosody	jicofo/jicofo-authpassword	password	STH
# The secret used to connect to xmpp server as component
jitsi-meet-prosody	jitsi-videobridge/jvbsecret	password	STH
jitsi-videobridge	jitsi-videobridge/jvbsecret	password	STH
jitsi-videobridge2	jitsi-videobridge/jvbsecret	password	STH
# Jicofo Component secret:
jicofo	jicofo/jicofosecret	password	STH
jitsi-meet-prosody	jicofo/jicofosecret	password	STH
# Jicofo username:
jicofo jicofo/jicofo-authuser	string	focus
jitsi-meet-prosody	jicofo/jicofo-authuser	string	focus
# The hostname of the current installation:
jitsi-meet-turnserver	jitsi-meet-turnserver/jvb-hostname	string	${JITSI_HOST}
# Full local server path to the SSL certificate file:
jitsi-meet-web-config	jitsi-meet/cert-path-crt	string
# Full local server path to the SSL key file:
jitsi-meet-web-config	jitsi-meet/cert-path-key	string
EOF
)
fi

DEBCONF_SETTINGS=$(cat <<EOF
# The hostname of the current installation:
jitsi-meet-web-config	jitsi-meet/jvb-hostname	string	${JITSI_HOST}
# Hostname:
jicofo	jitsi-videobridge/jvb-hostname	string	${JITSI_HOST}
jitsi-meet-prosody	jitsi-videobridge/jvb-hostname	string	${JITSI_HOST}
jitsi-meet-turnserver	jitsi-videobridge/jvb-hostname	string	${TURN_SERVER}
jitsi-meet-web-config	jitsi-videobridge/jvb-hostname	string	${JITSI_HOST}
jitsi-videobridge	jitsi-videobridge/jvb-hostname	string	${JITSI_HOST}
jitsi-videobridge2	jitsi-videobridge/jvb-hostname	string	${JITSI_HOST}
# The hostname of the current installation:
jitsi-meet-prosody	jitsi-meet-prosody/jvb-hostname string	${JITSI_HOST}
# SSL certificate for the Jitsi Meet instance
# Choices: Generate a new self-signed certificate (You will later get a chance to obtain a Let's encrypt certificate), I want to use my own certificate
jitsi-meet-web-config	jitsi-meet/cert-choice	select	Generate a new self-signed certificate (You will later get a chance to obtain a Let's encrypt certificate)
EOF
)

if [ -n "${TURN_SECRET}" ]
then
	DEBCONF_SETTINGS=$(cat <<EOF
${DEBCONF_SETTINGS}
# The turn server secret
jitsi-meet-prosody	jitsi-meet-prosody/turn-secret	string	${TURN_SECRET}
EOF
)
fi
