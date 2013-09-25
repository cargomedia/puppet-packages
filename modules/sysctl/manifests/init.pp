class sysctl {

  $sysctlFile = '/etc/sysctl.d/local.conf'

  $entries = hiera_hash('sysctl::entries')

  file { $sysctlFile:
    ensure => file,
    alias => 'sysctl file',
    owner => '0',
    group => '0',
    mode => '0644',
    content => template('sysctl/sysctl')
  }

  exec { 'sysctl reload':
    path => '/sbin',
    command => 'sysctl -p /etc/sysctl.d/*.conf',
    refreshonly => true,
    subscribe => File['sysctl file'],
  }

}
