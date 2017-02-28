node default {

  class { 'systemd::config::journald':
    max_retention_sec   => '10month',
    rate_limit_interval => '5s',
    rate_limit_burst    => 30,
  }
  ->

  file { '/tmp/flood_and_dump_log':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0755',
    content => "#!/bin/bash\n for i in $(seq 10000); do logger 'Foo'; done;journalctl --no-pager >/tmp/journal_dump",
  }
  ->

  exec { 'flood log with lots of entries and dump it to a file':
    command => '/tmp/flood_and_dump_log',
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

}
