#!/bin/sh

SHELLCHECKCMD="shellcheck -s sh -f gcc -x"
# Skip SC2154 for variables starting with __ since such variables are cdist
# environment variables.
SHELLCHECK_SKIP=': __.*is referenced but not assigned.*\[SC2154\]'
SHELLCHECKTMP=".shellcheck.tmp"

check () {
	find type/ -type f $1 $2 -exec ${SHELLCHECKCMD} {} + | grep -v "${SHELLCHECK_SKIP}"  > "${SHELLCHECKTMP}"
	test ! -s "${SHELLCHECKTMP}" || { cat "${SHELLCHECKTMP}"; exit 1; }
}

check -path "*/explorer/*"
check -path "*/files/*"
check -name manifest
check -name gencode-local
check -name gencode-remote
