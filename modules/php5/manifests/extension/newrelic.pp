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

  php5::config_extension { 'newrelic':
    content => template("${module_name}/extension/newrelic/conf.ini"),
    require => Package['newrelic-php5'],
  }

  @fluentd::config::source_tail{ 'newrelic-php-agent':
    path        => '/var/log/newrelic/php_agent.log',
    fluentd_tag => 'newrelic',
    format      => 'json',
    time_key    => 'time',
    time_format => '%FT%T.%L%:z',
  }

  @fluentd::config::source_tail{ 'newrelic-daemon':
    path        => '/var/log/newrelic/newrelic-daemon.log',
    fluentd_tag => 'newrelic',
    format      => 'json',
    time_key    => 'time',
    time_format => '%FT%T.%L%:z',
  }
}
