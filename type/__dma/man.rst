cdist-type__dma(7)
============================

NAME
----
cdist-type__dma - Setup the DragonFly Mail Agent as the MTA.


DESCRIPTION
-----------
This (singleton) type uses DMA, a small Mail Transport Agent (MTA), to accept
mails from locally installed Mail User Agents (MUA) and either deliver the mails
to a remote smart host for delivery or communicate with remote SMTP servers
directly.


REQUIRED PARAMETERS
-------------------
None.


BOOLEAN PARAMETERS
------------------
defer
    If enabled, mail will not be sent immediately, but stored in a queue.
    To flush the queue and send the mails, ```dma -q`` has to be run
    periodically (e.g. using a cron job.)
    This type does not manage such a cron job, but some operating systems ship
    such a cron job with the package.
fullbounce
    Enable if bounce messages should include the complete original message,
    not just the headers.
nullclient
    Enable to bypass aliases and local delivery, and instead forward all mails
    to the defined ``--smarthost``.
send-test-mail
    If set, this type will send a test email to root after setup, to check if
    the configured settings work.


OPTIONAL PARAMETERS
-------------------
mailname
    If present, this will be the hostname used to identify this host and the
    remote part of the sender addresses.
    If not defined, it defaults to ``/etc/mailname`` on Debian derivatives and
    to ``__target_fqdn`` otherwise.
    See `dma(8)` for more information.

    Note: on Debian derivatives the ``/etc/mailname`` file should be updated
    instead of using this parameter.
masquerade
    Masquerade the envelope-from addresses with this address/hostname.
    Use this setting if mails are not accepted by destination mail servers
    because your sender domain is invalid.
    This option can be used multiple times.
    For more information see the `dma(8)` man page.
port
    The port on which to deliver email.
    If not provided, a sensible default port will be used based on the
    ``--security`` argument.
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
        Should really *not* be used anymore!
smarthost
    The mail server used to send email.
    It must be configured to act as a relay for the host being configured by
    this type so that mail can be sent to users non-local to the smarthost.


EXAMPLES
--------

.. code-block:: sh

    # Install DMA and use the smarthost mx1.domain.tld to send mail.
    __dma --smarthost mx1.domain.tld --send-test-mail

    # Install DMA in a default configuration.
    __dma


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
