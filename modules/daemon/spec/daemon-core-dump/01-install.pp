node default {

  require 'monit'

  sysctl::entry { 'kernel-core-pattern':
    entries => {
      'kernel.core_pattern' => '/tmp/core.%e.%p.%h.%t',
    }
  }

  user { 'myuser':
    ensure => present,
  }

  file { '/tmp/my-program':
    ensure  => file,
    owner   => 'myuser',
    group   => 'myuser',
    mode    => '0755',
    content => "#!/bin/bash\n while true; do sleep 1; done",
  }

  daemon { 'my-program':
    binary    => '/tmp/my-program',
    user      => 'myuser',
    core_dump => true,
  }
}
