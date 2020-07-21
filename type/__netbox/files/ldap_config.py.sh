#!/bin/sh

cat << EOF
##############################
# LDAP-backed authentication #
##############################

import ldap
from django_auth_ldap.config import LDAPSearch

# Server URI
AUTH_LDAP_SERVER_URI = "$LDAP_SERVER"

# Set the DN and password for the NetBox service account.
AUTH_LDAP_BIND_DN = "$LDAP_BIND_DN"
AUTH_LDAP_BIND_PASSWORD = "$LDAP_BIND_PASSWORD"

# If a user's DN is producible from their username, we don't need to search.
AUTH_LDAP_USER_DN_TEMPLATE = "$LDAP_USER_DN_TEMPLATE"

# You can map user attributes to Django attributes as so.
AUTH_LDAP_USER_ATTR_MAP = {
    "first_name": "givenName",
    "last_name": "sn",
    "email": "mail"
}
EOF
