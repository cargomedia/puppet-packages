class php5::extension::newrelic(
  $license_key,
  $appname = undef,
  $enabled = true,
  $browser_monitoring_enabled = true) {

  include 'php5'

  apt::source {'newrelic':
    entries => ['deb http://apt.newrelic.com/debian/ newrelic non-free'],
    keys => {'newrelic' => {
        key     => '548C16BF',
        key_url => 'http://download.newrelic.com/548C16BF.gpg',
      }
    }
  }

  package {['newrelic-php5']:
    ensure => present,
    require => Apt::Source['newrelic'],
  }
  ->

  exec {'newrelic postinstall':
    command => 'newrelic-install install',
    environment => ['NR_INSTALL_SILENT=yes'],
    path => ['/usr/bin', '/bin'],
    unless => 'newrelic-daemon -v',
  }
  ->

  php5::config_extension {'newrelic':
    content => template('php5/extension/newrelic/conf.ini'),
  }
}
