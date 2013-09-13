define apache2::vhost ($content, $enabled = true) {

  require 'apache2'

  $vhostPath = "/etc/apache2/sites-available/${name}"

  file { $vhostPath:
    ensure => present,
    content => $content,
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Service['apache2'],
  }
  ->

  file { "/etc/apache2/sites-enabled/${name}":
    ensure => $enabled ? { true => link, false => absent},
    target => $vhostPath,
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Service['apache2'],
  }
}
