class polipo(
  $diskCacheRoot = '/var/cache/polipo',
  $diskCacheDirectoryPermissions = '0700',
  $diskCacheFilePermissions = '0600'
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
