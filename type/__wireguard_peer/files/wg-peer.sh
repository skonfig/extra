#!/bin/sh
#
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
# Generate the WireGuard configuration.
#

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

for ip in ${ALLOWED_IPS};
do
	echo "AllowedIPs = ${ip:?}"
done

if [ -n "${ENDPOINT}" ];
then
	echo "Endpoint = ${ENDPOINT:?}"
fi

if [ -n "${PERSISTENT_KA}" ];
then
	echo "PersistentKeepalive = ${PERSISTENT_KA:?}"
fi

echo
