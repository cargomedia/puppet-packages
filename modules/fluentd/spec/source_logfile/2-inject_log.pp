node default {

  file { '/tmp/simple.log':
    ensure  => file,
    content => template('fluentd/spec/source_logfile/simple.log'),
    mode    => '0644',
  }

  file { '/tmp/multiline.log':
    ensure  => file,
    content => template('fluentd/spec/source_logfile/multiline.log'),
    mode    => '0644',
  }
}
