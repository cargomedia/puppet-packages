class apt::update {

  require 'apt'

  exec { 'apt_update':
    command     => "apt-get update",
    logoutput   => 'on_failure',
    refreshonly => true,
  }

  Exec['apt_update'] -> Package <| |>
}
