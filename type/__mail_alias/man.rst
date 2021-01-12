cdist-type__mail_alias(7)
=========================

NAME
----
cdist-type__mail_alias - Manage mail aliases.


DESCRIPTION
-----------
This cdist type allows you to configure mail aliases (/etc/aliases).


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
state
    'present' or 'absent', defaults to 'present'
alias
    an alias, i.e. a mail address where mail for the user should be redirected
    to.
    This parameter can be specified multiple times to redirect to multiple
    recipients.
    If ``--state`` is ``present`` this parameter is required.
    See `aliases(5)` for the different forms this parameter can take.


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
- Quoted strings are not parsed by this type. As a result, aliases
  containing ``,`` (commas) are treated incorrectly (they are treated as
  separate aliases.)
  Make sure that email addresses, file names, and pipe commands do not contain
  commas.
- ``:include:`` directives in the aliases file are not evaluated by this type.
  They are treated like a regular alias, the values of the included file are
  not expanded.


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
