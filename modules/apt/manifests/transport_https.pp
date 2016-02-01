class apt::transport_https {

  include 'apt'

  package { 'apt-transport-https':
    provider => 'apt',
    before   => Exec['apt_update'],
  }

}
