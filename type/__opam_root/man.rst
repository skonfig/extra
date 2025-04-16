cdist-type__opam_root(7)
========================

NAME
----
cdist-type__opam_root - Manage an opam root


DESCRIPTION
-----------
This type allows you to manage opam roots (the ``~user/.opam``) directory used
as the basis for all other opam operations.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
root
   The directory in which the OPAM root should be located
   (like ``opam init --root``).

   Defaults to: ``~user/.opam``
   (with ``~user`` being the home directory of ``--user``)
state
   One of:

   ``present``
      the opam root exists
   ``absent``
      the opam root does not exist
user
   The user for which the opam root should be managed.

   Defaults to: ``__object_id``


BOOLEAN PARAMETERS
------------------
shell-setup
   Set up the user's shell configuration for opam, i.e.
   * register a shell hook to keep the shell environment up-to-date at every prompt,
   * setup shell completion (for supported shells).


EXAMPLES
--------

.. code-block:: sh

   # Create an opam root for the root user (not recommened by opam)
   __opam_root root

   # Create an opam root and install recommended packages
   __package m4
   __package git
   __package darcs
   __package hg
   __package darcs
   __opam_root root


SEE ALSO
--------
:strong:`cdist-type__opam_switch`\ (7),
:strong:`cdist-type__opam_pin`\ (7),
:strong:`cdist-type__package_opam`\ (7)


AUTHORS
-------
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
