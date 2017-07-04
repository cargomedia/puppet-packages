class sudo {

  require 'apt'

  package { 'sudo':
    ensure   => present,
    provider => 'apt',
  }

  file { '/etc/sudoers.d/mail-no-user-off':
    ensure => absent,
  }

}
