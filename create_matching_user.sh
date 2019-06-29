#!/bin/sh
user=$1
target_dir=$2
home=/home/$user
group=${user}_group
uid=$(stat -c %u $target_dir)
gid=$(stat -c %g $target_dir)

mkdir -p $home
chown -R $uid:$gid $home

if ! getent group $gid; then
	groupadd -g $gid $group
fi

if [ $uid = 0 ] && [ $gid = 0 ]; then
	rmdir /root
	ln /home/$user /root
fi

useradd -o -u $uid -g $gid -G sudo -d $home -s /bin/bash $user

