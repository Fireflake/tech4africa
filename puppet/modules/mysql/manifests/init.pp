# vagrant/puppet/modules/mysql/manifests/init.pp

class mysql {
  yumrepo { 'percona':
    baseurl    => 'http://repo.percona.com/centos/$releasever/os/$basearch/',
    enabled    => 1,
    gpgcheck   => 1,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-percona',
    descr      => "RHEL-$releasever-Percona",
    require    => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-percona'],
  }

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-percona':
    source => 'puppet:///modules/mysql/RPM-GPG-KEY-percona',
  }

  package { 'percona-release':
    require => Yumrepo['percona'],
    ensure  => installed,
  }

  # install percona
  package { ['percona-server']:
    name    => 'Percona-Server-server-56',
    ensure  => present,
    require => Package['percona-release'],
  }

  # Run percona
  service { 'mysql':
    ensure => running,
    require => Package['percona-server'],
    enable => true,
  }

}