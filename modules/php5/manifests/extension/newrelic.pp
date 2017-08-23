class php5::extension::newrelic (
  $license_key,
  $appname                    = undef,
  $enabled                    = true,
  $browser_monitoring_enabled = true,
  $guzzle_support_enabled     = true
) {

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

  @fluentd::config::source_logfile { 'newrelic-php-agent':
    path           => '/var/log/newrelic/php_agent.log',
    unit           => 'newrelic-php-agent',
    format         => '/(?<time>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3} \+\d{4}) \(\S+ \S+\) (?<level>\S+): (?<message>.*)/',
    time_format    => '%Y-%m-%d %H:%M:%S.%L %z',
    read_from_head => true,
  }

  @fluentd::config::source_logfile { 'newrelic-php-agent-segfaults':
    path           => '/var/log/newrelic/php_agent.log',
    unit           => 'newrelic-php-agent',
    format         => '/(?<message>^Process.*)/',
    fluentd_tag    => 'php-segfault',
    read_from_head => true,
  }

  @fluentd::config::source_logfile { 'newrelic-daemon':
    path           => '/var/log/newrelic/newrelic-daemon.log',
    unit           => 'newrelic-daemon',
    format         => '/(?<time>\d{4}\/\d{2}\/\d{2} \d{2}:\d{2}:\d{2}\.\d{6}) \((?<pid>\d*)\) (?<level>\S+): (?<message>.*)/',
    time_format    => '%Y/%m/%d %H:%M:%S.%N',
    read_from_head => true,
  }
}
