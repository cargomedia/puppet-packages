class gearmand::params {

  $username = $::username ? {
    undef   => 'gearman',
    default => $::username,
  }

  $confdir = $::confdir ? {
    undef   => '/etc/gearmand',
    default => $::confdir,
  }

  $conffile = $::conffile ? {
    undef   => "gearmand.conf",
    default => $::conffile,
  }

  $logdir = $::logdir ? {
    undef   => '/var/log/gearman-job-server',
    defualt => $::logdir,
  }

  $piddir = $::piddir ? {
    undef   => '/var/run/gearman-job-server',
    default => $::piddir,
  }

  $dbfile = $::dbfile ? {
    undef   => "gearman-persist.sqlite3",
    default => $::dbfile,
  }
}
