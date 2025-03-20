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

function comment_line(line) {
	# returns the position in line at which the comment's text starts
	# (0 if the line is not a comment)
	match(line, /^[ \t]*\#+[ \t]*/)
	return RSTART ? (RLENGTH + 1) : 0
}
function empty_line(line) { return line ~ /^[ \t]*$/ }
function is_word(s) { return s ~ /^[A-Z_]+$/ }  # "looks like a plausible word"

function first(line, sep_re) {
	# returns the part of the line until sep is found
	# (or the whole line if sep is not found)
	if (!sep_re) sep_re = "[" SUBSEP "]"
	match(line, sep_re)
	return RSTART ? substr(line, 1, RSTART - 1) : line
}

function rest(line, sep_re) {
	# returns the part of the line after the first occurrence of sep is found.
	# (or nothing if sep is not found)
	if (!sep_re) sep_re = "[" SUBSEP "]"
	if (match(line, sep_re))
		return substr(line, RSTART + RLENGTH)
}

function conf_pop(word, value) {
	# returns the next value for the config `word` and delete it from the list.
	# if value is set, this function will only return value if it is the first
	# option in the list, otherwise it returns 0.

	if (!(word in conf)) return 0
	if (!value) {
		if (index(conf[word], SUBSEP))  # more than one element?
			value = substr(conf[word], 1, index(conf[word], SUBSEP) - 1)
		else
			value = conf[word]
	}

	if (index(conf[word], SUBSEP)) {
		if (index(conf[word], value SUBSEP) != 1) return 0
		conf[word] = substr(conf[word], length(value) + 2)
	} else {
		if (conf[word] != value) return 0
		delete conf[word]
	}
	return value
}

function print_conf(word, value) {
	# print a config line with the given parameters
	printf "%s", word
	if (value) printf " %s", value
	printf "\n"
}

function print_confs(word,    value) {
	# print config lines for all values stored in conf[word].
	if (!(word in conf)) return
	if (conf[word]) {
		while (value = conf_pop(word))
			print_conf(word, value)
	} else {
		print_conf(word)
		delete conf[word]
	}
}

BEGIN {
	FS = "\n"
	EQS = "[ \t]"  # copied from dma/conf.c

	if (ARGV[2]) exit (e=1)

	# Loop over file twice!
	ARGV[2] = ARGV[1]
	ARGC++

	# read the "should" state into the `conf` array.
	while (getline < "/dev/stdin") {
		word = first($0, EQS)
		if ((word in conf))
			conf[word] = conf[word] SUBSEP rest($0, EQS)
		else
			conf[word] = rest($0, EQS)
	}
}

# first pass, gather information about where which information is stored in the
# current config file. This information will be used in the second pass.
NR == FNR {
	if (comment_line($0)) {
		# comment line
		word = first(substr($0, comment_line($0)), " ")
		if (is_word(word)) last_occ["#" word] = FNR
	} else {
		word = first($0, EQS)
		if (is_word(word)) last_occ[word] = FNR
	}
}

# before second pass prepare hashes containing location information to be used
# in the second pass.
NR > FNR && FNR == 1 {
	# First we drop the locations of commented-out options if a non-commented
	# option is available. If a non-commented option is available, we will
	# append new config options there to have them all at one place.
	for (k in last_occ)
		if (k ~ /^\#/ && (substr(k, 2) in last_occ))
			delete last_occ[k]

	# Reverse the option => line mapping. The line_map allows for easier lookups
	# in the second pass.
	for (k in last_occ) line_map[last_occ[k]] = k
}

# second pass, generate and output new config
NR > FNR {
	if (comment_line($0) || empty_line($0)) {
		# comment or empty line
		print

		if ((FNR in line_map)) {
			if (line_map[FNR] ~ /^\#/) {
				# This line contains a commented config option. If the conf hash
				# contains options to be set, we output them here because this
				# option is not used in the current config.
				k = substr(line_map[FNR], 2)
				if ((k in conf)) print_confs(k)
			}

			if (("INSECURE" in conf) && line_map[FNR] ~ /^\#?SECURE$/) {
				# INSECURE goes where SECURE comment is.
				print_confs("INSECURE")
			}
		}
	} else {
		word = first($0, EQS)
		value = rest($0, EQS)
		sub(/[ \t]*\#.*$/, "", value)  # ignore comments in value

		if ((word in conf) && value == first(conf[word])) {
			# keep config options we want
			conf_pop(word)
			print
		}

		if ((FNR in line_map) && line_map[FNR] == word) {
			# rest of config options should be here
			print_confs(word)
		}
	}
}

END {
	if (e) exit

	# print rest of config options (
	for (word in conf) print_confs(word)
}
