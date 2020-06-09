cdist-type__dma(7)
============================

NAME
----
cdist-type__dma - Setup the DragonFly Mail Agent as the MTA.


DESCRIPTION
-----------
This (singleton) type uses dma, a small Mail Transport Agent (MTA), to accept
mails from locally installed Mail User Agents (MUA) and deliver the mails
to a remote destination.

Remote delivery happens over TLS to one or more mailboxes that are local to the
mail server configured in the ``smarthost`` parameter.


REQUIRED PARAMETERS
-------------------
smarthost
    The mail server used to send email.
    It must be configured to act as a relay for the host being configured by
    this type so that mail can be sent to users non-local to the smarthost.


BOOLEAN PARAMETERS
------------------
defer
    If enabled, the mail queue has to be manually flushed with the `-q` option.
full-bounce
    Enable if the bounce message should include the complete original message,
    not just the headers.
null-client
    Enable to bypass aliases and local delivery, and instead forward all mails
    to the defined ``--smarthost``.
send-test-email
    If present, after setup this type will send an email to root, to allow you
    to easily test your setup.


OPTIONAL PARAMETERS
-------------------
mailname
    If present, this will be the hostname used to identify this host and the
    remote part of the from addresses.
    If not defined, it defaults to `/etc/mailname` on Debian-derived Operating
    Systems and to `__target_host` otherwise.
    See `dma(8)` for more information.
masquerade
    Masquerade the envelope-from addresses with this address/hostname.
    Use this setting if mails are not accepted by destination mail servers
    because your sender domain is invalid.
    This option can be used multiple times.
    For more information see the `dma(8)` man page.
port
    The port on which to deliver email.
    If not provided, a sensible default port will be used based on the
    `--security` argument.
security
    Configures whether and how DMA should use secure connections.

    ssl/tls
        Enable TLS/SSL secured transfer.
    starttls
        Use STARTTLS to establish a secure connection.
    opportunistic (default)
        Will try to establish a secure connection using STARTTLS, but allow
        unencrypted transfer if STARTTLS fails.
        Most useful when dma is used without a smarthost, delivering remote
        messages directly to the outside mail exchangers.
    insecure
        allow plain text SMTP login over an insecure connection.
        Should really not be used anymore!

EXAMPLES
--------

.. code-block:: sh

    __dma --smarthost mx1.domain.tld --send-test-email


SEE ALSO
--------
- `DragonFly Mail Agent <https://github.com/corecode/dma>`_
- `DragonFly Handbook MTA <https://www.dragonflybsd.org/handbook/mta/>`_


AUTHORS
-------
Evilham <contact@evilham.com>
Dennis Camera <dennis.camera@ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2020 Evilham and Dennis Camera. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
