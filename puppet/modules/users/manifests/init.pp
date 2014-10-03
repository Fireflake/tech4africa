# vagrant/puppet/modules/users/manifests/init.pp

class users {
  # let's create a user
  user { "tech4africa":
    ensure     => present,
    password   => '$1$MK5QE5nK$ApCZO9lI.6GvgAEfnGM5I/',
    gid        => 'wheel',
    managehome => true
  }

  # lets make him a sudoer
  file { 'tech4africa-sudo':
    path => '/etc/sudoers.d/tech4africa',
    ensure => file,
    require => User['tech4africa'],
    source => 'puppet:///modules/users/tech4africa',
    group => 'root'
  }
}