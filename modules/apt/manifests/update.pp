class apt::update(
  $options = [],
  $max_cache_age = 5,
) {

  require 'apt'

  $arguments = parse_apt_opts($options)

  $refreshonly = (apt_cache_age() < $max_cache_age)

  exec { 'apt_update':
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command     => "apt-get ${arguments} update",
    logoutput   => 'on_failure',
    refreshonly => $refreshonly,
  }

  Exec['apt_update'] -> Package <| |>
}
