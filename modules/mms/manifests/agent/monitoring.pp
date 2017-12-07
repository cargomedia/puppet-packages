class mms::agent::monitoring (
  $version = '6.2.0.397',
  $api_key,
  $auth_username = undef,
  $auth_password = undef,
  $concurrency = 4,
  $mms_server = 'https://mms.mongodb.com',
  $mms_group_settings,
){

# Docu: https://docs.mms.mongodb.com/tutorial/install-monitoring-agent-with-deb-package/

  require 'apt'
  require 'mms'

  $agent_name = 'mms-monitoring'
  $config_file = '/etc/mongodb-mms/monitoring-agent.config'

  helper::script { 'install-mms-monitoring':
    content => template("${module_name}/install.sh"),
    unless  => "(test -x /usr/bin/mongodb-${agent_name}-agent) && (/usr/bin/mongodb-${agent_name}-agent -version | grep -q ${version})",
    require => Class['apt::update'],
  }

  file { $config_file:
    ensure  => file,
    content => template("${module_name}/conf-monitoring"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    require => Helper::Script['install-mms-monitoring'],
    notify  => Service[$agent_name];
  }
  ->

  daemon { $agent_name:
    binary  => "/usr/bin/mongodb-${agent_name}-agent",
    args    => "-conf ${config_file} -concurrency=${concurrency}",
    user    => 'mongodb-mms-agent',
    require => File[$config_file],
  }

}
