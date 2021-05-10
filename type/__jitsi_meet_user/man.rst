cdist-type__jitsi_meet_user(7)
=================================

NAME
----
cdist-type__jitsi_meet_user - Setup users when using jitsi_meet instance with secure domain configuration

DESCRIPTION
-----------
This type just places a file with a user and a password (plaintext) that will be used in a jitsi-meet instance with `secure domain configuration https://jitsi.github.io/handbook/docs/devops-guide/secure-domain`. There is a different from the official approach: to have an `internal_plain` authentication method to facilitate the auth management. That user will be able to create and join rooms on that instance as a moderator.

You will also need to setup first the `__jitsi_meet_domain` and `__jitsi_meet` types.

This type only works on De{bi,vu}an systems.

REQUIRED PARAMETERS
-------------------
object id
    The user that will be able to authenticate against a Jitsi-Meet instance with secure domain configuration

passwd
    The user's password in plaintext (beware that it is also stored as plaintext in the server)

OPTIONAL PARAMETERS
-------------------
state
    If user should be (default) present or absent

EXAMPLES
--------

.. code-block:: sh

    # Setup a Jitsi user for secure domain configuration
    __jitsi_meet_user "user_1" --password "WeNeedGoodSecurity"

SEE ALSO
--------
- `__jitsi_meet`
- `__jitsi_meet_domain`


AUTHORS
-------
Pedro <pedrodocs2021@cas.cat>
Evilham <contact@evilham.com>

COPYING
-------
Copyright \(C) 2021 Pedro. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
Copyright \(C) 2021 Evilham
