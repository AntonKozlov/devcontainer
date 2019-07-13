
Container-based development environment from any docker image

# Motivation

1. Quick setup: current directory is mounted into container, a-la Vagrant
2. Solves uid/gid problem: no more `chmod` in host OS on files generated in container. For that, a user created in container, which uid and gid are match to owner of current directory.

# Usage

```
$ . devcontainer ubuntu:14.04
$ dr cat /etc/release
# Ubuntu 14.04.6 LTS \n \l
```

Usual workflow:

```
$ cd myproject
$ . devcontainer ubuntu:14.04
$ dr make # start the build
```

Interactive session:

```
$ dr sh # or bash, or ...
```

If you accidentally lost a terminal with devcontainer setup (suppose container name or hash is `mycont`):

```
$ . devcontainer -C mycont
```

If you like other alias name (alias binds to specific container):

```
$ . devcontainer -a ra alpine
$ . devcontainer -a ru ubuntu
$ du cat /etc/issue
Ubuntu 18.04.2 LTS \n \l
$ da cat /etc/issue
Welcome to Alpine Linux 3.10
Kernel \r on an \m (\l)
```

Docker by default uses <kbd>CTRL</kbd>+<kbd>P</kbd> as detach prefix. If you want to change the prefix, i.e. to more pleasant work in interactive session with Emacs-like shortcuts:

```
$ . devcontainer -e "--detach-keys ctrl-_"
```

