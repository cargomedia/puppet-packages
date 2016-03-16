define rsyslog::config($content) {

  include 'rsyslog'

  file { "/etc/rsyslog.d/${title}.conf":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    require => Package['rsyslog'],
    notify  => Service['rsyslog'],
  }
}
