class gearmand::deps::debian_wheezy {

  package {['libboost-all-dev', 'libevent-dev', 'libcloog-ppl0']:
    ensure => present,
  }

}
