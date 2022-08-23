#!/bin/sh -e
#
# 2022 Dennis Camera (dennis.camera at ssrq-sds-fds.ch)
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
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with skonfig-extra. If not, see <http://www.gnu.org/licenses/>.
#
# determines the current switch state using the "attributes" explorer’s output
# and object parameters.
#

RS=$(printf '\036')

test -s "${__object:?}/explorer/attributes" || {
	# empty output -> switch is absent
	echo absent
	exit 0
}

# compare attributes

# name

if test -s "${__object:?}/parameter/name"
then
	read -r name_should <"${__object:?}/parameter/name"
else
	name_should=${__object_id:?}
fi

grep -qxF "switch=${name_should}" "${__object:?}/explorer/attributes" || {
	echo 'different'
	exit 0
}


# compiler

if test -s "${__object:?}/parameter/compiler"
then
	read -r compiler_should <"${__object:?}/parameter/compiler"
fi
compiler_is=$(sed -n -e 's/^compiler=//p' <"${__object:?}/explorer/attributes")

case ${compiler_should}
in
	(*.*) ;;  # --compiler includes a version number
	(*)  # no version number in --compiler, don't compare version numbers
		compiler_is=${compiler_is%%.[0-9]*} ;;
esac

test "${compiler_should}" = "${compiler_is}" || {
	echo 'different'
	exit 0
}


# description

if test -f "${__object:?}/parameter/description"
then
	# concat multiple lines to a single one by using RS instead of NL
	_v=$(LC_ALL=C tr '\n' "${RS}" <"${__object:?}/parameter/description")
	_v=${_v%"${RS}"}
else
	_v=
fi

grep -qxF "description=${_v}" "${__object:?}/explorer/attributes" || {
	echo 'different'
	exit 0
}


echo 'present'
