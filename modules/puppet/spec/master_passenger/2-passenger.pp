node default {

  exec {'stop puppet master':
    command => 'service puppetmaster stop',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  class {'puppet::master':
    server_engine => 'passenger',
  }

}
