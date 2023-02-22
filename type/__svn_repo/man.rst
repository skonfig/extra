cdist-type__svn_repo(7)
=======================

NAME
----
cdist-type__svn_repo - Manage a Subversion repo using :strong:`svnadmin`\ (1)


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
compatible-version
   Create a repository using a format compatible with the given Subversion
   version.

   This option can only be used for new repositories. Trying to change the
   compatible version of an already existing repository will produce an error.

   Defaults to: the default of :strong:`svnadmin`\ (1).
fs-type
   Type of the repository (file system format).

   This option can only be used for new repositories. Trying to change the
   compatible version of an already existing repository will produce an error.

   Defaults to: the default of :strong:`svnadmin`\ (1).
db-owner
   A ``user[:group]`` string (name or UID) as is suitable for
   :strong:`chown`\ (1).
   All files and subdirectories of the ``db`` and ``locks`` subdirectories in the
   SVN repo will be chowned to this user.

   If not used, these directories will be owned by ``--owner``.
owner
   A ``user[:group]`` string (name or UID) as is suitable for
   :strong:`chown`\ (1).
   All files and subdirectories (esp. the ``conf`` subdirectory) in the SVN repo will be chowned to this user.

   If not used, these directories will receive the default ownership.
path
   The path of the repository.

   Defaults to: ``__object_id``
state
   One of:

   ``present``
      the Subversion repository exists at the given ``--path``.
   ``absent``
      the Subversion repository does not exist at the given ``--path``.


BOOLEAN PARAMETERS
------------------
None.


EXAMPLES
--------

.. code-block:: sh

   # Create a SVN repo at /var/svn/repos
   __svn_repo /var/svn/repos

   # Create a SVN repository with hardened permissions (e.g. for use with
   # mod_dav_svn).  httpd will only be able to read/write the revision database,
   # not change configuration, authz or hooks.
   __svn_repo /var/svn/repos --owner 0:0 --db-owner www-data:www-data


SEE ALSO
--------
:strong:`cdist-type__svn`\ (7)


AUTHORS
-------
| Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2023 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
