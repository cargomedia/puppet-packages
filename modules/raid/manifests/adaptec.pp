class raid::adaptec {

  $version = '7.31 (B18856)'

  helper::script {'download and install arcconf':
    content => template('raid/adaptec/install-arcconf.sh'),
    unless => "which arcconf && arcconf | grep 'Version ${version}'",
  }

  helper::script {'set hard drive write cache off if adaptec raid':
    content => template('raid/adaptec/set-write-cache-off.sh'),
    unless => 'which arcconf',
  }

  file { '/usr/sbin/check-adaptec-raid-health.sh':
    content => template('raid/adaptec/check-adaptec-raid-health.sh'),
    mode => '0755',
  }
  ->

  cron {'raid-health-check':
    command => '/usr/sbin/check-adaptec-raid-health.sh',
    user => 'root',
    minute  => '*/5',
  }
}
