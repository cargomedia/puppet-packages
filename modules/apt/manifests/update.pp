class apt::update {
  exec { 'apt_update':
    command     => "/usr/bin/apt-get update",
    logoutput   => 'on_failure',
    refreshonly => 'true',
  }
}
