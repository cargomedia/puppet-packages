define postgresql::server::role(
  $username = $title,
  $password,
  $createdb = false,
  $createrole = false,
  $port = $postgresql::server::port,
  $login = true,
  $inherit = true,
  $superuser = false,
  $replication = false,
  $connection_limit = '-1',
) {

  require 'postgresql::server'

  $password_md5 = md5("${password}${username}")
  $password_hash_sql = "md5${password_md5}"

  $login_sql = $login       ? { true => 'LOGIN',       default => 'NOLOGIN' }
  $inherit_sql = $inherit     ? { true => 'INHERIT',     default => 'NOINHERIT' }
  $createrole_sql = $createrole  ? { true => 'CREATEROLE',  default => 'NOCREATEROLE' }
  $createdb_sql = $createdb    ? { true => 'CREATEDB',    default => 'NOCREATEDB' }
  $superuser_sql = $superuser   ? { true => 'SUPERUSER',   default => 'NOSUPERUSER' }
  $replication_sql = $replication ? { true => 'REPLICATION', default => '' }

  Postgresql_psql {
    port    => $port,
    require => [
      Postgresql_psql["CREATE ROLE ${username} ENCRYPTED PASSWORD ****"],
    ],
  }

  postgresql_psql { "CREATE ROLE ${username} ENCRYPTED PASSWORD ****":
    command     => "CREATE ROLE \"${username}\" PASSWORD '${password_hash_sql}' ${login_sql} ${createrole_sql} ${createdb_sql} ${superuser_sql} ${replication_sql} CONNECTION LIMIT ${connection_limit}",
    unless      => "SELECT rolname FROM pg_roles WHERE rolname='${username}'",
    require     => Class['Postgresql::Server'],
  }

  postgresql_psql { "ALTER ROLE \"${username}\" ${superuser_sql}":
    unless => "SELECT rolname FROM pg_roles WHERE rolname='${username}' and rolsuper=${superuser}",
  }

  postgresql_psql { "ALTER ROLE \"${username}\" ${createdb_sql}":
    unless => "SELECT rolname FROM pg_roles WHERE rolname='${username}' and rolcreatedb=${createdb}",
  }

  postgresql_psql { "ALTER ROLE \"${username}\" ${createrole_sql}":
    unless => "SELECT rolname FROM pg_roles WHERE rolname='${username}' and rolcreaterole=${createrole}",
  }

  postgresql_psql { "ALTER ROLE \"${username}\" ${login_sql}":
    unless => "SELECT rolname FROM pg_roles WHERE rolname='${username}' and rolcanlogin=${login}",
  }

  postgresql_psql { "ALTER ROLE \"${username}\" ${inherit_sql}":
    unless => "SELECT rolname FROM pg_roles WHERE rolname='${username}' and rolinherit=${inherit}",
  }

  if $replication_sql == '' {
    postgresql_psql { "ALTER ROLE \"${username}\" NOREPLICATION":
      unless => "SELECT rolname FROM pg_roles WHERE rolname='${username}' and rolreplication=${replication}",
    }
  } else {
    postgresql_psql { "ALTER ROLE \"${username}\" ${replication_sql}":
      unless => "SELECT rolname FROM pg_roles WHERE rolname='${username}' and rolreplication=${replication}",
    }
  }

  postgresql_psql { "ALTER ROLE \"${username}\" CONNECTION LIMIT ${connection_limit}":
    unless => "SELECT rolname FROM pg_roles WHERE rolname='${username}' and rolconnlimit=${connection_limit}",
  }

  postgresql_psql { "ALTER ROLE ${username} ENCRYPTED PASSWORD ****":
    command     => "ALTER ROLE \"${username}\" PASSWORD '${password_hash_sql}'",
    unless      => "SELECT usename FROM pg_shadow WHERE usename='${username}' and passwd='${password_hash_sql}'",
  }
}
