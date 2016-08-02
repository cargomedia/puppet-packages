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

  file { '/tmp/my-program-pre':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    content => "#!/bin/bash\n echo $(date --utc +%s) > /tmp/created_by_pre",
  }

  file { '/tmp/my-program-post':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    content => "#!/bin/bash\n cp /tmp/created_by_pre /tmp/copied_by_post",
  }

  notify { 'restart my-service if running': }
  ~>

  daemon { 'my-program':
    binary                 => '/tmp/my-program',
    args                   => '--foo=12',
    user                   => 'alice',
    nice                   => 19,
    oom_score_adjust       => -500,
    env                    => { 'DISPLAY' => ':99', 'FOO' => 'BOO' },
    limit_nofile           => 9999,
    limit_fsize            => 'unlimited',
    limit_cpu              => 25,
    limit_as               => 'unlimited',
    limit_rss              => 4096,
    limit_nproc            => 300,
    pre_command            =>  '/tmp/my-program-pre',
    post_command           => '/tmp/my-program-post',
    runtime_directory      => 'my-program',
    runtime_directory_mode => '0700',
    require                => File['/tmp/my-program','/tmp/my-program-pre','/tmp/my-program-post'],
  }

}
