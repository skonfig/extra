#!/bin/sh
#
# 2020 Timothée Floure (timothee.floure at posteo.net)
# 2020 Matthias Stecher (matthiasstecher at gmx.de)
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
# Generate contents of ldap_config.py.
#

# no configuration if there are no ldap parameters
if [ -z "${USE_LDAP}" ]; then
    # skip
    cat << EOF
##############################
# LDAP-backed authentication #
##############################

# no options set
EOF
    exit 0
fi


cat << EOF
##############################
# LDAP-backed authentication #
##############################

import ldap
from django_auth_ldap.config import LDAPSearch, PosixGroupType

# Server URI
AUTH_LDAP_SERVER_URI = "${LDAP_SERVER}"

# Set the DN and password for the NetBox service account.
AUTH_LDAP_BIND_DN = "${LDAP_BIND_DN}"
AUTH_LDAP_BIND_PASSWORD = "${LDAP_BIND_PASSWORD}"

# Search for user entry.
AUTH_LDAP_USER_SEARCH = LDAPSearch("${LDAP_USER_BASE}",
                                    ldap.SCOPE_SUBTREE,
                                    "(uid=%(user)s)")

# You can map user attributes to Django attributes as so.
AUTH_LDAP_USER_ATTR_MAP = {
    "first_name": "givenName",
    "last_name": "sn",
    "email": "mail"
}
EOF

if [ "${LDAP_GROUP_BASE}" != "" ]; then
    cat << EOF

# This search ought to return all groups to which the user belongs. django_auth_ldap uses this to determine group
# hierarchy.
AUTH_LDAP_GROUP_SEARCH = LDAPSearch("${LDAP_GROUP_BASE}", ldap.SCOPE_SUBTREE,
                                    "(objectClass=posixGroup)")
AUTH_LDAP_GROUP_TYPE = PosixGroupType()

# Mirror LDAP group assignments.
AUTH_LDAP_MIRROR_GROUPS = True
# For more granular permissions, map LDAP groups to Django groups.
AUTH_LDAP_FIND_GROUP_PERMS = True
EOF

    if [ "${LDAP_REQUIRE_GROUP}" != "" ]; then
        cat << EOF

# Define a group required to login.
AUTH_LDAP_REQUIRE_GROUP = "${LDAP_REQUIRE_GROUP}"
EOF
    fi

    cat << EOF

# Define special user types using groups. Exercise great caution when assigning superuser status.
AUTH_LDAP_USER_FLAGS_BY_GROUP = {
EOF
    # superuser
    if [ "${LDAP_SUPERUSER_GROUP}" != "" ]; then
        echo "    \"is_superuser\": \"${LDAP_SUPERUSER_GROUP}\","
    fi
    # staff user
    if [ "${LDAP_STAFF_GROUP}" != "" ]; then
        echo "    \"is_staff\": \"${LDAP_STAFF_GROUP}\","
    fi
    echo "}"
fi
