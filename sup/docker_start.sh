#!/usr/bin/env bash

dockerimage=${1}
contname=${2:-dc}
workspace=${3:-/p}

if [ $BASH_SOURCE = $0 ]; then
	echo "Please source the script, like " >&2
	echo "$ . $0" >&2
	exit 1
fi

if [ -z "$dockerimage" ]; then
	echo "Please provide image to use, like" >&2
	echo "$ . $BASH_SOURCE ubuntu" >&2
	return
fi

docker run -d --privileged \
	--name "$contname" \
	-e "WORKSPACE=$workspace" \
	-p 2222:22 \
	-v "$PWD:$workspace" \
	$dockerimage

export DC_NAME=$contname
. $(dirname $BASH_SOURCE)/docker_rc.sh

# wait till docker started, otherwise getting "No 'user' user found"
waittries=${DOCKER_START_WAIT_TIME_SEC:-10}
started=0
while [ 0 -lt $waittries ]; do
	if dr true 2>/dev/null 1>/dev/null; then
		started=1
		break;
	fi
	sleep 1
	waittries=$(($waittries - 1))
done

if [ x0 = x$started ]; then
	echo "Container is not stated for some time, trying one more time in verbose mode" >&2
	echo "If it fail, try to change timeout specifying DOCKER_START_WAIT_TIME_SEC env, like" >&2
	echo "" >&2
	echo "$ DOCKER_START_WAIT_TIME_SEC=60 $0 $*" >&2
	dr true && started=1
fi

if [ x0 = x$started ]; then
	echo "Can't start container" >&2
	exit 1
fi

echo "Initialized container $DC_NAME"
