node default {

  helper::script { 'add log entries':
    content => template('fluentd/spec/source_journald_add_log.sh'),
    unless  => false,
  }
  ->
  exec { 'restart fluentd':
    provider => shell,
    command  => 'systemctl restart fluentd.service',
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

}
