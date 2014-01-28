class rdiff-backup {

  if $::lsbdistid == 'Debian' and $::lsbmajdistrelease <= 6 {
    file {'/etc/python2.6':
      ensure => directory,
      owner => '0',
      group => '0',
      mode => '755',
    }
    ->

    file {'/etc/python2.6/sitecustomize.py':
      ensure => file,
      content => template('rdiff-backup/python-sitecustomize.py'),
      owner => '0',
      group => '0',
      mode => '644',
    }
    ->

    package {'python':
      ensure => present,
    }
  }

  package {'rdiff-backup':
    ensure => installed,
  }
}
