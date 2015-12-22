class lightdm {

  require 'apt'

  package { 'lightdm':
    ensure   => present,
    provider => 'apt',
  }

  file { '/etc/lightdm/lightdm.conf.d':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
    require => Package['lightdm'],
  }

}
