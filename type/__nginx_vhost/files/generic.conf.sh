#!/bin/sh
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
# Template for static NGINX hosting.
#

echo 'server {'

# Listen
cat <<-EOF
	listen ${LPORT:?} ${TLS};
	listen [::]:${LPORT:?} ${TLS};
EOF

# Name
echo "server_name ${DOMAIN:?} ${ALTDOMAINS};"

# ACME challenges.
cat <<EOF
location /.well-known/acme-challenge/ {
	alias ${ACME_CHALLENGE_DIR:?};
}
EOF

if [ -n "${TLS}" ];
then
	if [ -n "${HSTS}" ];
	then
		echo 'include snippets/hsts;'
	fi

	cat <<-EOF
		ssl_certificate ${NGINX_CERTDIR:?}/${DOMAIN:?}/fullchain.pem;
		ssl_certificate_key ${NGINX_CERTDIR:?}/${DOMAIN:?}/privkey.pem;
	EOF
fi

echo "${NGINX_LOGIC:?}"

echo '}'
