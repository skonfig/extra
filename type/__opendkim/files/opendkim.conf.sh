#!/bin/sh -e
# Generate an opendkim.conf(5) file for opendkim(8).


# Optional chdir(2)
if [ "$BASEDIR" ];
then
	printf "BaseDirectory %s\n" "$BASEDIR"
fi

# Optional canonicalization settings
if [ "$CANON" ];
then
	case "$CANON" in
		"simple/simple")
			:
			;;
		"simple/relaxed")
			:
			;;
		"relaxed/simple")
			:
			;;
		"relaxed/relaxed")
			:
			;;
		*)
			echo "Invalid Canonicalization setting!" >&2
			exit 1
			;;
	esac
	printf "Canonicalization %s\n" "$CANON"
fi

# Key and Domain tables
echo 'KeyTable /etc/opendkim/KeyTable'
echo 'SigningTable /etc/opendkim/SigningTable'

# Required socket to listen on
printf "Socket %s\n" "${SOCKET:?}"

# Optional subdomain signing settings
if [ "$SUBDOMAINS" ];
then
	printf "SubDomains %s\n" "$SUBDOMAINS"
fi

# Optional request logging to syslog
if [ "$SYSLOG" ];
then
	echo "Syslog yes"
fi

# Optional UMask specification
if [ "$UMASK" ];
then
	printf "UMask %s\n" "$UMASK"
fi

# Optional UserID to change to
if [ "$USERID" ];
then
	printf "UserID %s\n" "$USERID"
fi
