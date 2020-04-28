cdist-type__find_exec(7)
========================

NAME
----
cdist-type__find_exec - Find files and execute commands on them


DESCRIPTION
-----------
``find`` in explorer will only run with expressions given with ``--exp`` parameter.

Code will be generated only, if explorer produces output.

For code generation ``--exec`` and/or ``--execdir`` parameters are used.

Please see your OS ``find`` manpage for details.


REQUIRED MULTIPLE PARAMETERS
----------------------------
exp
   Expression to add to ``find`` command after starting point.
   DO NOT add ``-exec`` or ``-execdir`` here.


OPTIONAL MULTIPLE PARAMETERS
----------------------------
exec
   See ``find`` manpage about ``-exec``.

execdir
   See ``find`` manpage about ``-execdir``.


OPTIONAL PARAMETERS
-------------------
path
   Use this path instead of object id.

onchange
   The code to run if something happens.


EXAMPLES
--------

.. code-block:: sh

    # find *.list files under /etc/apt/sources.list.d, delete them and update apt cache
    __find_exec /etc/apt/sources.list.d \
        --exp '-name "*.list"' \
        --exec 'rm "{}" \;' \
        --onchange 'apt-get update || true'

    # find files with execute bit under /some/path and remove execute bit
    __find_exec remove-exec-bit \
        --path /some/path \
        --exp '-type f' \
        --exp '-perm /111' \
        --exec 'chmod -x "{}" \;'


AUTHORS
-------
Ander Punnar <ander-at-kvlt-dot-ee>


COPYING
-------
Copyright \(C) 2020 Ander Punnar. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
