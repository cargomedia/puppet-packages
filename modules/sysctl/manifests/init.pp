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

    exec {'/sbin/sysctl -p /etc/sysctl.conf':
      refreshonly => true,
    }
  }
}
