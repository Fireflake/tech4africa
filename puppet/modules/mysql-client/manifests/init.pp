# vagrant/puppet/modules/mysql-client/manifests/init.pp

class mysql-client {
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

  # install percona client
  package { ['percona-client']:
    name    => 'Percona-Server-client-56',
    ensure  => present,
    require => Package['percona-release'],
  }
}