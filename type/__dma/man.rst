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
email server configured in the `smart-host` parameter.


REQUIRED PARAMETERS
-------------------
smart-host
    The email server used to send email.
    It must be configured to act as a relay for the host being configured by
    this type so that mail can be sent to users non-local to the smart-host.


BOOLEAN PARAMETERS
------------------
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


EXAMPLES
--------

.. code-block:: sh

    __dma \
      --smart-host mx1.domain.tld \
      --send-test-email


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
