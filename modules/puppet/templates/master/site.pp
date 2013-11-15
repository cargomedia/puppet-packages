node default {

  Exec {
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  class {'puppet::agent':
    tag => 'bootstrap',
  }

  include hiera_array('classes', [])
}
