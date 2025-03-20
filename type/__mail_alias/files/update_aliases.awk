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

function getvalue(path,    line) {
	# Reads the first line of the file located at path and returns it.
	getline line < path
	close(path)
	return line
}

function sepafter(f, def,    _) {
	# finds the separator between field $f and $(f+1)
	_ = substr($0, length($f)+1, index(substr($0, length($f)+1), $(f+1))-1)
	return _ ? _ : def
}

function write_aliases(    line) {
	if (aliases_written) return

	# print aliases line
	printf "%s%s", ENVIRON["__object_id"], sepafter(1, ": ")
	while ((getline line < aliases_should_file) > 0) {
		if (aliases_written) printf ", "
		printf "%s", line
		aliases_written = 1
	}
	printf "\n"
	close(aliases_should_file)
}

BEGIN {
	FS = ":[ \t]*"

	parameter_dir = ENVIRON["__object"] "/parameter/"

	mode = (getvalue(parameter_dir "state") != "absent")
	aliases_should_file = (parameter_dir "/alias")
}

/^[ \t]*\#/ {
	# comment line (leave alone)
	select = 0; cont = 0  # comments terminate alias lists and continuations
	print
	next
}

{
	# is this line a continuation line?
	# (the prev. line ended in a backslash or the line starts with whitespace)
	is_cont = /^[ \t]/ || cont

	# detect if the line is a line to be continued (ends with a backslash)
	cont = /\\$/
}

is_cont {
	# we only print the line if it has not been rewritten (select)
	if (!select) print
	next
}

$1 == ENVIRON["__object_id"] {
	# "target" user -> rewrite aliases list
	select = 1
	if (mode) write_aliases()
	next
}

{
	# other user
	select = 0
	print
}

END {
	# if the last line was an alias, the separator will be reused (looks better)
	if (mode && !aliases_written)
		write_aliases()
}
