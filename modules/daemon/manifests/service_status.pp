class daemon::service_status {

  file { '/usr/local/bin/service-status':
    ensure  => file,
    content => template("${module_name}/service-status.sh.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
}
