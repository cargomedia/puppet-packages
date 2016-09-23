define sysctl::entry ($entries) {

  $localEntries = $entries

  file { "/etc/sysctl.d/${name}.conf":
    ensure  => file,
    content => template("${module_name}/sysctl"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }
  ~>

  exec { "/sbin/sysctl -p /etc/sysctl.d/${name}":
    refreshonly => true,
  }
}
