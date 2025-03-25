#!/bin/sh
#
# 2020 Timothée Floure (timothee.floure at posteo.net)
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
# Generate contents of config.json.
#
# Upstream configuration guide/documentation:
#   https://github.com/vector-im/riot-web/blob/develop/docs/config.md
#

generate_embedded_pages () {
    if [ "${EMBED_HOMEPAGE}" != "" ]; then
        cat << EOF
    "embeddedPages": {
        "homeUrl": "home.html"
    },
EOF
    fi
}

generate_jitsi_config () {
    if [ "${JITSI_DOMAIN}" != "" ]; then
        cat << EOF
    "jitsi": {
        "preferredDomain": "${JITSI_DOMAIN}"
     },
EOF
    fi
}

generate_branding () {
    echo '"branding": {'

    if [ "${BRANDING_AUTH_HEADER_LOGO_URL}" != "" ]; then
        cat << EOF
        "authHeaderLogoUrl": "${BRANDING_AUTH_HEADER_LOGO_URL}",
EOF
    fi

    if [ "${BRANDING_AUTH_FOOTER_LINKS}" != "" ]; then
        cat << EOF
        "authFooterLinks": "${BRANDING_AUTH_FOOTER_LINKS}",
EOF
    fi

    cat << EOF
    "welcomeBackgroundUrl": "themes/element/img/backgrounds/lake.jpg"
EOF
    echo '},'
}

cat << EOF
{
    "default_server_config": {
        "m.homeserver": {
            "base_url": "${DEFAULT_SERVER_URL}",
            "server_name": "${DEFAULT_SERVER_NAME}"
        },
        "m.identity_server": {
            "base_url": "https://vector.im"
        }
    },
    "brand": "${BRAND}",
    $(generate_branding)
    "defaultCountryCode": "${DEFAULT_COUNTRY_CODE}",
    "integrations_ui_url": "https://scalar.vector.im/",
    "integrations_rest_url": "https://scalar.vector.im/api",
    "integrations_widgets_urls": [
        "https://scalar.vector.im/_matrix/integrations/v1",
        "https://scalar.vector.im/api",
        "https://scalar-staging.vector.im/_matrix/integrations/v1",
        "https://scalar-staging.vector.im/api",
        "https://scalar-staging.riot.im/scalar/api"
    ],
    "bug_report_endpoint_url": "https://riot.im/bugreports/submit",
    "roomDirectory": {
        "servers": [
            ${ROOM_DIRECTORY_SERVERS}
        ]
    },
    "disable_custom_urls": "${DISABLE_CUSTOM_URLS}",
    $(generate_embedded_pages)
    $(generate_jitsi_config)
    "terms_and_conditions_links": [
        {
            "url": "${PRIVACY_POLICY_URL}",
            "text": "Privacy Policy"
        },
        {
            "url": "${COOKIE_POLICY_URL}",
            "text": "Cookie Policy"
        }
    ]
}
EOF
