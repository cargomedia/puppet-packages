class sysctl {

  $entries = hiera_hash('sysctl::entries')

  file { '/etc/sysctl.d/local.conf':
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
    content => template('sysctl/sysctl')
  }

  exec { 'sysctl reload':
    path => '/sbin',
    command => 'sysctl -p /etc/sysctl.d/local.conf',
    refreshonly => true,
    subscribe => File['/etc/sysctl.d/local.conf'],
  }
}
