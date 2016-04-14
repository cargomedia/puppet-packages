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
    content => "#!/bin/bash\n touch /tmp/created_by_pre",
  }

  file { '/tmp/my-program-post':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    content => "#!/bin/bash\n mv /tmp/created_by_pre /tmp/modified_by_post",
  }

  daemon { 'my-program':
    binary                 => '/tmp/my-program',
    args                   => '--foo=12',
    user                   => 'alice',
    nice                   => 19,
    oom_score_adjust       => -500,
    env                    => { 'DISPLAY' => ':99', 'FOO' => 'BOO' },
    limit_nofile           => 9999,
    permissions_start_only => true,
    exec_start_pre         =>  '/tmp/my-program-pre',
    exec_start_post        => '/tmp/my-program-post',
    require => File['/tmp/my-program','/tmp/my-program-pre','/tmp/my-program-post'],
  }

}
