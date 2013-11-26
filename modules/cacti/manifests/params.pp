class cacti::params {

  $user_name = 'cacti'
  $group_name = 'cacti'

  $user_id = $::user_id ? {
    undef   => 2001,
    default => $::user_id,
  }

  $group_id = $::group_id ? {
    undef   => 2001,
    default => $::group_id,
  }

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

  $resource_dir = $::resource_dir ? {
    undef   => '/usr/share/cacti',
    default => $::resource_dir,
  }

  $script_dir = $::script_dir ? {
    undef   => "${resource_dir}/site/scripts",
    default => $::script_dir,
  }

  $template_dir = $::template_dir ? {
    undef   => "${resource_dir}/templates",
    default => $::script_dir,
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
    undef   => undef,
    default => $::htpasswd,
  }

  $ssh_private = $::ssh_private ? {
    undef   => 'No private key',
    default => $::ssh_private,
  }

  $ssl_cert = $::ssl_cert ? {
    undef   => 'No ssl key',
    default => $::ssl_cert,
  }

}
