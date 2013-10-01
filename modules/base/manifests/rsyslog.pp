class base::rsyslog {

  file { '/etc/rsyslog.conf':
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
    content => template('base/rsyslog'),
    notify => Service['rsyslog']
  }
  ->
  package { 'rsyslog': }

  service { 'rsyslog': }
}
