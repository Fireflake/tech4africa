# make sure that vim is installed
package { ['vim-common', 'vim-enhanced']:
  ensure => present,
}

# needed as the allow_virtual parameter will change, so we set it explictly
if versioncmp($::puppetversion,'3.6.1') >= 0 {
  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

# include our modules
# if this is a webserver, go full out
if 'apache' in $server_roles {
  include apache
  include php
  include rpmforge
}

# if this is not a vagrant server, go full out
if 'aws-app' in $server_roles {
  include application
  include mysql-client
}

# if we need mysql, install that
if 'mysql' in $server_roles {
  include mysql
}

include users

