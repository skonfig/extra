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
# Template to generate a bgp protocol configuration file for bird(1).
# Required non-empty variables:
# __object_id, local_{ip,as}, neighbor_{ip,as}
#
# Required defined variables:
# description, password, ipv{4,6}_{import,export}
#

# Header
echo "protocol bgp ${__object_id:?} {"

# Optional description
[ -n "${description?}" ] && printf "\tdescription \"%s\";\n" "${description?}"

# Mandatory session information
cat <<EOF
	local ${local_ip?} as ${local_as:?};
	neighbor ${neighbor_ip:?} as ${neighbor_as:?};
EOF

# Direct connection ?
[ -n "${direct?}" ] && printf "\tdirect;\n"

# Password-protected session ?
[ -n "${password?}" ] && printf "\tpassword \"%s\";\n" "${password?}"

if [ -n "${ipv4_import?}" ] || [ -n "${ipv4_export?}" ] || "${ipv4_extended_next_hop?}";
then
	printf "\tipv4 {\n"
	[ -n "${ipv4_import?}" ] && printf "\t\timport %s;\n" "${ipv4_import:?}"
	[ -n "${ipv4_export?}" ] && printf "\t\texport %s;\n" "${ipv4_export:?}"
	[ -n "${ipv4_extended_next_hop?}" ] && printf "\t\textended next hop;\n"
	printf "\t};\n"
fi
if [ -n "${ipv6_import?}" ] || [ -n "${ipv6_export?}" ] || "${ipv6_extended_next_hop?}";
then
	printf "\tipv6 {\n"
	[ -n "${ipv6_import?}" ] && printf "\t\timport %s;\n" "${ipv6_import:?}"
	[ -n "${ipv6_export?}" ] && printf "\t\texport %s;\n" "${ipv6_export:?}"
	[ -n "${ipv6_extended_next_hop?}" ] && printf "\t\textended next hop;\n"
	printf "\t};\n"
fi

# Header close
echo "}"
