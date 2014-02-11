class gearmand::deps::debian_squeeze {

  package {['libboost-all-dev', 'libevent-dev']:
    ensure => present,
  }

}
