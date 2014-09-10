define mysql::grant (
  $privileges,
  $user = undef,
  $database = undef
) {

  require 'mysql::service'

  database_grant {$name:
    privileges => $privileges,
    provider => mysql,
  }
}
