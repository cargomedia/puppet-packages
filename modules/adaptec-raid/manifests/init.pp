class adaptec-raid {


  helper::script {'download and install arcconf':
    content => template('adaptec-raid/install-arcconf.sh'),
    unless => 'which arcconf'
  }
  ->
  helper::script {'set hard drive write cache off if adaptec raid':
    content => template('adaptec-raid/set-write-cache-off.sh')
    unless => 'which arcconf'
  }

  file { '/usr/sbin/check-adaptec-raid-health.sh':
    content => template('adaptec-raid/check-adaptec-raid-health.sh')
  }
  ->

  cron {'raid-health-check':
    command => '/usr/sbin/check-adaptec-raid-health.sh',
    user => 'root',
    minute  => '*//5',
  }

}
