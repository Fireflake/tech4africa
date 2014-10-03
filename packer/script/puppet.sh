#!/bin/bash -eux

echo "==> Installing Puppet"
REDHAT_MAJOR_VERSION=$(egrep -Eo 'release ([0-9][0-9.]*)' /etc/redhat-release | cut -f2 -d' ' | cut -f1 -d.)

echo "==> Installing Puppet Labs repositories"
rpm -ipv "http://yum.puppetlabs.com/puppetlabs-release-el-${REDHAT_MAJOR_VERSION}.noarch.rpm"

echo "==> Installing latest Puppet version"
yum -y install puppet
