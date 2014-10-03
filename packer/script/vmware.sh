#!/bin/bash -eux

echo "==> Installing VMware Tools"

# remove fuse if needed
yum erase -y fuse

# install vmware tools
cd /tmp
mkdir -p /mnt/cdrom
mount -o loop /home/vagrant/linux.iso /mnt/cdrom
tar zxf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
/tmp/vmware-tools-distrib/vmware-install.pl --default
rm /home/vagrant/linux.iso
umount /mnt/cdrom
rmdir /mnt/cdrom
rm -rf /tmp/VMwareTools-*

# cleanup
echo "==> Removing packages needed for building guest tools"
yum -y remove gcc cpp kernel-devel kernel-headers perl