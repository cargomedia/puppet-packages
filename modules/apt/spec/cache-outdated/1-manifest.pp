node default {

  exec { 'set cache modify time':
    provider    => shell,
    command     => 'sudo touch -mt $(date --date "100 seconds ago" +%Y%m%d%H%M.%S) /var/lib/apt/periodic/update-success-stamp',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

}
