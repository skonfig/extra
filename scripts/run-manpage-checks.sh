#!/bin/sh

# Move to top-level cdist-contrib directory.
cd $(dirname $0)/..

# Check that each type has a man page.
status=0
for t in type/*; do
	if [ ! -f "$t/man.rst" ]; then
		echo "No manpage for type $t!"
		status=1
	fi
done

exit $status
