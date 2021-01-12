#!/bin/sh -eu

SHELLCHECKCMD='shellcheck -s sh -f gcc -x'
# Skip SC2154 for variables starting with __ since such variables are cdist
# environment variables.
SHELLCHECK_SKIP=': __.*is referenced but not assigned.*\[SC2154\]'
SHELLCHECKTMP='.shellcheck.tmp'

# Move to top-level cdist-contrib directory.
cd "$(dirname $0)"/..

check() {
	find type/ -type f "$@" -exec ${SHELLCHECKCMD} {} + \
	| grep -v "${SHELLCHECK_SKIP}" >>"${SHELLCHECKTMP}" || true
}

rm -f "${SHELLCHECKTMP}"

check -path '*/explorer/*'
check -path '*/files/*' -name '*.sh'
check -name manifest
check -name gencode-local
check -name gencode-remote

if test -s "${SHELLCHECKTMP}"
then
	cat "${SHELLCHECKTMP}" >&2
	exit 1
fi
