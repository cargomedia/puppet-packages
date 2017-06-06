node default {

  helper::script { 'add log entries':
    content => template('fluentd/spec/default/add_log.sh'),
    unless  => false,
  }

}
