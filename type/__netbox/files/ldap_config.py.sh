#!/bin/sh

# no configuration if there are no ldap parameters
if [ "$(find "$__object/parameter/" -type f -name 'ldap-*' -print)" ]; then
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
AUTH_LDAP_SERVER_URI = "$LDAP_SERVER"

# Set the DN and password for the NetBox service account.
AUTH_LDAP_BIND_DN = "$LDAP_BIND_DN"
AUTH_LDAP_BIND_PASSWORD = "$LDAP_BIND_PASSWORD"

# Search for user entry.
AUTH_LDAP_USER_SEARCH = LDAPSearch("$LDAP_USER_BASE",
                                    ldap.SCOPE_SUBTREE,
                                    "(uid=%(user)s)")

# You can map user attributes to Django attributes as so.
AUTH_LDAP_USER_ATTR_MAP = {
    "first_name": "givenName",
    "last_name": "sn",
    "email": "mail"
}
EOF

if [ "$LDAP_GROUP_BASE" != "" ]; then
    cat << EOF

# This search ought to return all groups to which the user belongs. django_auth_ldap uses this to determine group
# hierarchy.
AUTH_LDAP_GROUP_SEARCH = LDAPSearch("$LDAP_GROUP_BASE", ldap.SCOPE_SUBTREE,
                                    "(objectClass=posixGroup)")
AUTH_LDAP_GROUP_TYPE = PosixGroupType()

# Mirror LDAP group assignments.
AUTH_LDAP_MIRROR_GROUPS = True
EOF

    if [ "$LDAP_REQUIRE_GROUP" != "" ]; then
        cat << EOF

# Define a group required to login.
AUTH_LDAP_REQUIRE_GROUP = "$LDAP_REQUIRE_GROUP"
EOF
    fi

    if [ "$LDAP_SUPERUSER_GROUP" != "" ]; then
        cat << EOF

# Define special user types using groups. Exercise great caution when assigning superuser status.
AUTH_LDAP_USER_FLAGS_BY_GROUP = {
    "is_superuser": "$LDAP_SUPERUSER_GROUP",
}
EOF
    fi
fi
