class apt::update(
  $options = []
) {

  require 'apt'

  $arguments = join(prefix($options, '-o '), ' ')

  exec { 'apt_update':
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command     => "apt-get ${arguments} update",
    logoutput   => 'on_failure',
    refreshonly => true,
  }

  Exec['apt_update'] -> Package <| |>
}
