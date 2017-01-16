class fs::config::nofsck {

  ensure_packages(['util-linux'], { provider => 'apt' })

  helper::script { 'Disable fsck on all partitions':
    content => template("${module_name}/disable-fsck-at-mount.sh"),
    unless  => 'ls -1 /var/local/nofsck',
    require => Package['util-linux'],
  }
}
