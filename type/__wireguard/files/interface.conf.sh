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
# Generate the Debian interface configuration.
#

cat <<-EOF
	auto ${WG_IFACE:?}
	iface ${WG_IFACE:?} inet6 static
	address ${WG_ADDRESS:?}
	pre-up ip link add dev ${WG_IFACE:?} type wireguard
	pre-up wg setconf ${WG_IFACE:?} /etc/wireguard/${WG_IFACE:?}.conf
	post-down ip link delete dev ${WG_IFACE:?}
EOF
