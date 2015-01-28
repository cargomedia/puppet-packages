define mysql::grant (
  $privileges
) {

  require 'mysql::client'

  database_grant { $name:
    privileges => $privileges,
    provider   => mysql,
  }
}
