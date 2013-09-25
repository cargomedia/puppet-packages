class base::rsyslog {

  package { 'rsyslog': ensure => present }
  ->
  file { '/etc/rsyslog.conf':
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
    content => template('base/rsyslog'),
    notify => Service['rsyslog']
  }
  ->
  service { 'rsyslog': }
}
