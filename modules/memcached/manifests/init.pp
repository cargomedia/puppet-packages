class memcached (
  $port = 11211,
  $memory = 2048,
  $user = 'nobody',
  $max_connections = 10000
) {

  require 'apt'

  package { 'memcached':
    ensure   => present,
    provider => 'apt',
  }

  if $::facts['lsbdistcodename'] == 'wheezy' {

    service { 'memcached':
      enable  => true,
      require => Package['memcached'],
    }

    file { '/etc/memcached.conf':
      ensure  => file,
      content => template("${module_name}/memcached.conf"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Service['memcached'],
    }

    @monit::entry { 'memcached':
      content => template("${module_name}/monit"),
      require => Service['memcached'],
    }

  } else {

    exec { 'true && /etc/init.d/memcached stop':
      path         => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
      provider     => shell,
      subscribe    => Package['memcached'],
      refreshonly  => true,
    }

    daemon { 'memcached':
      binary  => '/usr/bin/memcached',
      args    => "-p ${port} -m ${memory} -u ${user} -c ${max_connections} -v",
      require => Package['memcached'],
    }

  }

  @bipbip::entry { 'memcached':
    plugin  => 'memcached',
    options => {
      'hostname' => 'localhost',
      'port' => $port,
    }
  }
}
