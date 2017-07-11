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

  file { '/usr/local/sbin/raid-adaptec':
    ensure  => file,
    content => template("${module_name}/adaptec/raid-adaptec.rb"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => Package['arcconf'],
  }

  helper::script { 'set hard drive write cache off if adaptec raid':
    content => template("${module_name}/adaptec/set-write-cache-off.sh"),
    unless  => 'test "$(/usr/local/sbin/raid-adaptec list_devices_with_cache)" != ""',
    require => File['/usr/local/sbin/raid-adaptec'],
  }

  @bipbip::entry { 'raid-adaptec':
    plugin  => 'command-status',
    options => {
      command => 'sudo /usr/local/sbin/raid-adaptec status 1>/dev/null',
    },
    require => File['/usr/local/sbin/raid-adaptec'],
  }

  @sudo::config { 'raid-bipbip':
    content => 'bipbip ALL=NOPASSWD: /usr/local/sbin/raid-adaptec',
  }
}
