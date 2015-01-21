class mms::agent::monitoring (
  $version = '2.8.0.143',
  $api_key,
  $auth_username = undef,
  $auth_password = undef,
  $concurrency = 4,
  $mms_server = 'https://mms.mongodb.com'
){

  require 'mms'

  $agent_name = 'mms-monitoring'
  $daemon_args = "-conf /etc/mongodb-mms/monitoring-agent.config -concurrency=${concurrency}"

  helper::script {'install-mms-monitoring':
    content => template("${module_name}/install.sh"),
    unless => "(test -x /usr/bin/mongodb-${agent_name}-agent) && (/usr/bin/mongodb-${agent_name}-agent -version | grep -q ${version})",
  }
  ->

  file {
    '/etc/mongodb-mms/monitoring-agent.config':
      ensure => file,
      content => template("${module_name}/conf-monitoring"),
      owner => '0',
      group => '0',
      mode => '0644',
      require => Helper::Script['install-mms-monitoring'],
      notify => Service[$agent_name];

    "/etc/init.d/${agent_name}":
      ensure => file,
      content => template("${module_name}/init"),
      owner => '0',
      group => '0',
      mode => '0755',
      require => Helper::Script['install-mms-monitoring'],
      notify => Service[$agent_name];
  }
  ->

  helper::service{$agent_name:
    subscribe => File["/etc/init.d/${agent_name}"],
  }
  ->

  service {$agent_name:
    hasrestart => true
  }

  @monit::entry {'mms-monitoring':
    content => template("${module_name}/monit"),
    require => Service[$agent_name],
  }

}
