#!/bin/bash -eux

echo "==> Installing Ruby for EC2 AMI Tools"
yum install -y ruby

echo "==> Installing EC2 AMI Tools"
yum install -y "http://s3.amazonaws.com/ec2-downloads/ec2-ami-tools.noarch.rpm"