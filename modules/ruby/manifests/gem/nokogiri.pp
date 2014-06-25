class ruby::gem::nokogiri ($version = 'present') {

  require 'build'

  package {['libxslt1-dev', 'libxml2-dev']:
    ensure => present
  }

  ruby::gem {'nokogiri':
    ensure => $version,
    require => Package['libxslt1-dev', 'libxml2-dev'],
  }
}
