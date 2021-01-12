#!/bin/sh

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

if [ "$SSL" = "true" ]; then
	cat << EOF
  port: $HTTPS_PORT
  provider: letsencrypt
  domain: ${__target_host:?}
  subscriberEmail: ${LE_EMAIL:?}
EOF
	fi
}

cat << EOF
port: $HTTP_PORT
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
