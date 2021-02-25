#!/bin/sh -e

NL=$(printf '\n!'); NL=${NL%!}

add_param() {
	_PARAMS=${_PARAMS}${_PARAMS:+${NL}}${1}\ ${2}${3:+ }${3}
}

comma_join() { sed -e :a -e '$!N' -e 's/\n/,/' -e ta; }

add_param cap str comma_join
add_param chdir str
add_param enable-threads bool
add_param env str_multiple
add_param gid str
add_param harakiri uint
add_param home str
add_param http-socket str
add_param max-requests uint
add_param module str
add_param processes uint
add_param plugin str comma_join
add_param pythonpath str
add_param threads uint
add_param uid str
add_param uwsgi-socket str
add_param vacuum bool
add_param wsgi-file str


################################################################################

printf '[uwsgi]\n'

while read -r param type preproc
do
	if test "${type}" = 'bool'
	then
		value=$(test -f "${__object:?}/parameter/${param}" \
			&& echo true || echo false)
	elif test -f "${__object:?}/parameter/${param}"
	then
		if test -n "${preproc}" && ! command -v "${preproc}" >/dev/null 2>&1
		then
			printf 'Function not defined: %s\n' "${preproc}" >&2
			exit 1
		fi

		value=$("${preproc:-cat}" <"${__object:?}/parameter/${param}")
	else
		unset value
	fi

	case ${type}
	in
		(int)
			test -n "${value-}" || continue

			printf '%s = %d\n' "${param}" "${value}"
			;;
		(uint)
			test -n "${value-}" || continue

			printf '%s = %u\n' "${param}" "${value}"
			;;
		(bool|str)
			# only print boolean options if they differ from the default
			test -f "${__object:?}/parameter/${param}" || continue
			test -n "${value-}" || continue

			printf '%s = %s\n' "${param}" "${value}"
			;;
		(str_multiple)
			while read -r line
			do
				printf '%s = %s\n' "${param}" "${line}"
			done <<-EOF
			${value}
			EOF
			;;
	esac
done <<EOF
$(printf '%s\n' "${_PARAMS}" | sort -t ' ' -k 1)
EOF

# socket = $apphome/uwsgi.sock
# chdir = $apphome
# wsgi-file = $projectname/wsgi.py
# touch-reload = $projectname/wsgi.py
# processes = 4
# threads = 2
# chmod-socket = 666
# daemonize=true
# vacuum = true
# uid = $user
# gid = $user
