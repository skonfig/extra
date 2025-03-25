#!/bin/sh -e
#
# 2021 Evilham (cvs at evilham.com)
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
# Exports the contents for the different Let’s Encrypt hooks.
#

# It is expected that this defines hook_contents

# Reasonable defaults
hook_source="${__object:?}/parameter/${hook}-hook"
hook_state="absent"
hook_contents_head="#!/bin/sh -e"
hook_contents_logic=""
hook_contents_tail=""

# Backwards compatibility
# Remove this when renew-hook is removed
# Falling back to renew-hook if deploy-hook is not passed
if [ "${hook}" = "deploy" ] && [ ! -f "${hook_source}" ]; then
	hook_source="${__object:?}/parameter/renew-hook"
fi
if [ "${state}" = "present" ] && \
	[ -f "${hook_source}" ]; then
	# This hook is to be installed, let's generate it with some
	# safety boilerplate
	# Since certbot runs all hooks for all renewal processes
	# (at each state for deploy, pre, post), it is up to us to
	# differentiate whether or not the hook must run
	hook_state="present"
	hook_contents_head=$(cat <<EOF
#!/bin/sh -e
#
# Managed remotely with https://cdi.st
#
# Domains for which this hook is supposed to apply
lineage="${LE_DIR}/live/${__object_id:?}"
domains="\$(cat <<eof
${domains}
eof
)"
EOF
)
	case "${hook}" in
		pre|post)
			# Certbot is kind of terrible, we have
			# no way of knowing what domain/lineage the
			# hook is running for
			hook_contents_logic=$(cat <<EOF
# pre/post-hooks apply always due to a certbot limitation
APPLY_HOOK="YES"
EOF
)
		;;
		deploy)
			hook_contents_logic=$(cat <<EOF
# certbot defines these environment variables:
# RENEWED_DOMAINS="DOMAIN1 DOMAIN2"
# RENEWED_LINEAGE="/etc/letsencrypt/live/__object_id"
# It feels more stable to use RENEWED_LINEAGE
if [ "\${lineage}" = "\${RENEWED_LINEAGE}" ]; then
	APPLY_HOOK="YES"
fi
EOF
)
		;;
		*)
			echo "Unknown hook '${hook}'" >> /dev/stderr
			exit 1
		;;
	esac

	hook_contents_tail=$(cat <<EOF
if [ -n "\${APPLY_HOOK}" ]; then
	# Messing with indentation can eff up the users' scripts, let's not
$(cat "${hook_source}")
fi
EOF
)
fi

hook_contents=$(cat <<EOF
${hook_contents_head}

${hook_contents_logic}

${hook_contents_tail}
EOF
)
