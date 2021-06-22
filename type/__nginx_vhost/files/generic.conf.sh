#!/bin/sh
# Template for static NGINX hosting.

echo 'server {'

# Listen
cat <<- EOF
	listen ${LPORT:?} $TLS;
	listen [::]:${LPORT:?} $TLS;
EOF

# Name
echo "server_name ${DOMAIN:?} $ALTDOMAINS;"

# ACME challenges.
cat << EOF
location /.well-known/acme-challenge/ {
	alias ${ACME_CHALLENGE_DIR:?};
}
EOF

if [ -n "$TLS" ];
then
	if [ -n "$HSTS" ];
	then
		echo 'include snippets/hsts;'
	fi

	cat <<- EOF
		ssl_certificate ${NGINX_CERTDIR:?}/${DOMAIN:?}/fullchain.pem;
		ssl_certificate_key ${NGINX_CERTDIR:?}/${DOMAIN:?}/privkey.pem;
	EOF
fi

echo "${NGINX_LOGIC:?}"

echo '}'
