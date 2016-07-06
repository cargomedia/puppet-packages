define sysvinit::script(
  $content,
  $start_on_create = true,
) {

  include 'sysctl::entry::core_pattern'

  $unless_start_on_create = $start_on_create ? {
    false => true,
    default => false,
  }

  file { "/etc/init.d/${name}":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
  ~>

    # The unless clause will evaluate to *true* (do not execute) if $start_on_create is false
  exec { "/etc/init.d/${name} start":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "${unless_start_on_create} || /etc/init.d/${name} status",
    refreshonly => true,
  }

  Service <| title == $name |> {
    enable    => true,
    provider  => 'debian',
    subscribe => File["/etc/init.d/${name}"],
  }
}
