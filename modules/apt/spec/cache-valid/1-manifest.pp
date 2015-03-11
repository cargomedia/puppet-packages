node default {

  package { 'less':
    ensure => absent
  }
  ->

  exec { 'set cache modify time':
    provider    => shell,
    command     => 'sudo touch -mt $(date --date @12345 +%Y%m%d%H%M.%S) /var/lib/apt/periodic/update-success-stamp',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

}
