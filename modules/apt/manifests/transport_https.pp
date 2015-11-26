class apt::transport_https {

  require 'apt'

  package { 'apt-transport-https':
    provider => 'apt',
    before   => Exec['apt_update']
  }

}
