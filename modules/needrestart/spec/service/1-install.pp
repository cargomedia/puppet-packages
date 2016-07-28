node default {

  include 'ruby'

  user { 'alice':
    ensure => present,
  }

  $daemon_name = 'my-program1'
  $example_app = "#!/usr/bin/ruby\n `touch /tmp/${daemon_name}-start-stamp-$(date +%s.%N)`\n while(1) do sleep(1) end"

  file { "/tmp/${daemon_name}":
    ensure  => file,
    owner   => 'alice',
    group   => 'alice',
    mode    => '0755',
    content => $example_app,
  }

  daemon { $daemon_name:
    binary           => "/tmp/${daemon_name}",
    user             => 'alice',
    require          => File["/tmp/${daemon_name}"],
  }
  ->

  needrestart::service { $daemon_name:
    require => [Daemon[$daemon_name], Service[$daemon_name]]
  }
}
