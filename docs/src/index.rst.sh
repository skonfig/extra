#!/bin/sh

__cdist_pwd="$(pwd -P)"
__cdist_mydir="${0%/*}";
__cdist_abs_mydir="$(cd "$__cdist_mydir" && pwd -P)"
__cdist_myname=${0##*/};
__cdist_abs_myname="$__cdist_abs_mydir/$__cdist_myname"

filename="${__cdist_myname%.sh}"
dest="$__cdist_abs_mydir/$filename"

if ! command -v pandoc > /dev/null; then
	echo "Pandoc is required to generate HTML index from README." >&2
	exit 1
fi

cd "$__cdist_abs_mydir"

exec > "$dest"

pandoc -f markdown -t rst ../../README.md

cat << EOF

.. toctree::
   :hidden:

EOF

# If there is no such file then ls prints error to stderr,
# so redirect stderr to /dev/null.
for type in $(ls man7/cdist-type__*.rst 2>/dev/null | LC_ALL=C sort); do
    no_dir="${type#man7/}";
    no_type="${no_dir#cdist-type}";
    name="${no_type%.rst}";
    manref="${no_dir%.rst}"
    man="${manref}(7)"

    echo "      $name" "<man7/${manref}>"
done
