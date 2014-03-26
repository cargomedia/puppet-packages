define monit::entry ($content) {

  include 'monit'

  file { "/etc/monit/conf.d/${name}":
    ensure => file,
    content => $content,
    group => 0,
    owner => 0,
    mode => '0644',
    require => Helper::Script['install monit'],
    notify => Service['monit'],
  }
}
