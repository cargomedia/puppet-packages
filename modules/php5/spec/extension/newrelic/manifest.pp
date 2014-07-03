node default {

  require 'php5'

  class {'php5::extension::newrelic':
    license_key => 'xxxxx',
    appname => 'bar',
    enabled => true,
    browser_monitoring_enabled => true,
  }
}
