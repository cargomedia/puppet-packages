class ruby::gem::bipbip ($version = 'present') {

  require 'build'
  require 'ruby::gem::nokogiri'
  include 'cgi-fcgi'

  package {'libsasl2-dev':
    ensure => present
  }

  package {'libmysqlclient-dev':
    ensure => present
  }

  ruby::gem {'bipbip':
    ensure => $version,
    require => [
      Package['libsasl2-dev'],        # For "memcached"
      Package['libmysqlclient-dev'],  # For "mysql2"
      Class['cgi-fcgi'],
    ],
  }
}
