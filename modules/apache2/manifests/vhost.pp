define apache2::vhost ($content, $enabled = true) {

  require 'apache2'

  $vhostPath = "/etc/apache2/sites-available/${name}"
  $linkIfEnabled = $enabled ? { true => link, false => absent }

  file { $vhostPath:
    ensure  => present,
    content => $content,
    group   => '0',
    owner   => '0',
    mode    => '0644',
  }
  ->

  file { "/etc/apache2/sites-enabled/${name}":
    ensure => $linkIfEnabled,
    target => $vhostPath,
    group  => '0',
    owner  => '0',
    mode   => '0644',
    notify => [
      Service['apache2'],
      Exec['start apache2'], # Start apache if it didn't have any vhosts, and was not running before
    ],
  }
}
