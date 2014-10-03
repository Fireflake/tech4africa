# vagrant/puppet/modules/application/manifests/init.pp

# do an initial deploy for your application
# ideally this should be done via capistrano or something similiar
# for our demo we'll just git clone

class application {
  # git clone might throw an error if this already exists, so make sure it doesn't
  file { '/var/www/magento.dev':
    ensure => absent,
    force => true
  }

  # lets make sure that git is actually installed
  package { "git":
    name => "git-all",
    ensure => "present"
  }

  # let's clone our repo
  exec { 'git-clone':
    command => "/usr/bin/git clone https://github.com/Fireflake/tech4africa-www.git /var/www/magento.dev",
    require => [ Package['git'], File['/var/www/magento.dev'] ]
  }

  # add a phpinfo file
  file { '/var/www/magento.dev/flotest.php':
    content => "<?php phpinfo();",
    require => Exec['git-clone']
  }

  # add the magento config xml
  file { '/var/www/magento.dev/app/etc/local.xml':
    source => 'puppet:///modules/application/local.xml',
    require => Exec['git-clone']
  }
}