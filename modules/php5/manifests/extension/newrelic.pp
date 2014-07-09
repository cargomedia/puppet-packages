class php5::extension::newrelic(
  $license_key,
  $appname = undef,
  $enabled = true,
  $browser_monitoring_enabled = true) {

  require 'php5'
  require 'apt::source::newrelic'

  package {['newrelic-php5']:
    ensure => present,
    require => Class['apt::source::newrelic'],
  }
  ->

  php5::config_extension {'newrelic':
    content => template('php5/extension/newrelic/conf.ini'),
  }
}
