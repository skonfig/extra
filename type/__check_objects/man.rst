cdist-type__check_objects(7)
============================

NAME
----
cdist-type__check_objects - Run command(s) if required object(s)
generate code.


DESCRIPTION
-----------
Check if objects in `$__object/require` (and its `children`) generated
`code-local` or `code-remote`, and execute the command if they did.


REQUIRED MULTIPLE PARAMETERS
----------------------------
onchange
   Command to run.


EXAMPLES
--------

.. code-block:: sh

   export require='__package_apt/nginx'

   __file /etc/nginx/nginx.conf \
       --owner root \
       --group root \
       --mode 644 \
       --source "$__files/nginx.conf"

   __systemd_unit nginx.service \
       --enablement-state enabled

   unset require

   require='__file/etc/nginx/nginx.conf __systemd_unit/nginx.service' \
       __check_objects nginx \
           --onchange 'systemctl restart nginx.service'


AUTHORS
-------
* Ander Punnar <ander--@--kvlt.ee>


COPYING
-------
Copyright \(C) 2025 Ander Punnar.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
