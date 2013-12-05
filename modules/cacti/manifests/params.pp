class cacti::params {

  $user_name = 'cacti'
  $group_name = 'cacti'

  $hostname = $::hostname  ? {
    undef   => 'localhost',
    default => $::hostname,
  }

  $port = $::port  ? {
    undef   => 80,
    default => $::port,
  }

  $port_ssl = $::port_ssl  ? {
    undef   => 443,
    default => $::port_ssl,
  }

  $deploy_dir = $::deploy_dir  ? {
    undef   => undef,
    default => $::deploy_dir,
  }

  $db_host = $::db_host ? {
    undef   => 'localhost',
    default => $::db_host,
  }

  $db_port = $::db_port ? {
    undef   => '3306',
    default => $::db_port,
  }

  $db_name = $::db_name ? {
    undef   => 'cacti',
    default => $::db_name,
  }

  $db_user = $::db_user ? {
    undef   => 'cacti',
    default => $::db_user,
  }

  $db_password = $::db_password ? {
    undef   => 'cacti',
    default => $::db_password,
  }

  $db_sense_user = $::db_sense_user ? {
    undef   => 'cacti-sense',
    default => $::db_sense_user,
  }

  $db_sense_password = $::db_sense_password ? {
    undef   => 'cacti',
    default => $::db_sense_password,
  }

  $htpasswd = $::htpasswd ? {
    undef   => 'password',
    default => $::htpasswd,
  }

  $ssl_cert = $::ssl_cert ? {
    undef   => 'No ssl key',
    default => $::ssl_cert,
  }

}
