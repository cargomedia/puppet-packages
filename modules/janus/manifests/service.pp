class janus::service {

  require 'janus'

  service { 'janus':
    ensure => running,
    hasrestart => true,
    enable     => true,
    require    => [ Helper::Script['install janus'], Sysvinit::Script['janus'] ],
  }

  @monit::entry { 'janus':
    content => template("${module_name}/monit"),
    require => Service['janus'],
  }

}
