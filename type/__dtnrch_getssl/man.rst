cdist-type__dtnrch_getssl(7)
============================

NAME
----
cdist-type__dtnrch_getssl - Set up getssl.


DESCRIPTION
-----------
This space intentionally left blank.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
state
   Whether getssl should be installed (``present``) on the target or not
   (``absent``).
version
   The version of getssl to install on the target.
   Or ``latest`` to use the latest version.


BOOLEAN PARAMETERS
------------------
None.


EXAMPLES
--------

.. code-block:: sh

   # Ensure the latest version of getssl is installed
   __dtnrch_getssl --version latest


SEE ALSO
--------
- https://github.com/srvrco/getssl.git


AUTHORS
-------
Dennis Camera <cdist--@--dtnr.ch>


COPYING
-------
Copyright \(C) 2020 Dennis Camera. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
