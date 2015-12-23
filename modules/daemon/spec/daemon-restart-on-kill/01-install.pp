node default {

  if ($::service_provider == 'debian') {
    require 'monit'
  }

  file { '/tmp/my-program':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => "#!/bin/bash\n while true; do sleep 1; done",
  }

  daemon { 'my-program':
    binary => '/tmp/my-program',
  }
}
