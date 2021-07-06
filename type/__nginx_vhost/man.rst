cdist-type__nginx_vhost(7)
===================================

NAME
----
cdist-type__nginx_vhost - Have nginx serve content for a virtual host


DESCRIPTION
-----------
This type setups up nginx with reasonable defaults and creates a vhost to be
served, optionally with TLS certificates obtained from the Let's Encrypt CA
through the ACME HTTP-01 challenge-response mechanism.

By default, if no rules are specified, then the vhost will serve as-is the
contents of the `WEBROOT/foo.com` directory, where WEBROOT is
determined depending on the OS, adhering as close to `hier(7)` as possible.

NGINX expects files in the vhost to be served to be at least readable by the
`USER` group, that it creates if it does not exist. It is recommended to have
the user owning the files to be someone else, and the files beeing
group-readable but not writeable.

Finally, if TLS is not disabled, then this type makes nginx expect the
fullchain certificate and the private key in
`CERTDIR/domain/{fullchain,privkey}.pem`.

+------------------+---------+-------------------+-----------------------------+
| Operating System | USER    | WEBROOT           | CERTDIR                     |
+==================+=========+===================+=============================+
| Alpine Linux     | `nginx` | `/srv/www/`       | `/etc/nginx/ssl/`           |
+------------------+---------+-------------------+-----------------------------+
| Arch Linux       | `www`   | `/srv/www/`       | `/etc/nginx/ssl/`           |
+------------------+---------+-------------------+-----------------------------+

OPTIONAL PARAMETERS
-------------------

config
  A custom configuration file for the vhost, inserted in a server section
  populated with `server_name` and TLS parameters unless `--standalone-config`
  is specified. Can be specified either as a file path, or if the value of this
  flag is '-', then the configuration is read from stdin.

domain
  The domain this server will respond to. If this is omitted, then the
  `__object_id` is used.

lport
  The port to which we listen. If this is omitted, the defaults of `80` for
  HTTP and `443` for HTTPS are used.

altdomains
  Alternative domain names for this vhost.

BOOLEAN PARAMETERS
------------------

no-hsts
  Do not use HSTS pinning.

no-tls
  Do not serve over HTTPS.

to-https
  Ignore --config flag and redirect to HTTPS. Implies --no-tls.

standalone-config
  Use as-in the vhost configuration (= do not wrap in generic server section)
  the content of the `config` parameter.

AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>
Timothée Floure <timothee.floure@posteo.net>

COPYING
-------
Copyright \(C) 2020 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
