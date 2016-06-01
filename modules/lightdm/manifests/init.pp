class lightdm {

  require 'apt'

  package { 'lightdm':
    ensure   => present,
    provider => 'apt',
  }

  service { 'lightdm':
    enable   => true,
    require  => Package['lightdm'],
  }

  file { '/etc/lightdm/lightdm.conf.d':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
    require => Package['lightdm'],
    notify  => Service['lightdm'],
  }

  file { '/usr/share/xsessions':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
    notify  => Service['lightdm'],
  }

}
