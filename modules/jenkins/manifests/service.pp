class jenkins::service {

  require 'jenkins::package'

  service {'jenkins':}

  @monit::entry {'jenkins':
    content => template("${module_name}/monit"),
    require => Service['jenkins'],
  }
}
