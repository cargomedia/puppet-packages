class cm_janus::service {

  require 'cm_janus'

  sysvinit::script { 'cm-janus':
    content => template("${module_name}/init.sh"),
  }
  ->

  service { 'cm-janus':
    enable  => true,
    subscribe => Class['cm_janus'],
  }

  @monit::entry { 'cm-janus':
    content => template("${module_name}/monit"),
    require => Service['cm-janus'],
  }
}
