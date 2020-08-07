cdist-type__borg_repo(7)
========================

NAME
----
cdist-type__borg_repo - Configure a borg repository on host


DESCRIPTION
-----------

Initializes a borg repository at the location specified in the
`${__object_id}`. Nothing is done if the repository already exists.

Currently, only `none` and `repokey` are supported as encryption modes;
`repokey` requires the `passphrase` argument to be given. The default is
`none`.

REQUIRED PARAMETERS
-------------------
encryption
  The encryption to use.

OPTIONAL PARAMETERS
-------------------
passphrase
  The passphrase to encrypt the keyfile with.

BOOLEAN PARAMETERS
------------------
append-only
  If the repository is append-only

AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>

COPYING
-------
Copyright \(C) 2020 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
