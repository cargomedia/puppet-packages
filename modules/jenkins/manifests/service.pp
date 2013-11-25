class jenkins::service {

  require 'jenkins::package'

  service {'jenkins':}

  @monit::entry {'jenkins':
    content => template('jenkins/monit'),
    require => Service['jenkins'],
  }
}
