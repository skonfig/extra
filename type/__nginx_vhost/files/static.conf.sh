#!/bin/sh
# Template for static NGINX hosting.

NGINX_LOGIC="$(cat << EOF
	location / {
		root ${NGINX_WEBROOT:?}/${DOMAIN:?};
		index index.html;
	}
EOF
)"
export NGINX_LOGIC

"${__type:?}/files/generic.conf.sh"
