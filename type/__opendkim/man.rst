cdist-type__opendkim(7)
=======================

NAME
----
cdist-type__opendkim - Configure an instance of OpenDKIM


DESCRIPTION
-----------
OpenDKIM is a DKIM signing and verifying filter for MTAs. This type enables the
installation and basic configuration of an instance of OpenDKIM.

Note that this type does not generate or ensure that a key is present: use
`cdist-type__opendkim-genkey(7)` for that.

Note that this type is currently only implemented for Alpine Linux. Please
contribute an implementation if you can.


REQUIRED PARAMETERS
-------------------
socket
  A string specifying a socket to listen on for communication with the MTA. See
  `opendkim.conf(5)` for details on the syntax.


OPTIONAL PARAMETERS
-------------------
basedir
  A directory to `chdir(2)` to before beginning operations.

canonicalization
  Directives for message canonicalization. See `opendkim.conf(5)` for details
  on the syntax.

subdomains
  Explicitely control whether subdomains should be signed as well. Expects a
  string containing 'Y', 'N', 'y', 'n', 'yes' or 'no'.

umask
  Set the umask for the socket and PID file.

userid
  Change the user the opendkim program is to run as. By default, Alpine Linux's
  OpenRC service will set this to `opendkim` on the command-line.

custom-config
  The string following this parameter is appended as-is in the configuration, to
  enable more complex configurations.

BOOLEAN PARAMETERS
------------------
syslog
  Log to syslog.


EXAMPLES
--------

.. code-block:: sh

    __opendkim \
        --socket inet:8891@localhost \
        --basedir /var/lib/opendkim \
        --canonicalization relaxed/simple \
        --subdomains no \
        --umask 002 \
        --syslog \
        --custom-config "Mode v"

    require='__opendkim' \
        __opendkim_genkey mykey \
                --domain example.com \
                --selector default \
                --sigkey example.com


SEE ALSO
--------
`cdist-type__opendkim-genkey(7)`
`opendkim(8)`
`opendkim.conf(5)`


AUTHORS
-------
Joachim Desroches <joachim.desroches@epfl.ch>


COPYING
-------
Copyright \(C) 2021 Joachim Desroches. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
