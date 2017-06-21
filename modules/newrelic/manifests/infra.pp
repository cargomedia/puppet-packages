class newrelic::infra (
  $license_key,
  $display_name      = '',
  $verbose           = '',
  $proxy             = '',
  $custom_attributes = { },
) {

  if ($::facts['lsbdistid'] == 'Debian') {
    require 'apt'
    require 'apt::source::newrelic_infra'

    package { ['newrelic-infra']:
      ensure   => present,
      provider => 'apt',
      require  => Class['apt::source::newrelic_infra'],
      before   => Service['newrelic-infra'],
    }

    file { '/etc/newrelic-infra.yml':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      content => template("${module_name}/newrelic-infra.yml.erb"),
      notify  => Daemon['newrelic-infra'],
    }

    daemon { 'newrelic-infra':
      binary  => '/usr/bin/newrelic-infra',
      require => Package['newrelic-infra'],
    }
  }
}

