class janus::service {

  require 'janus'

  service { 'janus':
    hasrestart => true,
    enable => true,
  }

  @monit::entry { 'janus':
    content => template("${module_name}/monit"),
    require => Service['janus'],
  }

}
