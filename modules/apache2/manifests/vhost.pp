define apache2::vhost ($content, $enabled = true) {

  require 'apache2'

  $vhostPath = "/etc/apache2/sites-available/${name}"

  file { $vhostPath:
    content => $content,
    ensure => present,
    owner => 0, group => 0, mode => 0644,
  }

  file { "/etc/apache2/sites-enabled/${name}":
    ensure => $enabled ? { true => link, false => absent},
    target => $vhostPath,
    owner => 0, group => 0, mode => 0644,
  }
}
