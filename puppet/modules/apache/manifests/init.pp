# vagrant/puppet/modules/apache/manifests/init.pp

class apache {
  # Install the apache package
  package { 'httpd':
    ensure => 'present',
    }

  # Make sure that the apache service is running
  service { 'httpd':
    ensure => running,
    require => Package['httpd'],
    enable => true,
  }

  # add our own vhost
  file { 'vagrant-apache':
    path => '/etc/httpd/conf/httpd.conf',
    ensure => file,
    require => Package['httpd'],
    group => 'root',
    source => 'puppet:///modules/apache/httpd.conf',
    notify => Service['httpd'],
  }
}
