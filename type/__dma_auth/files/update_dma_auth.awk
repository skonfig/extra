#!/usr/bin/awk -f
#
# 2020 Dennis Camera (dennis.camera at riiengineering.ch)
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

function getvalue(path) {
	# Reads the first line of the file located at path and returns it.
	getline < path
	close(path)
	return $0
}

function print_should() {
	printf "%s|%s:%s\n", login_param, host_param, passwd_param
}

BEGIN {
	FS = "\n"
	DP = "[: \t]"  # copied from dma/conf.c

	parameter_dir = ENVIRON["__object"] "/parameter/"

	mode = (getvalue(parameter_dir "state") != "absent")

	host_param = ENVIRON["__object_id"]
	login_param = getvalue(parameter_dir "login")
	passwd_param = getvalue(parameter_dir "password")
}

# skip comments and empty lines
/^#/ || /^$/ {
	print
	next
}

{
	# parse line (like dma/conf.c would)

	login = substr($0, 1, index($0, "|") - 1)
	if (!login) { login = $0 }  # if no "|" found

	host = substr($0, length(login) + 2)

	if (match(host, DP)) {
		passwd = substr(host, RSTART + 1)
		host = substr(host, 1, RSTART - 1)
	} else {
		passwd = ""
	}
}

host == host_param {
	if (mode) {
		# state_should == present
		if (!written) {
			# replace first line if host matches (but only if no line has
			# been written already -> no duplicates)
			print_should()
			written = 1
		}
		next
	} else {
		# state_should == absent
		next
	}
}

# leave other lines alone
{
	print
}

END {
	if (mode && !written) {
		# append line if no match to replace was found
		print_should()
	}
}
