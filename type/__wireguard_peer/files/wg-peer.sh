#!/bin/sh
# We expect the pre-shared key, if it exists, as an argument because we do not
# consider the environment to be secure.

cat << EOF
[Peer]
PublicKey = ${PKEY:?}
EOF

if [ -n "$1" ];
then
	echo "PresharedKey = ${1:?}"
fi

for ip in $ALLOWED_IPS;
do
	echo "AllowedIPs = ${ip:?}"
done

if [ -n "$ENDPOINT" ];
then
	echo "Endpoint = ${ENDPOINT:?}"
fi

if [ -n "$PERSISTENT_KA" ];
then
	echo "PersistentKeepalive = ${PERSISTENT_KA:?}"
fi

echo
