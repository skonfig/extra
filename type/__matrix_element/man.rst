cdist-type__matrix_element(7)
=============================

NAME
----
cdist-type__matrix_element - Install and configure Element, a web Matrix client.


DESCRIPTION
-----------
This type install and configure the Element web client.


REQUIRED PARAMETERS
-------------------
install_dir
  Root directory of Element's static files.

version
  Release of Element to install.

OPTIONAL PARAMETERS
-------------------
default_server_name
  Name of matrix homeserver to connect to, defaults to 'matrix.org'.

default_server_url
  URL of matrix homeserver to connect to, defaults to 'https://matrix-client.matrix.org'.

owner
  Owner of the deployed files, passed to `chown`. Defaults to 'root'.

brand
  Web UI branding, defaults to 'Element'.

default_country_code
  ISO 3166 alpha2 country code to use when showing country selectors, such as
  phone number inputs. Defaults to GB.

privacy_policy_url
  Defaults to 'https://element.io/privacy'.

cookie_policy_url
  Defaults to 'https://matrix.org/docs/guides/element_im_cookie_policy'.

jitsi_domain
  Domain name of preferred Jitsi instance (default is jitsi.element.im). This is
  used whenever a user clicks on the voice/video call buttons.

homepage
  Path to custom homepage, displayed once logged in.

welcomepage
  Path to custom welcome (= login) page.

custom_asset
  Serve a file a the top-level directory (e.g. /my-custom-logo.svg). Can be specified multiple times.

BOOLEAN PARAMETERS
-------------------
disable_custom_urls
  Disallow the user to change the default homeserver when signing up or logging in.

EXAMPLES
--------

.. code-block:: sh

    __matrix_element my-element --install_dir /var/www/element-web --version 1.5.6


SEE ALSO
--------
- `cdist-type__matrix_synapse(7) <cdist-type__matrix_synapse.html>`_


AUTHORS
-------
Timothée Floure <timothee.floure@ungleich.ch>


COPYING
-------
Copyright \(C) 2019 Timothée Floure. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
