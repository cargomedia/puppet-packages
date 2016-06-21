class rsyslog(
  $logfile_mode = '0644',
) {

  require 'apt'
  include 'rsyslog::service'

  file {
    '/etc/rsyslog.conf':
      ensure  => file,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      content => template("${module_name}/rsyslog.conf.erb"),
      notify  => Service['rsyslog'];
    '/etc/rsyslog.d':
      ensure    => directory,
      owner     => '0',
      group     => '0',
      mode      => '0644',
      notify    => Service['rsyslog'];
  }

  rsyslog::config { '50-default':
    content => template("${module_name}/rules.conf.erb"),
  }

  file { '/var/log/syslog':
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => $logfile_mode,
    require => Package['rsyslog'],
  }

  package { 'rsyslog':
    ensure   => present,
    provider => 'apt',
  }

  @fluentd::config::source_tail{ 'syslog':
    path        => '/var/log/syslog',
    fluentd_tag => 'syslog',
    format      => '/^(?<time>[^ ]*) (?<host>[^ ]*) (?<ident>[a-zA-Z0-9_\/\.\-]*)(?:\[(?<pid>[0-9]+)\])?(?:[^\:]*\:)? *(?<message>.*)$/',
    time_format => '%FT%T.%L%:z',
  }
}
