class coturn::service {

  require 'coturn'

  service { 'coturn':
    hasrestart => true,
    enable => true,
  }

  @monit::entry { 'coturn':
    content => template("${module_name}/monit"),
    require => Service['coturn'],
  }

}
