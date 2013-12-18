class ruby::gem::bipbip ($version = 'present') {

  require 'ruby::gem::mysql2'
  require 'ruby::gem::memcached'
  require 'cgi-fcgi'

  ruby::gem {'bipbip':
    ensure => $version,
  }
}
