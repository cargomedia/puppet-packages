class ruby::gem::bipbip ($version = 'present') {

  require 'apt'
  require 'build'
  require 'ruby::gem::nokogiri'
  include 'cgi_fcgi'

  package { 'libsasl2-dev':
    provider => 'apt',
    ensure => present
  }

  package { 'libmysqlclient-dev':
    provider => 'apt',
    ensure => present
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
