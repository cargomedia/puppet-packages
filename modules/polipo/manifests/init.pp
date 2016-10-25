class polipo(
  $diskCacheRoot = '/var/cache/polipo',
  $idleTime = 20,
  $chunkHighMark = 33354342,
  $objectHighMark = 4096,
) {

  require 'apt'
  include 'polipo::service'

  file { '/etc/polipo':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/polipo/config':
    ensure  => file,
    content => template("${module_name}/config"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['polipo'],
  }
  ->

  package { 'polipo':
    ensure   => present,
    provider => 'apt',
  }
}
