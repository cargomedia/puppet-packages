node default {

  include 'fluentd'

  class { 'php5::extension::newrelic':
    license_key                => 'xxxxx',
    appname                    => 'bar',
    enabled                    => true,
    browser_monitoring_enabled => true,
    guzzle_support_enabled     => true,
  }

  fluentd::config::match_copy { 'dump_to_file':
    pattern  => '**',
    priority => 85,
    stores   => [{
      'type'   => 'file',
      'path'   => '/tmp/dump',
      'format' => 'json',
    }]
  }

}
