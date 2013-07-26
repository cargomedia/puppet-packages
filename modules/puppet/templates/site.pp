node default {

  stage {'bootstrap':
    before => Stage['main'],
  }

  class {'puppet::agent':
    stage => 'bootstrap',
  }

  hiera_include('classes')
}
