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

  Service <| title == $name |> {
    enable    => true,
    ensure    => running,
    provider  => 'debian',
    subscribe => File["/etc/init.d/${name}"],
  }
}
