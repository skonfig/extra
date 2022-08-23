cdist-type__opam_pin(7)
=======================

NAME
----
cdist-type__opam_pin - Manage opam pins


DESCRIPTION
-----------
This type can be used to manage opam pins.

Depending on the kind of ``--target`` it may be necessary to install additional
OS packages, e.g. the ``git`` package needs to be installed for opam to support
pinning Git repositories.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
package
   The name of the opam package to pin.

   Defaults to: ``__object_id``
state
   One of:

   ``present``
      the ``--package`` is pinned to ``--target``
   ``absent``
      the ``--package`` is not pinned
switch
   The name of the switch to pin this package in.

   Defaults to: ``default``
target
   What to pin ``--package`` to.

   This parameter is required if ``--state present``.
user
   The user in whose opam root the switch should be managed.

   Defaults to: ``root``


BOOLEAN PARAMETERS
------------------
None.


EXAMPLES
--------

.. code-block:: sh

   # TODO
   __opam_pin


SEE ALSO
--------
:strong:`cdist-type__opam_root`\ (7),
:strong:`cdist-type__opam_switch`\ (7)


AUTHORS
-------
| Dennis Camera <dennis.camera--@--ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
