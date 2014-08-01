class mms::agent::monitoring (
  $version = '2.4.0.101',
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
    content => template('mms/install.sh'),
    unless => "(test -x /usr/bin/mongodb-${agent_name}-agent) && (dpkg -s mongodb-${agent_name}-agent | grep -q ${version})",
  }
  ->

  file {
    '/etc/mongodb-mms/monitoring-agent.config':
      ensure => file,
      content => template('mms/conf-monitoring'),
      owner => '0',
      group => '0',
      mode => '0644',
      require => Helper::Script['install-mms-monitoring'],
      notify => Service[$agent_name];

    "/etc/init.d/${agent_name}":
      ensure => file,
      content => template('mms/init'),
      owner => '0',
      group => '0',
      mode => '0755',
      require => Helper::Script['install-mms-monitoring'],
      notify => Service[$agent_name];
  }
  ->

  helper::service{$agent_name:
  }
  ->

  service {$agent_name:
    hasrestart => true
  }

  @monit::entry {'mms-monitoring':
    content => template('mms/monit'),
    require => Service[$agent_name],
  }

}
