class mms::agent::monitoring (
  $version = '5.1.0.323',
  $api_key,
  $auth_username = undef,
  $auth_password = undef,
  $concurrency = 4,
  $mms_server = 'https://mms.mongodb.com'
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
    binary  => '/usr/bin/mongodb-mms-backup-agent',
    args    => "-conf ${config_file} -concurrency=${concurrency}",
    require => [File[$config_file], Helper::Script['install-mms-monitoring']],
  }

}
