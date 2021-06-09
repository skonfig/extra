#!/bin/sh

cat <<- EOF
	auto ${WG_IFACE:?}
	iface ${WG_IFACE:?} inet6 static
	address ${WG_ADDRESS:?}
	pre-up ip link add dev ${WG_IFACE:?} type wireguard
	pre-up wg setconf ${WG_IFACE:?} /etc/wireguard/${WG_IFACE:?}.conf
	post-down ip link delete dev ${WG_IFACE:?}
EOF
