define sysvinit::script(
  $content,
) {

  include 'sysctl::entry::core_pattern'

  file { "/etc/init.d/${name}":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
  ~>

  exec { "/etc/init.d/${name} start":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "/etc/init.d/${name} status",
    refreshonly => true,
  }

  Service <| title == $name |> {
    enable    => true,
    provider  => 'debian',
    subscribe => File["/etc/init.d/${name}"],
    before    => Exec["/etc/init.d/${name} start"],
  }
}
