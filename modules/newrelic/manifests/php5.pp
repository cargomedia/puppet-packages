class newrelic::php5 ($license_key, $appname = undef, $enabled = false, $browser_monitoring_enabled = false) {

  include '::php5'

  apt::source {'newrelic':
    entries => ['deb http://apt.newrelic.com/debian/ newrelic non-free'],
    keys => {'newrelic' => {
        key     => '548C16BF',
        key_url => 'http://download.newrelic.com/548C16BF.gpg',
      }
    }
  }
  ->

  package {'newrelic-php5':
    ensure => present
  }
  ->

  exec {'newrelic postinstall':
    command => 'newrelic-install install',
    environment => ['NR_INSTALL_SILENT=yes', "NR_INSTALL_KEY=${license_key}"],
    path => ['/usr/bin', '/bin'],
    unless => 'newrelic-daemon -v',
    require => Package['php5-common'],
  }
  ->

  file { '/etc/php5/conf.d/newrelic.ini':
    ensure  => file,
    content => template('newrelic/php5/config'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

  @monit::entry {'newrelic-daemon':
    content => template('newrelic/php5/monit'),
    require => File['/etc/php5/conf.d/newrelic.ini'],
  }
}
