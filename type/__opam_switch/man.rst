cdist-type__opam_switch(7)
==========================

NAME
----
cdist-type__opam_switch - Manage opam switches


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
compiler
   The invariant of the switch.
description
   The description of the opam switch.
name
   The name of the opam switch.

   Defaults to: ``__object_id``
state
   One of:

   ``present``
      the switch exists
   ``absent``
      the switch does not exist
user
   The user in whose opam root the switch should be managed.

   Defaults to: ``root``


BOOLEAN PARAMETERS
------------------
empty
   Create an empty switch, with no invariant.


EXAMPLES
--------

.. code-block:: sh

   # Create a default switch
   __opam_switch default --empty

   # Create a switch for a specific OCaml version
   __opam_switch 4.11.1


SEE ALSO
--------
:strong:`cdist-type__opam_root`\ (7),
:strong:`cdist-type__opam_pin`\ (7),
:strong:`cdist-type__package_opam`\ (7)


AUTHORS
-------
* Dennis Camera <dennis.camera--@--ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
