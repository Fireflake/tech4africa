# vagrant/puppet/modules/php/manifests/init.pp

class php {
  # Install the php5-fpm and php5-cli packages
  # Let's make sure that apache is installed first
  package { ['php-fpm', 'php-cli']:
    ensure => present,
    require => Package['httpd']
  }

  # install needed modules for Magento
  package { ['php-mysql', 'php-mcrypt', 'php-gd', 'php-soap', 'php-xml']:
    ensure => present,
    require => Package['php-fpm'],
    notify => Service['php-fpm'],
  }

  # Make sure php5-fpm is running
  service { 'php-fpm':
    ensure => running,
    require => Package['php-fpm'],
    enable => true,
  }

  # get the mod_fastcgi module from rpmforge
  package {'mod_fastcgi':
    ensure => present,
    require => [Package['rpmforge-release'], Package['php-fpm']],
    notify => Service['httpd'],
  }

  # add our fastcgi configuration to apache
  file { 'vagrant-fastcgi':
    path => '/etc/httpd/conf.d/fastcgi.conf',
    ensure => file,
    require => Package['php-fpm'],
    group => 'root',
    source => 'puppet:///modules/php/fastcgi.conf',
    notify => Service['httpd'],
  }

  # make sure that the fastcgi path exists
  file { '/usr/lib/cgi-bin':
    ensure => 'directory',
    notify => Service['httpd'],
  }

  # fix mcrypt config
  file { 'vagrant-mcrypt':
    path => '/etc/php.d/mcrypt.ini',
    ensure => file,
    require => Package['php-mcrypt'],
    group => 'root',
    source => 'puppet:///modules/php/mcrypt.ini',
    notify => Service['php-fpm'],
  }
}
