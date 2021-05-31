cdist-type__opendkim_genkey(7)
==============================

NAME
----
cdist-type__opendkim_genkey - Generate DKIM keys suitable for OpenDKIM


DESCRIPTION
-----------

This type uses the `opendkim-genkey(8)` to generate signing keys suitable for
usage by `opendkim(8)` to sign outgoing emails. Then, a line with the domain,
selector and keyname in the `$selector._domainkey.$domain` format will be added
to the OpenDKIM key table located at `/etc/opendkim/KeyTable`. Finally, a line
will be added to the OpenDKIM signing table, using either the domain or the
provided key for the `domain:selector:keyfile` value in the table. An existing
key will not be overwritten.

Currently, this type is only implemented for Alpine Linux. Please contribute an
implementation if you can.

REQUIRED PARAMETERS
-------------------
domain
  The domain to generate the key for.

selector
  The DKIM selector to generate the key for.


OPTIONAL PARAMETERS
-------------------
bits
  The size of the generated key, in bits. The default is 1024, the recommended
  by the DKIM standard.

directory
  The directory in which to generate the key, `/var/db/dkim/` by default.

sigkey
  The key used in the SigningTable for this signing key. Defaults to the
  specified domain. If `%`, OpenDKIM will replace it with the domain found
  in the `From:` header. See `opendkim.conf(5)` for more options.

BOOLEAN PARAMETERS
------------------
no-subdomains
  Disallows subdomain signing by this key.

unrestricted
  Do not restrict this key to email signing usage.


EXAMPLES
--------

.. code-block:: sh

    __opendkim \
        --socket inet:8891@localhost \
        --basedir /var/lib/opendkim \
        --canonicalization relaxed/simple \
        --subdomains no \
        --umask 002 \
        --syslog

    require='__opendkim' \
        __opendkim_genkey default \
                --domain example.com \
                --selector default

        __opendkim_genkey myfoo \
                --domain foo.com \
                --selector backup


SEE ALSO
--------
`opendkim(8)`
`opendkim-genkey(8)`
`cdist-type__opendkim(7)`


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
