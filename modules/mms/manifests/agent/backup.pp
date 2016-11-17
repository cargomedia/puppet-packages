class mms::agent::backup (
  $version = '5.0.1.453',
  $api_key,
  $mms_server = 'api-backup.mongodb.com'
){

# Docu: https://docs.mms.mongodb.com/tutorial/install-backup-agent-with-deb-package/

  require 'apt'
  require 'mms'

  $agent_name = 'mms-backup'
  $config_file = '/etc/mongodb-mms/backup-agent.config'

  helper::script { 'install-mms-backup':
    content => template("${module_name}/install.sh"),
    unless  => "(test -x /usr/bin/mongodb-${agent_name}-agent) && (/usr/bin/mongodb-${agent_name}-agent -version | grep -q ${version})",
    require => Class['apt::update'],
  }

  file { $config_file:
    ensure  => file,
    content => template("${module_name}/conf-backup"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    require => Helper::Script['install-mms-backup'],
    notify  => Service[$agent_name];
  }
  ->

  daemon { $agent_name:
    binary  => "/usr/bin/mongodb-${agent_name}-agent",
    args    => "-c ${config_file}",
    user    => 'mongodb-mms-agent',
    require => File[$config_file],
  }

}
