class bipbip::service {

  require 'bipbip'

  service {'bipbip':
    hasrestart => true,
  }

  @monit::entry {'bipbip':
    content => template('bipbip/monit'),
    require => Service['bipbip'],
  }

}
