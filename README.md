This is a ubuntu/debian ppa for chromebook kernel headers.

Currently supported:
 * Kernel 3.4.0 Architecture arm, i386 and am64 These all need testing.
 * Kernel 3.8.11 Architecture arm, i386 and am64 amd64 is tested i386 and arm needs testing
 * kerenl 3.10.18 Architecture arm and amd64 These all need testing.

Open a shell in your chroot:

```
$ cd ~
$ wget https://raw.githubusercontent.com/divx118/crouton-packages/master/setup-headers.sh
$ sudo sh setup-headers.sh
```

This script will: 
 * add my signing key with which the packages are signed.
 * add the ppa to the sources.list.d
 * install linux-headers-
 * install linux-image-
 * add a rc.local script to load vboxdrv modules on entering the chroot if they are available.

Kernel headers are build according to this guide https://github.com/dnschneid/crouton/wiki/Build-kernel-headers-and-install-Virtualbox-(x86) kernel headers for arm are cross compiled.
 
