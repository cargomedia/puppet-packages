class ruby::gem::nokogiri ($version = 'present') {

  require 'build'

  package {['libxslt-dev', 'libxml2-dev']:
    ensure => present
  }

  ruby::gem {'nokogiri':
    ensure => $version,
    require => Package['libxslt-dev', 'libxml2-dev'],
  }
}
