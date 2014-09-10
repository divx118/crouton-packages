#!/bin/sh
# This script will add the repo to your sources, download
# and install the kernel headers appropriate to your
# kernel version and architecture.
# check if script is run as root
uid=`id -u $USERNAME`
if [ $uid -ne 0 ]; then
  echo "$0 must be run as root"
  exit 1
fi
BRANCH="master"
TMP_DIST="./tmp_dist"
echo "# This script will add the repo to your sources, download
and install the kernel headers appropriate to your
kernel version and architecture."
apt-get install -y apt-transport-https
wget -O - "https://raw.github.com/divx118/crouton-packages/$BRANCH/mauricevankruchten@gmail.com.gpg.key" | apt-key add -
wget -O $TMP_DIST "https://raw.github.com/divx118/crouton-packages/$BRANCH/conf/distributions"
KERNEL="`uname -r`"
echo $KERNEL
ARCH="`uname -m | sed -e 's i.86 i386 ;s arm.* arm ;s x86_64 amd64 ;'`"
echo $ARCH
# split distributions file in multiple files to parse.
csplit $TMP_DIST -s '/^$/' {*}
supported=0
# FIXME need path.
for f in `ls xx*`;do
  if [ "x`cat $f|grep Codename|cut -d " " -f 2-`" = "x$KERNEL" ]; then
    if [ "x`cat $f|grep Architectures|cut -d " " -f 2-|grep -o $ARCH`" = "x$ARCH" ]; then
      supported=1
      break
    fi
  fi
done

# cleanup
rm xx*
rm $TMP_DIST

if [ $supported -eq 0 ]; then
  echo "Your kernel version $KERNEL with architecture $ARCH is not supported"
  exit 1
fi
# Adding the ppa to apt sources.
echo "deb https://raw.github.com/divx118/crouton-packages/$BRANCH/ $KERNEL main" > /etc/apt/sources.list.d/crouton-packages.list
apt-get update
# umount bindmounts /lib/modules from enter-chroot
for m in `cat /proc/mounts | /usr/bin/cut -d ' ' -f2 | grep /lib/modules| grep -v "^/$" `; do
        umount "$m"
done
apt-get install -y linux-headers-$KERNEL
apt-get install -y linux-image-$KERNEL
# get rc.local
if [ -f /etc/rc.local ]; then
  mv --backup=numbered /etc/rc.local /etc/rc.local.old
  echo "============================================================================"
  echo "If you made any changes to rc.local, then you should reapply them in the new
/etc/rc.local. Your old file is named /etc/rc.local.old."
  echo "============================================================================"
fi
wget -O /etc/rc.local "https://raw.github.com/divx118/crouton-packages/$BRANCH/rc.local"
echo "======================================================================================"
echo "All done now, you can install virtualbox. Note that you need to log out of your chroot
and start it again to load the modules needed for virtualbox."
echo "======================================================================================"


exit 0
