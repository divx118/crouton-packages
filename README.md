This is a ubuntu/debian ppa for chromebook kernel headers.

Currently supported:
 * Kernel 3.4.0 Architecture arm, i386 and am64  ==> These all need testing.
 * Kernel 3.8.11 Architecture arm, i386 and am64 ==> amd64 is tested. i386 and arm needs testing.
 * Kernel 3.10.18 Architecture arm and amd64     ==> amd64 is tested. i386 and arm needs testing.

For being able to load modules outside /lib/modules from chromeos we will need to disable module_locking.
This can be done by changing the kernel flags. I wrote a little script that does this for you and also has the option to revert the changes.  
Open a **crosh** shell and follow on screen instructions:
```
$ cd ~/Downloads
$ wget https://raw.githubusercontent.com/divx118/crouton-packages/master/change-kernel-flags
$ sudo sh ~/Downloads/change-kernel-flags
```
When running `sudo sh ~/Downloads/change-kernel-flags -h` it will give you the usage. 
When you want to revert the changes so put back a backup kernel use -r  
`sudo sh ~/Downloads/change-kernel-flags -r`  

**Note:** You will need to repeat the above steps after each chromeos update.  

Open a shell in your **chroot**:

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
 
