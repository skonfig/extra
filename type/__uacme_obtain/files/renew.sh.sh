#!/bin/sh
#
# 2021 Timothée Floure (timothee.floure at posteo.net)
# 2021 Joachim Desroches (joachim.desroches at epfl.ch)
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
# Generate contents for renew.sh.
#

cat << EOF
#!/bin/sh

UACME_CHALLENGE_PATH=${CHALLENGEDIR:?}
export UACME_CHALLENGE_PATH

# Issue certificate.
uacme -c ${CONFDIR:?} -h ${HOOKSCRIPT:?} ${DISABLE_OCSP?} ${MUST_STAPLE?} ${KEYTYPE?} \\
	issue -- ${DOMAIN:?}

# Note: exit code 0 means that certificate was issued.
# Note: exit code 1 means that certificate was still valid, hence not renewed.
# Note: exit code 2 means that something went wrong.
status=\$?

# All is well: we can stop now.
if [ \${status} -eq 1 ];
then
	exit 0
fi

# An error occured.
if [ \${status} -eq 2 ]
then
	echo "Failed to renew certificate - exiting." >&2
	exit 1
fi
EOF

# Re-deploy, if needed.
if [ -n "${KEY_TARGET?}" ] && [ -n "${CERT_TARGET?}" ];
then
cat << EOF

# Deploy newly issued certificate.
set -e

CERT_SOURCE=${CONFDIR:?}/${MAIN_DOMAIN:?}/cert.pem
KEY_SOURCE=${CONFDIR:?}/private/${MAIN_DOMAIN:?}/key.pem

mkdir -p -- $(dirname "${CERT_TARGET?}") $(dirname "${KEY_TARGET?}")

if ! cmp \${CERT_SOURCE:?} ${CERT_TARGET?} >/dev/null 2>&1
then
	install -m 0640 \${KEY_SOURCE:?} ${KEY_TARGET?}
	install -m 0644 \${CERT_SOURCE:?} ${CERT_TARGET?}
	chown ${OWNER?} ${KEY_TARGET?} ${CERT_TARGET?}

	${RENEW_HOOK?}
fi
EOF
fi
