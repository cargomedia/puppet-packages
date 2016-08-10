class librdkafka() {

  require 'apt'

  package { 'librdkafka-dev':
    ensure   => present,
    provider => 'apt',
  }
}
