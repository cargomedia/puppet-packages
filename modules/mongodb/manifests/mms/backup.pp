class mongodb::mms::backup (
  $version = '2.0.0.97',
  $apikey = undef
){

  require 'mongodb::mms'

  $daemon = 'mongod'
  $instance_name = "${daemon}_${name}"

  file { '/etc/mongodb-mms/monitoring-agent.config':
    content=>template('mongodbmms/monitoring-agent.config.erb'),
    require => [Exec['install-mms']]
  }

  service { "mongodb-mms-monitoring-agent":
    ensure     => 'running',
    provider   => 'upstart',
    hasrestart => 'true',
    hasstatus  => 'true',
    require => File['/etc/mongodb-mms/monitoring-agent.config'],
    subscribe  => File['/etc/mongodb-mms/monitoring-agent.config']
  }

}
