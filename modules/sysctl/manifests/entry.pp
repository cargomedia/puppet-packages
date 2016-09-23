define sysctl::entry ($entries) {

  $localEntries = $entries

  $entry_file = "/etc/sysctl.d/${name}.conf"

  file { $entry_file:
    ensure  => file,
    content => template("${module_name}/sysctl"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }
  ~>

  exec { "/sbin/sysctl -p ${entry_file}":
    refreshonly => true,
  }
}
