class sysctl ($entries = {}) {

  $localEntries = hiera_hash('sysctl::entries', $entries)

  if $localEntries != {} {
    file {'/etc/sysctl.conf':
      ensure => file,
      owner => '0',
      group => '0',
      mode => '0644',
      content => template('sysctl/sysctl')
    }

    exec {'sysctl reload':
      command => 'sysctl -p /etc/sysctl.conf',
      refreshonly => true,
      subscribe => File['/etc/sysctl.conf'],
    }
  }
}
