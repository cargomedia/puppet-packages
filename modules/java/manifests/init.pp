class java {

  require 'apt'

  package { 'openjdk-7-jre-headless':
    provider => 'apt',
    ensure => present,
  }
}
