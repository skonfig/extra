cdist-type__nginx(7)
===================================

NAME
----
cdist-type__nginx - Serve web content with NGINX


DESCRIPTION
-----------
Leverages `__nginx_vhost` to serve web content.

REQUIRED PARAMETERS
-------------------
domain
  Domain name to be served.

OPTIONAL PARAMETERS
-------------------
config
  Custom NGINX logic, templated within a standard `server` section with
  `server_name` and TLS parameters set. Defaults to simple static hosting.

altdomains
  Alternative domain names for this vhost and related TLS certificate.

uacme-hookscript
  Custom hook passed to the __uacme_obtain type: useful to integrate the
  dns-01 challenge with third-party DNS providers.

EXAMPLES
--------

.. code-block:: sh

  # TLS-enabled vhost serving static files in $WEBROOT/domain.tld (OS-specific,
  # usually `/var/www` on GNU/Linux systemd).
  __nginx domain.tld

  # TLS-enabled vhost with custom configuration.
  __nginx files.domain.tld \
    --config - <<- EOF
      root /var/www/files.domain.tld/;
      autoindex on;
    EOF

AUTHORS
-------
Timothée Floure <timothee.floure@posteo.net>
Joachim Desroches <joachim.desroches@epfl.ch>

COPYING
-------
Copyright \(C) 2020 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
