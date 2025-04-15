cdist-type__package_opam(7)
===========================

NAME
----
cdist-type__package_opam - Manage opam packages


DESCRIPTION
-----------
This type can be used to manage opam packages.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
destdir
   Install the files of the given package to the ``--destdir`` instead of into
   the opam switch.

   CAUTION when using this parameter: opam will only overwrite existing files
   but not delete outdated files on pacakge upgrades. When using
   ``--state absent`` opam will try to clean up but expect some rests left.
   If ``--destdir`` is only used by this object, it's probably a good idea to
   delete this directory after using ``--state absent``.
package
   The name of the opam package to manage.

   Defaults to: ``__object_id``
state
   One of:

   ``present``
      the ``--package`` is installed
   ``absent``
      the ``--package`` is not installed
switch
   The name of the switch to pin this package in.

   Defaults to: the currently active switch for the selected opam root
   (cf. ``--user``)
user
   The user in whose opam root the switch should be managed.

   Defaults to: ``root``


BOOLEAN PARAMETERS
------------------
deps-only
   Install only the dependencies of ``--package``, but not the package itself.
no-depexts
   Skips the automatic installation of external dependencies (i.e. OS packages)


EXAMPLES
--------

.. code-block:: sh

   # Install Coccinelle
   __package_opam coccinelle

   # Install a specific version of Frama-C
   __package_opam frama-c.25.0

   # Install a version of the Dune build system >= 2.0.0
   __package_opam dune --package 'dune>=2.0.0'


SEE ALSO
--------
:strong:`cdist-type__opam_root`\ (7),
:strong:`cdist-type__opam_switch`\ (7),
:strong:`cdist-type__opam_pin`\ (7)


AUTHORS
-------
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
