node default {

  file { '/var/log/foo.log':
    ensure => file,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }
  ->

  rsyslog::entry { 'foo':
    content => ':msg,contains,"[FOO]" /var/log/foo.log',
  }

  exec { 'log a foo entry':
    provider    => shell,
    command     => 'logger [FOO] bar',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Service['rsyslog'],
  }
}
