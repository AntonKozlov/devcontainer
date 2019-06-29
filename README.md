
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

If you accidentally lost a terminal with devcontainer setup (suppose container name is `mycontname`): 

```
$ . devcontainer -n mycontname
```

If you like other alias name instead of `dr` (for example, `rundoc`):

```
$ . devcontainer -a rundoc ...
```

Docker by default uses <kbd>CTRL</kbd>+<kbd>P</kbd> as detach prefix. If you want to change the prefix, i.e. to more pleasant work in interactive session with Emacs-like shortcuts:

```
$ . devcontainer -e "--detach-keys ctrl-_"
```

