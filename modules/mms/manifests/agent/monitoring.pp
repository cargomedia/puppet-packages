class mms::agent::monitoring (
  $version = '4.1.0.251',
  $api_key,
  $auth_username = undef,
  $auth_password = undef,
  $concurrency = 4,
  $mms_server = 'https://mms.mongodb.com'
){

  # Docu: https://docs.mms.mongodb.com/tutorial/install-monitoring-agent-with-deb-package/

  require 'mms'

  $agent_name = 'mms-monitoring'
  $daemon_args = "-conf /etc/mongodb-mms/monitoring-agent.config -concurrency=${concurrency}"

  helper::script { 'install-mms-monitoring':
    content => template("${module_name}/install.sh"),
    unless  => "(test -x /usr/bin/mongodb-${agent_name}-agent) && (/usr/bin/mongodb-${agent_name}-agent -version | grep -q ${version})",
  }

  file { '/etc/mongodb-mms/monitoring-agent.config':
    ensure  => file,
    content => template("${module_name}/conf-monitoring"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    require => Helper::Script['install-mms-monitoring'],
    notify  => Service[$agent_name];
  }
  ->

  sysvinit::script { $agent_name:
    content           => template("${module_name}/init"),
    require           => Helper::Script['install-mms-monitoring'],
  }
  ->

  service { $agent_name:
    hasrestart => true,
    enable     => true,
  }

  @monit::entry { 'mms-monitoring':
    content => template("${module_name}/monit"),
    require => Service[$agent_name],
  }

}
