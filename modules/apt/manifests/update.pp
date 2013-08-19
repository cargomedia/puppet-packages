class apt::update {
  exec { 'apt_update':
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command     => "apt-get update",
    logoutput   => 'on_failure',
    refreshonly => 'true',
  }
}
