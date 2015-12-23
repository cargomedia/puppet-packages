class bipbip::gem ($version = 'latest') {

  require 'apt'
  require 'build'
  require 'ruby::gem::nokogiri'
  include 'cgi_fcgi'

  package { 'libsasl2-dev':
    ensure   => present,
    provider => 'apt'
  }

  package { 'libmysqlclient-dev':
    ensure   => present,
    provider => 'apt'
  }

  ruby::gem { 'bipbip':
    ensure  => $version,
    require => [
      Package['libsasl2-dev'],        # For "memcached"
      Package['libmysqlclient-dev'],  # For "mysql2"
      Class['cgi_fcgi'],
    ],
  }
}
