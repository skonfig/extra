cdist-type__mail_alias(7)
=========================

NAME
----
cdist-type__mail_alias - Manage mail aliases.


DESCRIPTION
-----------
This cdist type allows you to configure mail aliases (/etc/mail/aliases).


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
state
    'present' or 'absent', defaults to 'present'
alias
    the aliases where mail for the given user should be redirected to.
    This parameter can be specified multiple times to redirect to more than one
    recipient.
    See the `aliases(5)` man page for the different forms this parameter can
    take..


BOOLEAN PARAMETERS
------------------
None.


EXAMPLES
--------

.. code-block:: sh

    # Redirect root mail to a "real" email address
    __mail_alias root --alias admin@example.com

    # Disable redirection of mail for joe
    __mail_alias joe --state absent


BUGS
----
- Quoted strings are not parsed by this type. As a result, email addresses
  containing ``,`` (commas) are treated incorrectly (they are treated as two
  addresses/aliases.)
  Make sure that email addresses do not contain commas.


SEE ALSO
--------
:strong:`aliases`\ (5)


AUTHORS
-------
Dennis Camera <dennis.camera@ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2020 Dennis Camera. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
