class bipbip::service {

  require 'bipbip'

  service {'bipbip':
  }

  @monit::entry {'bipbip':
    content => template('bipbip/monit'),
    require => Service['bipbip'],
  }

}
