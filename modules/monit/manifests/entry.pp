define monit::entry ($content, $ensure = present) {

  require 'monit'

  file { "/etc/monit/conf.d/${name}":
    content => $content,
    ensure => $ensure,
    group => 0, owner => 0, mode => 644,
  }
}
