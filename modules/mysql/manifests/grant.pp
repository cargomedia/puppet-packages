define mysql::grant (
  $privileges
) {

  require 'mysql::service'

  database_grant {$name:
    privileges => $privileges,
    provider => mysql,
  }
}
