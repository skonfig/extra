#!/bin/sh
#
# 2020 Joachim Desroches (joachim.desroches at epfl.ch)
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
# Generate the contents of config.yml.
#

if [ $# -ne 1 ];
then
	echo "You have to give me the database password as an argument:"
	echo "on some systems, anyone can read env(1)."
	exit 1;
fi

generate_ssl_section () {

	cat << EOF
ssl:
  enabled: ${SSL}
EOF

if [ "${SSL}" = "true" ]
then
	cat << EOF
  port: ${HTTPS_PORT}
  provider: letsencrypt
  domain: ${__target_host:?}
  subscriberEmail: ${LE_EMAIL:?}
EOF
	fi
}

cat << EOF
port: ${HTTP_PORT}
db:
  type: postgres
  host: localhost
  port: 5432
  user: ${DB_USER:?}
  pass: $1
  db: ${DB_NAME:?}
  ssl: false
$(generate_ssl_section)
pool:
  min: 2
  max: 10
bindIP: 0.0.0.0
logLevel: warn
offline: false
ha: false
dataPath: ./data
EOF
