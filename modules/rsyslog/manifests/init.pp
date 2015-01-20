class rsyslog(
  $logfile_mode = '0644',
) {

  file {'/etc/rsyslog.conf':
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
    content => template("${module_name}/rsyslog.conf"),
    notify => Service['rsyslog']
  }
  ~>

  file { '/var/log/syslog':
    ensure => file,
    owner  => '0',
    group  => '0',
    mode   => $logfile_mode,
  }

  package { 'rsyslog': }
  ->

  service { 'rsyslog': }
}
