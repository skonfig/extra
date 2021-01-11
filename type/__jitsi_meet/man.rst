cdist-type__jitsi_meet(7)
=================================


NAME
----
cdist-type__jitsi_meet - Setup the server-side of Jitsi-Meet.


DESCRIPTION
-----------
This (singleton) type installs and configures jitsi-meet automatically.

It does so by following loosely the official quick-install instructions and
eXO's notes for installing and managing Jitsi Meet instances.

This type also sets up nginx in a way that is compatible with
`__letsencrypt_cert` and assumes that it will only serve Jitsi instances.

You will also need the `__jitsi_meet_domain` type in order to finish setting up
the web frontend (including TLS certificates) and its settings.

You may want to use the `files/ufw` example manifest for a `__ufw`-based
firewall compatible with this type.
This file does not include rules for TCP port 9888, which exposes the
prometheus exporter if not disabled.
You should apply your own rules here.

This type only works on De{bi,vu}an systems.

NOTE: This type currently does not deal with setting up coturn.
      For that, you might want to check `__coturn` in
      https://code.ungleich.ch/ungleich-public/cdist-contrib
      In that case, this type should run *after* `__coturn`.


OPTIONAL PARAMETERS
-------------------
turn-secret
    The shared secret for the TURN server.


turn-server
    The hostname of the TURN server.
    This will assume that it is listening with TLS on port 443.


BOOLEAN PARAMETERS
------------------
disable-prometheus-exporter
    This type enables a prometheus exporter for jitsi by default, if you would
    rather not have that, pass this parameter.
    The explorer is based on:
    https://github.com/systemli/prometheus-jitsi-meet-exporter


EXAMPLES
--------

.. code-block:: sh

    # Setup the firewall 
    . "${__global}/type/__jitsi_meet/files/ufw"
    export require="__ufw"
    # Setup Jitsi on this host
    __jitsi_meet \
      --turn-server "turn.exo.cat" \
      --turn-secret "WeNeedGoodSecurity"


SEE ALSO
--------
- `__jitsi_meet_domain`



AUTHORS
-------
Evilham <contact@evilham.com>


COPYING
-------
Copyright \(C) 2020 Evilham.
