class java::jre {

  require 'apt'

  package { 'openjdk-7-jre':
    ensure   => present,
    provider => 'apt',
  }

}
