node default {

  host { 'local.source':
    ip => '127.1.1.1',
  }

  user { ['foo', 'bar']:
    ensure     => 'present',
    managehome => true,
  }

  $keys = generate_sshkey('foo@local.source')

  ssh::key { 'id_rsa':
    user    => 'foo',
    content => $keys['private'],
    id      => 'foo@local.source',
    fqdn    => 'local.source',
    require => User['foo'],
  }

  ssh::authorized_key { 'foo@local.source':
    user    => 'bar',
    content => $keys['public'],
    require => User['bar'],
  }

  exec { 'nc 127.0.0.1:8000':
    command  => '/bin/nc -lvnp 8000 -s 127.0.0.1 -c "echo nc1" &',
    user     => 'root',
    provider => shell,
  }

  exec { 'nc 127.1.1.1:8001':
    command  => '/bin/nc -lvnp 8001 -s 127.1.1.1 -c "echo nc2" &',
    user     => 'root',
    provider => shell,
  }

  autossh { 'nc-forwarding':
    user       => 'foo',
    connection => 'bar@localhost',
    forwards   => {
      '8000'              => '9000',
      'local.source:8001' => '9001',
    },
    require    => Exec['nc 127.0.0.1:8000', 'nc 127.1.1.1:8001'],
  }
}
