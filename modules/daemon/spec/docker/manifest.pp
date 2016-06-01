node default {

  user { 'alice':
    ensure => present,
  }

  file { '/tmp/my-program':
    ensure  => file,
    owner   => 'alice',
    group   => 'alice',
    mode    => '0755',
    content => "#!/bin/bash\n while true; do sleep 1; done",
  }

  daemon { 'my-program':
    binary           => '/tmp/my-program',
    args             => '--foo=12',
    user             => 'alice',
    nice             => 19,
    oom_score_adjust => -500,
    env              => { 'FOO' => 'BOO' },
    limit_nofile     => 9999,
    require          => File['/tmp/my-program'],
  }

}
