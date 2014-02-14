class polipo(
  $diskCacheRoot = '/var/cache/polipo',
  $idleTime = 20,
  $chunkHighMark = 819200,
  $objectHighMark = 128,
) {

  include 'polipo::service'

  file {'/etc/polipo':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {'/etc/polipo/config':
    ensure => file,
    content => template('polipo/config'),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service['polipo'],
  }
  ->

  package {'polipo':
    ensure => present,
  }
}
