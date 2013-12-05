class rsyslog {

  file { '/etc/rsyslog.conf':
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
    content => template('rsyslog/rsyslog.conf'),
    notify => Service['rsyslog']
  }
  ->

  package { 'rsyslog': }
  ->

  service { 'rsyslog': }
}
