class polipo(
  $diskCacheRoot = '/var/cache/polipo',
  $diskCacheDirectoryPermissions = '0700',
  $diskCacheFilePermissions = '0600'
) {

  file {'/etc/polipo/config':
    ensure => file,
    content => template('polipo/config'),
    owner => '0',
    group => '0',
    mode => '0644'
  }
  ->

  package {'polipo':
    ensure => present,
  }
}
