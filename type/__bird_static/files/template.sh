#!/bin/sh
#
# 2021 Joachim Desroches (joachim.desroches at epfl.ch)
#
# This file is part of skonfig-extra.
#
# skonfig-extra is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# skonfig-extra is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with skonfig-extra. If not, see <http://www.gnu.org/licenses/>.
#
# Template to generate a static protocol configuration file for bird(1).
# Required non-empty variables:
# __object_id, object
#
# Required defined variables:
# description
#

# Header
printf "protocol static %s {\n" "${__object_id:?}"

# Optional description
[ -n "${description?}" ] && printf "\tdescription \"%s\";\n" "${description:?}"

# Channel choice
printf "\t%s;\n" "$(cat "${__object:?}/parameter/channel")"

# Routes
while read -r route
do
	printf "\troute %s;\n" "${route?}"
done < "${__object:?}/parameter/route"

# Header close
printf "}\n"
