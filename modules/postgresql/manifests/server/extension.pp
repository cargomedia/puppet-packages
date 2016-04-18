define postgresql::server::extension (
  $extension = $title,
  $database,
  $port = $postgresql::server::port,
) {

  require 'postgresql::server'

  Postgresql_psql {
    port    => $port,
  }

  postgresql_psql { "Add ${extension} extension to ${database}":
    db      => $database,
    command => "CREATE EXTENSION \"${extension}\"",
    unless  => "SELECT extname FROM pg_extension WHERE extname = '${extension}'",
    require => Postgresql::Server::Database[$database],
  }

}
