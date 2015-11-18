class apt::transport_https {

  package { 'apt-transport-https':
    before => Exec['apt_update']
  }

}
