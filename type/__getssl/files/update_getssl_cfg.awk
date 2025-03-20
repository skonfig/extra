#!/usr/bin/awk -f
#
# 2023 Dennis Camera (dennis.camera at riiengineering.ch)
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
# Updates a getssl.cfg file with given "should lines" on stdin.
#

# FIXME: This script does not handle multi-line options, e.g. bash arrays.

BEGIN {
	FS = RS

	# Store the should state read from stdin in should array
	while (("cat" | getline should_line)) {
		k = substr(should_line, 1, index(should_line, "=") - 1)
		v = substr(should_line, length(k) + 2)

		if (k !~ /^[A-Z_]+$/) {
			printf "Suspicious key: %s\n", k | "cat >&2"
			suspicious_keys = 1
		}

		should[k] = v
	}
	close("cat")
	if (suspicious_keys) exit (e=1)
}

{
	line = $0
	sub(/^[ \t]*/, "", line)

	is_comment = (line ~ /^#/)

	if (is_comment) {
		# keep comments
		print
		sub(/^#*[ \t]*/, "", line)
	}
}

line {
	key = substr(line, 1, index(line, "=") - 1)
	value = substr(line, length(key) + 2)

	if ((key in should)) {
		# update option
		if (should[key] != value || is_comment) {
			printf "%s=%s\n", key, should[key]
		} else {
			print  # keep line
		}
		delete should[key]
		next
	} else {
		# drop option
		next
	}
}

# Do not print comments, they have already been printed above
!is_comment { print }

END {
	if (!e) {
		for (key in should) {
			printf "%s=%s\n", key, should[key]
		}
	}
}
