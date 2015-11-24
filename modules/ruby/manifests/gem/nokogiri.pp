class ruby::gem::nokogiri ($version = 'present') {

  require 'apt'
  require 'build'
  require 'build::dev::zlib1g'

  package { ['libxslt1-dev', 'libxml2-dev']:
    provider => 'apt',
    ensure => present
  }

  ruby::gem { 'nokogiri':
    ensure  => $version,
    require => Package['libxslt1-dev', 'libxml2-dev'],
  }
}
