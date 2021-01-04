#!/bin/sh

__cdist_pwd="$(pwd -P)"
__cdist_mydir="${0%/*}";
__cdist_abs_mydir="$(cd "$__cdist_mydir" && pwd -P)"
__cdist_myname=${0##*/};
__cdist_abs_myname="$__cdist_abs_mydir/$__cdist_myname"

filename="${__cdist_myname%.sh}"
dest="$__cdist_abs_mydir/$filename"

cd "$__cdist_abs_mydir"

exec > "$dest"
cat << EOF
cdist-contrib - Community maintained cdist types
================================================

This project extends the \`cdist <https://cdi.st/>\`_ configuration management
tool with community-maitained types which are either too specific to fit/be
maintained in cdist itself or were not accepted in code cdist but could still
be useful.

Please note this project is a **rolling release**! The documentation you're
reading has been generated from the |version| state (commit |release|).
Sources are available on \`code.ungleich.ch
<https://code.ungleich.ch/ungleich-public/cdist-contrib>\`_.


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
