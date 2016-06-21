class java::jre_headless {

  require 'apt'

  package { 'openjdk-7-jre-headless':
    ensure   => present,
    provider => 'apt',
  }

}
