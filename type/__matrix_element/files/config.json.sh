#!/bin/sh
#
# Upstream configuration guide/documentation:
#   https://github.com/vector-im/riot-web/blob/develop/docs/config.md

generate_embedded_pages () {
    if [ "$EMBED_HOMEPAGE" != "" ]; then
        cat << EOF
    "embeddedPages": {
        "homeUrl": "home.html"
    },
EOF
    fi
}

generate_jitsi_config () {
    if [ "$JITSI_DOMAIN" != "" ]; then
        cat << EOF
    "jitsi": {
        "preferredDomain": "$JITSI_DOMAIN"
     },
EOF
    fi
}

generate_branding () {
    echo '"branding": {'

    if [ "$BRANDING_AUTH_HEADER_LOGO_URL" != "" ]; then
        cat << EOF
        "authHeaderLogoUrl": "$BRANDING_AUTH_HEADER_LOGO_URL",
EOF
    fi

    if [ "$BRANDING_AUTH_FOOTER_LINKS" != "" ]; then
        cat << EOF
        "authFooterLinks": "$BRANDING_AUTH_FOOTER_LINKS",
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
            "base_url": "$DEFAULT_SERVER_URL",
            "server_name": "$DEFAULT_SERVER_NAME"
        },
        "m.identity_server": {
            "base_url": "https://vector.im"
        }
    },
    "brand": "$BRAND",
    $(generate_branding)
    "defaultCountryCode": "$DEFAULT_COUNTRY_CODE",
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
            $ROOM_DIRECTORY_SERVERS
        ]
    },
    "disable_custom_urls": "$DISABLE_CUSTOM_URLS",
    $(generate_embedded_pages)
    $(generate_jitsi_config)
    "terms_and_conditions_links": [
        {
            "url": "$PRIVACY_POLICY_URL",
            "text": "Privacy Policy"
        },
        {
            "url": "$COOKIE_POLICY_URL",
            "text": "Cookie Policy"
        }
    ]
}
EOF
