class jenkins::service {

  $port = $jenkins::port

  require 'jenkins::package'

  service { 'jenkins':
    enable => true,
  }

  @monit::entry { 'jenkins':
    content => template("${module_name}/monit"),
    require => Service['jenkins'],
  }
}
