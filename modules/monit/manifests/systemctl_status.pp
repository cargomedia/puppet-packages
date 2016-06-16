class monit::systemctl_status {

  file { '/usr/local/bin/systemctl-status':
    ensure  => file,
    content => template("${module_name}/bin/systemctl-status.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
}
