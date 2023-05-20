cdist-type__gnupg_key(7)
========================

NAME
----
cdist-type__gnupg_key - Manage GnuPG keys


DESCRIPTION
-----------
This type can be used to manage PGP keys inside `GnuPG <https://www.gnupg.org>`_
keyrings.
Keys can be retrieved from files (either local or via HTTP) or automatically
found and imported using :strong:`gpg`\ (1)'s ``--locate-keys`` feature.

Because the PGP file format is complex, this type requires that you give it the
key ID even if you import from a file/URL.

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
   the PGP key id of the key to import or of the key in ``--source``.
   The value of this parameter is used to check if the key already exists, so
   it does not necessarily have to be an ID, but it should be unique, especially
   for ``--state absent`` :-).

   Defaults to: ``__object_id``
key-locate-mechanisms
   this parameter takes any number of GnuPG ``--auto-key-locate`` mechanisms.
   If a key needs to be fetched, these mechanisms will be tried in the order
   listed in this parameter.

   This parameter can be used multiple times. The values of all instances will
   be concatenated by :strong:`gpg`\ (1).

   Hint: this parameter also accepts keyserver URLs.
source
   the source to take the key from.
   Will use auto-key-locate if not used.

   Acceptable values:

   ``http://...`` / ``https://...``
      key file downloaded from the web.
   ``file://...`` / ``/...``
      files local to the config host
   ``-``
      stdin
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

   # import a PGP key from a keyserver/WKD
   __gnupg_key wk@gnupg.org

   # import a PGP key from a specific keyserver
   __gnupg_key openzfs-release-key \
      --key-id bass6@llnl.gov \
      --key-locate-mechanisms clear,'hkps://pgp.mit.edu'


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
