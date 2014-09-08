class bipbip::service {

  require 'bipbip'

  service {'bipbip':
    hasrestart => true,
  }

  @monit::entry {'bipbip':
    content => template("${module_name}/monit"),
    require => Service['bipbip'],
  }

}
