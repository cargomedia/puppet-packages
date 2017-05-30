node default {

  helper::script { 'add log entries':
    content => template('fluentd/spec/source_journald_add_log.sh'),
    unless  => false,
  }

}
