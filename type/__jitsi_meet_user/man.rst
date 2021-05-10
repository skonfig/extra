cdist-type__jitsi_meet_user(7)
==============================

NAME
----
cdist-type__jitsi_meet_user - Manage users in a Jitsi-Meet with secured-domains


DESCRIPTION
-----------
This type manages a user identified by `$__object_id` that is allowed to start
meetings in a Jitsi Meet instance managed by `__jitsi_meet(7)` and
`__jitsi_meet_domain(7)`.

It does so by taking advantage of Prosody's plaintext authentication and
managing a file per user with the credentials.
If a different authentication mechanism is needed, `__jitsi_meet(7)` should be
patched accordingly.

This type only works on De{bi,vu}an systems.


OPTIONAL PARAMETERS
-------------------
password
    The user's password in plaintext.
    Beware that since Prosody's plaintext authentication is used, this password
    will also be stored as plaintext in the server.
    Unless `--state` is `absent`, this parameter is required.

state
    Whether the user should be `present` (default) or `absent`.

EXAMPLES
--------

.. code-block:: sh

    # Setup a Jitsi user for secure domain configuration
    __jitsi_meet_user "user_1" --password "WeNeedGoodSecurity"

    # Remove such Jitsi user so it is not allowed to start meetings
    __jitsi_meet_user "user_1" --state absent


SEE ALSO
--------
- Prosody authentication https://modules.prosody.im/type_auth.html
- Jitsi Meet secure domain configuration https://jitsi.github.io/handbook/docs/devops-guide/secure-domain
- `__jitsi_meet(7)`
- `__jitsi_meet_domain(7)`


AUTHORS
-------
Pedro <pedrodocs2021@cas.cat>
Evilham <contact@evilham.com>


COPYING
-------
Copyright \(C) 2021 Pedro and Evilham. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
