#!/bin/sh

cat << EOF
#!/bin/sh

CERT_SOURCE=$CONFDIR/$MAIN_DOMAIN/cert.pem
KEY_SOURCE=$CONFDIR/private/$MAIN_DOMAIN/key.pem

export UACME_CHALLENGE_PATH=$CHALLENGEDIR

# Issue certificate.
uacme issue -c $CONFDIR -h $HOOKSCRIPT $DISABLE_OCSP $MUST_STABLE $KEYTYPE \
$DOMAIN
if [ $? -eq 2 ]; then
	# Note: exit code 0 means that certificate was issued.
	# Note: exit code 1 means that certificate was still valid, hence not renewed.
	# Note: exit code 2 means that something went wrong.
	echo "Failed to renew certificate - exiting." >&2
	exit 1
fi

# Re-deploy, if needed.
if [ -n "$KEY_TARGET" ] && [ -n "$CERT_TARGET" ]; then
	set -e

	mkdir -p $(dirname "$CERT_TARGET") $(dirname "$KEY_TARGET")
	
	if ! cmp \$CERT_SOURCE $CERT_TARGET >/dev/null 2>&1; then
		install -m 0640 \$KEY_SOURCE $KEY_TARGET
		install -m 0644 \$CERT_SOURCE $CERT_TARGET
		chown $OWNER $KEY_TARGET $CERT_TARGET

		$RENEW_HOOK
	fi
fi
EOF
