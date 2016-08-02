define apt::config (
  $content
) {

  require 'apt'

  file { "/etc/apt/apt.conf.d/${name}":
    ensure  => file,
    content => $content,
    owner   => 0,
    group   => 0,
    mode    => '0644'
  }
}
