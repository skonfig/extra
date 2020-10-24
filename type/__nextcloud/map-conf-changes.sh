#!/bin/sh -e
# __nextcloud/map-conf-changes.sh


# The environment variable "$install" should be set if nextcloud was installed
# now. This changes the behaviour to not trust gathered values from the
# explorer.


# Test if the value exists as given.
#
# Arguments:
#  1: The nextcloud config name
#  2: The value that should be set
#
# Return code:
#  0: value exactly matched
#  1: value not matched or do not exist
testparam() {
    # short-circuit after installation; the explorer may not be valid
    if [ "$install" ]; then return 1; fi

    if grep -q -F "$1 = $2" "$__object/explorer/config"; then
        return 0
    else
        return 1
    fi
}

# Test if the parameter is somehow set.
#
# Arguments:
#  1: The nextcloud config name
#
# Return code:
#  0: param exists
#  1: param not found
paramexist() {
    # short-circuit after installation; the explorer may not be valid
    if [ "$install" ]; then return 0; fi

    if grep -q "^$1 = " "$__object/explorer/config"; then
        return 0
    else
        return 1
    fi
}

# Base for the basic function types.
#
# Arguments:
#  1: cdist type parameter name
#  2: nextcloud config name
#  3: conditially mandatory argument, value "required" if true
#  4: occ printf pattern to set the value
#  5: "installation" default value, can be used to backup the user value
conf_base() {
    if [ -f "$__object/parameter/$1" ] || [ "$5" ]; then
        value="$(cat "$__object/parameter/$1" || printf "%s" "$5")"
        if ! testparam "$2" "$value"; then
            # set it because it does not exist
            # shellcheck disable=SC2059  # $4 contains patterns
            printf "php occ config:system:$4\n" "$2" "$value"
        fi
    else
        if [ "$3" = "required" ]; then
            # error because the parameter should be set
            printf "Parameter '%s' not set by user, but required!\n" "$1" >&2
            exit 4
        fi

        if paramexist "$2"; then
            # remove it because it exists
            printf "php occ config:system:delete '%s'\n" "$2"
        fi
    fi
}

# Set's the cdist parameter value to nextcloud as specific value.
#
# Arguments:
#  1: cdist type parameter name
#  2: nextcloud config name
#  3: conditional mandatory of this parameter; value "required" if true
#  4: default value; will be used if parameter is absent
conf_string() {
    conf_base "$1" "$2" "$3" "set '%s' --type=string --value='%s'" "$4"
}
conf_number() {
    conf_base "$1" "$2" "$3" "set '%s' --type=integer --value='%s'" "$4"
}
conf_decimal() {
    conf_base "$1" "$2" "$3" "set '%s' --type=double --value='%s'" "$4"
}

# Sets the nextcloud configuration option after a boolean cdist parameter.
#
# Arguments:
#  1: cdist type parameter name
#  2: nextcloud config name
# FIXME default value required for booleans?
conf_boolean() {
    # map parameter to a php boolean (are outputted as 0 or 1)
    if [ -f "$__object/parameter/$1" ]; then
        testval="1"
        value="true"
    else
        testval="0"
        value="false"
    fi

    if ! testparam "$2" "$testval"; then
        # set it if does not already exist
        printf "php occ config:system:set '%s' --type=boolean --value=%s\n" "$2" "$value"
    fi
}

# Corrects the array after all values given by the parameter. Values not given
# to this type will be removed.
#
# Arguments:
#  1: cdist type parameter name
#  2: nextcloud config name
#  3: conditional mandatory of this parameter; value "required" if true
# FIXME currently no default value due to complexity of arrays
conf_array() {
    if [ -f "$__object/parameter/$1" ]; then
        # reset array if installation is fresh
        if [ "$install" ]; then
            # just remove everything, because we don't know it
            printf "php occ config:system:delete '%s' || true\n" "$2"

            # counter is zero for sure
            counter=0

        # else, default behaviour of the array
        else
            # save counter of the next free index
            # shellcheck disable=SC1004  # the \ is required for awk
            counter=$( awk -v FS=" = " -v name="$2" '
                        BEGIN { counter = 0 }
                        split($1, header, "|") == 2 && header[1] ~ /^[[:digit:]]+$/ && header[2] == name \
                            { if(counter < header[1]) counter = header[1] }
                        END { print counter + 1 }
                        ' "$__object/explorer/config"
            )

            # create a file which contains all lines not already resolved by this function
            _dir="$__object/files/conf-arrays"
            mkdir -p "$_dir"
            grep "^[[:digit:]]*|$2 = " "$__object/explorer/config" > "$_dir/$2" || true  # ignore not found
        fi

        # iterate through every value
        while read -r value; do
            # check every value if he exists
            if ! grep -q "^[[:digit:]]*|$2 = $value$" "$__object/explorer/config"; then
                # add this value
                printf "php occ config:system:set '%s' '%s' --type=string --value='%s'\n" \
                    "$2" "$(( counter ))" "$value"
                counter=$(( counter + 1 ))
            fi

            if [ -z "$install" ]; then
                # removes it from the list of unhandled values
                grep -v "^[[:digit:]]*|$2 = $value$" "$_dir/$2" > "$_dir/$2_tmp" || true  # ignore not found
                mv "$_dir/$2_tmp" "$_dir/$2"  # because we can't do `cat foo > foo`
            fi
        done < "$__object/parameter/$1"

        if [ -z "$install" ]; then
            # interate through the leftover values
            # remove them, as they should not exist (at least can be)
            #
            # shellcheck disable=SC2034  # $equal left for readability
            while read -r start equal value; do
                # remove those specific elements from the array
                printf "php occ config:system:delete '%s' '%s' --error-if-not-exists\n" \
                    "$2" "$( printf "%s" "$start" | awk -F'|' '{print $1}' )"
            done < "$_dir/$2"
        fi
    else
        if [ "$3" = "required" ]; then
            # error because the parameter should be set
            printf "Parameter '%s' not set by user, but required!\n" "$1" >&2
            exit 4
        fi

        # remove everything because we don't know which was set by the user
        if paramexist "$2"; then
            # remove the whole array
            printf "php occ config:system:delete '%s'\n" "$2"
        fi
    fi
}

# Set the install variable if nextcloud was not installed before this type.
if ! testparam installed 1; then
    install="yes"
fi


# Map all parameters

# Generate the config changes

# misc
conf_array host trusted_domains

# Already set via the installer
# set default values from the nextcloud installer to do not override them
if [ -z "$install" ]; then
    # database
    database_type="$(cat "$__object/parameter/database-type")"
    case "$database_type" in
        sqlite3)
            conf_string database-type dbtype
            ;;

        mysql|pgsql)
            conf_string database-type dbtype
            conf_string database-host dbhost installdef "localhost"
            conf_string database-name dbname required
            conf_string database-user dbuser required
            conf_string database-password dbpassword required
            conf_string database-prefix dbtableprefix
            ;;

        *)
            printf "Databasetype '%s' is unkown!\n" "$database_type" >&2
            exit 3
            ;;
    esac

    # data-dir is handled in the gencode-remote
    #conf_string data-directory datadirectory installdef "$(cat "$__object/explorer/installdir")/$__object_id/data"
fi
