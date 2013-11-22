node default {

  apt::key {'java7':
    ensure => present,
    key => 'EEA14886',
    key_server => 'keyserver.ubuntu.com',
  }

  apt::key{'nginx':
    ensure => present,
    key => '7BD9BF62',
    key_url => 'http://nginx.org/keys/nginx_signing.key',
  }
}
