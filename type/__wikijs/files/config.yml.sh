#!/bin/sh

if [ $# -ne 1 ];
then
	echo "You have to give me the database password as an argument:"
	echo "on some systems, anyone can read env(1)."
	exit 1;
fi

cat << EOF
port: 80
db:
  type: postgres
  host: localhost
  port: 5432
  user: ${DB_USER:?}
  pass: $1
  db: ${DB_NAME:?}
  ssl: false
ssl:
  enabled: ${SSL}
  port: 443
  provider: letsencrypt
  domain: ${__target_host:?}
  subscriberEmail: ${LE_EMAIL:?}
pool:
  min: 2
  max: 10
bindIP: 0.0.0.0
logLevel: warn
offline: false
ha: false
dataPath: ./data
EOF
