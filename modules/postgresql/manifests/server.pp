class postgresql::server(
  $port = 5432,
) {

  require 'postgresql::common'

  package { 'postgresql-9.4':
    ensure   => present,
    provider => 'apt',
  }

  service { 'postgresql':
    enable     => true,
    hasrestart => true,
    require    => Package['postgresql-9.4'],
  }

  file { ['/etc/postgresql', '/etc/postgresql/9.4', '/etc/postgresql/9.4/main']:
    ensure => directory,
    owner  => 'postgres',
    group  => 'postgres',
    mode   => '0600',
  }

  file { '/etc/postgresql/9.4/main/postgresql.conf':
    ensure   => file,
    content  => template("${module_name}/postgresql.conf"),
    owner    => 'postgres',
    group    => 'postgres',
    mode     => '0600',
    notify   => Service['postgresql'],
  }

}
