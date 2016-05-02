class puppetserver::puppetdb::postgresql (
  $port = 5432,
  $database = 'puppetdb',
  $username = 'puppetdb',
  $password = 'puppetdb',
) {

  class { 'postgresql::server':
    port => $port,
  }

  require 'postgresql::server'

  postgresql::server::role{ $username:
    password => $password
  }

  postgresql::server::database{ $database:
    owner   => $username,
  }

  postgresql::server::extension{ 'pg_trgm':
    database => $database,
  }

  file { '/etc/puppetlabs/puppetdb/conf.d/postgresql.ini':
    ensure  => file,
    content => template("${module_name}/puppetdb/postgresql.ini"),
    owner   => 'puppetdb',
    group   => 'puppetdb',
    mode    => '0640',
    notify  => Service['puppetdb'],
    require => [
      Postgresql::Server::Role[$username],
      Postgresql::Server::Database[$database],
    ],
  }

}
