class adaptec-raid {

  helper::script {'install arcconf if hardware is present':
    content => template('adaptec-raid/install-arcconf.sh'),
    onlyif => 'lspci | grep -qi "adaptec.*raid"'
  }
  ->
  helper::script {'set hard drive write cache off if adaptec raid':
    content => template('adaptec-raid/install-arcconf.sh')
  }

  file { '/usr/sbin/check-adaptec-raid-health.sh':
    content => template('adaptec-raid/check-adaptec-raid-health.sh')
  }
  ->
  cron {'raid-health-check':
    command => '/usr/sbin/check-adaptec-raid-health.sh',
    user => 'root',
    minute  => '*/5'
  }
}
