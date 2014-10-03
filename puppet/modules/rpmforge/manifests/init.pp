# Makes the rpmforge repository available on a system.

class rpmforge {
  yumrepo { 'rpmforge':
    baseurl    => 'http://apt.sw.be/redhat/el6/en/$basearch/rpmforge',
    enabled    => 1,
    gpgcheck   => 1,
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
    descr      => "RHEL-$releasever-RPMforge.net-dag",
    mirrorlist => 'http://apt.sw.be/redhat/el6/en/mirrors-rpmforge',
    require    => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag']
  }

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag':
    source => 'puppet:///modules/rpmforge/RPM-GPG-KEY.dag',
  }

  package { 'rpmforge-release':
    require => Yumrepo['rpmforge'],
    ensure  => installed,
  }
}

