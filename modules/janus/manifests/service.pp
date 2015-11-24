class janus::service {

  require 'janus'

  sysvinit::script { 'janus':
    content => template("${module_name}/init.sh"),
  }
  ->

  service { 'janus':
    enable     => true,
    hasrestart => true,
    subscribe  => [
      Class['janus'],
      Class['janus::transport::http'],
      Class['janus::transport::http']
    ],
  }

  @monit::entry { 'janus':
    content => template("${module_name}/monit"),
    require => Service['janus'],
  }

}
