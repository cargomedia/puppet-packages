node default {

  class {'newrelic::php5':
    license_key => 'please provide licence for valid testing',
    appname => 'bar',
    enabled => false,
    browser_monitoring_enabled => true,
  }
}
