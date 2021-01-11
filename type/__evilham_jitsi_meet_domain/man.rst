cdist-type__evilham_jitsi_meet_domain(7)
========================================


NAME
----
cdist-type__evilham_jitsi_meet_domain - Setup a frontend for Jitsi-Meet.


DESCRIPTION
-----------
This type installs and configures the frontend for Jitsi-Meet.

This supports "multi-domain" installations, notice that in such a setup, all
rooms are shared across the different URLs, e.g.
https://jitsi1.example.org/room1 and https://jitsi2.example.org/room1 are
equivalent.

This is due to the underlying XMPP and signaling rooms being common.
There might be a way to perform tricks on the Nginx-side to avoid this, but
time is lacking :-).

This assumes `__evilham_jitsi_meet` has already been ran on the target host,
and, amongst others, that Jitsi was set up with `__target_host` as the Jitsi
domain.

This type will take care of TLS settings, branding and client-side
configuration for Jitsi.

This type only works on De{bi,vu}an systems.


REQUIRED PARAMETERS
-------------------
object id
    The domain that will be configured as a Jitsi-Meet instance.


admin-email
    Where to send Let's Encrypt emails like "certificate needs renewal".


OPTIONAL PARAMETERS
-------------------
channel-last-n
    Default value for the "last N" attribute.
    Defaults to 20. Set to -1 for unlimited.


default-language
    Default language for the user interface.
    Defaults to 'en'.


notice-message
    Message to show the users when they join a room.


start-video-muted
    Every participant after the Nth will start video muted.
    Defaults to 10.


turn-server
    The TURN server to be used.
    Defaults to `__target_host`.


video-constraints
    w3c spec-compliant video constraints to use for video capture. Currently
    used by browsers that return true from lib-jitsi-meet's
    util#browser#usesNewGumFlow. The constraints are independent from
    this config's resolution value. Defaults to requesting an ideal
    resolution of 720p.
    It must not have a trailing comma, see `constraints` in
    `__evilham_jitsi_meet_domain/files/config.js.sh`.


branding-json
    Path to a JSON file that will be served as the `brandingDataUrl`.
    For information on the format see `brandingDataUrl` in
    `__evilham_jitsi_meet_domain/files/config.js.sh`.
    If not set, no branding will be set up.


branding-index
    Path to an HTML file that will be served instead of Jitsi-Meet's default
    one.
    If not set, the default index file will be used.


branding-watermark
    Path to a png file that will be served instead of Jitsi-Meet's default
    one.
    If not set, the default watermark will be used.


BOOLEAN PARAMETERS
------------------
disable-audio-levels
    Disable measuring of audio levels.
    This has been reported to improve performance on clients.


enable-third-party-requests
    This type disables third-party requests by default, this flag re-enables
    them, restoring Jitsi-Meet's defaults.
    This affects things like avatars, callstats, ...


EXAMPLES
--------

.. code-block:: sh

    # Setup a Jitsi frontend for jitsi.exo.cat
    __evilham_jitsi_meet_domain "jitsi.exo.cat" \
      --admin-email "info@exo.cat" \
      --turn-server "turn.exo.cat" \
      --notice-message "Hola!" \
      --disable-audio-levels \
      --turn-secret "WeNeedGoodSecurity" \
      --video-constraints "$(cat <<EOF
        constraints: {
             video: {
                 height: {
                     ideal: 320,
                     max: 320,
                     min: 180
                 }
             }
         }
    EOF
    )"



SEE ALSO
--------
- `__evilham_jitsi_meet`



AUTHORS
-------
Evilham <contact@evilham.com>


COPYING
-------
Copyright \(C) 2020 Evilham.
