class raid::adaptec {

  helper::script {'download and install arcconf':
    content => template('raid/adaptec/install-arcconf.sh'),
    unless => 'which arcconf'
  }
  ->

  helper::script {'set hard drive write cache off if adaptec raid':
    content => template('raid/adaptec/set-write-cache-off.sh')
    unless => 'which arcconf'
  }

  file { '/usr/sbin/check-adaptec-raid-health.sh':
    content => template('raid/adaptec/check-adaptec-raid-health.sh')
  }
  ->

  cron {'raid-health-check':
    command => '/usr/sbin/check-adaptec-raid-health.sh',
    user => 'root',
    minute  => '*/5',
  }

}
