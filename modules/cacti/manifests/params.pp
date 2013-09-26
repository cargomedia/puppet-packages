class cacti::params {

  $host = $::host ? {
    undef => 'localhost',
    default => $::host,
  }

  $dbname = $::dbname ? {
    undef => 'cacti',
    default => $::dbname,
  }

  $dbuser = $::dbuser ? {
    undef => 'cacti',
    default => $::dbuser,
  }

  $dbpassword = $::dbpassword ? {
    undef => '',
    default => $::dbpassword,
  }

  $username = $::username ? {
    undef => 'cacti',
    default => $::username,
  }

  $groupname = $::groupname ? {
    undef => 'cacti',
    default => $::groupname,
  }
}
