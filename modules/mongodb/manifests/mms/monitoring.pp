class mongodb::mms::monitoring (
  $version = '2.1.0.35',
  $api_key = undef,
  $auth_username = '',
  $auth_password = '',
  $concurrency = 4,
  $mms_server = 'https://mms.mongodb.com'
){

  require 'mongodb::mms'

  $instance_name = "mongodb-mms-monitoring-agent"

  helper::script {'install-mms-monitoring':
    content => template('mongodb/mms/install.sh'),
    unless => "test -x /usr/bin/${instance_name}",
  }
  ->

  file {
    '/etc/mongodb-mms/monitoring-agent.config':
      ensure => file,
      content=>template('mongodb/mms/conf-monitoring'),
      owner => '0',
      group => '0',
      mode => '0644',
      require => Helper::Script['install-mms-monitoring'],
      notify => Service[$instance_name];

    "/etc/init.d/${instance_name}":
      ensure => file,
      content=>template('mongodb/mms/init-monitoring'),
      owner => '0',
      group => '0',
      mode => '0755',
      require => Helper::Script['install-mms-monitoring'],
      notify => Service[$instance_name];
  }
  ->

  service {$instance_name:
  }
  ->

  helper::service{$instance_name:
  }

  @monit::entry {'mms-monitoring':
    content => template('mongodb/mms/monit'),
  }

}
