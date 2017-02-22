class sysctl ($entries = { }) {

  $localEntries = lookup('sysctl::entries', $entries)

  if $localEntries != { } {
    file { '/etc/sysctl.conf':
      ensure  => file,
      content => template("${module_name}/sysctl"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
    }
    ~>

    exec { '/sbin/sysctl -p /etc/sysctl.conf':
      refreshonly => true,
    }
  }
}
