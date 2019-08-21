#!/bin/bash
set -e

HOST=${HOST:-""}
USER=${USER:-""}
PASSWORD=${PASSWORD:-""}
INTERVAL=${INTERVAL:-"60"}

CACHED_IPV4=''
CACHED_IPV6=''

# Make sure credentials are specified
if [[ -z "${USER// }" ]] || [[ -z "${PASSWORD// }" ]]; then
	echo "error: USER and PASSWORD must be provided" >&2
	exit 1
fi

# Make sure location is specified
if [[ -z "${HOST// }" ]] && [[ -z "${LOCATION// }" ]]; then
	echo "error: LOCATION or HOST must be provided" >&2
	exit 2
fi

# Make sure Interval is correct
if [[ $INTERVAL != [0-9]* ]]; then
   echo "error: Invalid INTERVAL ${INTERVAL}" >&2
   exit 3
fi

while :
do

	ADDRESS="https://api.dynu.com/nic/update?username=${USER}&password=${PASSWORD}"

	# IPv4
	ipv4=$(curl -s https://api.ipify.org)
	if [[ ! -z "${ipv4// }" ]]; then
		echo "My public IPv4 address is: $ipv4"
		ADDRESS="${ADDRESS}&myip=${ipv4}"
	fi

	#IPv6
	ipv6=$(curl -s https://api6.ipify.org)
	if [[ ! -z "${ipv6// }" ]] && [[ ! $ipv6 == *"."* ]]; then
		echo "My public IPv6 address is: $ipv6"
		ADDRESS="${ADDRESS}&myipv6=${ipv6}"
	fi

	if [[ $ipv4 == $CACHED_IPV4 ]] && [[ $ipv6 == $CACHED_IPV6 ]]; then
		echo 'Address not changed. Skiping refresh.'
	else
		# Hostname
		if [[ ! -z "${HOST// }" ]]; then
			ADDRESS="${ADDRESS}&hostname=${HOST}"
		fi

		# Location
		if [[ ! -z "${LOCATION// }" ]]; then
			ADDRESS="${ADDRESS}&location=${LOCATION}"
		fi

		curl -s --verbose ${ADDRESS}

		CACHED_IPV4=$ipv4
		CACHED_IPV6=$ipv6
	fi

	if [ $INTERVAL -eq 0 ]
	then
		break
	else
		sleep "${INTERVAL}"
	fi

done