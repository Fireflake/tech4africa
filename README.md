Tech4Africa Demo Repo
=========

This is a demo repo for my Tech4Africa talk. It's a collection of examples for:
- [Puppet]
- [Packer]
- [build-cloud]
- [Fog] and
- [Vagrant]

Version
----

0.1

Installation
--------------

```sh
git clone https://github.com/Fireflake/tech4africa tech4africa
cd tech4africa
```

##### Setup Configurations
There are 4 configuration files that will need renaming and changing.

* build-cloud/tech4africa.sample.yml
* puppet/modules/application/files/local.sample.xml
* packer/centos65-local.sample.json
* centos65-ec2.sample.json

You will need to remove the "sample" string in the filename, like so
```sh
cp build-cloud/tech4africa.sample.yml build-cloud/tech4africa.yml
```

The details in these files that need changing for sure are the variable placeholder in CAPS.

##### Setup Packer

* put your AWS x509 keys into packer/keys (x509.cert, x509.key)
* create a file called *set_keys.sh* with below content

Example:

```sh
#!/bin/sh
echo 'Setting up access keys via environment!'
export AWS_ACCESS_KEY_ID=YOURKEY
export AWS_SECRET_ACCESS_KEY=YOURSECRETKEY
echo 'All done!'
```

And import into your current session via:
```sh
. set_keys.sh
```

##### Setup Authorization for build-cloud

* create a file called *set_keys.sh* with below content

Example:

```sh
#!/bin/sh
echo 'Setting up access keys via environment!'
export AWS_ACCESS_KEY=YOURKEY
export AWS_SECRET_KEY=YOURSECRETKEY
echo 'All done!'
```

And import into your current session via:
```sh
. set_keys.sh
```

Running the examples
--------------
Always make sure that your access keys are in your terminal environment if you want to connect to AWS.

##### Running packer
```sh
cd packer
packer build centos65-ec2.json
```

##### Running vagrant
You *might* need to replace the config.vm.box path in your .Vagrantfile to match your generated local Vagrant box file.

In the directory of your .Vagrantfile run
```sh
mkdir www
vagrant up
```

##### Running build-cloud
```sh
cd build-cloud
build-cloud -c tech4africa.yml --all --create
```

[Puppet]:http://puppetlabs.com/
[Packer]:http://www.packer.io/
[build-cloud]: https://github.com/scalefactory/build-cloud/
[Fog]: http://fog.io/
[Vagrant]: http://www.vagrantup.com/
[git-repo-url]: https://github.com/Fireflake/tech4africa