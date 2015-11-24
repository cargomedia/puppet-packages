class bipbip::service {

  require 'bipbip'

  service { 'bipbip':
    hasrestart => true,
    enable     => true,
  }

  @monit::entry { 'bipbip':
    content => template("${module_name}/monit"),
    require => Service['bipbip'],
  }

}
