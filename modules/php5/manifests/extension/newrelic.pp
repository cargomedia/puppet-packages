class php5::extension::newrelic(
  $license_key,
  $appname = undef,
  $enabled = true,
  $browser_monitoring_enabled = true,
  $guzzle_support_enabled = true) {

  require 'apt'
  require 'php5'
  require 'apt::source::newrelic'

  package { ['newrelic-php5']:
    ensure   => present,
    provider => 'apt',
    require  => Class['apt::source::newrelic'],
  }
  ->

  php5::config_extension { 'newrelic':
    content => template("${module_name}/extension/newrelic/conf.ini"),
  }
}
