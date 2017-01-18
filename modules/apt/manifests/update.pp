class apt::update(
  $options = [],
  $max_cache_age = 5*24*3600,
) {

  require 'apt'
  require 'apt::transport_https'

  $arguments = parse_apt_opts($options)

  $refreshonly = (apt_cache_age() < $max_cache_age)

  file { '/etc/apt/apt.conf.d/15update-stamp':
    ensure  => file,
    content => 'APT::Update::Post-Invoke-Success {"touch /var/lib/apt/periodic/update-success-stamp 2>/dev/null || true";};',
    owner   => 0,
    group   => 0,
    mode    => '0644'
  }
  ->

  exec { 'apt_update':
    provider    => shell,
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command     => "apt-get ${arguments} update",
    logoutput   => true,
    refreshonly => $refreshonly,
  }

  Exec['apt_update'] -> Package <| provider == 'apt' and before != Exec['apt_update'] |>
}
