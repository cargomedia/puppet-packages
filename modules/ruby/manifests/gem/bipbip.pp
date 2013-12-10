class ruby::gem::bipbip {

  require 'ruby::gem::mysql2'
  require 'ruby::gem::memcached'

  ruby::gem {'bipbip':
    ensure => present,
  }
}
