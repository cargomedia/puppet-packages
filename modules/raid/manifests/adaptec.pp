class raid::adaptec {

  require 'apt'
  require 'unzip'
  require 'apt::source::cargomedia'
  require 'python'

  package { 'arcconf':
    ensure   => present,
    provider => 'apt',
    require  => Class['apt::source::cargomedia'],
  }

  file { '/usr/local/sbin/raid-adpatec':
    ensure  => file,
    content => template("${module_name}/adaptec/raid-adpatec.rb"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

  @bipbip::entry { 'raid-adaptec':
    plugin  => 'command_status',
    command => '/usr/local/sbin/raid-adpatec status',
    require => File['/usr/local/sbin/raid-adpatec'],
  }

  @sudo::config { 'raid-bipbip':
    content => 'bipbip ALL=NOPASSWD: /usr/sbin/arcconf',
  }

  helper::script { 'set hard drive write cache off if adaptec raid':
    content => template("${module_name}/adaptec/set-write-cache-off.sh"),
    unless  => 'test "$(/usr/local/sbin/raid-adpatec list_devices_with_cache)" != "off"',
    require => [Package['arcconf'], File['/usr/local/sbin/raid-adpatec']],
  }
}
