node default {

  exec { 'set old cache modify time':
    provider    => shell,
    command     => 'sudo touch -mt $(date --date "100 days ago" +%Y%m%d%H%M.%S) /var/lib/apt/periodic/update-success-stamp',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

}
