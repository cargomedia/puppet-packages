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

  exec { 'add-journald-log':
    provider => shell,
    command  => 'logger -p local0.warning hey',
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
