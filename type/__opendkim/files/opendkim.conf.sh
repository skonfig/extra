#!/bin/sh -e
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
# Generate an opendkim.conf(5) file for opendkim(8).
#

# Optional chdir(2)
if [ "${BASEDIR}" ];
then
	printf "BaseDirectory %s\n" "${BASEDIR}"
fi

# Optional canonicalization settings
if [ -n "${CANON}" ]
then
	case ${CANON}
	in
		"simple/simple")
			:
			;;
		"simple/relaxed")
			:
			;;
		"relaxed/simple")
			:
			;;
		"relaxed/relaxed")
			:
			;;
		*)
			echo "Invalid Canonicalization setting!" >&2
			exit 1
			;;
	esac
	printf "Canonicalization %s\n" "${CANON}"
fi

# Key and Domain tables
echo 'KeyTable /etc/opendkim/KeyTable'
echo 'SigningTable /etc/opendkim/SigningTable'

# Required socket to listen on
printf "Socket %s\n" "${SOCKET:?}"

# Optional subdomain signing settings
if [ "${SUBDOMAINS}" ]
then
	printf "SubDomains %s\n" "${SUBDOMAINS}"
fi

# Optional request logging to syslog
if [ "${SYSLOG}" ]
then
	echo "Syslog yes"
fi

# Optional UMask specification
if [ "${UMASK}" ]
then
	printf "UMask %s\n" "${UMASK}"
fi

# Optional UserID to change to
if [ "${USERID}" ]
then
	printf "UserID %s\n" "${USERID}"
fi
