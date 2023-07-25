cdist-type__gnupg_key(7)
========================

NAME
----
cdist-type__gnupg_key - Manage GnuPG keys


DESCRIPTION
-----------
This type can be used to manage PGP keys inside `GnuPG <https://www.gnupg.org>`_
keyrings.
Keys can be retrieved from files (either local or via HTTP) or imported from a
keyserver.

Because the PGP file format is complex, this type requires that you give it the
full key ID (i.e. fingerprint) of the primary key even if you import from a file/URL.

Once a key is present in the keyring, this type will not process it further,
i.e. it won't update the keyring if e.g. new signatures or sub keys were added.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
homedir
   the path of the GnuPG home directory.

   Defaults to: ``/root/.gnupg``
key-id
   the PGP key id of the key to receive when importing from a keyserver or of
   the key in ``--source`` when importing from a file.

   The value of this parameter is used to check if the key already exists.

   Defaults to: ``__object_id``
ownertrust
   set the ownertrust of the imported key to the given value.

   The value must be one of:

   undefined
      not enough information to assign an ownertrust
   never
      never trusted
   marginal
      marginally trusted
   fully
      fully trusted
   ultimate
      ultimately trusted
source
   the source to take the key from.

   Acceptable values:

   ``http://...`` / ``https://...``
      key file downloaded from the web
   ``hkp://...`` / ``hkps://...``
      receive public key from an HTTP (compatible) keyserver
   ``ldap://...`` / ``ldaps://...``
      receive public key from an LDAP keyserver
   ``file://...`` / ``/...``
      key file local to the config host
   ``-``
      read key data from standard input
state
   One of:

   present
      the key is available in the keyring
   absent
      the key is missing from the keyring


BOOLEAN PARAMETERS
------------------
None.


EXAMPLES
--------

.. code-block:: sh

   # import a PGP key from file
   __gnupg_key 3F7121B3B286715A3325234E536E504BD7E91E76 \
      --source "${__files:?}/pgp/7E91E764.asc"

   # import a PGP key from the web
   __gnupg_key 453B65310595562855471199CA68BE8010084C9C \
      --source https://download.libvirt.org/gpg_key.asc

   # import a PGP key from the default keyserver
   __gnupg_key AEA84EDCF01AD86C4701C85C63113AE866587D0A

   # import a PGP key from a specific keyserver
   __gnupg_key openzfs-release-key \
      --key-id 29D5610EAE2941E355A2FE8AB97467AAC77B9667 \
      --source 'hkps://pgp.mit.edu'


SEE ALSO
--------
:strong:`gpg`\ (1)


AUTHORS
-------
| Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2023 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
