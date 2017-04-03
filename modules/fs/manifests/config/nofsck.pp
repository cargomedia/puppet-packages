class fs::config::nofsck {

  ensure_packages(['util-linux'], { provider => 'apt' })

  file { '/usr/local/bin/disable-fsck-at-mount.sh':
    ensure  => file,
    content => template("${module_name}/disable-fsck-at-mount.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0750',
    require => Package['util-linux'],
  }

  $unit_name = 'nofsck.service'

  service { $unit_name:
    enable => true,
  }

  systemd::unit { $unit_name:
    service_name => $unit_name,
    critical => false,
    content => template("${module_name}/nofsck.service"),
    require => File['/usr/local/bin/disable-fsck-at-mount.sh'],
  }

}
