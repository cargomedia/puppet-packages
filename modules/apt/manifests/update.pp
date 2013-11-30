class apt::update {

  require 'apt'

  exec { 'apt_update':
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command     => "apt-get -o Acquire::http::proxy=false update",
    logoutput   => 'on_failure',
    refreshonly => true,
  }

  Exec['apt_update'] -> Package <| |>
}
