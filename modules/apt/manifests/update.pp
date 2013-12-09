class apt::update(
  $options = []
) {

  require 'apt'

  $arguments = parse_apt_opts($options)

  exec { 'apt_update':
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command     => "apt-get ${arguments} update",
    logoutput   => 'on_failure',
    refreshonly => true,
  }

  Exec['apt_update'] -> Package <| |>
}
