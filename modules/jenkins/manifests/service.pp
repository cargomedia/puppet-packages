class jenkins::service {

  require 'jenkins'

  service {'jenkins':}

  @monit::entry {'jenkins':
    content => template('jenkins/monit'),
    require => Service['jenkins'],
  }
}
