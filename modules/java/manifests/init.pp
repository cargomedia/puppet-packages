class java {

  require 'apt'

  package { 'openjdk-7-jre-headless':
    ensure => present,
    provider => 'apt',
  }
}
