#!/bin/sh

if [ $# -ne 1 ];
then
	echo "The WG private key must be passed to the script as an argument," >&2
	echo "as we do not consider the environment to be private. Aborting." >&2
	exit 1;
fi

cat <<- EOF
	[Interface]
	PrivateKey = ${1:?}
EOF

if [ -n "$WG_PORT" ];
then
	echo "ListenPort = ${WG_PORT:?}"
fi
