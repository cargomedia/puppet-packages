define postgresql::server::database(
  $dbname = $title,
  $owner = 'postgres',
  $port = $postgresql::server::port,
) {

  require 'postgresql::server'

  Postgresql_psql {
    port    => $port,
  }

  postgresql_psql { "CREATE DATABASE '${dbname}'":
    command => "CREATE DATABASE \"${dbname}\" WITH OWNER=\"${owner}\"",
    unless  => "SELECT datname FROM pg_database WHERE datname='${dbname}'",
  }

}
