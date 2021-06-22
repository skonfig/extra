#!/bin/sh
# Template for HTTPS redirection.

echo 'server {'

# Listen
cat <<- EOF
	listen ${LPORT:?};
	listen [::]:${LPORT:?};
EOF

# Name
echo "server_name ${DOMAIN:?} $ALTDOMAINS;"

# ACME challenges.
cat << EOF
location /.well-known/acme-challenge/ {
	alias ${ACME_CHALLENGE_DIR:?};
}
EOF

# HTTPS redirection.
echo 'include snippets/301-to-https;'

echo '}'
