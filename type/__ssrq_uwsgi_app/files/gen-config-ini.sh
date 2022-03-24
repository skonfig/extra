#!/bin/sh -e

NL=$(printf '\n!'); NL=${NL%!}

add_param() {
	_PARAMS=${_PARAMS}${_PARAMS:+${NL}}${1}\ ${2}${3:+ }${3}
}

comma_join() { sed -e :a -e '$!N' -e 's/\n/,/' -e ta; }

add_param buffer-size uint
add_param cap str comma_join
add_param chdir str
add_param check-static str_multiple
add_param enable-threads bool
add_param env str_multiple
add_param gid str
add_param harakiri uint
add_param home str
add_param http str_multiple
add_param http-modifier1 uint
add_param http-modifier2 uint
add_param http-socket str
add_param http-to str_multiple
add_param http-to-https str
add_param lazy bool
add_param lazy-apps bool
add_param manage-script-name bool
add_param max-requests uint
add_param max-requests-delta uint
add_param max-worker-lifetime uint
add_param min-worker-lifetime uint
add_param module str
add_param mount str_multiple
add_param processes uint
add_param plugin str comma_join
add_param pythonpath str
add_param rack str
add_param route-if str_multiple
add_param ruby-require str_multiple
add_param shared-socket str_multiple
add_param skip-atexit bool
add_param skip-atexit-teardown bool
add_param static-map str_multiple
add_param threads uint
add_param thunder-lock bool
add_param touch-workers-reload str
add_param uid str
add_param uwsgi-socket str
add_param vacuum bool
add_param workers uint
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

	test -n "${value-}" || continue

	case ${type}
	in
		(int)
			printf '%s = %d\n' "${param}" "${value}"
			;;
		(uint)
			printf '%s = %u\n' "${param}" "${value}"
			;;
		(bool|str)
			# only print boolean options if they differ from the default
			test -f "${__object:?}/parameter/${param}" || continue

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
