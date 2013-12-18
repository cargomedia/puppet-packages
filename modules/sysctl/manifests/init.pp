class sysctl ($entries = {}) {

  $localEntries = hiera_hash('sysctl::entries', $entries)

  if $localEntries != {} {
    file {'/etc/sysctl.conf':
      ensure => file,
      content => template('sysctl/sysctl'),
      owner => '0',
      group => '0',
      mode => '0644',
    }
    ~>

    exec {'sysctl reload':
      path => '/sbin',
      command => 'sysctl -p /etc/sysctl.conf',
      refreshonly => true,
    }
  }
}
