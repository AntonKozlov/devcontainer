#!/bin/sh

username="user"
groupname="${username}_group"
homedir="/home/$username"
# provided in docker run
target_dir="$WORKSPACE"

# UID/USER setup
uid=$(stat -c %u $target_dir)
gid=$(stat -c %g $target_dir)

mkdir -p $homedir
chown -R $uid:$gid $homedir

if awk -F : -v gid=$gid '$3 == gid { exit 1 }' /etc/group; then 
	echo "$groupname:x:$gid:" >> /etc/group
fi

for s in bash sh; do
	shell=$(which $s 2>/dev/null) && break
done
	
echo "$username:x:$uid:$gid::$homedir:$shell" >> /etc/passwd

if [ $uid = 0 ] && [ $gid = 0 ]; then
	cp -r $homedir/* /root/
fi

# some of setups below may be not relevant for particular containers, i.e. 
# package missing.  We'll provide harmless and check package available
# otherwise

# sudo
echo "$username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# opensshd 

mkdir -p /var/run/sshd

