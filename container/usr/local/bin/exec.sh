#!/bin/sh

USER=$1
shift
. /home/$USER/.bashrc
exec "$@"

