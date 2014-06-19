class mms::agent::backup (
  $version = '2.0.0.97',
  $api_key,
  $mms_server = 'api-backup.mongodb.com'
){

  require 'mms'

  $agent_name = 'mms-backup'
  $daemon_args = "-c /etc/mongodb-mms/backup-agent.config"

  helper::script {'install-mms-backup':
    content => template('mms/install.sh'),
    unless => "(test -x /usr/bin/mongodb-${agent_name}-agent) && (/usr/bin/mongodb-${agent_name}-agent -version | grep -q ${version})",
  }
  ->

  file {
    '/etc/mongodb-mms/backup-agent.config':
      ensure => file,
      content => template('mms/conf-backup'),
      owner => '0',
      group => '0',
      mode => '0644',
      require => Helper::Script['install-mms-backup'],
      notify => Service[$agent_name];

    "/etc/init.d/${agent_name}":
      ensure => file,
      content => template('mms/init'),
      owner => '0',
      group => '0',
      mode => '0755',
      require => Helper::Script['install-mms-backup'],
      notify => Service[$agent_name];
  }
  ->

  service {$agent_name:
  }
  ->

  helper::service{$agent_name:
  }

  @monit::entry {'mms-backup':
    content => template('mms/monit'),
  }
}
