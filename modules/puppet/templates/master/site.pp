node default {

  class {'puppet::agent':
    tag => 'bootstrap',
  }

  include hiera_array('classes', [])
}
