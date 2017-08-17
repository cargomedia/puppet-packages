node default {

  helper::script { 'add log entries':
    content => template('fluentd/spec/source_journald/add_log.sh'),
    unless  => false,
  }

}
