class backup::base::rdiff {

  # This will not be needed anymore in wheezy
  # rdiff-backup will not have this bug anymore (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=587370)

  file {'/etc/python2.6':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '755',
  }
  ->

  file {'/etc/python2.6/sitecustomize.py':
    ensure => file,
    content => template('backup/rdiff/python-sitecustomize.py'),
    owner => '0',
    group => '0',
    mode => '644',
  }
  ->
  # With wheezy, ditch the lines above and the referenced template

  package {'python':
    ensure => present,
  }

  package {'rdiff-backup':
    ensure => installed,
  }
}