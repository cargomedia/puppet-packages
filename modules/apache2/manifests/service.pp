class apache2::service {

  require 'apache2'

  service {'apache2':}

  @monit::entry {'apache2':
    content => template("${module_name}/monit"),
    require => Service['apache2'],
  }
}
