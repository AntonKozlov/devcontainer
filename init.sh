#!/bin/sh

/usr/local/sbin/create_matching_user.sh user $WORKSPACE

mkdir -p /var/run/sshd
exec /usr/sbin/sshd -D
