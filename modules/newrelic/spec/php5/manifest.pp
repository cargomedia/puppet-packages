node default {

  class {'newrelic::php5':
    license_key => 'xxxxx',
    appname => 'bar',
    enabled => true,
    browser_monitoring_enabled => true,
  }
}
