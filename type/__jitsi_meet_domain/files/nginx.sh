#!/bin/sh -e

# shellcheck disable=SC2034  # This is intended to be included
JITSI_NGINX_CONFIG="$(cat <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name ${DOMAIN};

    include snippets/acme-challenge.conf;

    location / {
       return 301 https://\$host\$request_uri;
    }
}
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name ${DOMAIN};

    include snippets/acme-challenge.conf;

# Mozilla Guideline v5.4, nginx 1.17.7, OpenSSL 1.1.1d, intermediate configuration
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;

    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:10m;  # about 40000 sessions
    ssl_session_tickets off;

    add_header Strict-Transport-Security "max-age=63072000" always;

    ssl_certificate /etc/letsencrypt/live/${DOMAIN}/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem;

    root /usr/share/jitsi-meet;

    # ssi on with javascript for multidomain variables in config.js
    ssi on;
    ssi_types application/x-javascript application/javascript;

    # Try the custom page for this domain, fallback to default page
    index index-${DOMAIN}.html index.html index.htm;
    error_page 404 /static/404.html;

    gzip on;
    gzip_types text/plain text/css application/javascript application/json image/x-icon application/octet-stream application/wasm;
    gzip_vary on;
    gzip_proxied no-cache no-store private expired auth;
    gzip_min_length 512;

    # We expect this domain to be properly configured, the file should exist
    location = /config.js {
        alias /etc/jitsi/meet/${DOMAIN}-config.js;
    }
    # We expect this domain to be properly configured, the file should exist
    location = /interface_config.js {
        alias /etc/jitsi/meet/${DOMAIN}-interface_config.js;
    }
    # This may or may not exist; it will be set up in config.js if needed
    location = /branding.json {
        alias /etc/jitsi/meet/${DOMAIN}-branding.json;
    }
    # Try custom image and fallback to default
    location = /images/watermark.png {
        try_files /images/watermark-${DOMAIN}.png \$uri;
    }

    location = /external_api.js {
        alias /usr/share/jitsi-meet/libs/external_api.min.js;
    }

    #ensure all static content can always be found first
    location ~ ^/(libs|css|static|images|fonts|lang|sounds|connection_optimization|.well-known)/(.*)\$
    {
        add_header 'Access-Control-Allow-Origin' '*';
        alias /usr/share/jitsi-meet/\$1/\$2;

        # cache all versioned files
        if (\$arg_v) {
          expires 1y;
        }
    }

    # BOSH
    location = /http-bind {
        proxy_pass      http://localhost:5280/http-bind;
        proxy_set_header X-Forwarded-For \$remote_addr;
	# Prevision for 'multi-domain' jitsi instances
	# https://community.jitsi.org/t/same-jitsi-meet-instance-with-multiple-domain-names/17391
        proxy_set_header Host ${JITSI_HOST};
    }

    # xmpp websockets
    location = /xmpp-websocket {
        proxy_pass http://127.0.0.1:5280/xmpp-websocket?prefix=\$prefix&\$args;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
	# Prevision for 'multi-domain' jitsi instances
	# https://community.jitsi.org/t/same-jitsi-meet-instance-with-multiple-domain-names/17391
        proxy_set_header Host ${JITSI_HOST};
        tcp_nodelay on;
    }

    # colibri (JVB) websockets for jvb1
    location ~ ^/colibri-ws/default-id/(.*) {
       proxy_pass http://127.0.0.1:9090/colibri-ws/default-id/\$1\$is_args\$args;
       proxy_http_version 1.1;
       proxy_set_header Upgrade \$http_upgrade;
       proxy_set_header Connection "upgrade";
       tcp_nodelay on;
    }

    location ~ ^/([^/?&:'"]+)\$ {
        try_files \$uri @root_path;
    }

    location @root_path {
        rewrite ^/(.*)\$ / break;
    }

    location ~ ^/([^/?&:'"]+)/config.js\$
    {
       set \$subdomain "\$1.";
       set \$subdir "\$1/";

       alias /etc/jitsi/meet/jitsi-meet.example.com-config.js;
    }

    #Anything that didn't match above, and isn't a real file, assume it's a room name and redirect to /
    location ~ ^/([^/?&:'"]+)/(.*)\$ {
        set \$subdomain "\$1.";
        set \$subdir "\$1/";
        rewrite ^/([^/?&:'"]+)/(.*)\$ /\$2;
    }

    # BOSH for subdomains
    location ~ ^/([^/?&:'"]+)/http-bind {
        set \$subdomain "\$1.";
        set \$subdir "\$1/";
        set \$prefix "\$1";

        rewrite ^/(.*)\$ /http-bind;
    }

    # websockets for subdomains
    location ~ ^/([^/?&:'"]+)/xmpp-websocket {
        set \$subdomain "\$1.";
        set \$subdir "\$1/";
        set \$prefix "\$1";

        rewrite ^/(.*)\$ /xmpp-websocket;
    }
}
EOF
)"
