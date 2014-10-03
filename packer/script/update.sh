#!/bin/bash -eux
# apply updates
echo "==> Please wait while we apply all updates"
yum -y update

# reboot
echo "Rebooting the machine..."
reboot
sleep 60