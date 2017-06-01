node default {

  helper::script { 'add log entries':
    content => template('fluentd/spec/filters_grep/add_log.sh'),
    unless  => false,
  }

}
